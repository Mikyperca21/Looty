package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class appartieneDAO {
	public synchronized int doSave (int id_categoria, int id_prodotto) throws SQLException {
		Connection connection = null; 
		PreparedStatement ps = null; 
		ResultSet rs = null;
		
		String insertSQL = "INSERT INTO appartiene (id_categoria, id_ prodotto) VALUES (?, ?)";
		
		try {
            connection = DriverManagerConnectionPool.getConnection();
            ps = connection.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, id_categoria);
            ps.setInt(2, id_prodotto);
            

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
	
	public synchronized boolean doDelete(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM appartiene" + " WHERE id = ?";

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
	
	/*
	 * public oRetrieveIdByIds(int id_categoria, int id_prodotto) throws
	 * SQLException { categoriaBean categoria = null; Connection con = null;
	 * Prepareint ddStatement ps = null; ResultSet rs = null;
	 * 
	 * String sql = "SELECT * FROM categoria WHERE id = ?";
	 * 
	 * try { con = DriverManagerConnectionPool.getConnection(); ps =
	 * con.prepareStatement(sql); ps.setInt(1, id); rs = ps.executeQuery();
	 * 
	 * if (rs.next()) { categoria = new categoriaBean();
	 * categoria.setId(rs.getInt("id")); categoria.setNome(rs.getString("nome")); }
	 * } finally { if (rs != null) rs.close(); if (ps != null) ps.close();
	 * DriverManagerConnectionPool.releaseConnection(con); }
	 * 
	 * return categoria; }
	 */
}
