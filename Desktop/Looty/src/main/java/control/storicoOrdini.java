package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ordineBean;
import model.ordineDAO;
import model.utenteBean;

@WebServlet("/storicoOrdini")
public class storicoOrdini extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public storicoOrdini() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        utenteBean utente = (utenteBean) session.getAttribute("utenteLoggato");
        if (utente == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        try {
            ordineDAO ordineDAO = new ordineDAO();
            List<ordineBean> ordini = ordineDAO.doRetrieveByUser(utente.getId(), null);

            // Passo gli ordini alla pagina JSP
            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("storicoOrdini.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Errore durante il recupero degli ordini.", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
