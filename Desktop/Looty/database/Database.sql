DROP DATABASE IF EXISTS Looty;
CREATE DATABASE Looty;
USE Looty;

DROP TABLE IF EXISTS prodotti;

CREATE TABLE categoria(
	id INT auto_increment PRIMARY KEY,
    nome varchar(20) not null
);

CREATE TABLE prodotti (	
  codice INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(20) NOT NULL,
  descrizione VARCHAR(500),
  prezzoS FLOAT DEFAULT 0,
  prezzoM FLOAT DEFAULT 0,
  prezzoL FLOAT DEFAULT 0,
  quantita INT DEFAULT 0,
  immagine VARCHAR(255),
  id_categoria INT NOT NULL DEFAULT 1,
  
  FOREIGN KEY(id_categoria) REFERENCES categoria(id)
);

CREATE TABLE appartiene (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_prodotti INT NOT NULL, 
    
    FOREIGN KEY (id_categoria) REFERENCES categoria(id),
    FOREIGN KEY (id_prodotti) REFERENCES prodotti(codice)
);

CREATE TABLE utente (	
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  email VARCHAR(20) NOT NULL,
  pass VARCHAR(255) NOT NULL,
  ruolo BOOLEAN NOT NULL DEFAULT 0
); 

CREATE TABLE metodoPagamento(
	id INT PRIMARY KEY AUTO_INCREMENT,
	codiceCarta VARCHAR(255) NOT NULL,
	titolare VARCHAR (50) NOT NULL,
	id_utente INT NOT NULL, 
	CVV INT NOT NULL,
	mese_scadenza INT NOT NULL,
	anno_scadenza INT NOT NULL,
	is_preferito BOOLEAN DEFAULT FALSE,
    valido BOOLEAN DEFAULT TRUE,
    
	FOREIGN KEY (id_utente) REFERENCES utente(id) ON DELETE CASCADE
);

CREATE TABLE indirizzo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    etichetta VARCHAR(50),
    via VARCHAR(100),
    citta VARCHAR(50),
    cap VARCHAR(10),
    provincia VARCHAR(50),
    paese VARCHAR(50),
    telefono VARCHAR(20),
    is_preferito BOOLEAN DEFAULT FALSE,
    valido BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (id_utente) REFERENCES utente(id) ON DELETE CASCADE
);

CREATE TABLE ordine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_metodoPagamento INT NOT NULL,
    id_indirizzo INT NOT NULL,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale FLOAT(10,2),

    FOREIGN KEY (id_metodoPagamento) REFERENCES metodoPagamento(id),
    FOREIGN KEY (id_indirizzo) REFERENCES indirizzo(id)
);

CREATE TABLE OrdineProdotto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ordine INT,
    id_prodotto INT,
    quantita INT,
    dimensione varchar(1),
    prezzo_unitario FLOAT(10,2),
    FOREIGN KEY (id_ordine) REFERENCES ordine(id),
    FOREIGN KEY (id_prodotto) REFERENCES prodotti(codice)
);
