<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Looty</title>
		<link rel = "stylesheet" href = "style/Home.css">
	</head>
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
		
		<div class = "banner-container">
			<div class = "banner-content">
				<img id = "banner" src = "images/bannerhome.jpg">
			</div>
		</div>
		
		<div class = "frase-container">
			<div class = "box-content">
				<h1>Looty your passions</h1>
			</div>
		</div>
		
		<div class = "categoria-container">
			<div class = "categoria-content">
				<div class = "item">
					<img src = "images/cat1.png">
					<span>Non sai cosa aspettarti? È proprio questo il bello! Le lootbox della categoria Gadget nascondono al loro interno oggetti sorprendenti: portachiavi originali, accessori tech, mini figure da collezione, articoli da scrivania e tanto altro!</span>
				</div>
				
				<div class = "item">
					<span>Per i veri collezionisti e gli appassionati del gioco, le nostre lootbox di Carte sono un tesoro nascosto. Che tu sia un veterano o un neofita, ogni apertura è una nuova possibilità di trovare qualcosa di epico!</span>
					<img src = "images/cat2.png">
				</div>
				
				<div class = "item">
					<img src = "images/cat3.png">
					<span>Scopri le nostre lootbox dedicate al mondo dell’abbigliamento! Ogni scatola è una sorpresa: potresti trovare t-shirt esclusive, felpe uniche, accessori introvabili e capi limited edition selezionati con cura.</span>
				</div>
			</div>
		</div>
		
		<div class = "box-container">
			<div class = "box-content">
				<a href = "Catalogo.jsp" class = "btn">Inizia ad acquistare</a>
			</div>
		</div>
		
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
</html>