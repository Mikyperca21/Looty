package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.utenteBean;
import model.utenteDAO;

@WebServlet("/visualizzaUtenti")
public class visualizzaUtenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public visualizzaUtenti() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<utenteBean> listaUtenti = new ArrayList<>();
		utenteDAO dao = new utenteDAO();
		
		try {
			listaUtenti = (List<utenteBean>) dao.doRetrieveAll();
			request.setAttribute("listaUtenti", listaUtenti);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RequestDispatcher disp = getServletContext().getRequestDispatcher("/VisualizzaUtenti.jsp");
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
