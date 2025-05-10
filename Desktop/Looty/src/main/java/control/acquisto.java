package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Carrello;
import model.ElementoCarrello;
import model.ordineBean;
import model.ordineDAO;
import model.ordineProdottoBean;
import model.utenteBean;

@WebServlet("/acquisto")
public class acquisto extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public acquisto() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utente == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        if (carrello == null || carrello.getProdotti().isEmpty()) {
            response.sendRedirect("carrello.jsp?errore=vuoto");
            return;
        }

        try {
            ordineDAO dao = new ordineDAO();

            List<ElementoCarrello> prodottiCarrello = carrello.getProdotti();

            // Verifica disponibilità
            for (ElementoCarrello item : prodottiCarrello) {
                if (!dao.verificaDisponibilita(item)) {
                    request.setAttribute("errore", "Prodotto non disponibile: " + item.getProdotto().getNome());
                    request.getRequestDispatcher("carrello.jsp").forward(request, response);
                    return;
                }
            }

            // Calcolo totale
            double totale = calcolaTotale(carrello);

            // Salvataggio ordine
            ordineBean ordine = new ordineBean();
            ordine.setIdUtente(utente.getId());
            ordine.setTotale(totale);
            int idOrdine = dao.doSave(ordine);

            // Salvataggio prodotti ordine
            List<ordineProdottoBean> prodottiOrdine = new ArrayList<>();
            for (ElementoCarrello item : prodottiCarrello) {
                ordineProdottoBean op = new ordineProdottoBean();
                op.setIdProdotto(item.getProdotto().getCodice());
                op.setQuantita(item.getQuantita());
                op.setPrezzoUnitario(item.getProdotto().getPrezzoByTagliaCarrello());
                prodottiOrdine.add(op);
            }
            dao.salvaProdottiOrdine(prodottiOrdine, idOrdine);

            // Aggiornamento magazzino
            for (ElementoCarrello item : prodottiCarrello) {
                dao.updateMagazzino(item);
            }

            // Svuota carrello e redirect
            session.removeAttribute("carrello");
            response.sendRedirect("ordineConfermato.jsp");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private double calcolaTotale(Carrello carrello) {
        double totale = 0;
        for (ElementoCarrello item : carrello.getProdotti()) {
            totale += item.getProdotto().getPrezzoByTagliaCarrello() * item.getQuantita();
        }
        return totale;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
