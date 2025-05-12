<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8" />
		<title>404-NOT FOUND</title>
		<link rel = "stylesheet" href = "style/Error404.css"/>
<link rel="icon" href="images/LogoLooty_resized.png">
	</head>
	
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
	
		<div class = "error-container">
			<div class = "error-content">
				<img id = "ly" src = "images/LogoLooty.png">
				<h1>Errore 404!</h1>
				<p>Pagina non trovata</p>
				<a href = "Catalogo.jsp">Torna al catalogo</a>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>