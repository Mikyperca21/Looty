package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.utenteBean;
import model.utenteDAO;

/**
 * Servlet implementation class ModificaUtente
 */
@WebServlet("/ModificaUtente")
public class ModificaUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaUtente() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");

        if (utente == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String nuovoNome = request.getParameter("nome");
        String nuovoCognome = request.getParameter("cognome");
        String nuovaEmail = request.getParameter("email");
        String nuovaPassword = request.getParameter("password");
        String confermaPassword = request.getParameter("confermaPassword");

        if (nuovoNome == null || nuovoCognome == null || nuovaEmail == null ||
            nuovoNome.isEmpty() || nuovoCognome.isEmpty() || nuovaEmail.isEmpty()) {
            request.setAttribute("errorMessage", "Tutti i campi sono obbligatori!");
            request.getRequestDispatcher("ProfiloUtente.jsp").forward(request, response);
            return;
        }
        
        
        if (!nuovaPassword.isEmpty()) {
            if (!nuovaPassword.equals(confermaPassword)) {
                request.setAttribute("errorMessage", "Le password non coincidono.");
                request.getRequestDispatcher("ProfiloUtente.jsp").forward(request, response);
                return;
            }
            utente.setPassword(utenteBean.toHash(nuovaPassword));
        }

        utenteDAO dao = new utenteDAO();
        try {
            utenteBean utenteConEmail = dao.doRetrieveByEmail(nuovaEmail);
            if (utenteConEmail != null && utenteConEmail.getId() != utente.getId()) {
                request.setAttribute("errorMessage", "Questa email è già in uso da un altro utente.");
                request.getRequestDispatcher("ProfiloUtente.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Errore nel verificare l'email.");
            request.getRequestDispatcher("ProfiloUtente.jsp").forward(request, response);
            return;
        }

        utente.setNome(nuovoNome);
        utente.setCognome(nuovoCognome);
        utente.setEmail(nuovaEmail);

        try {
            dao.doUpdate(utente);
            session.setAttribute("utenteLoggato", utente); 
            response.sendRedirect("ProfiloUtente.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Errore nel salvataggio dei dati.");
            request.getRequestDispatcher("ProfiloUtente.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
