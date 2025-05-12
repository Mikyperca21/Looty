package model;

public class metodoPagamentoBean {
	
	private int id;
	private String codiceCarta;
	private String titolare;
	private int idUtente;
	private int CVV;
	private int meseScadenza;
	private int annoScadenza;
	private boolean isPreferito;
	
	public metodoPagamentoBean ()
	{}

	public metodoPagamentoBean(int id, String codiceCarta, String titolare, int idUtente, int cVV, int meseScadenza,
			int annoScadenza, boolean isPreferito) {
		super();
		this.id = id;
		this.codiceCarta = codiceCarta;
		this.titolare = titolare;
		this.idUtente = idUtente;
		CVV = cVV;
		this.meseScadenza = meseScadenza;
		this.annoScadenza = annoScadenza;
		this.isPreferito = isPreferito;
	}

	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCodiceCarta() {
		return codiceCarta;
	}

	public void setCodiceCarta(String codiceCarta) {
		this.codiceCarta = codiceCarta;
	}

	public String getTitolare() {
		return titolare;
	}

	public void setTitolare(String titolare) {
		this.titolare = titolare;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

	public int getCVV() {
		return CVV;
	}

	public void setCVV(int cVV) {
		CVV = cVV;
	}

	public int getMeseScadenza() {
		return meseScadenza;
	}

	public void setMeseScadenza(int meseScadenza) {
		this.meseScadenza = meseScadenza;
	}

	public int getAnnoScadenza() {
		return annoScadenza;
	}

	public void setAnnoScadenza(int annoScadenza) {
		this.annoScadenza = annoScadenza;
	}

	public boolean isPreferito() {
		return isPreferito;
	}

	public void setPreferito(boolean isPreferito) {
		this.isPreferito = isPreferito;
	}

	
}
