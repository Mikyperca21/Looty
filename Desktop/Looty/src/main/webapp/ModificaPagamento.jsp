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


<%
int idUtente = utente.getId();
metodoPagamentoDAO metodoDAO = new metodoPagamentoDAO();
List<metodoPagamentoBean> metodi = metodoDAO.doRetrieveByUtente(idUtente);
%>
<html>
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
    <form method="post" action="ModificaPagamento?action=aggiungi"  onsubmit="event.preventDefault(); validate(this)">
        
        <div class="input-row">
            <div>
                <label for="titolare">Titolare della carta:</label>
                <input type="text" name="titolare" placeholder="Titolare della carta" id="titolare" required>
                <p class="errore" id="titolare-error" style="color:red;"></p>
            </div>
            <div>
                <label for="codiceCarta">Inserire il codice della carta</label>
                <input type="text" name="codiceCarta" placeholder="xxxx-xxxx-xxxx-xxxx" id="codice" required maxlength="16">
                <p class="errore" id="codice-error" style="color:red;"></p>
            </div>
        </div>

        <div class="input-row-tre">
            <div>
                <label for="cvv">CVV</label>
                <input type="text" name="cvv" placeholder="xxx" id="cvv" required maxlength="3"> 
                <p class="errore" id="cvv-error" style="color:red;"></p>
            </div>
            <div>
                <label for="meseScadenza">Mese di scadenza</label>
                <input type="number" name="meseScadenza" id="mese" required>
                <p class="errore" id="mese-error" style="color:red;"></p>
            </div>
            <div>
                <label for="annoScadenza">Anno di scadenza</label>
                <input type="number" name="annoScadenza" id="anno" required >
                <p class="errore" id="anno-error" style="color:red;"></p>
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
		
		function checkTitolare(input) {
			var titolare = /^[A-Za-z\s]+$/;
			if(input.value.match(titolare)){
				return true;
			} 

			return false;	
		}
		
		function checkOnlyNumber(input){
			var numeri = /^\d+$/;
			if(input.value.match(numeri)){
				return true;
			} 
			return false;
		}
		
		function checkMese(input) {
			var mese = /^([1-9]|1[0-2])$/;
			if(input.value.match(mese)){
				return true;
			} 

			return false;	
		}
		
		function checkAnno(input){
			var anno = /^(202[6-9]|20[3-9][0-9]|2[1-9][0-9]{2}|[3-9][0-9]{3})$/;
			if(input.value.match(anno)){
				return true;
			} 

			return false;	
		}
		
		function validate(obj) {	
			var valid = true;	
			
			const titolareError = document.getElementById("titolare-error");
			const codiceError = document.getElementById("codice-error");
			const cvvError = document.getElementById("cvv-error");
			const meseError = document.getElementById("mese-error");
			const annoError = document.getElementById("anno-error");
			

						
			var titolare = document.getElementById("titolare");
			var codice = document.getElementById("codice");
			var cvv = document.getElementById("cvv");
			var mese = document.getElementById("mese");
			var anno = document.getElementById("anno");

			
			
			if(!checkTitolare(titolare)) {
				valid = false;
				titolareError.textContent = "Inserisci un nome valido";
			}
			
			if(!checkOnlyNumber(codice)) {
				valid = false;
				codiceError.textContent = "Inserisci un codice valido";
			}
			
			if(!checkOnlyNumber(cvv)) {
				valid = false;
				cvvError.textContent = "Inserisci un cvv valido";
			}
			
			if(!checkMese(mese)) {
				valid = false;
				meseError.textContent = "Inserisci un mese valido";
			}
			
			if(!checkAnno(anno)) {
				valid = false;
				annoError.textContent = "Inserisci un anno valido";
			}

			if(valid){
				obj.submit();
			} 
		}


</script>
</html>