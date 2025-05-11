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
		<meta charset="utf-8" />
		<title>Login-Looty</title>
		<link rel = "stylesheet" href = "style/Login.css"/>
<link rel="icon" href="images/LogoLooty_resized.png">
	</head>
	
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
	
		<div class = "login-container">
			<div class = "login-content">
				<form action = "<%=request.getContextPath()%>/login" method = "post">
				<% if (request.getAttribute("errore") != null) { %>
    <div class="errore"><%= request.getAttribute("errore") %></div>
<% } %>
						<div class="form-row">
						<input name = "email" class = "login" type = "text" placeholder = "E-mail" required = "true"/>
						</div>
						<div class="form-row">
						<input name = "password" class = "login" type = "password" placeholder = "Password" required = "true"/>
						</div>
						<input class = "login" type = "submit" value = "Login"/>
						<i><a id = "link-registrati" href = "Registrazione.jsp">Altrimenti registrati</a></i>
					
				</form>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>