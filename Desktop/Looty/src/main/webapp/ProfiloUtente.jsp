<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ page import="java.util.*, model.utenteBean, model.utenteDAO"%>
   
<%
	utenteBean utente = (utenteBean) request.getAttribute("utente");
	//Carrello carrello = (Carrello) session.getAttribute("carrello");
%>
  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><%= utente.getNome() %>'s profile</title>
		<link rel = "stylesheet" href = "style/ProfiloUtente.css">
		<link rel = "icon" href = "images/LogoLooty_resized.png">
	</head>
	
	<body>
		<div class = "user-container">
			<div class = "user-content">
				<h1>Bentornato <%= utente.getNome() %> <%= utente.getCognome() %></h1> <!--  mi da errore se li metto insieme -->
				<a href = "#">I miei ordini</a>
			</div>
		</div>
	</body>
</html>