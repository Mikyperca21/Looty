package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Carrello {
	private List<ElementoCarrello> prodotti = new ArrayList<ElementoCarrello>();

	public void Carello() {

	}

	public void aggiungiProdotto(ElementoCarrello prodotto) {
		for (ElementoCarrello esistente : prodotti) {
			if (esistente.getProdotto().getCodice() == prodotto.getProdotto().getCodice()
					&& esistente.getDimensione().equalsIgnoreCase(prodotto.getDimensione())) {
				int nuovaQuantita = esistente.getQuantita() + prodotto.getQuantita();
				esistente.setQuantita(nuovaQuantita);
				return;
			}
		}
		prodotti.add(prodotto);
	}

	public void eliminaProdotto(ElementoCarrello prodotto) {
		Iterator<ElementoCarrello> it = prodotti.iterator();
		while (it.hasNext()) {
			ElementoCarrello prod = it.next();
			if (prod.getProdotto().getCodice() == prodotto.getProdotto().getCodice()
					&& prod.getDimensione().equalsIgnoreCase(prodotto.getDimensione())) {
				
				it.remove();

			}
		}
	}

	public List<ElementoCarrello> getProdotti() {
		return prodotti;
	}

}
