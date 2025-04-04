package model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
	private List<prodottoBean> prodotti = new ArrayList<prodottoBean>();
	public void Carello() {
		
	}
	
	public void aggiungiProdotto(prodottoBean prodotto) {
		prodotti.add(prodotto);
	}
	
	public void eliminaProdotto(prodottoBean prodotto) {
		for(prodottoBean prod : prodotti) {
			if(prod.getCodice() == prodotto.getCodice()) {
				prodotti.remove(prod);
				break;
			}
		}
	}
	
	public List<prodottoBean> getProdotti(){
		return prodotti;
	}

}
