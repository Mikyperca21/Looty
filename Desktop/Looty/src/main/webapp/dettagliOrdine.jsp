<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat" %>
<%@ page import="model.ordineBean, model.ordineDAO, model.ordineProdottoBean, model.prodottoBean, model.prodottoDAO" %>
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
    int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
    ordineBean ordine = null;
    List<ordineProdottoBean> dettagliOrdine = null;

    try {
        ordineDAO dao = new ordineDAO();
        ordine = dao.doRetrieveById(idOrdine);
        dettagliOrdine = dao.doRetrieveByOrdine(idOrdine);
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Errore nel recupero dei dettagli dell'ordine.</p>");
    }

    if (ordine != null && dettagliOrdine != null && !dettagliOrdine.isEmpty()) {
%>

<div class="dettagli-ordine">
    <div class="ordine-header">
    <h3>Codice ordine: <%= ordine.getId() %></h3>
    <a href="generarePDF.jsp?idOrdine=<%= ordine.getId() %>" class="action-button" title="Scarica Fattura">
        <span class="material-symbols-outlined">picture_as_pdf</span>
    </a>
</div>
<p>Data Ordine: <%= new SimpleDateFormat("dd/MM/yyyy").format(ordine.getDataOrdine()) %></p>
<p>Totale: €<%= ordine.getTotale() %></p>

<hr class="separatore">

<h4>Indirizzo di Spedizione:</h4>
<p><strong>Via:</strong> <%= ordine.getVia() %></p>
<p><strong>Città:</strong> <%= ordine.getCitta() %> (<%= ordine.getProvincia() %>)</p>
<p><strong>CAP:</strong> <%= ordine.getCap() %></p>
<p><strong>Paese:</strong> <%= ordine.getPaese() %></p>
<p><strong>Telefono:</strong> <%= ordine.getTelefono() %></p>

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

                for (ordineProdottoBean dettaglio : dettagliOrdine) {
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
