package model;

public class prodottoBean {

	private int codice;
	private String nome;
	private String descrizione;
	private float prezzoS;
	private float prezzoM;
	private float prezzoL;
	private int quantita;
	private String immagine;

	public prodottoBean() {
	}

	public prodottoBean(int codice, String nome, String descrizione, float prezzoS, float prezzoM, float prezzoL,
			int quantita, String immagine) {
		super();
		this.codice = codice;
		this.nome = nome;
		this.descrizione = descrizione;
		this.prezzoS = prezzoS;
		this.prezzoM = prezzoM;
		this.prezzoL = prezzoL;
		this.quantita = quantita;
		this.immagine = immagine;
	}

	private String tagliaCarrello;

	public String getTagliaCarrello() {
		return tagliaCarrello;
	}

	public void setTagliaCarrello(String tagliaCarrello) {
		this.tagliaCarrello = tagliaCarrello;
	}

	public String getPrezzoByTagliaCarrello() {
		float prezzo;
		if (tagliaCarrello == null) {
			prezzo = prezzoS;
		} else {
			switch (tagliaCarrello.toUpperCase()) {
			case "M":
				prezzo = prezzoM;
				break;
			case "L":
				prezzo = prezzoL;
				break;
			default:
				prezzo = prezzoS;
			}
		}
		return String.format("%.2f", prezzo);
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

	public float getPrezzoS() {
		return prezzoS;
	}

	public void setPrezzoS(float prezzoS) {
		this.prezzoS = prezzoS;
	}

	public float getPrezzoM() {
		return prezzoM;
	}

	public void setPrezzoM(float prezzoM) {
		this.prezzoM = prezzoM;
	}

	public float getPrezzoL() {
		return prezzoL;
	}

	public void setPrezzoL(float prezzoL) {
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
