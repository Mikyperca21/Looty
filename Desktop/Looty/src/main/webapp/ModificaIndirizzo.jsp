<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, model.utenteBean, model.utenteDAO, model.indirizzoDAO, model.indirizzoBean"%>
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
indirizzoDAO indirizzoDao = new indirizzoDAO();
List<indirizzoBean> indirizzi = indirizzoDao.doRetrieveByUtente(idUtente);
%>
<html>
<head>
<meta charset="UTF-8">
<title>I miei indirizzi</title>
<link rel="stylesheet" type="text/css"
	href="style/ModificaIndirizzo.css">
<link rel="icon" href="images/LogoLooty_resized.png">

</head>
<body>

	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>
	<h2>I miei indirizzi</h2>

	<div class="container-form">
		<%
		for (indirizzoBean i : indirizzi) {
		%>
		<div class="container-form">
			<div class="card-indirizzo" id="card-<%=i.getId()%>">
				<form method="post" action="ModificaIndirizzo?action=modifica" onsubmit="event.preventDefault(); validate(this)">
				<input type="hidden" name="id" value="<%= i.getId() %>">
				
					<div class="form-row">
					    <label for="etichetta">Etichetta</label>
					    <input type="text" id="etichetta" name="etichetta" 
					           value="<%= i.getEtichetta() != null && !i.getEtichetta().isEmpty() ? i.getEtichetta() : "" %>" 
					           readonly placeholder="Etichetta">
					           <label for="citta">Città</label>
					    <input type="text" id="citta" name="citta" 
					           value="<%= i.getCitta() != null && !i.getCitta().isEmpty() ? i.getCitta() : "" %>" 
					           readonly required placeholder="Città">
					</div>
					
					<div class="form-row">
						<label for="via">Via</label>
					    <input type="text" id="via" name="via" 
					           value="<%= i.getVia() != null && !i.getVia().isEmpty() ? i.getVia() : "" %>" 
					           readonly required placeholder="Via">
					</div>
					
					<div class="form-row">
					    
					    <label for="provincia">Provincia</label>
					    <input type="text" id="provincia" name="provincia" 
					           value="<%= i.getProvincia() != null && !i.getProvincia().isEmpty() ? i.getProvincia() : "" %>" 
					           readonly required placeholder="Provincia">
					    <label for="cap">CAP</label>
					    <input type="text" id="cap" name="cap" 
					           value="<%= i.getCap() != null && !i.getCap().isEmpty() ? i.getCap() : "" %>" 
					           readonly required placeholder="CAP">
					</div> 
					
					<div class="form-row">
					    <label for="paese">Paese</label>
					    <input type="text" id="paese" name="paese" 
					           value="<%= i.getPaese() != null && !i.getPaese().isEmpty() ? i.getPaese() : "" %>" 
					           readonly required placeholder="Paese">
					    <label for="telefono">Telefono</label>
					    <input type="text" id="telefono" name="telefono" 
					           value="<%= i.getTelefono() != null && !i.getTelefono().isEmpty() ? i.getTelefono() : "" %>" 
					           readonly required placeholder="Telefono">
					</div>

					<div>
						<label> <input type="radio" name="preferito"
							value="<%=i.getId()%>"
							<%=i.isIs_preferito() ? "checked" : ""%>
							onchange="impostaPreferito(<%=i.getId()%>)"> Indirizzo
							preferito
						</label>
					</div>

					<div class="button-container">
						<button type="button" onclick="abilitaModifica(<%=i.getId()%>)">
							<span class="material-symbols-outlined">edit</span> 
						</button>
						<button type="submit" style="display: none;"
							id="salva-<%=i.getId()%>">
							<span class="material-symbols-outlined">save</span> 
						</button>
						<button type="button" onclick="annullaModifica(<%=i.getId()%>)"
							style="display: none;" id="annulla-<%=i.getId()%>">
							<span class="material-symbols-outlined">cancel</span> 
						</button>
					</div>
				</form>
				<div class="container-delete">
				<form method="post" action="ModificaIndirizzo?action=elimina"
					onsubmit="return confirm('Sicuro di eliminare?')">
					<input type="hidden" name="id" value="<%=i.getId()%>">
					<button type="submit">
						<span class="material-symbols-outlined">delete</span> Elimina indirizzo
					</button>
				</form>
				</div>
			</div>
		</div>

		<%
		}
		%>




		<div class="card-indirizzo">
    <h3>Aggiungi un nuovo indirizzo</h3>
    <form method="post" action="ModificaIndirizzo?action=aggiungi" onsubmit="event.preventDefault(); validate(this)">
        	<p style="color:red;" id="citta-error"></p>
			<p style="color:red;" id="via-error"></p>
			<p style="color:red;" id="cap-error"></p>
        <div class="input-row">
			
        
        	<div>
                <label for="etichetta">Etichetta</label>
                <input type="text" name="etichetta" placeholder="Casa, lavoro, ... ">
            </div>
            <div>
                <label for="via">Via</label>
                <input type="text" name="via" placeholder="Via" required>
            </div>
            <div>
                <label for="citta">Città</label>
                <input type="text" name="citta" placeholder="Città" required>
            </div>
        </div>

        <div class="input-row">
            <div>
                <label for="provincia">Provincia</label>
                <input type="text" name="provincia" placeholder="Provincia" required>
            </div>
            <div>
                <label for="cap">CAP</label>
                <input type="text" name="cap" placeholder="CAP" required>
            </div>
        </div>

        <div class="input-row">
            <div>
                <label for="paese">Paese</label>
                <input type="text" name="paese" placeholder="Paese" required>
            </div>
            <div>
                <label for="telefono">Telefono</label>
                <input type="text" name="telefono" placeholder="Telefono" required>
            </div>
        </div>
        
			<p style="color:red;" id="provincia-error"></p>
			<p style="color:red;" id="paese-error"></p>
			<p style="color:red;" id="telefono-error"></p>
		<div class="container-aggiungi">
        <button type="submit">Aggiungi Indirizzo</button>
        </div>
    </form>
