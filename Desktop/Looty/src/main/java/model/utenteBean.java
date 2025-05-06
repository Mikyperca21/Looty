package model;

import java.nio.charset.StandardCharsets;

public class utenteBean {
	private int id;
	private String nome;
	private String cognome;
	private String email;
	private String password;
	private int ordini;
	private boolean ruolo; // forse è un ENUM
	
	public utenteBean(){
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String pass) {
		// cifro la password per poi salvarla nel DB
		pass = toHash(pass);
		
		this.password = pass;
	}

	public int getOrdini() {
		return ordini;
	}

	public void setOrdini(int ordini) {
		this.ordini = ordini;
	}

	public boolean getRuolo() {
		return ruolo;
	}

	public void setRuolo(boolean ruolo) {
		this.ruolo = ruolo;
	}
	
	
	//	funzione per trasformare le stringhe in HASH (SHA-512)
	//	lo uso per salvare la passord nel DB e/o confrontarle per il login
	public static String toHash(String password){
		String hashString = null;
		
		try {
			java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
			byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
			hashString = "";
			for(int i = 0; i < hash.length; i++) {
				hashString += Integer.toHexString((hash[i] & 0xFF) | 0x100).toLowerCase().substring(1,3); // <- copiato dalle slides
			}
		}catch (java.security.NoSuchAlgorithmException e){
			System.out.println(e);
		}
		
		return hashString;
	}
}