package model;

import java.sql.Timestamp;


public class ordineBean {

	private int id; 
	private int idUtente;
	private Timestamp dataOrdine;
	private double totale;
	private String immagineProdotto;
	
	public ordineBean() {
	
	}

	public ordineBean(int id, int idUtente, Timestamp dataOrdine, double totale, String immmagineProdotto) {
		super();
		this.id = id;
		this.idUtente = idUtente;
		this.dataOrdine = dataOrdine;
		this.totale = totale;
		this.immagineProdotto = immagineProdotto;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
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

	public String getImmagineProdotto() {
		return immagineProdotto;
	}

	public void setImmagineProdotto(String immagineProdotto) {
		this.immagineProdotto = immagineProdotto;
	}
	
	
	
}
