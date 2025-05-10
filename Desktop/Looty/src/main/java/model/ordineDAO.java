package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ordineDAO {

	public synchronized int doSave(ordineBean ordine) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet rs = null;

	    String insertSQL = "INSERT INTO ordine (id_utente, totale, data_ordine) VALUES (?, ?, NOW())";

	    try {
	        connection = DriverManagerConnectionPool.getConnection();
	        
	        preparedStatement = connection.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
	        preparedStatement.setInt(1, ordine.getIdUtente());
	        preparedStatement.setDouble(2, ordine.getTotale());

	        preparedStatement.executeUpdate();

	        rs = preparedStatement.getGeneratedKeys();
	        if (rs.next()) {
	            return rs.getInt(1);
	        } else {
	            throw new SQLException("Nessuna chiave generata trovata.");
	        }
	    } finally {
	        if (rs != null) rs.close();
	        if (preparedStatement != null) preparedStatement.close();
	        DriverManagerConnectionPool.releaseConnection(connection);
	    }
	}



	public void salvaProdottiOrdine(List<ordineProdottoBean> prodotti, int idOrdine) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario) VALUES (?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			for (ordineProdottoBean prodotto : prodotti) {
				preparedStatement.setInt(1, idOrdine);
				preparedStatement.setInt(2, prodotto.getIdProdotto());
				preparedStatement.setInt(3, prodotto.getQuantita());
				preparedStatement.setDouble(4, prodotto.getPrezzoUnitario());
				preparedStatement.addBatch();
			}

			preparedStatement.executeBatch();
		}

		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}

	}

	
	public boolean verificaDisponibilita(ElementoCarrello elem) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String selectSQL = "SELECT quantita FROM prodotti WHERE codice = ?";
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, elem.getProdotto().getCodice());
			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
				int disponibile = rs.getInt("quantita");
				int richiesto = elem.getQuantitaDaScalare();
				return disponibile >= richiesto;
			}	
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
	return false;
	}
	
	public void updateMagazzino(ElementoCarrello elem) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE prodotti SET quantita = quantita - ? WHERE codice = ?";
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setInt(1, elem.getQuantitaDaScalare());
			preparedStatement.setInt(2, elem.getProdotto().getCodice());
			
			preparedStatement.execute();
			
	} finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
	}
	}
	
	public List<ordineBean> doRetrieveAll(Connection con) throws SQLException {
	    List<ordineBean> ordini = new ArrayList<>();
	    String sql = "SELECT * FROM Ordine ORDER BY data_ordine DESC";

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            ordineBean ordine = new ordineBean();
	            ordine.setId(rs.getInt("id"));
	            ordine.setIdUtente(rs.getInt("id_utente"));
	            ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
	            ordine.setTotale(rs.getDouble("totale"));
	            ordini.add(ordine);
	        }
	    }
	    return ordini;
	}
	
	public List<ordineBean> doRetrieveByUser(int idUtente, Connection con) throws SQLException {
	    List<ordineBean> ordini = new ArrayList<>();
	    String sql = "SELECT o.id, o.id_utente, o.data_ordine, o.totale, " +
	                 "(SELECT p.immagine FROM OrdineProdotto op2 " +
	                 " JOIN prodotti p ON op2.id_prodotto = p.codice " +
	                 " WHERE op2.id_ordine = o.id LIMIT 1) AS immagine " +
	                 "FROM ordine o " +
	                 "WHERE o.id_utente = ? " +
	                 "ORDER BY o.data_ordine DESC";

	    boolean closeConnection = false;

	    if (con == null) {
	        con = DriverManagerConnectionPool.getConnection();
	        closeConnection = true;
	    }

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, idUtente);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                ordineBean ordine = new ordineBean();
	                ordine.setId(rs.getInt("id"));
	                ordine.setIdUtente(rs.getInt("id_utente"));
	                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
	                ordine.setTotale(rs.getDouble("totale"));
	                ordine.setImmagineProdotto(rs.getString("immagine"));
	                ordini.add(ordine);
	            }
	        }
	    } finally {
	        if (closeConnection && con != null) {
	            DriverManagerConnectionPool.releaseConnection(con);
	        }
	    }

	    return ordini;
	}

	public List<Map<String, Object>> getDettagliOrdine(int idOrdine) {
        List<Map<String, Object>> dettagliOrdine = new ArrayList<>();

        Connection connection = null;
		PreparedStatement preparedStatement = null;
        
        String sql = "SELECT o.id AS ordine_id, o.data_ordine, o.totale, "
                   + "p.nome AS prodotto_nome, op.quantita, op.prezzo_unitario, "
                   + "(op.quantita * op.prezzo_unitario) AS totale_prodotto "
                   + "FROM ordine o "
                   + "JOIN OrdineProdotto op ON o.id = op.id_ordine "
                   + "JOIN prodotti p ON op.id_prodotto = p.codice "
                   + "WHERE o.id = ?";

        try {connection = DriverManagerConnectionPool.getConnection();
             preparedStatement = connection.prepareStatement(sql); {
             
        	preparedStatement.setInt(1, idOrdine);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> ordineDettagli = new HashMap<>();
                ordineDettagli.put("ordine_id", rs.getInt("ordine_id"));
                ordineDettagli.put("data_ordine", rs.getTimestamp("data_ordine"));
                ordineDettagli.put("totale", rs.getFloat("totale"));
                ordineDettagli.put("nome_prodotto", rs.getString("prodotto_nome"));
                ordineDettagli.put("quantita", rs.getInt("quantita"));
                ordineDettagli.put("prezzo_unitario", rs.getFloat("prezzo_unitario"));
                ordineDettagli.put("totale_prodotto", rs.getFloat("totale_prodotto"));
                dettagliOrdine.add(ordineDettagli);
            }
             }}catch (SQLException e) {
            e.printStackTrace();
        }
             

        return dettagliOrdine;
    }
	
	
	public List<ordineProdottoBean> doRetrieveByOrdine(int idOrdine) throws SQLException {
	    List<ordineProdottoBean> prodottiOrdine = new ArrayList<>();

	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet rs = null;

	    String sql = "SELECT * FROM OrdineProdotto WHERE id_ordine = ?";

	    try {
	        connection = DriverManagerConnectionPool.getConnection();
	        preparedStatement = connection.prepareStatement(sql);
	        preparedStatement.setInt(1, idOrdine);

	        rs = preparedStatement.executeQuery();

	        while (rs.next()) {
	            ordineProdottoBean opb = new ordineProdottoBean();
	            opb.setIdOrdine(rs.getInt("id_ordine"));
	            opb.setIdProdotto(rs.getInt("id_prodotto"));
	            opb.setPrezzoUnitario(rs.getDouble("prezzo_unitario"));
	            opb.setQuantita(rs.getInt("quantita"));
	            prodottiOrdine.add(opb);
	        }

	    } finally {
	        if (rs != null) rs.close();
	        if (preparedStatement != null) preparedStatement.close();
	        DriverManagerConnectionPool.releaseConnection(connection);
	    }

	    return prodottiOrdine;
	}


	public ordineBean doRetrieveById(int id) throws SQLException {
	    ordineBean ordine = null;
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    String sql = "SELECT * FROM ordine WHERE id = ?";

	    try {
	        con = DriverManagerConnectionPool.getConnection();
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, id);
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            ordine = new ordineBean();
	            ordine.setId(rs.getInt("id"));
	            ordine.setIdUtente(rs.getInt("id_utente"));
	            ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
	            ordine.setTotale(rs.getDouble("totale"));
	        }
	    } finally {
	        if (rs != null) rs.close();
	        if (ps != null) ps.close();
	        DriverManagerConnectionPool.releaseConnection(con);
	    }

	    return ordine;
	}



	
}

