package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class prodottoDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/Looty";
    private static final String USER = "root";
    private static final String PASS = "root";

    
    public static List<prodottoBean> getAllProdotti() {
        List<prodottoBean> listaProdotti = new ArrayList<>();
        String query = "SELECT * FROM prodotti";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int codice = rs.getInt("codice");
                String nome = rs.getString("nome");
                String descrizione = rs.getString("descrizione");
                String dimensioneStr = rs.getString("dimensione");
                Dimensione dimensione = Dimensione.fromString(dimensioneStr);
                float prezzo1 = rs.getFloat("prezzo1");
                float prezzo2 = rs.getFloat("prezzo2");
                float prezzo3 = rs.getFloat("prezzo3");
                int quantita = rs.getInt("quantita");

                prodottoBean prodotto = new prodottoBean(codice, nome, descrizione, dimensione, prezzo1, prezzo2, prezzo3, quantita);
                listaProdotti.add(prodotto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaProdotti;
    }

    
    public static boolean inserisciProdotto(prodottoBean prodotto) {
        String query = "INSERT INTO prodotti (nome, descrizione, dimensione, prezzo1, prezzo2, prezzo3, quantita) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setString(3, prodotto.getDimensione().name());
            stmt.setFloat(4, prodotto.getPrezzo1());
            stmt.setFloat(5, prodotto.getPrezzo2());
            stmt.setFloat(6, prodotto.getPrezzo3());
            stmt.setInt(7, prodotto.getQuantita());

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public static boolean aggiornaProdotto(prodottoBean prodotto) {
        String query = "UPDATE prodotti SET nome=?, descrizione=?, dimensione=?, prezzo1=?, prezzo2=?, prezzo3=?, quantita=? WHERE code=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setString(3, prodotto.getDimensione().name());
            stmt.setFloat(4, prodotto.getPrezzo1());
            stmt.setFloat(5, prodotto.getPrezzo2());
            stmt.setFloat(6, prodotto.getPrezzo3());
            stmt.setInt(7, prodotto.getQuantita());
            stmt.setInt(8, prodotto.getCodice());

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public static boolean eliminaProdotto(int code) {
        String query = "DELETE FROM prodotti WHERE code=?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, code);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}


