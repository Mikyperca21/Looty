package model;

import java.sql.Timestamp;


public class ordineBean {

	private int id; 
	private int id_metodoPgamento;
	private int id_indirizzo;
	private Timestamp dataOrdine;
	private double totale;
	private String immagine;
	
	public ordineBean() {
	
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getId_metodoPgamento() {
		return id_metodoPgamento;
	}


	public void setId_metodoPgamento(int id_metodoPgamento) {
		this.id_metodoPgamento = id_metodoPgamento;
	}


	public int getId_indirizzo() {
		return id_indirizzo;
	}


	public void setId_indirizzo(int id_indirizzo) {
		this.id_indirizzo = id_indirizzo;
	}


	public Timestamp getDataOrdine() {
		return dataOrdine;
	}


	public void setDataOrdine(Timestamp dataOrdine) {
		this.dataOrdine = dataOrdine;
	}


	public double getTotale() {
		return totale;
	}


	public void setTotale(double totale) {
		this.totale = totale;
	}


	public String getImmagine() {
		return immagine;
	}


	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}
		
}
