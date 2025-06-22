<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, model.utenteBean, model.utenteDAO"%>
<%
utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
if (utente == null) {
	response.sendRedirect("Login.jsp");
	return;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AreaUtente di: <%=utente.getNome()%></title>
<link rel="stylesheet" href="style/ProfiloUtente.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>

<body>

	<div class="container-header">
		<%@ include file="Header.jsp"%>
	</div>
	<div class="user-container">
		<div class="user-content">
			<h1>
				Bentornato/a
				<%=utente.getNome() + " " + utente.getCognome()%></h1>
			<a href="<%=request.getContextPath()%>/logout"><span class="material-symbols-outlined">
logout
</span>Esci</a>

		</div>
	</div>
<div class="container">
  <div class="grid">
    <div class="box">
      <a href="ModificaDatiUtente.jsp">
        <span class="material-symbols-outlined">person</span>
        <p>Dati personali</p>
      </a>
    </div>

	<% if(!utente.getRuolo()){ %>

	    <div class="box">
	      <a href="storicoOrdini">
	        <span class="material-symbols-outlined">local_shipping</span>
	        <p>I miei ordini</p>
	      </a>
	    </div>
	
	    <div class="box">
	      <a href="ModificaIndirizzo.jsp">
	        <span class="material-symbols-outlined">location_on</span>
	        <p>I miei indirizzi</p>
	      </a>
	    </div>
	
	    <div class="box">
	      <a href="ModificaPagamento.jsp">
	        <span class="material-symbols-outlined">payments</span>
	        <p>Metodi di pagamento</p>
	      </a>
	    </div>
    
	<% }else if(utente.getRuolo()){%>
		<div class=box>
			<a href = "storicoOrdini">
				<span class="material-symbols-outlined">trolley</span>
				<p>Visualizza tutti gli ordini.</p>
			</a>
			
		</div>
		<div class="box">
			<a href = "visualizzaUtenti">
				<span class="material-symbols-outlined">groups</span>
				<p>Visualizza tutti gli utenti.</p>
			</a>
		</div>
		<div class="box">
			<a href = "CatalogoAdmin.jsp">
				<span class="material-symbols-outlined">edit_square</span>
				<p>Aggiungi, rimuovi o modifica prodotti.</p>
			</a>
		</div> 
		<div class="box">
			<a href = "categorieAdmin">
				<span class="material-symbols-outlined">category</span>
				<p>Aggiungi, rimuovi o modifica categorie.</p>
			</a>
		</div> 
	<% } %>
  </div>
</div>



	<!-- Sezioni -->
	<div class="container">
		<div id="profile" class="section active">
			<h2>Profilo</h2>
			<p>
				Nome utente: <strong><%=utente.getNome() + " " + utente.getCognome()%></strong>
			</p>
			<p> Email: <%=utente.getEmail() %></p>
	</div>
	</div>

	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>
</html>