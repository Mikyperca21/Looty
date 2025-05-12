<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, model.utenteBean, model.metodoPagamentoBean, model.metodoPagamentoDAO"%>
<%
utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
if (utente == null) {
	response.sendRedirect("Login.jsp");
	return;
}
%>
<!DOCTYPE html>

<html>

<%
int idUtente = utente.getId();
metodoPagamentoDAO metodoDAO = new metodoPagamentoDAO();
List<metodoPagamentoBean> metodi = metodoDAO.doRetrieveByUtente(idUtente);
%>
<head>
<meta charset="UTF-8">
<title>Modifica metodo di pagamento</title>
<link rel="stylesheet" href="style/ModificaIndirizzo.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>

	<h2>Metodi di pagamento</h2>

	
		<%
		for (metodoPagamentoBean metodo : metodi) {
		%>
		<div class="container-form">
		
	
			<div class="card-indirizzo" id="card-<%=metodo.getId()%>">
			
			<div style="display: flex; justify-content: flex-end; gap: 8px; margin-bottom: 10px;">
  <i class="fa fa-cc-visa" style="color:navy; font-size: 24px;"></i>
  <i class="fa fa-cc-amex" style="color:blue; font-size: 24px;"></i>
  <i class="fa fa-cc-mastercard" style="color:red; font-size: 24px;"></i>
  <i class="fa fa-cc-discover" style="color:orange; font-size: 24px;"></i>
</div>

<label>
	<input type="radio" name="preferito"
	value="<%=metodo.getId()%>"
	<%=metodo.isPreferito() ? "checked" : "" %>
	onchange="impostaPreferito(<%=metodo.getId()%>)">
Metodo di pagamento preferito

</label>



            
            <p> <strong>Titolare: </strong> <%= metodo.getTitolare() %>
				<p>
					<strong>Codice carta:</strong>
					<%=metodo.getCodiceCarta()%>
				</p>
				<p>
					<strong>Data scadenza: </strong>
					<%=metodo.getMeseScadenza()%>
					/
					<%=metodo.getAnnoScadenza()%>
				</p>
				
				<div class="container-delete">
				<form method="post" action="ModificaPagamento?action=elimina"
					onsubmit="return confirm('Sicuro di eliminare?')">
					<input type="hidden" name="id" value="<%=metodo.getId()%>">
					<button type="submit">
						<span class="material-symbols-outlined">delete</span> Elimina
						metodo di pagamento
					</button>
				</form>
				</div>
			</div>
		</div>


	<%
	}
	%>
	
	<div class="card-indirizzo">
    <h3>Aggiungi un nuovo metodo di pagamento</h3>
    <form method="post" action="ModificaPagamento?action=aggiungi">
        
        <div class="input-row">
            <div>
                <label for="titolare">Titolare della carta:</label>
                <input type="text" name="titolare" placeholder="Titolare della carta" required>
            </div>
            <div>
                <label for="codiceCarta">Inserire il codice della carta</label>
                <input type="text" name="codiceCarta" placeholder="xxxx-xxxx-xxxx-xxxx" required maxlength="16">
            </div>
        </div>

        <div class="input-row-tre">
            <div>
                <label for="cvv">CVV</label>
                <input type="text" name="cvv" placeholder="xxx" required maxlength="3"> 
            </div>
            <div>
                <label for="meseScadenza">Mese di scadenza</label>
                <input type="number" name="meseScadenza" min="1" max="12" required>
            </div>
            <div>
                <label for="annoScadenza">Anno di scadenza</label>
                <input type="number" name="annoScadenza" required min="2025" max="2030">
            </div>
        </div>
        <div class="container-aggiungi">
        <button type="submit">Aggiungi metodo di pagamento</button>
        </div>
    </form>
</div>




	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>

<script>
		function impostaPreferito(id) {
			fetch('ModificaPagamento?action=setPreferito&id=' + id, {
		        method: 'GET'
		    })
		    .then(response => {
		        if (response.ok) {
		            window.location.href = "ProfiloUtente.jsp"; 
		        } else {
		            response.text().then(errorMessage => {
		                console.error("Errore nel server:", errorMessage);
		                alert("Errore nell'impostare l'indirizzo preferito.");
		            });
		        }
		    })
		    .catch(error => {
		        console.error("Errore nella comunicazione:", error);
		        alert("Errore nell'impostare l'indirizzo preferito.");
		    });
		}


</script>
</html>