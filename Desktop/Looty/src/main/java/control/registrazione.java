package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.utenteBean;
import model.utenteDAO;

@WebServlet("/registrazione")
public class registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	utenteDAO dao = new utenteDAO();
       
   
    public registrazione() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 HttpSession session = request.getSession();
	        if (session.getAttribute("utenteLoggato") != null) {
	            // L'utente è già loggato, reindirizza alla pagina di profilo
	            RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
		
		String nome = request.getParameter("Nome");
		String cognome = request.getParameter("Cognome");
		String email = request.getParameter("Email");
		String password = request.getParameter("Password");
		/*
		 * String via = request.getParameter("Via"); String citta =
		 * request.getParameter("Citta"); String provincia =
		 * request.getParameter("Provincia"); int cap =
		 * Integer.parseInt(request.getParameter("Cap"));
		 */
		
		if (nome != null && cognome != null && email != null && password != null) {
            utenteBean bean = new utenteBean();
            bean.setNome(nome);
            bean.setCognome(cognome);
            bean.setEmail(email);
            bean.setPassword(password);
            bean.setRuolo(false);

            try {
                utenteBean esistente = dao.doRetrieveByEmail(email);
                if (esistente != null && esistente.getId() != 0) {
                    request.setAttribute("errore", "Email già registrata");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                dao.doSave(bean);

                utenteBean utenteLoggato = dao.doRetrieveByEmail(email);
                session.setAttribute("utenteLoggato", utenteLoggato);

                RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errore", "Errore durante la registrazione");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
