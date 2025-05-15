<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*, model.utenteBean, model.Carrello"%>

<%
	utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
	if (utente == null) {
		response.sendRedirect("Login.jsp");
		return;
	}
	
	if(!utente.getRuolo()){ // se non è admin
		response.sendRedirect("Error500.jsp");
		return;
	}
%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Visualizza utenti</title>
		<link rel = "icon" href = "images/LogoLooty_resized.png">
	</head>
	<body>
		<div class="container-header">
			<%@ include file="Header.jsp"%>
		</div>
		
		<div class = "table-container">
		<%
		Collection<?> utenti = (Collection<?>) request.getAttribute("utenti"); // devo fare la servlet che mi mette gli utenti nella sessione
		
		if(utenti ==  null){
		%>
			<p>Ancora nessun cliente</p>
		<%
		}else {
		%>
		<table border = "1">
			<tr>
				<th>ID</th>
   				<th>Nome</th>
   				<th>Cognome</th>
    			<th>Email</th>
  			</tr>
			<%
			for(Object obj : utenti){
				utenteBean bean = (utenteBean) obj;
			%>
			<tr><td><%= bean.getId() %></td><td><%= bean.getNome() %></td><td><%= bean.getCognome() %></td><td><%= bean.getEmail() %></td></tr>
			<%
			}
			%>
		</table>
		<%
		}
		%>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>