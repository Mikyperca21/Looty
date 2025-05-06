<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="model.utenteBean" %>

<%
    utenteBean utenteHeader = (utenteBean) session.getAttribute("utenteLoggato");
    String accountLink = (utenteHeader != null) ? "ProfiloUtente.jsp" : "Login.jsp";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Header Looty</title>
		<link rel = "stylesheet" href = "style/header.css"/>
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	</head>
	<body>
		<header class = "header">
			<div class = "navbar">
				<div class = "navbar-content">
					<a href = "catalogo" class = "logo">
						<img src = "images/LogoLooty_resized.png" alt = "Logo di Looty"/>	
						<span class = "logo-text">Looty</span>
					</a>
					
					<div class="search-container">
						<form action="#">
							<input type="text" placeholder="Cerca prodotti..." name="cerca">
							<button type="submit"><i class="fa fa-search"></i></button>
						</form>
					 </div>
										
					<nav class = "top-nav">
						<ul class = "nav-ul">
							<li class = "nav-item">
								<a href= "#" class = "nav-link"><span class="material-symbols-outlined">category</span></a>
								<!-- <a href= "#" class = "nav-link">Categoria</a> -->
							</li>
							<li class = "nav-item">
								<a href= "<%= accountLink %>" class = "nav-link"><span class="material-symbols-outlined">account_circle</span></a>
								<!-- <a href= "#" class = "nav-link">Account</a> -->
							</li>
							<li class = "nav-item">
								<a href= "Carrello.jsp" class = "nav-link"><span class="material-symbols-outlined">shopping_cart</span></a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
	</body>
</html>
