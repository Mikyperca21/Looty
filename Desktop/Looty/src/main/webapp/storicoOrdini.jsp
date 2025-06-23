<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.ordineBean, model.utenteBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Storico Ordini</title>
    <link rel="stylesheet" type="text/css" href="style/storicoOrdini.css">
    <link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

    <div class="container-header">
        <%@ include file="Header.jsp" %>
    </div>

    <h2>Storico Ordini</h2>

    <div class="carrello-container">
        <div class="articoli" style="flex: 1;">
            <h3>
                <% 
                    utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
                    if (utente == null) {
                        response.sendRedirect("Login.jsp");
                        return;
                    }

                    boolean isAdmin = utente.getRuolo(); // true se admin
                    out.print(isAdmin ? "Tutti gli ordini effettuati:" : "I tuoi ordini passati:");
                %>
            </h3>

            <%
            List<ordineBean> ordini = (List<ordineBean>) request.getAttribute("ordini");


                if (ordini != null && !ordini.isEmpty()) {
            %>

            <table class="ordini-table">
                <thead>
                    <tr>
                        <th>Anteprima</th>
                        <th>Data Ordine</th>
                        <th>Totale</th>
                        <th>Dettagli</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

                        for (ordineBean ordine : ordini) {
                            String formattedDate = sdf.format(ordine.getDataOrdine());
                    %>
                    <tr>
                        <td><img src="<%= ordine.getImmagine() %>" alt="Immagine prodotto" style="width: 50px; height: 50px;"></td>
                        <td><%= formattedDate %></td>
                        <td>€<%= ordine.getTotale() %></td>
                        <td>
                            <a href="dettaglioOrdine?idOrdine=<%= ordine.getId() %>" class="action-button">
                                <span class="material-symbols-outlined">info</span>
                            </a>
                           <!--  <a onclick="window.print()" href="#" class="action-button">
                                <span class="material-symbols-outlined">picture_as_pdf</span>
                            </a> -->
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <%
                } else {
                    out.println("<p>Nessun ordine disponibile.</p>");
                }
            %>
        </div>
    </div>

    <div class="container-footer">
        <%@ include file="Footer.jsp" %>
    </div>

</body>
</html>
