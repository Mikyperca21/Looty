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
		<link rel = "stylesheet" href = "style/TabellaCat.css"/>
	</head>
	<body>
		<table border = "1">
			<% for(categoriaBean cat : categorie){ %>
				<tr><th><%= cat.getNome() %></th></tr>
			<% } %>
		</table>
	</body>
</html>