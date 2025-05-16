<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*, model.utenteBean, model.Carrello, model.utenteDAO"%>

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
		<link rel="stylesheet" href="style/storicoOrdini.css">
		
	</head>
	<body>
		<div class="container-header">
			<%@ include file="Header.jsp"%>
		</div>
		
		<div class = "carrello-container">
		<%
			Collection<utenteBean> utenti = null; 
			try {
				utenteDAO dao = new utenteDAO();
				utenti = dao.doRetrieveAll();
			}catch (SQLException e) {
				e.printStackTrace();
				out.println("<p>Errore nel recupero degli utenti</p>");
			}
		if(utenti ==  null){
		%>
			<p>Ancora nessun cliente</p>
		<%
		}else {
		%>
		<table class="ordini-table">
			<tr>
				<th>ID</th>
   				<th>Nome</th>
   				<th>Cognome</th>
    			<th>Email</th>
  			</tr>
			<%
			for(utenteBean ut : utenti){
				
			%>
			<tr>
			<td data-label="ID"><%=ut.getId()%></td>
			<td data-label="Nome"><%=ut.getNome() %></td>
			<td data-label="Cognome"><%=ut.getCognome()%></td>
			<td data-label="Email"><%=ut.getEmail()%></td>
			</tr>
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