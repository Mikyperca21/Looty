package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import model.utenteBean;
import model.utenteDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public login() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
	    
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		List<String> errors = new ArrayList<>();
		RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("Login.jsp"); 

		if (email == null || email.trim().isEmpty()) {
			errors.add("L'email non può essere vuota!");
		}
		if (password == null || password.trim().isEmpty()) {
			errors.add("La password non può essere vuota!");
		}
		if (!errors.isEmpty()) {
			request.setAttribute("errors", errors);
			dispatcherToLoginPage.forward(request, response);
			return;
		}

		String hashedPassword = utenteBean.toHash(password);
		
		utenteDAO dao = new utenteDAO();
		utenteBean utente;
		try {
		    utente = dao.doRetrieveByEmail(email);

		    if (utente != null && utente.getPassword().equals(hashedPassword)) {
		        request.getSession().setAttribute("utenteLoggato", utente);
		        response.sendRedirect("ProfiloUtente.jsp");
		        return;
		    } else {
		    	request.setAttribute("errore", "Username o password non validi!");
		        dispatcherToLoginPage.forward(request, response);
		    }

		} catch (SQLException e) {
		    e.printStackTrace();
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
