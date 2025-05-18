package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class metodoPagamentoDAO {

	public synchronized int doSave(metodoPagamentoBean metodo) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String insertSQL = "INSERT INTO metodoPagamento (codiceCarta, titolare, id_utente, CVV, mese_scadenza, anno_scadenza, is_preferito)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		try{
			conn = DriverManagerConnectionPool.getConnection();
			ps = conn.prepareStatement(insertSQL,PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setString(1, metodo.getCodiceCarta());
			ps.setString(2, metodo.getTitolare());
			ps.setInt(3, metodo.getIdUtente());
			ps.setInt(4, metodo.getCVV());
			ps.setInt(5, metodo.getMeseScadenza());
			ps.setInt(6, metodo.getAnnoScadenza());
			ps.setBoolean(7, metodo.isPreferito());

			
			
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();

			if(rs.next()){
				return rs.getInt(1);
			} else {
				throw new SQLException("Nessuna chiave generata trovata.");

			}
	        } finally {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            DriverManagerConnectionPool.releaseConnection(conn);
	        }
	}
	
	

	public List<metodoPagamentoBean> doRetrieveByUtente(int idUtente) throws SQLException {
	    List<metodoPagamentoBean> metodi = new ArrayList<>();
	    String selectSQL = "SELECT * FROM metodoPagamento WHERE id_utente = ?";
	    
	    try (
	        Connection con = DriverManagerConnectionPool.getConnection();
	        PreparedStatement ps = con.prepareStatement(selectSQL)
	    ) {
	        ps.setInt(1, idUtente);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            metodoPagamentoBean metodoPagamento = new metodoPagamentoBean();
	            metodoPagamento.setId(rs.getInt("id"));
	            metodoPagamento.setCodiceCarta(rs.getString("codiceCarta"));
	            metodoPagamento.setTitolare(rs.getString("titolare"));
	            metodoPagamento.setIdUtente(rs.getInt("id_utente"));
	            metodoPagamento.setCVV(rs.getInt("CVV"));
	            metodoPagamento.setMeseScadenza(rs.getInt("mese_scadenza"));
	            metodoPagamento.setAnnoScadenza(rs.getInt("anno_scadenza"));
	            metodoPagamento.setPreferito(rs.getBoolean("is_preferito"));
	            metodi.add(metodoPagamento);
	        }
	    }
	    
	    return metodi;
	}
	
	public metodoPagamentoBean doRetrieveByID(int id) throws SQLException {
	    metodoPagamentoBean metodo = new metodoPagamentoBean();
	    String selectSQL = "SELECT * FROM metodoPagamento WHERE id = ?";
	    
	    try (
	        Connection con = DriverManagerConnectionPool.getConnection();
	        PreparedStatement ps = con.prepareStatement(selectSQL)
	    ) {
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            
	        	metodo.setId(rs.getInt("id"));
	        	metodo.setCodiceCarta(rs.getString("codiceCarta"));
	        	metodo.setTitolare(rs.getString("titolare"));
	            metodo.setIdUtente(rs.getInt("id_utente"));
	            metodo.setCVV(rs.getInt("CVV"));
	            metodo.setMeseScadenza(rs.getInt("mese_scadenza"));
	            metodo.setAnnoScadenza(rs.getInt("anno_scadenza"));
	            metodo.setPreferito(rs.getBoolean("is_preferito"));
	        }
	    }
	    
	    return metodo;
	}

	
	public void doDelete(int codiceCarta) throws SQLException{
		String sql = "UPDATE metodoPagamento SET valido = false, is_preferito = false WHERE id = ?";
		
		try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, codiceCarta);
            ps.executeUpdate();
		}
	}
	
	public metodoPagamentoBean doRetrievePreferitoByUtente(int idUtente){
		metodoPagamentoBean metodo = null;
		try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM metodoPagamento WHERE id_utente = ? AND is_preferito = 1 LIMIT 1")) {

            ps.setInt(1, idUtente);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    metodo = new metodoPagamentoBean();
                    metodo.setId(rs.getInt("id"));
                    metodo.setCodiceCarta(rs.getString("codiceCarta"));
                    metodo.setTitolare(rs.getString("titolare"));
                    metodo.setIdUtente(rs.getInt("id_utente"));
                    metodo.setCVV(rs.getInt("CVV"));
                    metodo.setMeseScadenza(rs.getInt("mese_scadenza"));
                    metodo.setAnnoScadenza(rs.getInt("anno_scadenza"));
                    metodo.setPreferito(rs.getBoolean("is_preferito"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return metodo;
    }
	
	public void setValido(int codiceCarta)  throws SQLException {
		String sql = "UPDATE metodoPagamento SET valido = true WHERE codiceCarta = ?";
		try (Connection con = DriverManagerConnectionPool.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, codiceCarta);
	            ps.executeUpdate();
			}
	}
	
	public void setPreferito(int idUtente, int id) throws SQLException {
        try (Connection con = DriverManagerConnectionPool.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement("UPDATE metodoPagamento SET is_preferito = 0 WHERE id_utente = ?")) {
                ps.setInt(1, idUtente);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = con.prepareStatement("UPDATE metodoPagamento SET is_preferito = 1 WHERE id = ?")) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        }
    }
	
}
