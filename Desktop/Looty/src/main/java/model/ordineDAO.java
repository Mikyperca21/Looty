package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ordineDAO {

    public synchronized int doSave(ordineBean ordine) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        String insertSQL = "INSERT INTO ordine (id_metodoPagamento, id_indirizzo, data_ordine, totale) "
                         + "VALUES (?, ?, NOW(), ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, ordine.getId_metodoPgamento());
            preparedStatement.setInt(2, ordine.getId_indirizzo());
            preparedStatement.setDouble(3, ordine.getTotale());

            preparedStatement.executeUpdate();
            rs = preparedStatement.getGeneratedKeys();
            connection.commit();
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

        String insertSQL = "INSERT INTO ordineProdotto (id_ordine, id_prodotto, quantita, dimensione, prezzo_unitario) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            for (ordineProdottoBean prodotto : prodotti) {
                preparedStatement.setInt(1, idOrdine);
                preparedStatement.setInt(2, prodotto.getIdProdotto());
                preparedStatement.setInt(3, prodotto.getQuantita());
                preparedStatement.setString(4, prodotto.getDimensione());
                preparedStatement.setDouble(5, prodotto.getPrezzoUnitario());
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
            connection.commit();
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
    }

    public boolean verificaDisponibilita(ElementoCarrello elem) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT quantita FROM prodotti WHERE codice = ?";
        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, elem.getProdotto().getCodice());
            ResultSet rs = preparedStatement.executeQuery();
            
            connection.commit();

            if (rs.next()) {
                int disponibile = rs.getInt("quantita");
                int richiesto = elem.getQuantitaDaScalare();
                return disponibile >= richiesto;
            }
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
        return false;
    }

    public void updateMagazzino(ElementoCarrello elem) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE prodotti SET quantita = quantita - ? WHERE codice = ?";
        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setInt(1, elem.getQuantitaDaScalare());
            preparedStatement.setInt(2, elem.getProdotto().getCodice());
            preparedStatement.execute();
            connection.commit();
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }
    }

    public List<ordineBean> doRetrieveAll() throws SQLException {
    	Connection connection = null; 
    	PreparedStatement preparedStatement = null;
        List<ordineBean> ordini = new ArrayList<>();
        String sql = "SELECT ordine.*, MIN(p.immagine) AS immagine, u.nome, u.cognome " +
        	    "FROM ordine " +
        	    "INNER JOIN ordineProdotto op ON ordine.id = op.id_ordine " +
        	    "INNER JOIN prodotti p ON p.codice = op.id_prodotto " +
        	    "INNER JOIN metodoPagamento mp ON mp.id = ordine.id_metodoPagamento " +
        	    "INNER JOIN utente u ON mp.id_utente = u.id " +
        	    "WHERE u.ruolo = false " +
        	    "GROUP BY ordine.id " +
        	    "ORDER BY ordine.data_ordine DESC";


        try {
        	connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                ordineBean ordine = new ordineBean();
                ordine.setId(rs.getInt("id"));
                ordine.setId_metodoPgamento(rs.getInt("id_metodoPagamento"));
                ordine.setId_indirizzo(rs.getInt("id_indirizzo"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setTotale(rs.getDouble("totale"));
                ordine.setImmagine(rs.getString("immagine"));
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                ordine.setNomeUtente(nome + " " + cognome);

                ordini.add(ordine);
            }
            connection.commit();
    	}finally {
                if (preparedStatement != null) preparedStatement.close();
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        
        return ordini;
    }

    public List<ordineBean> doRetrieveByUser(int idUtente) throws SQLException {
        List<ordineBean> ordini = new ArrayList<>();
        String sql = "SELECT ordine.*, MIN(p.immagine) AS immagine, u.nome, u.cognome " +
                "FROM ordine " +
                "INNER JOIN ordineProdotto op ON ordine.id = op.id_ordine " +
                "INNER JOIN prodotti p ON p.codice = op.id_prodotto " +
                "INNER JOIN metodoPagamento mp ON mp.id = ordine.id_metodoPagamento " +
                "INNER JOIN utente u ON mp.id_utente = u.id " +
                "WHERE u.ruolo = false AND u.id = ? " +
                "GROUP BY ordine.id, u.nome, u.cognome " +
                "ORDER BY ordine.data_ordine DESC";

        Connection con = null;
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
                    ordine.setId_metodoPgamento(rs.getInt("id_metodoPagamento"));
                    ordine.setId_indirizzo(rs.getInt("id_indirizzo"));
                    ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                    ordine.setTotale(rs.getDouble("totale"));
                    ordine.setImmagine(rs.getString("immagine"));
                    String nome = rs.getString("nome");
                    String cognome = rs.getString("cognome");
                    ordine.setNomeUtente(nome + " " + cognome);

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


    
    // aggiornare    
    public List<ordineProdottoBean> getDettagliOrdine(int idOrdine) {
        List<ordineProdottoBean> dettagliOrdine = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String sql = "SELECT op.*, p.immagine " +
                "FROM prodotti AS p " +
                "INNER JOIN ordineProdotto AS op ON p.codice = op.id_prodotto " +
                "INNER JOIN ordine ON op.id_ordine = ordine.id " +
                "WHERE ordine.id = ?";


        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, idOrdine);
            ResultSet rs = preparedStatement.executeQuery();
            connection.commit();

            while (rs.next()) {
               ordineProdottoBean dett = new ordineProdottoBean();
               dett.setId(rs.getInt("id"));
               dett.setDimensione(rs.getString("dimensione"));
               dett.setIdOrdine(rs.getInt("id_ordine"));
               dett.setIdProdotto(rs.getInt("id_prodotto"));
               dett.setPrezzoUnitario(rs.getDouble("prezzo_unitario"));
               dett.setQuantita(rs.getInt("quantita"));
               dett.setImmagine(rs.getString("immagine"));
               dettagliOrdine.add(dett);
            }
        } catch (SQLException e) {
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
            connection.commit();

            while (rs.next()) {
                ordineProdottoBean opb = new ordineProdottoBean();
                opb.setIdOrdine(rs.getInt("id_ordine"));
                opb.setIdProdotto(rs.getInt("id_prodotto"));
                opb.setPrezzoUnitario(rs.getDouble("prezzo_unitario"));
                opb.setQuantita(rs.getInt("quantita"));
                opb.setDimensione(rs.getString(rs.getString("dimensione")));
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
            con.commit();

            if (rs.next()) {
                ordine = new ordineBean();
                ordine.setId(rs.getInt("id"));
                ordine.setId_metodoPgamento(rs.getInt("id_metodoPagamento"));
                ordine.setId_indirizzo(rs.getInt("id_indirizzo"));
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
    
    public List<ordineBean> doRetrieveFiltered(Integer idUtente, String dataInizio, String dataFine) throws SQLException {
        List<ordineBean> ordini = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        StringBuilder sql = new StringBuilder(
            "SELECT ordine.*, MIN(p.immagine) AS immagine, u.nome, u.cognome " +
            "FROM ordine " +
            "INNER JOIN ordineProdotto op ON ordine.id = op.id_ordine " +
            "INNER JOIN prodotti p ON p.codice = op.id_prodotto " +
            "INNER JOIN metodoPagamento mp ON mp.id = ordine.id_metodoPagamento " +
            "INNER JOIN utente u ON mp.id_utente = u.id " +
            "WHERE u.ruolo = false "
        );

        List<Object> params = new ArrayList<>();

        if (idUtente != null) {
            sql.append("AND u.id = ? ");
            params.add(idUtente);
        }
        if (dataInizio != null) {
            sql.append("AND ordine.data_ordine >= ? ");
            params.add(dataInizio);
        }
        if (dataFine != null) {
            sql.append("AND ordine.data_ordine <= ? ");
            params.add(dataFine);
        }

        sql.append("GROUP BY ordine.id, u.nome, u.cognome ");
        sql.append("ORDER BY ordine.data_ordine DESC");

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                preparedStatement.setObject(i + 1, params.get(i));
            }

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                ordineBean ordine = new ordineBean();
                ordine.setId(rs.getInt("id"));
                ordine.setId_metodoPgamento(rs.getInt("id_metodoPagamento"));
                ordine.setId_indirizzo(rs.getInt("id_indirizzo"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setTotale(rs.getDouble("totale"));
                ordine.setImmagine(rs.getString("immagine"));
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                ordine.setNomeUtente(nome + " " + cognome);

                ordini.add(ordine);
            }
            connection.commit();
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }

        return ordini;
    }

    public List<ordineBean> doRetrieveByDate(String dataInizio, String dataFine) throws SQLException {
        List<ordineBean> ordini = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        StringBuilder sql = new StringBuilder(
            "SELECT ordine.*, MIN(p.immagine) AS immagine, u.nome, u.cognome " +
            "FROM ordine " +
            "INNER JOIN ordineProdotto op ON ordine.id = op.id_ordine " +
            "INNER JOIN prodotti p ON p.codice = op.id_prodotto " +
            "INNER JOIN metodoPagamento mp ON mp.id = ordine.id_metodoPagamento " +
            "INNER JOIN utente u ON mp.id_utente = u.id " +
            "WHERE ordine.data_ordine >= ? AND ordine.data_ordine <= ? " +
            "GROUP BY ordine.id, u.nome, u.cognome " +
            "ORDER BY ordine.data_ordine DESC"
        );

        List<Object> params = new ArrayList<>();
        params.add(dataInizio);
        params.add(dataFine);

        try {
            connection = DriverManagerConnectionPool.getConnection();
            preparedStatement = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                preparedStatement.setObject(i + 1, params.get(i));
            }

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                ordineBean ordine = new ordineBean();
                ordine.setId(rs.getInt("id"));
                ordine.setId_metodoPgamento(rs.getInt("id_metodoPagamento"));
                ordine.setId_indirizzo(rs.getInt("id_indirizzo"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setTotale(rs.getDouble("totale"));
                ordine.setImmagine(rs.getString("immagine"));

                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                ordine.setNomeUtente(nome + " " + cognome);

                ordini.add(ordine);
            }

            // connection.commit(); // Rimuovibile se non in transazione
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            DriverManagerConnectionPool.releaseConnection(connection);
        }

        return ordini;
    }
}
