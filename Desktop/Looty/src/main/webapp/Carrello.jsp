<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, model.prodottoBean, model.Carrello, model.ElementoCarrello"%>
<%
Carrello carrello = (Carrello) session.getAttribute("carrello");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>
<link rel="stylesheet" href="style/Carrello.css">
</head>
<body>
	<h2>Carrello</h2>
	<div class="carrello-container">
		<%
		if (carrello != null && carrello.getProdotti() != null && !carrello.getProdotti().isEmpty()) {
			List<ElementoCarrello> prodottiNelCarrello = carrello.getProdotti();
			for (ElementoCarrello prodCarr : prodottiNelCarrello) {
		%>
		<div class="card">
			<div class="card-body">
				<h3><%=prodCarr.getProdotto().getNome()%></h3>
				<p class="price">
					€<%=prodCarr.getPrezzoTotale()%></p>
				<p>
					Dimensione:
					<%=prodCarr.getDimensione()%></p>
				<form action="catalogo" method="post" style="display: inline;">
					<input type="hidden" name="action" value="modificaQuantitaCarrello" />
					<input type="hidden" name="id"
						value="<%=prodCarr.getProdotto().getCodice()%>" /> <input
						type="hidden" name="dimensione"
						value="<%=prodCarr.getDimensione()%>" /> <input type="number"
						name="quantita" value="<%=prodCarr.getQuantita()%>" min="1"
						max="99" required />
					<button type="submit" class="action-button">Aggiorna</button>
				</form>
				<a
					href="catalogo?action=rimuoviCarrello&id=<%=prodCarr.getProdotto().getCodice()%>&dimensione=<%=prodCarr.getDimensione()%>&quantita=<%=prodCarr.getQuantita()%>">

					<button class="action-button">
						<span class="material-symbols-outlined">delete</span>
					</button>
				</a>
			</div>
		</div>
		<%
		}
		} else {
		%>
		<p>Il carrello è vuoto.</p>
		<%
		}
		%>
		<div class="container-button">
			<button type="button" onClick="window.location.href='catalogo';">
				<span class="material-symbols-outlined">arrow_back</span>Torna
				Indietro
			</button>
			<button type="submit">
					<span class="material-symbols-outlined">payments</span>Procedi
					all'acquisto
			</button>
				
			
		</div>
	</div>
</body>
</html>