</div>



		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>

		<script>
		function impostaPreferito(id) {
		    fetch('ModificaIndirizzo?action=setPreferito&id=' + id, {
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

		<script>
function abilitaModifica(id) {
    const card = document.getElementById("card-" + id);
    const inputs = card.querySelectorAll("input[type='text']");
    const salvaBtn = document.getElementById("salva-" + id);
    const annullaBtn = document.getElementById("annulla-" + id);

    // Memorizza i valori originali per poterli annullare
    inputs.forEach(input => {
        input.dataset.original = input.value;
        input.removeAttribute("readonly");
    });

    salvaBtn.style.display = "inline-block";
    annullaBtn.style.display = "inline-block";
}

function annullaModifica(id) {
    const card = document.getElementById("card-" + id);
    const inputs = card.querySelectorAll("input[type='text']");
    const salvaBtn = document.getElementById("salva-" + id);
    const annullaBtn = document.getElementById("annulla-" + id);

    inputs.forEach(input => {
        input.value = input.dataset.original;
        input.setAttribute("readonly", true);
    });

    salvaBtn.style.display = "none";
    annullaBtn.style.display = "none";
}
</script>

<script>

function checkTel(input){
	var tel = /^\d{10}$/;
	
	if(input.value.match(tel)){
		return true;
	}
	
	return false;
}

function checkCap(input){
	var cap = /^\d{5}$/;
	
	if(input.value.match(cap)){
		return true;
	}
	
	return false;
}

function checkVia(inputtxt){
	var via = /^[a-zA-Z0-9\s]+$/;
	
	if(inputtxt.value.match(via)){
		return true;
	}
	
	return false;
}

function checkOnlyText(inputtxt) {
    var name = /^[A-Za-zÀ-ÿ0-9\s]+$/;
    if(inputtxt.value.match(name))
        return true;
    return false;
}



function validate(obj) {
    var valid = true;

    const paeseError = document.getElementById("paese-error");
    const cittaError = document.getElementById("citta-error");
    const capError = document.getElementById("cap-error");
    const viaError = document.getElementById("via-error");
    const telefonoError = document.getElementById("telefono-error");
    const provinciaError = document.getElementById("provincia-error");

    // Reset errori
    paeseError.textContent = "";
    cittaError.textContent = "";
    capError.textContent = "";
    viaError.textContent = "";
    telefonoError.textContent = "";
    provinciaError.textContent = "";
    
    var paese = document.getElementsByName("paese")[0];
    var citta = document.getElementsByName("citta")[0];
    var cap = document.getElementsByName("cap")[0];
    var via = document.getElementsByName("via")[0];
    var telefono = document.getElementsByName("telefono")[0];
    var provincia = document.getElementsByName("provincia")[0];

    if(!checkOnlyText(paese)) {
        valid = false;
        paeseError.textContent = "Inserisci un Paese valido";
    }

    if(!checkOnlyText(citta)) {
        valid = false;
        cittaError.textContent = "Inserisci una città valida";
    }

    if(!checkOnlyText(provincia)) {
        valid = false;
        provinciaError.textContent = "Inserisci una provincia valida";
    }

    if(!checkCap(cap)){
        valid = false;
        capError.textContent = "Inserisci un CAP valido";
    }

    if(!checkTel(telefono)){
        valid = false;
        telefonoError.textContent = "Inserisci un telefono valido";
    }

    if(!checkVia(via)){
        valid = false;
        viaError.textContent = "Inserisci una via valida";
    }

    if(valid){
		obj.submit();
	}
}
</script>
</body>
</html>