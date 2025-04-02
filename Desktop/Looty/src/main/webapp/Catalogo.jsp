<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Looty</title>
    <link rel="stylesheet" href="style/Catalogo.css">
</head>
<body>
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
        
        if (prodotti == null || prodotti.isEmpty()) {
        %>
            <p>I prodotti al momento non sono disponibili.</p>
        <%
            } else {
                for (Object obj : prodotti) {
                    prodottoBean bean = (prodottoBean) obj;
        %>
                    <div class="card">
                        <a href="#" style="text-decoration: none;">
                            <img src="#" alt="<%= bean.getNome() %>">
                        </a>
                        <div class="title-container">
                            <h2><%= bean.getNome() %></h2>
                            <p><span class="material-symbols-outlined">add_shopping_cart</span></p>
                        </div>
                        <p class="prezzo">A partire da: <%= bean.getPrezzoS() %> € </p>
                        <p style="color: black;"><%= bean.getDescrizione() %></p>
                    </div>
        <%
                }
            }
        %>
    </div>
    
   

</body>
</html>
