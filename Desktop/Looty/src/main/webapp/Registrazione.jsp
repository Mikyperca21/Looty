<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Registrati!</title>
		<link rel = "stylesheet" href = "style/Registrazione.css">
		<link rel="icon" href="images/LogoLooty_resized.png">
	</head>
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
		
		<div class = "signup-container">
			<div class = "signup-content">
				<form action = "<%=request.getContextPath()%>/registrazione" method = "post">
					<ul>
						<li><input class = "signup" type = "text" name="Nome" placeholder = "Nome" required = "true"/></li>
						<li><input class = "signup" type = "text" name="Cognome" placeholder = "Cognome" required = "true"/></li>
						<li><input class = "signup" type = "text" name="Email" placeholder = "E-mail" required = "true"/></li>
						<li><input class = "signup" type = "password" name="Password" placeholder = "Password" required = "true"/></li>
						<!-- indirizzo, città, prov, cap, -->
						<li><input class = "signup" type = "text" name="Via" placeholder = "Via" required = "true"/></li>
						<li><input class = "signup" type = "text" name="Citta" placeholder = "Citta" required = "true"/></li>
						<li><input class = "signup" type = "text" name="Provincia" placeholder = "Provincia" required = "true"/></li>
						<li><input class = "signup" type = "number" name="Cap" placeholder = "Cap" required = "true" max = "99999"/></li>
						<li><input class = "signup" type = "submit" value = "Registrati"/></li>
						<li><i><a id = "link-login" href = "Login.jsp">Hai già un account? Accedi</a></i></li>
					</ul>
				</form>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>