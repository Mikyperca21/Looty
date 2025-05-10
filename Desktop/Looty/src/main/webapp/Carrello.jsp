<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, model.prodottoBean, model.Carrello, model.ElementoCarrello"%>
<%
Carrello carrello = (Carrello) session.getAttribute("carrello");
double totale = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>
<link rel="stylesheet" href="style/Carrello.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>

	<h2>Il tuo carrello:</h2>
	<div class="carrello-container">
		<div class="articoli">
			<%
			if (carrello != null && carrello.getProdotti() != null && !carrello.getProdotti().isEmpty()) {
				List<ElementoCarrello> prodottiNelCarrello = carrello.getProdotti();
				for (ElementoCarrello prodCarr : prodottiNelCarrello) {
					double prezzoTotale = prodCarr.getPrezzoTotale();
					totale += prezzoTotale; 
			%>
			<div class="card">
				<div class="product-image">
					<img src="<%=prodCarr.getProdotto().getImmagine()%>"
						alt="Immagine prodotto">
				</div>
				<div class="product-details">
					<h3><%=prodCarr.getProdotto().getNome()%></h3>
					<p class="price">
						€<%=String.format("%.2f", prezzoTotale)%></p>
					<p>
						Dimensione:
						<%=prodCarr.getDimensione()%></p>
				</div>
				<div class="product-actions">
					<form action="catalogo" method="post" style="display: inline;">
						<input type="hidden" name="action"
							value="modificaQuantitaCarrello" /> <input type="hidden"
							name="id" value="<%=prodCarr.getProdotto().getCodice()%>" /> <input
							type="hidden" name="dimensione"
							value="<%=prodCarr.getDimensione()%>" />
						<button type="submit" class="action-button" name="operazione"
							value="decrementa"><span class="material-symbols-outlined">
remove
</span></button>
						<input type="number" name="quantita"
							value="<%=prodCarr.getQuantita()%>" min="1" max="99" required />
						<button type="submit" class="action-button" name="operazione"
							value="incrementa"><span class="material-symbols-outlined">
add
</span></button>
					</form>
				</div> <br>

					<a
						href="catalogo?action=rimuoviCarrello&id=<%=prodCarr.getProdotto().getCodice()%>&dimensione=<%=prodCarr.getDimensione()%>&quantita=<%=prodCarr.getQuantita()%>">
						<button class="action-button delete-button">
							<span class="material-symbols-outlined">delete</span>
						</button>
					</a>

			</div>
			<%
			}
			%>
		</div>
		<div class="riepilogo">
			<h3>Riepilogo Ordine</h3> <br>
			<p>
				Totale Prodotti (comprensivo di IVA): €<%=String.format("%.2f", totale)%></p> <br>
			<p>Costo di spedizione: €0,00</p> <br>
			<div class="container-button">
				<!-- <button type="button" onClick="window.location.href='catalogo';">
					<span class="material-symbols-outlined">arrow_back</span>Torna Indietro
				</button> -->
				<form action="acquisto" method="post">
					<button type="submit">
						<span class="material-symbols-outlined">payments</span> Procedi
						all'acquisto
					</button>
				</form>
			</div>
		</div>
	</div>
	<%
	} else {
	%>

	<div class="empty-cart-message">
		<p>Il carrello è vuoto.</p>
		<%
		}
		%>
	</div>

	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>
</html>
