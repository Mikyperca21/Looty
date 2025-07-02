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
            
            <% if (isAdmin) { %>
                
            <div id="filtri" class="action-button">
			    <label for="userId">Utente:</label>
					<select id="userId">
					    <option value="0">Tutti</option> 
					</select>


				    <label for="dataInizio">Da:</label>
				    <input type="date" id="dataInizio" />
				
				    <label for="dataFine">A:</label>
				    <input type="date" id="dataFine" />
			
			    <button id="filtraBtn" style="all:unset;"><span class="material-symbols-outlined">
					filter_alt
				</span></button>
			</div>
           	<% } %>
            
            

            <table class="ordini-table">
                <thead>
                    <tr>
                        <th>Anteprima</th>
                         <% if (isAdmin) { %>
                			<th>Utente</th>
           				 <% } %>
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
                        <% if (isAdmin) { %>
                			<td><%= ordine.getNomeUtente() %></td>  <!-- supponendo ci sia questo metodo -->
            			<% } %>
                        <td><%= formattedDate %></td>
                        <td>€<%= String.format("%.2f",ordine.getTotale()) %></td>
                        <td>
                            <a href="dettaglioOrdine?idOrdine=<%= ordine.getId() %>" class="action-button">
                                <span class="material-symbols-outlined">info</span>
                            </a>
                          
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

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    fetch("filtriOrdini")
    .then(response => response.json())
    .then(utenti => {
        const select = document.getElementById("userId");
        utenti.forEach(u =>{
            const option = document.createElement("option");
            option.value = u.id;
            option.textContent = u.nome + " " + u.cognome;
            select.appendChild(option);
        });
    })
    .catch(error => console.error("Errore caricamento utenti:", error));
});

document.getElementById("filtraBtn").addEventListener("click", function() {
    const userId = document.getElementById("userId").value;
    const dataInizio = document.getElementById("dataInizio").value;
    const dataFine = document.getElementById("dataFine").value;
    
    const dateIncompleta = (dataInizio && !dataFine) || (!dataInizio && dataFine);

    if (dateIncompleta) {
        alert("Per filtrare per data devi selezionare sia la data di inizio che di fine.");
        return; // blocca l'invio
    }
    
    let url = "filtriOrdini";
    
    if (userId) {
        url += "?userId=" + encodeURIComponent(userId);
    }

    if(dataInizio && dataFine) {
        url += (url.includes("?") ? "&" : "?") + "dataInizio=" + encodeURIComponent(dataInizio);
        url += "&dataFine=" + encodeURIComponent(dataFine);
    }

    
    window.location.href = url;
});


</script>
</body>
</html>
