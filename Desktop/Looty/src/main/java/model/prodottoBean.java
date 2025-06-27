package model;

public class prodottoBean {

	private int codice;
	private String nome;
	private String descrizione;
	private double prezzoS;
	private double prezzoM;
	private double prezzoL;
	private int quantita;
	private String immagine;

	public prodottoBean() {
	}

	private String tagliaCarrello;

	public String getTagliaCarrello() {
		return tagliaCarrello;
	}

	public void setTagliaCarrello(String tagliaCarrello) {
		this.tagliaCarrello = tagliaCarrello;
	}

	public double getPrezzoByTagliaCarrello(String taglia) {
	    if (taglia == null) return prezzoS;
	    switch(taglia.toUpperCase()) {
	        case "M": return prezzoM;
	        case "L": return prezzoL;
	        default: return prezzoS;
	    }
	}
	public int getCodice() {
		return codice;
	}

	public void setCodice(int codice) {
		this.codice = codice;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public double getPrezzoS() {
		return prezzoS;
	}

	public void setPrezzoS(double prezzoS) {
		this.prezzoS = prezzoS;
	}

	public double getPrezzoM() {
		return prezzoM;
	}

	public void setPrezzoM(double prezzoM) {
		this.prezzoM = prezzoM;
	}

	public double getPrezzoL() {
		return prezzoL;
	}

	public void setPrezzoL(double prezzoL) {
		this.prezzoL = prezzoL;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	
	public String getImmagine() {
		return immagine;
	}
	
	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}

	@Override
	public String toString() {
		return "prodottoBean [codice=" + codice + ", nome=" + nome + ", descrizione=" + descrizione + ", prezzoS="
				+ prezzoS + ", prezzoM=" + prezzoM + ", prezzoL=" + prezzoL + ", quantita=" + quantita + "]";
	}

}
