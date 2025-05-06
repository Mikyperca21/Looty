<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ page import="java.util.*, model.utenteBean, model.utenteDAO"%>
<%
    System.out.println("Session ID (profilo): " + session.getId());
    utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
    if (utente == null) {
        System.out.println("Sessione utenteLoggato non trovata!");
        response.sendRedirect("Login.jsp");
        return;
    }
%>

  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AreaUtente di: <%= utente.getNome() %></title>
		<link rel = "stylesheet" href = "style/ProfiloUtente.css">
		<link rel = "icon" href = "images/LogoLooty_resized.png">
	</head>
	
	<body>
	
	<div class = "container-header">
		<%@ include file="Header.jsp"%>
	</div>
		<div class = "user-container">
			<div class = "user-content">
				<h1>Bentornato <%= utente.getNome() +" "+ utente.getCognome() %></h1> <!--  mi da errore se li metto insieme -->
				<a href = "<%=request.getContextPath()%>/logout">Logout</a>
				
			</div>
		</div>
		
		<div class="container">
       

        <!-- Griglia con riquadri cliccabili -->
        <div class="grid">
            <div class="box" onclick="showSection('profile')">
                <span class="material-symbols-outlined">person</span>
                <p>Dati personali</p>
            </div>
            <div class="box" onclick="showSection('orders')">
                <span class="material-symbols-outlined">local_shipping</span>
                <p>I miei ordini</p>
            </div>
            <div class="box" onclick="showSection('addresses')">
                <span class="material-symbols-outlined">location_on</span>
                <p>I miei indirizzi</p>
            </div>
            <div class="box" onclick="showSection('payments')">
                <span class="material-symbols-outlined">payments</span>
                <p>Metodi di pagamento</p>
            </div>
        </div>
    </div>

    <!-- Sezioni -->
    <div class="container">
        <div id="profile" class="section active">
            <h2> Profilo</h2>
            <p>Nome utente: <strong><%= utente.getNome() %></strong></p>
            <p>Email:<%=utente.getEmail() %></p>
        </div>
        <div id="orders" class="section">
            <h2>I tuoi ordini</h2>
            <p>Qui troverai la lista dei tuoi ordini recenti.</p>
        </div>
        <div id="addresses" class="section">
            <h2>📍 Indirizzi salvati</h2>
            <p>Gestisci i tuoi indirizzi di spedizione.</p>
        </div>
        <div id="payments" class="section">
            <h2>Metodi di pagamento</h2>
            <p>Aggiungi o rimuovi carte di credito o altri metodi di pagamento.</p>
        </div>
    </div>
    
    <div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
	</body>
</html>