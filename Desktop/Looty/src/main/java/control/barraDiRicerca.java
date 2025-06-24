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

import model.categoriaBean;
import model.categoriaDAO;
import model.prodottoDAO;
import model.prodottoBean;


@WebServlet("/search") // la barra di ricerca quando fa il get nello script, viene mandata a questa pagina
public class barraDiRicerca extends HttpServlet {
	
	prodottoDAO pDao = new prodottoDAO();
	
	private static final long serialVersionUID = 1L;

    public barraDiRicerca() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("query");
		
		try {
			List<prodottoBean> prod = (List<prodottoBean>) pDao.doRetrieveByName(query);
			request.setAttribute("prodotti", prod);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/BarraDiRicerca.jsp");
	    dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
