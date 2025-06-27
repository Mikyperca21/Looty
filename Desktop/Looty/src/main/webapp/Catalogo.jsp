<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean, model.Carrello"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Looty</title>
	<link rel="stylesheet" href="style/Catalogo.css">
	<link rel="icon" href="images/LogoLooty_resized.png">
	<!-- Material Symbols -->
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>
	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>

	
		<h2>I nostri prodotti:</h2>
		

	<div class="container">
		<%
		Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
		if (request.getAttribute("prodotti") == null) {
			response.sendRedirect(request.getContextPath() + "/catalogo");
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
		%>
			<div class="card<%= bean.getQuantita() == 0 ? " disabled" : "" %>">
				<div class="card-img">
					<a href="dettaglioProdotto?action=getProdotto&id=<%=bean.getCodice()%>" style="text-decoration: none;">
						<img src="<%=bean.getImmagine()%>" />
					</a>
				</div>
				
				<div class="card-content">
					<h2 class="card-title"><%=bean.getNome()%></h2>
	
					<% if (bean.getQuantita() > 0) { %>
						<form action="catalogo" method="post" class="carrello-form">
							<input type="hidden" name="action" value="aggiungiCarrello">
							<input type="hidden" name="id" value="<%=bean.getCodice()%>">
	
							<div class="form-inline">
								<select name="dimensione" required>
									<option value="">Taglia</option>
									<option value="S">S</option>
									<option value="M">M</option>
									<option value="L">L</option>
								</select>
								<input type="number" name="quantita" min="1" max="<%=bean.getQuantita()%>" value="1" required />
								<button type="submit" class="action-button">
									<span class="material-symbols-outlined">add_shopping_cart</span>
								</button>
							</div>
						</form>
					<% } else { %>
						<p class="unavailable-message">Prodotto non disponibile</p>
						<div class="form-inline">
							<select disabled>
								<option>Non disponibile</option>
							</select>
							<input type="number" value="0" disabled />
							<button disabled class="action-button">
								<span class="material-symbols-outlined">remove_shopping_cart</span>
							</button>
						</div>
					<% } %>
	
					<p class="prezzo">
						A partire da: <%= String.format("%.2f", bean.getPrezzoS()) %> €
					</p>
				</div>
			</div>
		<%
			}
		}
		%>
	</div>
		<br><br><br><br>
	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
	<script>
document.addEventListener("DOMContentLoaded", function() {
    const forms = document.querySelectorAll(".carrello-form");

    forms.forEach(form => {
        form.addEventListener("submit", function(e) {
            const button = form.querySelector(".action-button");
            const icon = button.querySelector(".material-symbols-outlined");

            // Cambia colore bottone
            icon.style.backgroundColor = "#4CAF50"; 
            icon.style.color = "#FFFFFF"
            icon.textContent = "check"; 
            button.disabled = true;

            setTimeout(() => {
                icon.textContent = "add_shopping_cart"; 
                button.disabled = false;
            }, 5000);
        });
    });
});
</script>
	
</body>
</html>
