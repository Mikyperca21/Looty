package model;

public class indirizzoBean {
	
	private int id;
	private int idUtente;
	private String etichetta;
	private String via;
	private String citta; 
	private String cap;
	private String provincia;
	private String paese;
	private String telefono;
	private boolean is_preferito;
	
	public indirizzoBean() {
		
	}

	public indirizzoBean(int id, int idUtente, String etichetta, String via, String citta, String cap, String provincia, String paese,
			String telefono, boolean is_preferito) {
		super();
		this.id = id;
		this.idUtente = idUtente;
		this.etichetta = etichetta;
		this.via = via;
		this.citta = citta;
		this.cap = cap;
		this.provincia = provincia;
		this.paese = paese;
		this.telefono = telefono;
		this.is_preferito = is_preferito;
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

	public String getEtichetta() {
		return etichetta;
	}

	public void setEtichetta(String etichetta) {
		this.etichetta = etichetta;
	}

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getPaese() {
		return paese;
	}

	public void setPaese(String paese) {
		this.paese = paese;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public boolean isIs_preferito() {
		return is_preferito;
	}

	public void setIs_preferito(boolean is_preferito) {
		this.is_preferito = is_preferito;
	}
	
	

}
