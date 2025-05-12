package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.indirizzoBean;
import model.metodoPagamentoBean;
import model.metodoPagamentoDAO;
import model.utenteBean;

@WebServlet("/ModificaPagamento")
public class ModificaPagamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private metodoPagamentoDAO dao = new metodoPagamentoDAO();
	
    public ModificaPagamento() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
String action = request.getParameter("action");
		
		HttpSession session = request.getSession();
        utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");

        if (utente == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        int idUtente = utente.getId();
        try {
        	 if(action.equalsIgnoreCase("elimina")) {
        	 int id = Integer.parseInt(request.getParameter("id"));
             dao.doDelete(id);
        	 }
	        else if(action.equalsIgnoreCase("aggiungi")) {
	        	metodoPagamentoBean nuovo = new metodoPagamentoBean();
	            nuovo.setIdUtente(idUtente);
	            nuovo.setTitolare(request.getParameter("titolare"));
	            nuovo.setCodiceCarta(request.getParameter("codiceCarta"));
	            nuovo.setCVV(Integer.parseInt(request.getParameter("cvv")));
	            nuovo.setMeseScadenza(Integer.parseInt(request.getParameter("meseScadenza")));
	            nuovo.setAnnoScadenza(Integer.parseInt(request.getParameter("annoScadenza")));
	            nuovo.setPreferito(false);
	            dao.doSave(nuovo);
	        } 
	        else if(action.equalsIgnoreCase("setPreferito")) {
	        	int id = Integer.parseInt(request.getParameter("id"));
                dao.setPreferito(idUtente, id);
                response.setStatus(HttpServletResponse.SC_OK);
	        }

             List<metodoPagamentoBean> metodi = dao.doRetrieveByUtente(idUtente);
             request.setAttribute("metodi", metodi);
             RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
             dispatcher.forward(request, response);
        }catch (SQLException e) {
            throw new ServletException("Errore nella gestione degli indirizzi", e);
        }
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
