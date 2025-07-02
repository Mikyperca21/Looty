<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Looty</title>
		<link rel = "stylesheet" href = "style/Home.css">
    <link rel="icon" href="images/LogoLooty_resized.png">
	</head>
	<body>
		<div class = "container-header">
			<%@ include file="Header.jsp"%>
		</div>
		
		<div class = "banner-container">
			<div class = "banner-content">
				<img src="images/BannerLooty.png" class="slider-image" alt="Immagine 1" />
            	<img src="images/BannerPersonaggi.png" class="slider-image" alt="Immagine 2" />
            	<img src="images/BannerSpedizione.png" class="slider-image" alt="Immagine 3" />
			</div>
			
			<div class="arrow left-arrow" onclick="prevImage()">&#10094;</div>
        	<div class="arrow right-arrow" onclick="nextImage()">&#10095;</div>
		</div>
		
		<div class = "frase-container">
			<div class = "box-content">
				<h1>Looty your passions</h1>
			</div>
		</div>
		
		<div class = "categoria-container">
			<div class = "categoria-content">
				<div class = "item">
					<img src = "images/Gadget.png">
					<span>Non sai cosa aspettarti? È proprio questo il bello! Le lootbox della categoria Gadget nascondono al loro interno oggetti sorprendenti: portachiavi originali, accessori tech, mini figure da collezione, articoli da scrivania e tanto altro!</span>
				</div>
				
				<div class = "item">
					<span>Per i veri collezionisti e gli appassionati del gioco, le nostre lootbox di Carte sono un tesoro nascosto. Che tu sia un veterano o un neofita, ogni apertura è una nuova possibilità di trovare qualcosa di epico!</span>
					<img src = "images/Carte.png">
				</div>
				
				<div class = "item">
					<img src = "images/Vestiti.png">
					<span>Scopri le nostre lootbox dedicate al mondo dell’abbigliamento! Ogni scatola è una sorpresa: potresti trovare t-shirt esclusive, felpe uniche, accessori introvabili e capi limited edition selezionati con cura.</span>
				</div>
			</div>
		</div>
		
		<div class = "box-container">
			<div class = "box-content">
				<a href="${pageContext.request.contextPath}/Catalogo.jsp" class="btn">Inizia ad acquistare</a>
			</div>
		</div>
		<div class="container-footer">
			<%@ include file="Footer.jsp"%>
		</div>
	</body>
	
	<script>
		let currentIndex = 0; 
		const images = document.querySelectorAll('.slider-image'); // Seleziona tutte le immagini
		const totalImages = images.length; // Numero totale di immagini
	
		function changeImage() {
		    // Rimuovi la classe 'active' da tutte le immagini
		    images.forEach((image) => {
		        image.classList.remove('active');
		    });
	
		    // Aggiungi la classe 'active' all'immagine corrente
		    images[currentIndex].classList.add('active');
		}
	
		function nextImage() {
		    currentIndex = (currentIndex + 1) % totalImages; // Incrementa l'indice e torna a 0 se supera il numero totale
		    changeImage();
		}
	
		function prevImage() {
		    currentIndex = (currentIndex - 1 + totalImages) % totalImages; // Decrementa l'indice e torna all'ultimo se è negativo
		    changeImage();
		}
	
		// Mostra la prima immagine all'avvio
		changeImage();
	
		// Imposta l'intervallo per cambiare immagine ogni 5 secondi
		setInterval(nextImage, 7000);
	</script>
</html>