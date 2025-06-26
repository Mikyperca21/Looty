package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.LinkedList;

public class prodottoDAO {

	public synchronized int doSave(prodottoBean prodotto) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO prodotti"
				+ "(nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, prodotto.getNome());
			preparedStatement.setString(2, prodotto.getDescrizione());
			preparedStatement.setFloat(3, prodotto.getPrezzoS());
			preparedStatement.setFloat(4, prodotto.getPrezzoM());
			preparedStatement.setFloat(5, prodotto.getPrezzoL());
			preparedStatement.setInt(6, prodotto.getQuantita());
			preparedStatement.setString(7, prodotto.getImmagine());

			preparedStatement.executeUpdate();
			
			ResultSet  rs = preparedStatement.getGeneratedKeys();
		        if (rs.next()) {
		            int generatedId = rs.getInt(1); // recupera l'ID generato
		            connection.commit(); // commit dopo l'inserimento
		            return generatedId;
		        } else {
		            connection.commit();
		            return -1; // nessun ID generato
		        }
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
	}
	
	public synchronized void doUpdate(prodottoBean prodotto) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    String updateSQL = "UPDATE prodotti SET nome=?, descrizione=?, prezzoS=?, prezzoM=?, prezzoL=?, quantita=?, immagine=? WHERE codice=?";

	    try {
	        connection = DriverManagerConnectionPool.getConnection();
	        preparedStatement = connection.prepareStatement(updateSQL);
	        preparedStatement.setString(1, prodotto.getNome());
	        preparedStatement.setString(2, prodotto.getDescrizione());
	        preparedStatement.setFloat(3, prodotto.getPrezzoS());
	        preparedStatement.setFloat(4, prodotto.getPrezzoM());
	        preparedStatement.setFloat(5, prodotto.getPrezzoL());
	        preparedStatement.setInt(6, prodotto.getQuantita());
	        preparedStatement.setString(7, prodotto.getImmagine());
	        preparedStatement.setInt(8, prodotto.getCodice()); 

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


	public synchronized prodottoBean doRetrieveByKey(int codice) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		prodottoBean bean = new prodottoBean();

		String selectSQL = "SELECT * FROM prodotti WHERE codice = ?";

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
				bean.setImmagine(rs.getString("immagine"));
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
	
	public synchronized boolean doDeleteCatByProdotto(int codice) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM appartiene" + " WHERE id_prodotti = ?";

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

	public synchronized Collection<prodottoBean> doRetrieveAll() throws SQLException { // aggiungere come parametro:
																						// String order per ordinare
																						// prodotti
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
				bean.setImmagine(rs.getString("immagine"));
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
	
	
	public synchronized Collection<prodottoBean> doRetrieveByName(String name) throws SQLException { // aggiungere come parametro:
					// String order per ordinare
					// prodotti
		Connection connection = null;
		PreparedStatement preparedStatement = null;
			
		Collection<prodottoBean> prodotti = new LinkedList<prodottoBean>();
		
		String selectSQL = "SELECT * FROM prodotti WHERE nome LIKE ?";
			
			/*
			* if (order != null && !order.equals("")) { selectSQL += " ORDER BY " + order;
			* }
			*/
			
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, name + "%");	 // % è la wildcard di mysql che prende name + altri infiniti caratteri che possono venir dopo		
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
				bean.setImmagine(rs.getString("immagine"));
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
	
	public synchronized Collection<prodottoBean> doRetrieveByCategoria(int idCat) throws SQLException { // aggiungere come parametro:
		// String order per ordinare
		// prodotti
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<prodottoBean> prodotti = new LinkedList<prodottoBean>();
		
		String selectSQL = "SELECT DISTINCT prodotti.* FROM (prodotti INNER JOIN appartiene on prodotti.codice = appartiene.id_prodotti) INNER JOIN categoria on appartiene.id_categoria = ?";
		
		/*
		* if (order != null && !order.equals("")) { selectSQL += " ORDER BY " + order;
		* }
		*/
		
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, idCat);	 // % è la wildcard di mysql che prende name + altri infiniti caratteri che possono venir dopo		
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
				bean.setImmagine(rs.getString("immagine"));
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
	
	public synchronized Collection<categoriaBean> doRetrieveCategorieByProdotto(int idProdotto) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    Collection<categoriaBean> categorie = new LinkedList<>();

	    String selectSQL = 
	        "SELECT c.id, c.nome " +
	        "FROM categoria c " +
	        "INNER JOIN appartiene a ON c.id = a.id_categoria " +
	        "WHERE a.id_prodotti = ?";

	    try {
	        connection = DriverManagerConnectionPool.getConnection();
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, idProdotto);
	        ResultSet rs = preparedStatement.executeQuery();

	        while (rs.next()) {
	            categoriaBean categoria = new categoriaBean();
	            categoria.setId(rs.getInt("id"));
	            categoria.setNome(rs.getString("nome"));
	            categorie.add(categoria);
	        }

	    } finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	        } finally {
	            DriverManagerConnectionPool.releaseConnection(connection);
	        }
	    }

	    return categorie;
	}

}
