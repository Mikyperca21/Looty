<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page
	import="java.util.*, model.categoriaBean"%>
 
<%
 	List<categoriaBean> categorie = (List<categoriaBean>) request.getAttribute("categorie");
 	
 	if(categorie == null){
%>
 		<p>Ancora nessuna categoria</p>		
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
			<% for(categoriaBean cat : categorie){ %>
				<tr><th><a href = "catalogo?action=perCategoria&idCat=<%= cat.getId() %>"><%= cat.getNome() %></a></th></tr>
			<% } %>
		</table>
	</body>
</html>