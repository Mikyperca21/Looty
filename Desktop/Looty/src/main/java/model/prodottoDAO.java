package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;


public class prodottoDAO {
	

	public synchronized void doSave(prodottoBean prodotto) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO prodotti"+ "(nome, descrizione, prezzoS, prezzoM, prezzoL, quantita) VALUES (?, ?, ?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, prodotto.getNome());
			preparedStatement.setString(2, prodotto.getDescrizione());
			preparedStatement.setFloat(3, prodotto.getPrezzoS());
			preparedStatement.setFloat(4, prodotto.getPrezzoM());
			preparedStatement.setFloat(5, prodotto.getPrezzoL());
			preparedStatement.setInt(6, prodotto.getQuantita());

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

	public synchronized prodottoBean doRetrieveByKey(int codice) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		prodottoBean bean = new prodottoBean();

		String selectSQL = "SELECT * FROM prodotti" + " WHERE CODE = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, codice);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setCodice(rs.getInt("codice"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzoS(rs.getInt("prezzoS"));
				bean.setPrezzoM(rs.getFloat("prezzoM"));
				bean.setPrezzoL(rs.getFloat("prezzoL"));
				bean.setQuantita(rs.getInt("quantita"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return bean;
	}

	public synchronized boolean doDelete(int codice) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM prodotti" + " WHERE codice = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, codice);

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


	public synchronized Collection<prodottoBean> doRetrieveAll() throws SQLException { //aggiungere come parametro: String order per ordinare prodotti
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<prodottoBean> prodotti = new LinkedList<prodottoBean>();

		String selectSQL = "SELECT * FROM prodotti";

		/*
		 * if (order != null && !order.equals("")) { selectSQL += " ORDER BY " + order;
		 * }
		 */

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				prodottoBean bean = new prodottoBean();

				bean.setCodice(rs.getInt("codice"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzoS(rs.getInt("prezzoS"));
				bean.setPrezzoM(rs.getFloat("prezzoM"));
				bean.setPrezzoL(rs.getFloat("prezzoL"));
				bean.setQuantita(rs.getInt("quantita"));
				prodotti.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return prodotti;
	}
	
}




