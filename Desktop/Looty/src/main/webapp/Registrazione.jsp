<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%if (session.getAttribute("utenteLoggato") != null) {
    RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
    dispatcher.forward(request, response);
    return;
} %>
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
				<% if (request.getAttribute("errore") != null) { %>
    <div class="errore"><%= request.getAttribute("errore") %></div>
<% } %>
				
					<div class="form-row">
						
						<input class = "signup" type = "text" name="Nome" placeholder = "Nome" required = "true"/>
						<input class = "signup" type = "text" name="Cognome" placeholder = "Cognome" required = "true"/>
					</div>
					
					<div class="form-row">
						<input class = "signup" type = "text" name="Email" placeholder = "E-mail" required = "true"/>
						<input class = "signup" type = "password" name="Password" placeholder = "Password" required = "true"/>
					</div>
					<h3>Inserisci il tuo indirizzo</h3> <br>

					<div class="form-row">
					    <input class = "signup" type="text" name="Citta" placeholder = "Città" required>
			
					    <input class = "signup" type="text" name="Via" placeholder = "Via" required >
					</div><br>
					<div class="form-row">
					    <input class = "signup" type="text" name="Provincia" placeholder = "Provincia" required>
					    <input class = "signup" type="text" name="Cap" placeholder = "CAP" required>
					</div><br>
					<div class="form-row">
					    <input class = "signup" type="text" name="Paese" placeholder = "Paese" required>
					    <input class = "signup" type="text" name="Telefono" placeholder = "Telefono" required>
					</div><br>

						<input class = "signup" type = "submit" value = "Registrati"/>
						<i><a id = "link-login" href = "Login.jsp">Hai già un account? Accedi</a></i>
					
				</form>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>