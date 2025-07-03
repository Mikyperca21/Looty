<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
if (utente == null) {
	response.sendRedirect("Login.jsp");
	return;
}
%>
<html>
<head>
    <title>Ordine Confermato</title>
    <link rel="icon" href="images/LogoLooty_resized.png">
    <link rel="stylesheet" type="text/css" href="style/ordineConfermato.css">
</head>
<body>

    <div class="container-header">
        <%@ include file="Header.jsp"%>
    </div>

    <h2>Grazie per il tuo ordine!</h2>

    <div class="card" style="flex-direction: column; align-items: center; text-align: center;">
        <span class="material-symbols-outlined" style="font-size: 80px; color: #4CAF50;">check_circle</span>
        <h3 style="margin-top: 10px;">Il tuo ordine è stato confermato con successo.</h3>
        <p style="margin-top: 10px;">Riceverai il tuo acquisto in 4-5 giorni lavorativi.<br>
        Puoi consultare lo storico dei tuoi ordini dal tuo profilo.</p>
        
    </div>
    <div class="container-button">
			<button type="button" onClick="window.location.href='catalogo';">
				<span class="material-symbols-outlined">home</span>Torna
				alla Home
			</button>
			<button type="submit" onClick="window.location.href='storicoOrdini';">
				<span class="material-symbols-outlined">receipt_long</span>I miei ordini
			</button>
		</div>

    <div class="container-footer">
       <%@ include file="Footer.jsp"%>
    </div>

</body>
</html>
