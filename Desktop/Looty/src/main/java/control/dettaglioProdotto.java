package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import model.categoriaDAO;
import model.prodottoBean;
import model.prodottoDAO;
import model.utenteBean;
import model.categoriaBean;

/**
 * Servlet implementation class dettaglioProdotto
 */
@WebServlet("/dettaglioProdotto")
public class dettaglioProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	prodottoDAO prodDao = new prodottoDAO();
	categoriaDAO catDao = new categoriaDAO();
	
    public dettaglioProdotto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action =  request.getParameter("action");
		
		PrintWriter out = response.getWriter(); 
		
		try {
			if(action != null) {
				if(action.equalsIgnoreCase("getprodotto")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("prodotto");
					request.setAttribute("prodotto", prodDao.doRetrieveByKey(id));
		            Collection<categoriaBean> categorieProdotto = prodDao.doRetrieveCategorieByProdotto(id);
		            request.setAttribute("categorieProdotto", categorieProdotto);
		            
		            utenteBean quale = (utenteBean) request.getSession().getAttribute("utenteLoggato");
					
					if (quale != null && quale.getRuolo()) {
					    // Utente loggato ed è un admin
						 Collection<categoriaBean> tutteCat = catDao.doRetrieveAll();
				         request.setAttribute("categorieTutte", tutteCat);
					    RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/ModificaProdottoAdmin.jsp");
					    dispatcher.forward(request, response);
					} else {
					    // Utente non loggato o non è un admin
					    RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/DettaglioProdotto.jsp");
					    dispatcher.forward(request, response);
					}
					
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println("<h1><b>ERRORE NEL TROVARE IL PRODOTTO</b></h1>");
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
