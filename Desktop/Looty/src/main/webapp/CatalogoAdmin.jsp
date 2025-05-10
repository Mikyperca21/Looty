<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.prodottoBean, model.Carrello"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Catalogo Amministratore</title>
<link rel="stylesheet" href="style/CatalogoAdmin.css">
<link rel ="icon" href = "images/LogoLooty_resized.png">
</head>
<body>
	<%@ include file="Header.jsp"%>
	<h1>Catalogo Amministratore:</h1>
	
	

	<div id="form-container" class="form">
		<div class="form-content">
			<h2>Nuovo Prodotto</h2>
			<form action="<%=request.getContextPath()%>/catalogo" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="action" value="inserisci">

				<div class="form-group">
					<label for="nome">Nome:</label> <input type="text" id="nome"
						placeholder="Inserisci il nome" name="nome" required>
				</div>

				<div class="form-group">
					<label for="prezzoS">Prezzo per la mystery box di taglia S:</label>
					<input type="number" step="any" id="prezzoS" name="prezzoS"
						min="0.01" placeholder="Inserisci il prezzo per la box piccola"
						required>
				</div>
				<div class="form-group">
					<label for="prezzoM">Prezzo per la mystery box di taglia M:</label>
					<input type="number" step="any" id="prezzoM" name="prezzoM"
						min="0.01" placeholder="Inserisci il prezzo per la box media"
						required>
				</div>
				<div class="form-group">
					<label for="prezzoL">Prezzo per la mystery box di taglia L:</label>
					<input type="number" step="any" id="prezzoL" name="prezzoL"
						min="0.01" placeholder="Inserisci il prezzo per la box grande"
						required>
				</div>

				<div class="form-group">
					<label for="quantita">Quantità di box disponibili:</label> <input
						type="number" id="quantita" name="quantita" min="1"
						placeholder="Inserisci la quantità di box disponibili" required>
				</div>

				<div class="form-group">
					<label for="descrizione">Descrizione (Nota: per l'acquisto della box di dimensione S verrà scalata una quantità dal magazzino, per l'acquisto di una box di taglia media 
					verranno scalate due unità dal magazzino e per l'acquisto della box di dimensione L verranno scalate tre unità dal magazzino):</label>
					<textarea id="descrizione" name="descrizione"
						placeholder="Inserisci una descrizione della box" required></textarea>
				</div>

				<div class="form-group">
					<label for="immagine">Inserire immagine del prodotto:</label> <input
						type="file" id="immagine" name="immagine">
				</div>

				<div class="preview-container">
					<img id="preview" src="#" alt="Anteprima immagine">
				</div>


				<button type="submit" value="aggiungi">
					<span class="material-symbols-outlined">add</span>Inserisci
					Prodotto
				</button>
			</form>
		</div>
	</div>

	<div class="table-container">
		<%
		Collection<?> prodotti = (Collection<?>) request.getAttribute("prodotti");
		if (request.getAttribute("prodotti") == null) {
			response.sendRedirect(request.getContextPath() + "/catalogo");
		}
		prodottoBean prodotto = (prodottoBean) request.getAttribute("prodotto");
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		%>
		<table class="product-table">
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
					<td data-label="Dimensione">
						<form id="form-<%=bean.getCodice()%>" action="catalogo"
							method="post" class="carrello-form">
							<input type="hidden" name="action" value="aggiungiCarrello">
							<input type="hidden" name="id" value="<%=bean.getCodice()%>">
							<select name="dimensione" required>
								<option value="">Seleziona</option>
								<option value="S">S</option>
								<option value="M">M</option>
								<option value="L">L</option>
							</select> <input type="number" name="quantita" min="1" max="10" value="1"
								required />
							<button type="submit" class="action-button"
								id="btn-<%=bean.getCodice()%>">
								<span class="material-symbols-outlined">add_shopping_cart</span>
							</button>
							<a href="catalogo?action=delete&id=<%=bean.getCodice()%>">
								<button type="button" class="action-button">
									<span class="material-symbols-outlined">delete</span>
								</button>
							</a> <a href="ModificaProdottoAdmin.jsp?id=<%=bean.getCodice()%>">
								<button type="button" class="action-button">
									<span class="material-symbols-outlined">edit</span>
								</button>
							</a>
						</form>
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
	</script>

</body>
</html>
