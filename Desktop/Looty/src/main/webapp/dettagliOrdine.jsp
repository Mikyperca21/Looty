<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat" %>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dettagli Ordine</title>
    <link rel="stylesheet" type="text/css" href="style/dettagliOrdine.css">
    <link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>


<h2>Dettagli Ordine</h2>

<%
	List<ordineProdottoBean> opb = (List<ordineProdottoBean>) request.getAttribute("prodottiOrdine");
	indirizzoBean indirizzo = (indirizzoBean) request.getAttribute("indirizzo");
	metodoPagamentoBean metodoPagamento = (metodoPagamentoBean) request.getAttribute("meotodoPagamento");
	ordineBean ordine = (ordineBean) request.getAttribute("ordine");
	
    if (ordine != null && opb != null && !opb.isEmpty()) {
%>

<div class="dettagli-ordine">
    <div class="ordine-header">
    <h3>Codice ordine: <%= ordine.getId() %></h3>
    <a href="generarePDF.jsp?idOrdine=<%= ordine.getId() %>" class="action-button" title="Scarica Fattura">
        <span class="material-symbols-outlined">picture_as_pdf</span>
    </a>
</div>
<p>Data Ordine: <%= new SimpleDateFormat("dd/MM/yyyy").format(ordine.getDataOrdine()) %></p>


<hr class="separatore">

<h4>Indirizzo di Spedizione:</h4>
<p><strong>Cliente:</strong> <%= metodoPagamento.getTitolare() %></p>
<p><strong>Via:</strong> <%= indirizzo.getVia() %></p>
<p><strong>Città:</strong> <%= indirizzo.getCitta() %> (<%= indirizzo.getProvincia() %>)</p>
<p><strong>CAP:</strong> <%= indirizzo.getCap() %></p>
<p><strong>Paese:</strong> <%= indirizzo.getPaese() %></p>
<p><strong>Telefono:</strong> <%= indirizzo.getTelefono() %></p>

<hr class="separatore">

    <h4>Dettagli dei Prodotti:</h4>
    <table class="dettagli-table">
        <thead>
            <tr>
                <th>Immagine</th>
                <th>Nome Prodotto</th>
                <th>Prezzo</th>
                <th>Quantità</th>
                <th>Totale</th>
            </tr>
        </thead>
        <tbody>
            <%
                prodottoDAO dao = new prodottoDAO(); 

                for (ordineProdottoBean dettaglio : opb) {
                    prodottoBean prodotto = dao.doRetrieveByKey(dettaglio.getIdProdotto());

                    double prezzoUnitario = dettaglio.getPrezzoUnitario();
                    int quantita = dettaglio.getQuantita();
                    double totaleProdotto = prezzoUnitario * quantita;
            %>
            <tr>
                <td><img src="<%= prodotto.getImmagine() %>" alt="<%= prodotto.getNome() %>" style="width: 50px; height: 50px;"></td>
                <td><%= prodotto.getNome() %></td>
                <td>€<%= prezzoUnitario %></td>
                <td><%= quantita %></td>
                <td>€<%= totaleProdotto %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <br><br>
    <hr class="separatore"> <br> <br>
	<strong>Totale ordine: </strong> €<%= ordine.getTotale() %></p>
    
</div>

<%
    } else {
        out.println("<p>Dettagli non trovati.</p>");
    }
%>

<div class="container-footer">
    <%@ include file="Footer.jsp" %>
</div>

</body>
</html>
