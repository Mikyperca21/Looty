DROP DATABASE IF EXISTS Looty;
CREATE DATABASE Looty;
USE Looty;

DROP TABLE IF EXISTS prodotti;

CREATE TABLE prodotti (	
  codice INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(20) NOT NULL,
  descrizione VARCHAR(100),
  prezzoS FLOAT DEFAULT 0,
  prezzoM FLOAT DEFAULT 0,
  prezzoL FLOAT DEFAULT 0,
  quantita INT DEFAULT 0,
  immagine VARCHAR(255)
);


INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Marvel', 'box a sorpresa marvel', 29.99, 34.99, 39.99, 100, 'images/Marvel.png');


INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Pokemon', 'Box pokemon', 19.99, 22.99, 25.99, 150, 'images/pokemon.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('harry', 'Box harry', 99.99, 109.99, 119.99, 50, 'images/harry.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('demon', 'Box demon', 99.99, 109.99, 119.99, 50, 'images/demon.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('fragolina', 'Box fragolina', 99.99, 109.99, 119.99, 50, 'images/fragolina.png');



DROP TABLE IF EXISTS utente;

CREATE TABLE utente (	
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  email VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL,
  ruolo BOOLEAN NOT NULL DEFAULT 0
);
