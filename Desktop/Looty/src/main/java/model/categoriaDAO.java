package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class categoriaDAO {

	public synchronized int doSave (categoriaBean categoria) throws SQLException {
		Connection connection = null; 
		PreparedStatement ps = null; 
		ResultSet rs = null;
		
		String insertSQL = "INSERT INTO categoria (nome) VALUES (?)";
		
		try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, categoria.getNome());
            

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Nessuna chiave generata trovata.");
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
	}
	
	public List<categoriaBean> doRetrieveAll() throws SQLException {
		Connection connection = null; 
    	PreparedStatement preparedStatement = null;
        List<categoriaBean> categorie = new ArrayList<>();
        String sql = "SELECT * FROM categoria;";
        try {
        	connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                categoriaBean categoria = new categoriaBean();
                categoria.setId(rs.getInt("id"));
                categoria.setNome(rs.getString("nome"));
                categorie.add(categoria);
            }
    	}finally {
                if (preparedStatement != null) preparedStatement.close();
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        
        return categorie;
	}
	
	public categoriaBean doRetrieveById(int id) throws SQLException {
        categoriaBean categoria = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM categoria WHERE id = ?";

        try {
            con = DriverManagerConnectionPool.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                categoria = new categoriaBean();
                categoria.setId(rs.getInt("id"));
                categoria.setNome(rs.getString("nome"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            DriverManagerConnectionPool.releaseConnection(con);
        }

        return categoria;
    }
	
	public synchronized boolean doDelete(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM categoria" + " WHERE id = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, id);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return (result != 0);
	}
	
	public synchronized void doUpdate(categoriaBean categoria) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    String updateSQL = "UPDATE categoria SET nome=? WHERE id = ?";

	    try {
	        connection = DriverManagerConnectionPool.getConnection();
	        preparedStatement = connection.prepareStatement(updateSQL);
	        preparedStatement.setString(1, categoria.getNome());
	        preparedStatement.setInt(2, categoria.getId());
	        

	        preparedStatement.executeUpdate();
	        connection.commit();
	    } finally {
	        try {
	            if (preparedStatement != null) preparedStatement.close();
	        } finally {
	            DriverManagerConnectionPool.releaseConnection(connection);
	        }
	    }
	}
}
