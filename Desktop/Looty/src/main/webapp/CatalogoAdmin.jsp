<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Catalogo Amministratore</title>
<link rel="stylesheet" href="style/CatalogoAdmin.css">
</head>
<body>

	<h2>Catalogo Amministratore:</h2>

	<div class="table-container">
		<%
		// Recupero della collezione di prodotti dall'attributo della richiesta
		Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
		if (request.getAttribute("prodotti") == null) {
			response.sendRedirect("/catalogo");

			prodottoBean prodotto = (prodottoBean) request.getAttribute("prodotto");
		}
		%>
		<table class="product-table">
			<thead>
				<tr>
					<th>Nome</th>
					<th>Prezzo taglia S</th>
					<th>Prezzo taglia M</th>
					<th>Prezzo taglia L</th>
					<th>Descrizione</th>
					<th>Quantità</th>
					<th>Azione</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (prodotti != null && prodotti.size() != 0) {
					Iterator<?> it = prodotti.iterator();
					while (it.hasNext()) {
						prodottoBean bean = (prodottoBean) it.next();
				%>

				<tr>

					<td><%=bean.getNome()%></td>
					<td><%=bean.getPrezzoS()%> €</td>
					<td><%=bean.getPrezzoM()%> €</td>
					<td><%=bean.getPrezzoL()%> €</td>
					<td><%=bean.getDescrizione()%></td>
					<td><%=bean.getQuantita()%></td>
					<td class="button-container">
					<a href="catalogo?action=delete&id=<%=bean.getCodice()%>">
							<button class="action-button">
								<span class="material-symbols-outlined">delete</span>
							</button>
					</a>
					<a href="catalogo?action=modify&id=<%=bean.getCodice()%>">
							<button class="action-button">
								<span class="material-symbols-outlined">edit</span>
							</button>
					</a></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="6">No products available</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>



	<div id="form-container" class="form">
		<div class="form-content">
			<h2>Nuovo Prodotto</h2>
			<form action="<%= request.getContextPath() %>/catalogo" method="post">
				<input type="hidden" name="action" value="inserisci">

				<div class="form-group">
					<label for="nome">Nome:</label> <input type="text" id="nome"
						placeholder="Inserisci il nome" name="nome" required>
				</div>

				<div class="form-group">
					<label for="prezzoS">Prezzo per la mystery box di taglia S:</label>
					<input type="number" step="any" id="prezzoS" name="prezzoS"
						min="0.01" placeholder="Inserisci il prezzo per la box piccola"
						required>
				</div>
				<div class="form-group">
					<label for="prezzoM">Prezzo per la mystery box di taglia M:</label>
					<input type="number" step="any" id="prezzoM" name="prezzoM"
						min="0.01" placeholder="Inserisci il prezzo per la box media"
						required>
				</div>
				<div class="form-group">
					<label for="prezzoL">Prezzo per la mystery box di taglia L:</label>
					<input type="number" step="any" id="prezzoL" name="prezzoL"
						min="0.01" placeholder="Inserisci il prezzo per la box grande"
						required>
				</div>

				<div class="form-group">
					<label for="quantita">Quantità di box disponibili:</label> <input
						type="number" id="quantita" name="quantita" min="1"
						placeholder="Inserisci la quantità di box disponibili" required>
				</div>

				<div class="form-group">
					<label for="descrizione">Descrizione:</label>
					<textarea id="descrizione" name="descrizione"
						placeholder="Inserisci una descrizione della box" required></textarea>
				</div>

				<button type="submit" value="aggiungi">
					<span class="material-symbols-outlined">add</span>Inserisci
					Prodotto
				</button>
			</form>
		</div>
	</div>

</body>
</html>
