<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page
	import="java.util.*, model.prodottoBean"%>
 
<%
 	List<prodottoBean> prodotti = (List<prodottoBean>) request.getAttribute("prodotti"); // mi prendo i prodotti che ho trovato
 	
 	if(prodotti == null){
%>
 		<p>Prodotto non trovato</p>		
<%
		return;
 	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<table>
			<% for(prodottoBean prod : prodotti){ %>
				<!-- catalogo?categoria=%= cat.getId() %>  --> 
				<tr><th><a href = "#"><%= prod.getNome() %></a></th></tr>
			<% } %>
		</table>
	</body>
</html>