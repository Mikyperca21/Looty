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
					<a href = "Home.jsp" class = "logo">
						<img src = "images/LogoLooty_resized.png" alt = "Logo di Looty"/>	
						<span class = "logo-text">Looty</span>
					</a>
					
					<div class="search-container">
						<input id = "ricerca" onkeyup = "searchData()" type="text" placeholder="Cerca prodotti..." name="cerca">
						<div id="risultati"></div>
					</div>
				
					<nav class = "top-nav">
						<ul class = "nav-ul">
							<li class = "nav-item" id = "catBtn">
								<a href= "Catalogo.jsp" class = "nav-link"><span class="material-symbols-outlined">category</span></a>
								
								<!-- <a href= "#" class = "nav-link">Categoria</a> -->
							</li>
							<li class = "nav-item">
								<a href= "<%= accountLink %>" class = "nav-link"><span class="material-symbols-outlined">account_circle</span></a>
								<!-- <a href= "#" class = "nav-link">Account</a> -->
							</li>
							<% if(utenteHeader == null || !utenteHeader.getRuolo()){ %>
							<li class = "nav-item">
								<a href= "Carrello.jsp" class = "nav-link"><span class="material-symbols-outlined">shopping_cart</span></a>
							</li>
							<% } %>
						</ul>
					</nav>
				</div>
			</div>
			
			
			
		</header>
		
		<div id = "categorieOutput"></div>
		
		<script type="text/javascript">
			// barra di ricerca	
						
			function searchData(){
				var prodotto = document.getElementById("ricerca").value;
			    var risultati = document.getElementById("risultati");

			    if(prodotto.trim().length == 0){
			        risultati.innerHTML = "";
			        risultati.style.display = "none";
			        return;
			    }
				
			    /* var input = document.getElementById("ricerca");
			    var rect = input.getBoundingClientRect();

			    risultati.style.top = (rect.bottom) + "px";
			    risultati.style.left = (rect.left) + "px";
			    risultati.style.width = rect.width + "px"; */

			    var xhr = new XMLHttpRequest();
			    xhr.open("GET", "search?query=" + encodeURIComponent(prodotto), true);

			    xhr.onreadystatechange = function(){
			        if(xhr.status === 200 && xhr.readyState === 4){
			            risultati.innerHTML = xhr.responseText;
			            risultati.style.display = "block";
			        }
			    };

			    xhr.send();
			}
		
		// categorie
			const btn = document.getElementById("catBtn");
		  const output = document.getElementById("categorieOutput");

		  // Funzione per posizionare output sotto il bottone
		  function posizionaOutput() {
		    const rect = btn.getBoundingClientRect();
		    output.style.top = (rect.bottom + window.scrollY) + "px";
		    output.style.left = (rect.left + window.scrollX) + "px";
		    output.style.width = rect.width + "px";  // stessa larghezza del bottone (opzionale)
		  }

		  // Variabile per tracciare se il mouse è dentro bottone o output
		  let mouseInside = false;

		  // Mostra e carica dati
		  btn.addEventListener("mouseenter", () => {
		    mouseInside = true;
		    posizionaOutput();
		    output.style.display = "block";
		    const rect = btn.getBoundingClientRect();
		    const outputWidth = output.offsetWidth;
		    output.style.top = (rect.bottom + window.scrollY) + "px";
		    output.style.left = (rect.left + window.scrollX + (rect.width / 2) - (outputWidth / 2)) + "px";


		    const xhr = new XMLHttpRequest();
		    xhr.open("GET", "categorie", true);
		    xhr.onreadystatechange = function () {
		      if (xhr.readyState === 4 && xhr.status === 200) {
		        output.innerHTML = xhr.responseText;
		      }
		    };
		    xhr.send();
		  });

		  // Nascondi se esci da bottone e output
		  function checkHide(e) {
		    // Se mouse esce da bottone o output, aspetta e nascondi solo se mouse non entra in nessuno dei due
		    setTimeout(() => {
		      if (!mouseInside) {
		        output.style.display = "none";
		        
		        const newWidth = output.offsetWidth;
		        output.style.left = (rect.left + window.scrollX + (rect.width / 2) - (newWidth / 2)) + "px";
		      }
		    }, 100); // piccolo delay per lasciare tempo a mouse di passare tra i due elementi
		  }

		  btn.addEventListener("mouseleave", () => {
		    mouseInside = false;
		    checkHide();
		  });

		  output.addEventListener("mouseenter", () => {
		    mouseInside = true;
		  });

		  output.addEventListener("mouseleave", () => {
		    mouseInside = false;
		    checkHide();
		  });
		  
		  // NUOVA AGGIUNTA far scomparire i risultati (IL PROBLEMA DEL BANNER SULL'HEADER RIMANE)
		  
		  document.addEventListener("click", function(event) {
			    var ricerca = document.getElementById("ricerca");
			    var risultati = document.getElementById("risultati");
			
			    if (!ricerca.contains(event.target) && !risultati.contains(event.target)) {
			        risultati.style.display = "none";
			    }
			});
		  
		</script>
	</body>
</html>
