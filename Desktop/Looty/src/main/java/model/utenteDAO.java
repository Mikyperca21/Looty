package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class utenteDAO {
	public synchronized void doSave(prodottoBean prodotto) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO utente"
				+ " (nome, cognome, email, password, ruolo) VALUES ()";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, prodotto.getNome());
			preparedStatement.setString(2, prodotto.getDescrizione());
			preparedStatement.setFloat(3, prodotto.getPrezzoS());
			preparedStatement.setFloat(4, prodotto.getPrezzoM());
			preparedStatement.setFloat(5, prodotto.getPrezzoL());
			preparedStatement.setInt(6, prodotto.getQuantita());
			preparedStatement.setString(7, prodotto.getImmagine());

			preparedStatement.executeUpdate();
			
			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
	}
}