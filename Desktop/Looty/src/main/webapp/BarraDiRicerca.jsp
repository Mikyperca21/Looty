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
		<style>
    table {
      width: 100%;
    }
    

table tr:hover {
  background-color: #d8f1fa;  
  cursor: pointer;          
}
    table th, table td {
      padding: 8px 12px;
      text-align: center;
    }
    table a {
      color: inherit;
      text-decoration: none;
      display: block;
      width: 100%;
      height: 100%;
    }
    table a:hover {
      text-decoration: underline;
    }
  </style>
	</head>
	<body>
		<table>
			<% for(prodottoBean prod : prodotti){ %>
				<!-- catalogo?categoria=%= cat.getId() %>  --> 
				<tr><th><a href = "dettaglioProdotto?action=getProdotto&id=<%=prod.getCodice()%>"><%= prod.getNome() %></a></th></tr>
			<% } %>
		</table>
	</body>
</html>