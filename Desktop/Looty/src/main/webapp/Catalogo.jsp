<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean, model.Carrello"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Looty</title>
<link rel="stylesheet" href="style/Catalogo.css">
</head>
<body>
	<%@ include file="Header.jsp"%>
	<div class="titolo">

		<h2 style="padding: 40px;">I nostri prodotti:</h2>
		<br>
	</div>
	<div class="container">
		<%
		// Recupero della collezione di prodotti dall'attributo della richiesta
		Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
		if (request.getAttribute("prodotti") == null) {
			response.sendRedirect("/catalogo");
		}
		prodottoBean prodotto = (prodottoBean) request.getAttribute("prodotto");
		Carrello carrello = (Carrello) session.getAttribute("carrello");

		if (prodotti == null || prodotti.isEmpty()) {
		%>
		<p>I prodotti al momento non sono disponibili.</p>
		<%
		} else {
		for (Object obj : prodotti) {
			prodottoBean bean = (prodottoBean) obj;
		%><div class="card">
			<a href="#" style="text-decoration: none;">
 <img
				src="<%=bean.getImmagine()%>" />
			</a>
			<h2 class="card-title"><%=bean.getNome()%></h2>

			<form action="catalogo" method="post" class="carrello-form">
				<input type="hidden" name="action" value="aggiungiCarrello">
				<input type="hidden" name="id" value="<%=bean.getCodice()%>">

				<div class="form-inline">
					<select name="dimensione" required>
						<option value="">Taglia</option>
						<option value="S">S</option>
						<option value="M">M</option>
						<option value="L">L</option>
					</select> <input type="number" name="quantita" min="1" max="10" value="1"
						required />

					<button type="submit" class="action-button">
						<span class="material-symbols-outlined">add_shopping_cart</span>
					</button>
				</div>
			</form>
			<p><%=bean.getDescrizione()%></p>
			<p class="prezzo">
				A partire da:
				<%=bean.getPrezzoS()%>
				€
			</p>
			
		</div>

		<%
		}
		}
		%>
	</div>

	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>

</body>
</html>
