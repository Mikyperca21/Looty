<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.prodottoDAO, model.prodottoBean"%>
<%@ page import="java.sql.SQLException"%>

<%
int id = Integer.parseInt(request.getParameter("id"));
prodottoDAO dao = new prodottoDAO();
prodottoBean prodotto = dao.doRetrieveByKey(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modifica Prodotto</title>
<link rel="stylesheet" href="style/ModificaIndirizzo.css">
<link rel="icon" href="images/LogoLooty_resized.png">
</head>
<body>

		<%@ include file="Header.jsp"%>
	
	
	
<div class="card-indirizzo">
<h2>Modifica Prodotto</h2>
		<div class="form-content">
			<form action="catalogo" method="post" enctype="multipart/form-data">
				<input type="hidden" name="action" value="modify"> <input
					type="hidden" name="id" value="<%=prodotto.getCodice()%>">
				<div class="input-row">
					<div class="form-group">
						<label for="nome">Nome: </label> <input type="text" id="nome"
							name="nome" value="<%=prodotto.getNome()%>" required>
					</div>
					<div class="form-group">
						<label for="quantita">Quantità di box disponibii: </label> <input
							type="number" id="quantita" name="quantita"
							value="<%=prodotto.getQuantita()%>" required>
					</div>
				</div>
				
				<div class="input-row-tre">
					<div class="form-group">
						<label for="prezzoS">Prezzo per la mystery box di taglia S:
						</label> <input type="number" step="any" id="prezzoS" name="prezzoS"
							value="<%=prodotto.getPrezzoS()%>" required>
					</div>
					<div class="form-group">
						<label for="prezzoM">Prezzo per la mystery box di taglia M:
						</label> <input type="number" step="any" id="prezzoM" name="prezzoM"
							value="<%=prodotto.getPrezzoM()%>" required>
					</div>
					<div class="form-group">
						<label for="prezzoL">Prezzo per la mystery box di taglia L:
						</label> <input type="number" step="any" id="prezzoL" name="prezzoL"
							value="<%=prodotto.getPrezzoL()%>" required>
					</div>
				</div>
				<div class="form-group">
					<label for="descrizione">Descrizione: </label>
					<textarea style="width: 100%; height: 100px;" id="descrizione" name="descrizione" required><%=prodotto.getDescrizione()%></textarea>
				</div>

				<div class="form-group">
					<label for="immagine">Immagine attuale:</label>
					<div class="preview-container">
						<img id="preview" src="<%=prodotto.getImmagine()%>"
							alt="Immagine prodotto" style="width: 50px; height:50px;" />
					</div>
				</div>

				<div class="form-group">
					<label for="immagine">Sostituisci immagine:</label> <input
						type="file" id="immagine" name="immagine" accept="image/*">
				</div>

				<div class="container-aggiungi">
					<button type="button" onclick="window.history.back()">
						<span class="material-symbols-outlined">arrow_back</span>Torna
						Indietro
					</button>
					<button type="submit" value="modifica">
						<span class="material-symbols-outlined">check</span>Salva
						modifiche
					</button>
				</div>
			</form>

		</div>
	</div>
	<div class="container-footer">
		<%@ include file="Footer.jsp"%>
	</div>
</body>
</html>
