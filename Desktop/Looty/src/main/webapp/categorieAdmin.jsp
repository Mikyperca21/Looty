<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.categoriaBean"%>
    
    <%
	utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
	if (utente == null) {
		response.sendRedirect("Login.jsp");
		return;
	}
	
	if(!utente.getRuolo()){ // se non è admin
		response.sendRedirect("Error500.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione categorie</title>

<link rel="stylesheet" href="style/storicoOrdini.css">
<link rel="stylesheet" href="style/ModificaIndirizzo.css">
<link rel ="icon" href = "images/LogoLooty_resized.png">
</head>
<body>


		<%@ include file="Header.jsp"%>
	
	<h2>Modifica categorie</h2>
	
	 
<%
 	List<categoriaBean> categorie = (List<categoriaBean>) request.getAttribute("categorie");
 	
 	if(categorie == null){
%>
 	<p>Ancora nessuna categoria</p>		
<%
		return;
 	}
%>

<div id="form-container" class="form">
		<div class="card-indirizzo">
			<form action="<%=request.getContextPath()%>/categorieAdmin" method="post">
				<input type="hidden" name="azione" value="inserisci">


				<div class="form-group">
					<label for="nome">Nome:</label> <input type="text" id="nome"
						placeholder="Inserisci il nome" name="nome" required>
				</div>
			

				<div class="container-aggiungi">
				<button type="submit" value="aggiungi">
					<span class="material-symbols-outlined">add</span>Inserisci categoria
				</button>
				</div>
			</form>
		</div>
	</div>


<table class="ordini-table">
			<thead>
				<tr>
					<th>Nome</th>
					<th>Modifica</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (categorie != null && categorie.size() != 0) {
					Iterator<?> it = categorie.iterator();
					while (it.hasNext()) {
						categoriaBean bean = (categoriaBean) it.next();
				%>
				<tr>
					<td><%=bean.getNome()%></td>
					<td data-label="Modifica">
							
						<a href="categorieAdmin?azione=delete&id=<%=bean.getId()%>"
							class="action-button"> <span
							class="material-symbols-outlined">delete</span>
						</a> 
						</td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="9">Nessuna categoria disponibile</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	
	


	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
	
	<script>
    const modificaBtn = document.getElementById("modificaBtn");
    const salvaBtn = document.getElementById("salvaBtn");
    const annullaBtn = document.getElementById("annullaBtn");
    const inputs = document.querySelectorAll("#modificaForm input");

    const originalValues = {};

    inputs.forEach(input => {
        originalValues[input.name] = input.value;
    });

    modificaBtn.addEventListener("click", function() {
        inputs.forEach(input => input.removeAttribute("readonly"));
        modificaBtn.style.display = "none";
        salvaBtn.style.display = "inline-block";
        annullaBtn.style.display = "inline-block";
    });

    annullaBtn.addEventListener("click", function() {
        inputs.forEach(input => {
            input.value = originalValues[input.name];
            input.setAttribute("readonly", true);
        });
        salvaBtn.style.display = "none";
        annullaBtn.style.display = "none";
        modificaBtn.style.display = "inline-block";
    });
</script>
</body>
</html>