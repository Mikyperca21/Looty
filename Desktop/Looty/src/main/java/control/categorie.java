package control;
import java.util.*;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.categoriaBean;
import model.categoriaDAO;
@WebServlet("/categorie")
public class categorie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public categorie() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		categoriaDAO dao = new categoriaDAO();
		try {
			List<categoriaBean> cats = (List<categoriaBean>) dao.doRetrieveAll();
			request.setAttribute("categorie", cats);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/TabellaCat.jsp");
	    dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
