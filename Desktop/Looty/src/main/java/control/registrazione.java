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

/**
 * Servlet implementation class registrazione
 */
@WebServlet("/registrazione")
public class registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	utenteDAO dao = new utenteDAO();
       
   
    public registrazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
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
		
		utenteBean bean = new utenteBean();
		bean.setNome(nome);
		bean.setCognome(cognome);
		bean.setEmail(email);
		bean.setPassword(password);

		bean.setRuolo(false);
		
		try {
			dao.doSave(bean);
			request.getSession().setAttribute("utenteLoggato", bean);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Catalogo.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
