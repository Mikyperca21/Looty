package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class indirizzoDAO {

    public synchronized int doSave(indirizzoBean indirizzo) throws SQLException {
        String sql = "INSERT INTO indirizzo (id_utente, etichetta, via, citta, cap, provincia, paese, telefono) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, indirizzo.getIdUtente());
            ps.setString(2, indirizzo.getEtichetta());
            ps.setString(3, indirizzo.getVia());
            ps.setString(4, indirizzo.getCitta());
            ps.setString(5, indirizzo.getCap());
            ps.setString(6, indirizzo.getProvincia());
            ps.setString(7, indirizzo.getPaese());
            ps.setString(8, indirizzo.getTelefono());

            ps.executeUpdate();
            con.commit();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
                else throw new SQLException("Errore nel salvataggio dell'indirizzo.");
            }
        }
    }

    public indirizzoBean doRetrieveById(int id) throws SQLException {
        String sql = "SELECT * FROM indirizzo WHERE id = ? AND valido=true ";
        indirizzoBean indirizzo = null;

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            con.commit();
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    indirizzo = new indirizzoBean();
                    indirizzo.setId(rs.getInt("id"));
                    indirizzo.setIdUtente(rs.getInt("id_utente"));
                    indirizzo.setEtichetta(rs.getString("etichetta"));
                    indirizzo.setVia(rs.getString("via"));
                    indirizzo.setCitta(rs.getString("citta"));
                    indirizzo.setCap(rs.getString("cap"));
                    indirizzo.setProvincia(rs.getString("provincia"));
                    indirizzo.setPaese(rs.getString("paese"));
                    indirizzo.setTelefono(rs.getString("telefono"));
                }
            }
        }

        return indirizzo;
    }

    public List<indirizzoBean> doRetrieveByUtente(int idUtente) throws SQLException {
        List<indirizzoBean> indirizzi = new ArrayList<>();
        String sql = "SELECT * FROM indirizzo WHERE id_utente = ? AND valido=true";

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            con.commit();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    indirizzoBean indirizzo = new indirizzoBean();
                    indirizzo.setId(rs.getInt("id"));
                    indirizzo.setIdUtente(rs.getInt("id_utente"));
                    indirizzo.setEtichetta(rs.getString("etichetta"));
                    indirizzo.setVia(rs.getString("via"));
                    indirizzo.setCitta(rs.getString("citta"));
                    indirizzo.setCap(rs.getString("cap"));
                    indirizzo.setProvincia(rs.getString("provincia"));
                    indirizzo.setPaese(rs.getString("paese"));
                    indirizzo.setTelefono(rs.getString("telefono"));
                    indirizzo.setIs_preferito(rs.getBoolean("is_preferito"));
                    indirizzi.add(indirizzo);
                }
            }
        }

        return indirizzi;
    }

    public void doDelete(int id) throws SQLException {
        String sql = "UPDATE indirizzo SET valido = false, is_preferito = false WHERE id = ?";

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            con.commit();
        }
    }
    
    public void doUpdate(indirizzoBean indirizzo) throws SQLException {
        String sql = "UPDATE indirizzo SET etichetta = ?, via = ?, citta = ?, cap = ?, provincia = ?, paese = ?, telefono = ? WHERE id = ?";

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
        	
        	ps.setString(1, indirizzo.getEtichetta());
            ps.setString(2, indirizzo.getVia());
            ps.setString(3, indirizzo.getCitta());
            ps.setString(4, indirizzo.getCap());
            ps.setString(5, indirizzo.getProvincia());
            ps.setString(6, indirizzo.getPaese());
            ps.setString(7, indirizzo.getTelefono());
            ps.setInt(8, indirizzo.getId());

            ps.executeUpdate();
            con.commit();
        }
    }
    
    public indirizzoBean doRetrievePreferitoByUtente(int idUtente) {
        indirizzoBean indirizzo = null;

        try (Connection con = DriverManagerConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM indirizzo WHERE id_utente = ? AND is_preferito = 1 LIMIT 1")) {

            ps.setInt(1, idUtente);
            con.commit();

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    indirizzo = new indirizzoBean();
                    indirizzo.setId(rs.getInt("id"));
                    indirizzo.setIdUtente(rs.getInt("id_utente"));
                    indirizzo.setVia(rs.getString("via"));
                    indirizzo.setCitta(rs.getString("citta"));
                    indirizzo.setCap(rs.getString("cap"));
                    indirizzo.setProvincia(rs.getString("provincia"));
                    indirizzo.setPaese(rs.getString("paese"));
                    indirizzo.setTelefono(rs.getString("telefono"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return indirizzo;
    }

 
    
    public void setPreferito(int idUtente, int idIndirizzoPreferito) throws SQLException {
        try (Connection con = DriverManagerConnectionPool.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement("UPDATE indirizzo SET is_preferito = 0 WHERE id_utente = ?")) {
                ps.setInt(1, idUtente);
                ps.executeUpdate();
                con.commit();
            }

            try (PreparedStatement ps = con.prepareStatement("UPDATE indirizzo SET is_preferito = 1 WHERE id = ?")) {
                ps.setInt(1, idIndirizzoPreferito);
                ps.executeUpdate();
                con.commit();
            }
        }
    }


}
