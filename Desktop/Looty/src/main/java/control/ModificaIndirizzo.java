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
import model.indirizzoDAO;
import model.metodoPagamentoBean;
import model.utenteBean;

/**
 * Servlet implementation class ModificaIndirizzo
 */
@WebServlet("/ModificaIndirizzo")
public class ModificaIndirizzo extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private indirizzoDAO dao = new indirizzoDAO();

       
    public ModificaIndirizzo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
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
	        else if(action.equalsIgnoreCase("modifica")) {
	        	int id = Integer.parseInt(request.getParameter("id"));
	            indirizzoBean indirizzo = dao.doRetrieveById(id);
	            
	            indirizzo.setEtichetta(request.getParameter("etichetta"));
	            indirizzo.setVia(request.getParameter("via"));
	            indirizzo.setCitta(request.getParameter("citta"));
	            indirizzo.setCap(request.getParameter("cap"));
	            indirizzo.setProvincia(request.getParameter("provincia"));
	            indirizzo.setPaese(request.getParameter("paese"));
	            indirizzo.setTelefono(request.getParameter("telefono"));
	            
	            dao.doUpdate(indirizzo);
	        }
	        else if(action.equalsIgnoreCase("aggiungi")) {
	        	indirizzoBean nuovo = new indirizzoBean();
	            nuovo.setIdUtente(idUtente);
	            nuovo.setEtichetta(request.getParameter("etichetta"));
	            nuovo.setVia(request.getParameter("via"));
	            nuovo.setCitta(request.getParameter("citta"));
	            nuovo.setCap(request.getParameter("cap"));
	            nuovo.setProvincia(request.getParameter("provincia"));
	            nuovo.setPaese(request.getParameter("paese"));
	            nuovo.setTelefono(request.getParameter("telefono"));
	            nuovo.setIs_preferito(false);
	            int idNuovo = dao.doSave(nuovo);
    		    if (idNuovo > 0) {
    		        dao.setPreferito(idUtente, idNuovo);
    		    }
	        } 
	        else if(action.equalsIgnoreCase("setPreferito")) {
	        	int id = Integer.parseInt(request.getParameter("id"));
                dao.setPreferito(idUtente, id);
                response.setStatus(HttpServletResponse.SC_OK);
	        }

             List<indirizzoBean> indirizzi = dao.doRetrieveByUtente(idUtente);
             request.setAttribute("indirizzi", indirizzi);
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
