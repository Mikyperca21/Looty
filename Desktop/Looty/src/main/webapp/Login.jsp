<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8" />
		<title>Login-Looty</title>
		<link rel = "stylesheet" href = "style/Login.css"/>
		<link rel = "icon" href = "LogoLooty_resized.png" type = "image/x-icon"/>
	</head>
	
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
	
		<div class = "login-container">
			<div class = "login-content">
				<form action = "<%=request.getContextPath()%>/login" method = "post">
					<ul>
						<li><input name = "email" class = "login" type = "text" placeholder = "E-mail" required = "true"/></li>
						<li><input name = "password" class = "login" type = "password" placeholder = "Password" required = "true"/></li>
						<li><input class = "login" type = "submit" value = "Login"/></li>
						<li><i><a id = "link-registrati" href = "Registrazione.jsp">Altrimenti registrati</a></i></li>
					</ul>
				</form>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>