<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.utenteBean"%>
<%
utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
if (utente == null) {
	response.sendRedirect("Login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profilo Utente</title>
<link rel="stylesheet" href="style/ModificaDatiUtente.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<%@ include file="Header.jsp"%>
<body>

	<h2>Il mio profilo</h2>
	<div class="container-form">
	<form action="ModificaUtente" method="post" id="modificaForm">
		
		 <label for="nome">Nome:</label>
    <input type="text" name="nome" value="<%=utente.getNome()%>" required readonly><br>
    
    <label for="cognome">Cognome:</label>
    <input type="text" name="cognome" value="<%=utente.getCognome()%>" required readonly><br>
    
    <label for="email">Email:</label>
    <input type="email" name="email" value="<%=utente.getEmail()%>" required readonly><br>

    <label for="password">Nuova Password (opzionale):</label>
    <input type="password" name="password" placeholder="Nuova password" readonly><br>

    <label for="confermaPassword">Conferma Password:</label>
    <input type="password" name="confermaPassword" placeholder="Conferma password" readonly><br>
		
			
		<div class="container-button">
			<button type="button" id="modificaBtn">
				<span class="material-symbols-outlined"> edit </span> Modifica dati
			</button>

			<button type="submit" id="salvaBtn" style="display: none;">
				<span class="material-symbols-outlined"> description </span> Salva
			</button>

				<button type="button" id="annullaBtn" style="display: none;">
					<span class="material-symbols-outlined">cancel</span> Annulla
				</button>
			</div>
	</form>
	</div>

	<script>
    const modificaBtn = document.getElementById("modificaBtn");
    const salvaBtn = document.getElementById("salvaBtn");
    const annullaBtn = document.getElementById("annullaBtn");
    const inputs = document.querySelectorAll("#modificaForm input");

    const originalValues = {};

    inputs.forEach(input => {
        originalValues[input.name] = input.value;
    });

    modificaBtn.addEventListener("click", function() {
        inputs.forEach(input => input.removeAttribute("readonly"));
        modificaBtn.style.display = "none";
        salvaBtn.style.display = "inline-block";
        annullaBtn.style.display = "inline-block";
    });

    annullaBtn.addEventListener("click", function() {
        inputs.forEach(input => {
            input.value = originalValues[input.name];
            input.setAttribute("readonly", true);
        });
        salvaBtn.style.display = "none";
        annullaBtn.style.display = "none";
        modificaBtn.style.display = "inline-block";
    });
</script>

    <div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>
</html>
