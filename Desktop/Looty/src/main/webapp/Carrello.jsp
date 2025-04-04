<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean, model.Carrello" %>
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
                List<prodottoBean> prodottiNelCarrello = carrello.getProdotti();
                for(prodottoBean prodCarr : prodottiNelCarrello) {
        %>
            <div class="card">
                <div class="card-body">
                    <h3><%= prodCarr.getNome() %></h3>
                    <p class="price">€<%= prodCarr.getPrezzoS() %></p>
                    <a href="catalogo?action=rimuoviCarrello&id=<%=prodCarr.getCodice()%>">
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
            <button type="button" onClick="window.location.href='http://localhost:8080/Looty/catalogo';">
                <span class="material-symbols-outlined">arrow_back</span>Torna Indietro
            </button>
            <button type="submit" value="null">
                <span class="material-symbols-outlined">payments</span>Procedi all'acquisto
            </button>
        </div>
    </div>
</body>
</html>
