<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, model.prodottoBean, model.Carrello"%>

<%
prodottoBean prodotto = (prodottoBean) request.getAttribute("prodotto");
Carrello carrello = (Carrello) session.getAttribute("carrello");
%>

<!doctype html>

<html>
<head>
<title><%=prodotto.getNome()%> - Looty</title>
<link rel="stylesheet" href="style/dettaglioprodotto.css">
<link href='https://fonts.googleapis.com/css?family=Montserrat'
	rel='stylesheet'>
<link rel="icon" href="images/LogoLooty_resized.png">
</head>

<body>
	<%@ include file="Header.jsp"%>
	<div class="container">
		<div class="content">
			<span><img src="<%=prodotto.getImmagine()%>" alt="dinamico"></span>
			<div class="text">
				<h1><%=prodotto.getNome()%></h1>
				<p><%=prodotto.getDescrizione()%></p>
				<form action="catalogo" method="post">
					<%
					if (prodotto.getQuantita() > 0) {
					%>
					<input name="quantita" type="number" value="1"
						max="<%=prodotto.getQuantita()%>" placeholder="Quantit&agrave;"
						required> <br>
					<br> <input type="hidden" name="action"
						value="aggiungiCarrello"> <input type="hidden" name="id"
						value="<%=prodotto.getCodice()%>"> <select
						name="dimensione" required>
						<option value="">Seleziona</option>
						<option value="S">S</option>
						<option value="M">M</option>
						<option value="L">L</option>
					</select>
					<p>
						Solo
						<%=prodotto.getQuantita()%>
						disponibili
					</p>
					<input type="submit" value="Aggiungi al carrello">
					<%
					} else {
					%>
					<p style="color: red;">Prodotto non disponibile</p>
					<input type="number" value="0" disabled> <select disabled>
						<option>Non disponibile</option>
					</select> <br>
					<br> <input type="submit" value="Non disponibile" disabled
						style="background-color: gray; cursor: not-allowed;">
					<%
					}
					%>
				</form>

			</div>
		</div>
	</div>
	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
	
</body>
</html>