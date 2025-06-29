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
			<h2>Registrati ora!</h2>
			<br>
			<p style="color:red;" id="nome-error"></p>
			<p style="color:red;" id="email-error"></p>
			<p style="color:red;" id="citta-error"></p>
			<p style="color:red;" id="via-error"></p>
			<p style="color:red;" id="cap-error"></p>
			<p style="color:red;" id="provincia-error"></p>
			<p style="color:red;" id="paese-error"></p>
			<p style="color:red;" id="telefono-error"></p>
			
				<form action = "<%=request.getContextPath()%>/registrazione" method = "post" onsubmit="event.preventDefault(); validate(this)">				
					<div class="form-row">
						<input class = "signup" type = "text" name="Nome" placeholder = "Nome" required/>
						<input class = "signup" type = "text" name="Cognome" placeholder = "Cognome" required/>
						
					</div>
					
					<div class="form-row">
						<input class = "signup" type = "text" name="Email" placeholder = "E-mail" required/>
						
						<input class = "signup" type = "password" name="Password" placeholder = "Password" required/>
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
		
		<script>
		
		function checkTel(input){
			var tel = /^\d{10}$/;
			
			if(input.value.match(tel)){
				return true;
			}
			
			return false;
		}
		
		function checkCap(input){
			var cap = /^\d{5}$/;
			
			if(input.value.match(cap)){
				return true;
			}
			
			return false;
		}
		
		function checkVia(inputtxt){
			var via = /^[a-zA-Z0-9\s]+$/;
			
			if(inputtxt.value.match(via)){
				return true;
			}
			
			return false;
		}
		
		function checkOnlyText(inputtxt) {
		    var name = /^[A-Za-zÀ-ÿ0-9\s]+$/;
		    if(inputtxt.value.match(name))
		        return true;
		    return false;
		}

		
		function checkEmail(inputtxt) {
			var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if(inputtxt.value.match(email)){
				return true;
			} 

			return false;	
		}

		
		function validate(obj) {	
			var valid = true;	
			
			const emailError = document.getElementById("email-error"); // v
			const nomeError = document.getElementById("nome-error"); // testo v
			const paeseError = document.getElementById("paese-error");	// testo v
			const cittaError = document.getElementById("citta-error");	// testo v
			const capError = document.getElementById("cap-error");
			const viaError = document.getElementById("via-error");
			const telefonoError = document.getElementById("telefono-error");
			const provinciaError = document.getElementById("provincia-error");
			
			emailError.textContent = "";
			nomeError.textContent = "";
			paeseError.textContent = "";
			cittaError.textContent = "";
			capError.textContent = "";
			viaError.textContent = "";
			telefonoError.textContent = "";
			provinciaError.textContent = "";
						
			var email = document.getElementsByName("Email")[0];		
			var nome = document.getElementsByName("Nome")[0];
			var cognome = document.getElementsByName("Cognome")[0];
			var paese = document.getElementsByName("Paese")[0];
			var citta = document.getElementsByName("Citta")[0];
			var cap = document.getElementsByName("Cap")[0];
			var via = document.getElementsByName("Via")[0];
			var telefono = document.getElementsByName("Telefono")[0];
			var provincia = document.getElementsByName("Provincia")[0];
			
			if(!checkEmail(email)) {
				valid = false;
				emailError.textContent = "Inserisci un'email valida";
			}
			
			if(!checkOnlyText(nome) || !checkOnlyText(cognome)) {
				valid = false;
				nomeError.textContent = "Inserisci un nome valido";
			}
			
			if(!checkOnlyText(paese)) {
				valid = false;
				paeseError.textContent = "Inserisci un Paese valido";
			}
			
			if(!checkOnlyText(citta)) {
				valid = false;
				cittaError.textContent = "Inserisci una citta valida";
			}
			
			if(!checkOnlyText(provincia)) {
				valid = false;
				provinciaError.textContent = "Inserisci una provincia valida";
			}
			
			if(!checkCap(cap)){
				valid = false;
				capError.textContent = "Inserisci un CAP valido";
			}
			
			if(!checkTel(telefono)){
				valid = false;
				telefonoError.textContent = "Inserisci un telefono valido";
			}
			
			if(!checkVia(via)){
				valid = false;
				viaError.textContent = "Inserisci una via valida";
			}

			if(valid){
				obj.submit();
			} 
		}
		
		
		</script>
		
		<script>
let debounceTimer;
const emailInput = document.getElementsByName("Email")[0];
function checkEmailExistence() {
    clearTimeout(debounceTimer);
    const email = emailInput.value.trim();
    if (email === "") {
        document.getElementById("email-error").textContent = "";
        return;
    }
    debounceTimer = setTimeout(function() {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "<%=request.getContextPath()%>/controlloEmail?email=" + encodeURIComponent(email), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                console.log("XHR status:", xhr.status, "response:", xhr.responseText);
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    const emailError = document.getElementById("email-error");
                    if (response.exists) {
                        emailError.textContent = "Questa email è già registrata.";
                    } else {
                        emailError.textContent = "";
                    }
                }
            }
        };
        xhr.send();
    }, 500);
}

emailInput.addEventListener("input", checkEmailExistence);
emailInput.addEventListener("blur", checkEmailExistence);

</script>
		
	</body>
</html>