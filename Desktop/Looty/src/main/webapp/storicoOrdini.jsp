<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, java.sql.*, model.ordineBean, model.ordineDAO, model.utenteBean, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<title>Storico Ordini</title>
<link rel="stylesheet" type="text/css" href="style/storicoOrdini.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>

	<h2>Storico Ordini</h2>

	<div class="carrello-container">
		<div class="articoli" style="flex: 1;">
			<h3>I tuoi ordini passati:</h3>

			<%
			utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
			if (utente == null) {
				response.sendRedirect("Login.jsp");
				return;
			}

			List<ordineBean> ordini = null;
			try {
				ordineDAO ordineDAO = new ordineDAO();
				ordini = ordineDAO.doRetrieveByUser(utente.getId(), null);

			} catch (SQLException e) {
				e.printStackTrace();
				out.println("<p>Errore nel recupero degli ordini</p>");
			}

			if (ordini != null && !ordini.isEmpty()) {
			%>

			<table class="ordini-table">
				<thead>
					<tr>
						<th>Anteprima</th>
						<th>Data Ordine</th>
						<th>Totale</th>
						<th>Dettagli</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (ordineBean ordine : ordini) {
					%>
					<tr>
						<td><img src="<%=ordine.getImmagineProdotto()%>"
							alt="Immagine prodotto" style="width: 50px; height: 50px;">
						</td>

						<%
						SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
						String formattedDate = sdf.format(ordine.getDataOrdine());
						%>

						<td><%=formattedDate%></td>
						<td>€<%=ordine.getTotale()%>
						</td>
						<td><a href="dettagliOrdine.jsp?idOrdine=<%=ordine.getId()%>"
							class="action-button"> <span
								class="material-symbols-outlined">info</span>
						</a> <a href="dettagliOrdine.jsp?idOrdine=<%=ordine.getId()%>"
							class="action-button"> <span
								class="material-symbols-outlined">picture_as_pdf</span>
						</a></td>

					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<%
			} else {
			out.println("<p>Non hai ancora effettuato ordini.</p>");
			}
			%>
		</div>
	</div>

	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>

</body>
</html>
