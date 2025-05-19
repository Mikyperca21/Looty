<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.utenteBean, model.Carrello, model.ElementoCarrello, model.indirizzoDAO, model.indirizzoBean, model.metodoPagamentoDAO, model.metodoPagamentoBean" %>


<%


utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
if (utente == null) {
	response.sendRedirect("Login.jsp");
	return;
}
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    double totale = 0.0;
    if (carrello != null) {
        for (ElementoCarrello item : carrello.getProdotti()) {
            totale += item.getPrezzoTotale();
        }
    }


    indirizzoDAO dao = new indirizzoDAO();
    indirizzoBean indirizzo = dao.doRetrievePreferitoByUtente(utente.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="style/Checkout.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>
	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>

    <h2>Riepilogo Ordine</h2>

<div class="checkout-container">

    <!-- Colonna sinistra: Prodotti -->
    <div class="col-left">
        <div class="anteprima-prodotti">
            <h3>Prodotti nel carrello</h3>
            <div class="prodotti-list">
                <% if (carrello != null && carrello.getProdotti() != null) {
                    for (ElementoCarrello item : carrello.getProdotti()) { %>
                        <div class="prodotto-item">
                            <img src="<%= item.getProdotto().getImmagine() %>" alt="<%= item.getProdotto().getNome() %>">
                            <div class="prodotto-info">
                                <p><strong><%= item.getProdotto().getNome() %></strong></p>
                                <p>Dimensione: <%= item.getDimensione() %></p>
                                <p>Quantità: <%= item.getQuantita() %></p>
                                <p>Prezzo: €<%= String.format("%.2f", item.getPrezzoTotale()) %></p>
                            </div>
                        </div>
                <% } } else { %>
                    <p>Il carrello è vuoto.</p>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Colonna destra: Indirizzo, Totale, Pulsante -->
    <div class="col-right">
        <div class="indirizzo">
            <h3>Indirizzo di Spedizione</h3>
            <%if (indirizzo == null ) { %>
            	<a href="ModificaIndirizzo.jsp">Inserisci un indirizzo</a>	
            <% } else { %>>
            	<p><strong>Destinatario:</strong> <%= utente.getNome() %> <%= utente.getCognome() %></p>
	            <p><%= indirizzo.getVia() %>, <%= indirizzo.getCitta() %> (<%= indirizzo.getProvincia() %>), <%= indirizzo.getCap() %></p>
	            <p><%= indirizzo.getPaese() %></p>
	            <p>Telefono: <%= indirizzo.getTelefono() %></p>
	            <a href="ModificaIndirizzo.jsp">Modifica Indirizzo</a>
            <%} %>
        </div>
        <%
		    metodoPagamentoDAO metodoDAO = new metodoPagamentoDAO();
		    metodoPagamentoBean metodoPreferito = metodoDAO.doRetrievePreferitoByUtente(utente.getId());
		%>
        <div class="indirizzo">
            <h3>Metodo di pagamento: </h3>
            <% if (metodoPreferito == null) {%>
            	<a href="ModificaPagamento.jsp">Inserisci un metodo di pagamento</a>
            <% } else {    		
		    String numeroCarta = metodoPreferito.getCodiceCarta();
		    String formatoCarta = "xxxx-xxxx-xxxx-" + numeroCarta.substring(numeroCarta.length() - 4);
            %>
            <p><strong>Numero carta:</strong> <%= formatoCarta %></p>
            <a href="ModificaPagamento.jsp">Modifica metodo di pagamento</a>%>
            	
            <% } %>
        </div>

        <div class="totale">
            <p><strong>Totale ordine:</strong> €<%= String.format("%.2f", totale) %></p>
        </div>

        <form class="checkout-form" action="acquisto" method="post">
            <input type="hidden" name="via" value="<%= indirizzo.getVia() %>">
            <input type="hidden" name="citta" value="<%= indirizzo.getCitta() %>">
            <input type="hidden" name="cap" value="<%= indirizzo.getCap() %>">
            <input type="hidden" name="provincia" value="<%= indirizzo.getProvincia() %>">
            <input type="hidden" name="paese" value="<%= indirizzo.getPaese() %>">
            <input type="hidden" name="telefono" value="<%= indirizzo.getTelefono() %>">
            <button type="submit">Conferma e Acquista</button>
        </form>
    </div>
</div>
    <div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>
</html>
