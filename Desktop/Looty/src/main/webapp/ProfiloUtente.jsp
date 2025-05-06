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
		<title><%= utente.getNome() %>'s profile</title>
		<link rel = "stylesheet" href = "style/ProfiloUtente.css">
		<link rel = "icon" href = "images/LogoLooty_resized.png">
	</head>
	
	<body>
		<div class = "user-container">
			<div class = "user-content">
				<h1>Bentornato <%= utente.getNome() %> +""+ <%= utente.getCognome() %></h1> <!--  mi da errore se li metto insieme -->
				<a href = "#">I miei ordini</a>
				
			</div>
		</div>
		
		<div class="container">
        <!-- Info Utente -->
        <div class="user-info">
            <img src="https://via.placeholder.com/80" alt="Foto Profilo">
            <p><strong>Mario Rossi</strong></p>
            <p>Email: mario.rossi@example.com</p>
            <p>Telefono: +39 123 456 7890</p>
        </div>

        <!-- Griglia con riquadri cliccabili -->
        <div class="grid">
            <div class="box" onclick="showSection('profile')">
                <i class="fas fa-user"></i>
                <p>Profilo</p>
            </div>
            <div class="box" onclick="showSection('orders')">
                <i class="fas fa-box"></i>
                <p>Ordini</p>
            </div>
            <div class="box" onclick="showSection('addresses')">
                <i class="fas fa-map-marker-alt"></i>
                <p>Indirizzi</p>
            </div>
            <div class="box" onclick="showSection('payments')">
                <i class="fas fa-credit-card"></i>
                <p>Pagamenti</p>
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
	</body>
</html>