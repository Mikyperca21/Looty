-- Insert prodotti
INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Marvel', '
Entra nell''universo Marvel con una selezione casuale di prodotti ispirati ai tuoi supereroi e villain preferiti! Ogni mystery box contiene gadget esclusivi, action figures, e accessori da collezione. Scopri il tuo potere... e quello della sorpresa!', 29.99, 49.99, 69.99, 50, 'images/Marvel.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Pokemon', 'Pikachu e compagnia ti aspettano! Ogni Pokemon Mystery Box è un viaggio nel mondo dei Pokémon, ricca di carte collezionabili, peluche, spille e altri accessori esclusivi. Colleziona, esplora e scopri cosa c''è dentro la tua scatola misteriosa!', 39.99, 69.99, 99.99, 20, 'images/pokemon.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Harry Potter', 'Sei pronto a ricevere un po'' di magia? La nostra Harry Potter Mystery Box è piena di oggetti leggendari, da bacchette a sciarpe, da tazze incantate a accessori unici. Scegli la tua casa e preparati a vivere una vera esperienza magica!',  19.99, 39.99, 79.99, 35,'images/harry.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Demon Slayer', 'Unisciti alla lotta contro i demoni con la nostra Demon Slayer Mystery Box! Contiene articoli esclusivi dei tuoi personaggi preferiti, tra cui portachiavi, action figures, poster e altri gadget legati alla serie. Una box che ti farà sentire come un vero cacciatore di demoni!', 10.99, 39.99, 59.99, 30, 'images/demon.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('fragolina', 'Box fragolina', 99.99, 109.99, 119.99, 50, 'images/fragolina.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Dragon Ball', 'Sei pronto a ricevere un potere infinito? La Dragon Ball Mystery Box è il pacchetto perfetto per ogni fan della saga. Contiene action figures, portachiavi, poster e gadget esclusivi ispirati a Goku, Vegeta e tutti i tuoi personaggi preferiti. Raccogli le sfere del drago!', 19.99, 49.99, 69.99, 9, 'images/dragonball.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Funko pop', 'Da Fare descrizione', 99.99, 109.99, 119.99, 50, 'images/funko.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('Attack on Titan', 'Da fare Descrizione', 99.99, 109.99, 119.99, 50, 'images/attackontitan.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('prova', 'prova', 99.99, 109.99, 119.99, 50, 'images/dragonball.png');

INSERT INTO prodotti (nome, descrizione, prezzoS, prezzoM, prezzoL, quantita, immagine)
VALUES ('prova', 'prova', 99.99, 109.99, 119.99, 50, 'images/dragonball.png');

-- Insert utenti 
-- Inserimento utente normale
INSERT INTO utente (nome, cognome, email, pass, ruolo)
VALUES ('Mario', 'Rossi', 'mariorossi@gmail.com', '76bb849338db38e0ede3b8ae726373c42992152747c39e484f096b623946c8a265adde3a72c8177a70a8876694b9403f06d44decfcfe44be25f1078be0282239', false);

-- Inserimento admin
INSERT INTO utente (nome, cognome, email, pass, ruolo)
VALUES ('Laura', 'Bianchi', 'admin@admin.com', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', true);

INSERT INTO utente (nome, cognome, email, pass, ruolo)
VALUES ('Giulia', 'Verdi', 'utente@gmail.com', 'c7e44f02b10b08a958ce28eec7ea08f455e4cbb38cdf44c340405d0815826733582e588b2435d6caf5316b91626f360e0bdd500420ae0185f4b732db3aff0e0d', false);

-- Insert metodi di pagamento
INSERT INTO metodoPagamento (codiceCarta, titolare, id_utente, CVV, mese_scadenza, anno_scadenza, is_preferito)
VALUES (1111222233334444, 'Mario Rossi', 1, 123, 3, 2027, true);

INSERT INTO metodoPagamento (codiceCarta, titolare, id_utente, CVV, mese_scadenza, anno_scadenza, is_preferito)
VALUES (2222444466668888, 'Mario Rossi', 1, 123, 3, 2024, false);

-- Insert ordini + dettagli
-- Ordine 1
INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono)
VALUES (1, '2024-01-15 10:34:21', 99.99,  'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (1, 1, 1, 29.99);

-- Ordine 2
INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono)
VALUES (1, '2024-03-22 14:12:50', 149.98, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (2, 2, 1, 39.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (2, 3, 1, 19.99);

-- Ordine 3
INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono)
VALUES (1, '2024-05-03 09:48:10', 59.98, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (3, 4, 1, 10.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (3, 5, 1, 49.99);

-- Ordine 4
INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono)
VALUES (1, '2024-07-19 19:22:05', 299.97, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (4, 6, 1, 99.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (4, 7, 1, 99.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (4, 8, 1, 99.99);

-- Ordine 5
INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono)
VALUES (1, '2024-10-05 16:40:33', 199.98, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 1, 1, 29.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 2, 1, 39.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 3, 1, 19.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 4, 1, 10.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 5, 1, 49.99);
INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario)
VALUES (5, 6, 1, 99.99);

INSERT INTO ordine (id_utente, data_ordine, totale, via, citta, cap, provincia, paese, telefono) VALUES
(3, '2024-03-05 23:46:00', 39.99, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567'),
(3, '2024-01-04 20:22:00', 329.96, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567'),
(3, '2024-03-16 10:05:00', 59.99, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567'),
(3, '2024-01-21 04:34:00', 219.98, 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567');

INSERT INTO OrdineProdotto (id_ordine, id_prodotto, quantita, prezzo_unitario) VALUES
(6, 2, 1, 39.99),
(7, 8, 1, 99.99),
(7, 1, 1, 29.99),
(7, 9, 2, 99.99),
(8, 4, 1, 59.99),
(9, 10, 1, 109.99),
(9, 8, 1, 109.99);

 -- Insert indirizzi
INSERT INTO indirizzo (id_utente, etichetta, via, citta, cap, provincia, paese, telefono, is_preferito)
VALUES 
(1, 'Casa', 'Via Roma 12', 'Milano', '20100', 'MI', 'Italia', '3331234567', true),
(1, 'Lavoro', 'Via Garibaldi 50', 'Milano', '20122', 'MI', 'Italia', '3399876543', false);

-- Insert categorie
INSERT INTO categoria (nome)
VALUES ('Gadget');
INSERT INTO categoria (nome)
VALUES ('Carte');
INSERT INTO categoria (nome)
VALUES ('Vestiti');