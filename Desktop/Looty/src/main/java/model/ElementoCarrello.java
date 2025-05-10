package model;

public class ElementoCarrello {

	private prodottoBean prodotto;
	private String dimensione;
	private int quantita;

	public ElementoCarrello(prodottoBean prodotto, String dimensione, int quantita) {
		super();
		this.prodotto = prodotto;
		this.dimensione = dimensione;
		this.quantita = quantita;
	}

	public prodottoBean getProdotto() {
		return prodotto;
	}

	public void setProdotto(prodottoBean prodotto) {
		this.prodotto = prodotto;
	}

	public String getDimensione() {
		return dimensione;
	}

	public void setDimensione(String dimensione) {
		this.dimensione = dimensione;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	public float getPrezzoTotale() {
		float prezzoUnitario = 0;
		switch (dimensione) {
		case "S":
			prezzoUnitario = prodotto.getPrezzoS();
			break;
		case "M":
			prezzoUnitario = prodotto.getPrezzoM();
			break;
		case "L":
			prezzoUnitario = prodotto.getPrezzoL();
			break;
		}
		return prezzoUnitario * quantita;
	}
	
	
	public int getQuantitaDaScalare() {
		int quantitaDaScalare = 0;
		switch(dimensione) {
		case "S": 
			quantitaDaScalare = 1;
			break;
		case "M": 
			quantitaDaScalare = 2;
			break;
		case "L": 
			quantitaDaScalare = 3;
			break;
		}
		return quantitaDaScalare * quantita;
	}
}

