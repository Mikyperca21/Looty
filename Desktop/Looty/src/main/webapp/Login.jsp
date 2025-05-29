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
				<form action = "<%=request.getContextPath()%>/login" method = "post" onsubmit="event.preventDefault(); validate(this)">
						
						<p style="color:red;" id="email-error"></p>
						<div class="form-row">
						<input id = "email" name = "email" class = "login" type = "text" placeholder = "E-mail" required/>
						
						</div>
						<div class="form-row">
						<input id = "password" name = "password" class = "login" type = "password" placeholder = "Password" required/>
						</div>
						<input class = "login" type = "submit" value = "Login"/>
						<i><a id = "link-registrati" href = "Registrazione.jsp">Altrimenti registrati</a></i>
					
				</form>
			</div>
		</div>	
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
		
		<script>
		function checkEmail(inputtxt) {
			var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if(inputtxt.value.match(email)){
				return true;
			} 

			return false;	
		}

		
		function validate(obj) {	
			var valid = true;	
			
			const emailError = document.getElementById("email-error");
						
			var email = document.getElementById("email");
			if(!checkEmail(email)) {
				valid = false;
				emailError.textContent = "Inserisci un'email valida";
			}

			if(valid){
				obj.submit();
			} 
		}
		</script>
	</body>
</html>