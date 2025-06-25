<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean, model.Carrello, model.categoriaBean"%>

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
<title>Catalogo Amministratore</title>
<link rel="stylesheet" href="style/storicoOrdini.css">
<link rel="stylesheet" href="style/ModificaIndirizzo.css">
<link rel ="icon" href = "images/LogoLooty_resized.png">
</head>
<body>

	<%@ include file="Header.jsp"%>
	
	<h2>Catalogo Amministratore:</h2>
	
	

	<div id="form-container" class="form">
		<div class="card-indirizzo">
			<h2>Nuovo Prodotto</h2>
			<form action="<%=request.getContextPath()%>/catalogo" method="post"
				enctype="multipart/form-data"  onsubmit="event.preventDefault(); validate(this)">
				<input type="hidden" name="action" value="inserisci">


				<div class="input-row">
				<div class="form-group">
					<label for="nome">Nome:</label> <input type="text" id="nome"
						placeholder="Inserisci il nome" name="nome" required>
						<p class="errore" id="nome-error"></p>
				</div>
				<div class="form-group">
					<label for="quantita">Quantità di box disponibili:</label> <input
						type="number" id="quantita" name="quantita" min="1"
						placeholder="Inserisci la quantità di box disponibili" required>
						<p class="errore" id="quantita-error"></p>
				</div>
				</div>
				
				<div class="input-row-tre">
				<p class="errore" id="prezzo-error"></p>
		            <div>
		                <label for="prezzoS">Prezzo taglia S:</label>
		                <input type="number" step="any" id="prezzoS" name="prezzoS"
						min="0.01" placeholder="Inserisci il prezzo per la box piccola"
						required>
		            </div>
		            <div>
		                <label for="prezzoM">Prezzo taglia M:</label>
		               <input type="number" step="any" id="prezzoM" name="prezzoM"
						min="0.01" placeholder="Inserisci il prezzo per la box media"
						required>
		            </div>
		            <div>
		                <label for="prezzoL">Prezzo taglia L:</label>
		                <input type="number" step="any" id="prezzoL" name="prezzoL"
						min="0.01" placeholder="Inserisci il prezzo per la box grande"
						required>
		            </div>
		            </div>

				
				<div class ="input-row">
				<div class="form-group">
					<label for="descrizione">Descrizione:</label><br>
					<textarea id="descrizione" name="descrizione" style="width: 100%; height: 100px;"
						placeholder="Inserisci una descrizione della box" required></textarea>
				</div>
				</div>
				
				<div class="input-row-tre">
					<p class="errore" id="prezzo-error"></p>
					
					<%	Collection<categoriaBean> cats = (Collection<categoriaBean>) request.getAttribute("categorie");				
						
					if (cats != null && cats.size() != 0) {
						Iterator<?> it = cats.iterator();
						while (it.hasNext()) {
							categoriaBean categoria = (categoriaBean) it.next();
					%>
							<label for = "categoria<%= categoria.getId() %>"><%= categoria.getNome() %></label>
							<input type="checkbox" id="categoria<%= categoria.getId() %>" name="categoriaID" value="<%= categoria.getId() %>">
					<%
						}
						
					}
					%>
		        </div>
				
				<p>Nota: per l'acquisto della box di dimensione S verrà scalata una quantità dal magazzino, per l'acquisto di una box di taglia media 
					verranno scalate due unità dal magazzino e per l'acquisto della box di dimensione L verranno scalate tre unità dal magazzino</p>

				<div class="form-group">
					<label for="immagine">Inserire immagine del prodotto:</label> <input
						type="file" id="immagine" name="immagine">
				</div>

				<div class="preview-container">
					<img id="preview" src="#" alt="Anteprima immagine">
				</div>

				<div class="container-aggiungi">
				<button type="submit" value="aggiungi">
					<span class="material-symbols-outlined">add</span>Inserisci
					Prodotto
				</button>
				</div>
			</form>
		</div>
	</div>

	<div class="carrello-container">
		<%
		Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
		if (request.getAttribute("prodotti") == null) {
			response.sendRedirect(request.getContextPath() + "/catalogo");
		}
		prodottoBean prodotto = (prodottoBean) request.getAttribute("prodotto");
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		%>
		<table class="ordini-table">
			<thead>
				<tr>
					<th>Immagine</th>
					<th>Nome</th>
					<th>Prezzo taglia S</th>
					<th>Prezzo taglia M</th>
					<th>Prezzo taglia L</th>
					<th>Descrizione</th>
					<th>Quantità</th>
					<th>Modifica</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (prodotti != null && prodotti.size() != 0) {
					Iterator<?> it = prodotti.iterator();
					while (it.hasNext()) {
						prodottoBean bean = (prodottoBean) it.next();
				%>
				<tr>
					<td data-label="Immagine"><img src="<%=bean.getImmagine()%>"
						style="width: 100px;"></td>
					<td data-label="Nome"><%=bean.getNome()%></td>
					<td data-label="Prezzo taglia S"><%=bean.getPrezzoS()%> €</td>
					<td data-label="Prezzo taglia M"><%=bean.getPrezzoM()%> €</td>
					<td data-label="Prezzo taglia L"><%=bean.getPrezzoL()%> €</td>
					<td data-label="Descrizione"><%=bean.getDescrizione()%></td>
					<td data-label="Quantità disponibili"><%=bean.getQuantita()%></td>
					<td data-label="Modifica">
							
							<a href="catalogo?action=delete&id=<%=bean.getCodice()%>"
							class="action-button"> <span
								class="material-symbols-outlined">delete</span>
						</a> <a href="ModificaProdottoAdmin.jsp?id=<%=bean.getCodice()%>"
							class="action-button"> <span
								class="material-symbols-outlined">edit</span>
						</a>
					</td>
					
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="9">Nessun prodotto disponibile</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
	<script>
		document.getElementById("immagine").addEventListener("change",
				function(event) {
					const file = event.target.files[0];
					const preview = document.getElementById("preview");

					if (file && file.type.startsWith("image/")) {
						const reader = new FileReader();
						reader.onload = function(e) {
							preview.src = e.target.result;
							preview.style.display = "block";
						};
						reader.readAsDataURL(file);
					} else {
						preview.src = "#";
						preview.style.display = "none";
					}
				});
		
		function checkOnlyText(inputtxt) {
			var name = /^[A-Za-z]+$/;;
			if(inputtxt.value.match(name)) 
				return true;

			return false;	
		}
		
		function checkOnlyNumber(input) {
			var soloNumeri = /^\d+$/;
			if(input.value.match(soloNumeri))
				return true;
			return  false;
		}
		
		function checkOnlyPrice(input) {
			var prezzo = /^\d+(\.\d{1,2})?$/;
			if(input.value.match(prezzo))
				return true;
			return  false;
		}
		
		function validate(obj) {	
			var valid = true;	
			
			const nomeError = document.getElementById("nome-error");
			const quantitaError = document.getElementById("quantita-error");
			const prezzoError = document.getElementById("prezzo-error");
			
						
			var nome = document.getElementById("nome");
			var quantita = document.getElementById("quantita");
			var prezzoS = document.getElementById("prezzoS");
			var prezzoM = document.getElementById("prezzoM");
			var prezzoL = document.getElementById("prezzoL");

			
			if(!checkOnlyText(nome)) {
				valid = false;
				nomeError.textContent = "Inserisci un nome valido";
			}
			
			if(!checkOnlyNumber(quantita)) {
				valid = false;
				quantitaError.textContent = "Inserisci un numero valido";
			}
			
			if(!checkOnlyPrice(prezzoS)) {
				valid = false;
				prezzoError.textContent = "Inserisci un prezzo valido";
			}
			
			if(!checkOnlyPrice(prezzoM)) {
				valid = false;
				prezzoError.textContent = "Inserisci un prezzo valido";
			}
			
			if(!checkOnlyPrice(prezzoL)) {
				valid = false;
				prezzoError.textContent = "Inserisci un prezzo valido";
			}

			if(valid){
				obj.submit();
			} 
		}
		
	</script>

</body>
</html>
