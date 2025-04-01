package model;

public class prodottoBean {
	
	private int codice;
	private String nome;
	private String descrizione;
	private Dimensione dimensione;
	private float prezzo1;
	private float prezzo2;
	private float prezzo3;
	private int quantita;
	
	public prodottoBean() {}

	public prodottoBean(int codice, String nome, String descrizione, Dimensione dimensione, float prezzo1,
			float prezzo2, float prezzo3, int quantita) {
		super();
		this.codice = codice;
		this.nome = nome;
		this.descrizione = descrizione;
		this.dimensione = dimensione;
		this.prezzo1 = prezzo1;
		this.prezzo2 = prezzo2;
		this.prezzo3 = prezzo3;
		this.quantita = quantita;
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

	public Dimensione getDimensione() {
		return dimensione;
	}

	public void setDimensione(Dimensione dimensione) {
		this.dimensione = dimensione;
	}

	public float getPrezzo1() {
		return prezzo1;
	}

	public void setPrezzo1(float prezzo1) {
		this.prezzo1 = prezzo1;
	}

	public float getPrezzo2() {
		return prezzo2;
	}

	public void setPrezzo2(float prezzo2) {
		this.prezzo2 = prezzo2;
	}

	public float getPrezzo3() {
		return prezzo3;
	}

	public void setPrezzo3(float prezzo3) {
		this.prezzo3 = prezzo3;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	@Override
	public String toString() {
		return "prodottoBean [codice=" + codice + ", nome=" + nome + ", descrizione=" + descrizione + ", dimensione="
				+ dimensione + ", prezzo1=" + prezzo1 + ", prezzo2=" + prezzo2 + ", prezzo3=" + prezzo3 + ", quantita="
				+ quantita + "]";
	}
	
	
	

}
