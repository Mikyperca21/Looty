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

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public login() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		List<String> errors = new ArrayList<>();
		RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("Catalogo.jsp"); // <-- correggi se hai un'altra pagina login

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

		// Hash password
		String hashedPassword = utenteBean.toHash(password);
		

		// Recupera utente dal DB
		utenteDAO dao = new utenteDAO();
		utenteBean utente;
		try {
		    utente = dao.doRetrieveByEmail(email);

		    System.out.println("DEBUG — Email inserita: " + email);
		    System.out.println("DEBUG — Password inserita (hash): " + hashedPassword);

		    if (utente != null) {
		        System.out.println("DEBUG — Utente trovato: " + utente.getEmail());
		        System.out.println("DEBUG — Password salvata nel DB: " + utente.getPassword());
		    } else {
		        System.out.println("DEBUG — Nessun utente trovato con questa email.");

		    }

		    if (utente != null && utente.getPassword().equals(hashedPassword)) {
		        request.getSession().setAttribute("utenteLoggato", utente);
		        request.getSession().setAttribute("isAdmin", "admin@admin.com".equals(utente.getEmail()));
		        response.sendRedirect("ProfiloUtente.jsp");
		        return;
		    } else {
		        errors.add("Username o password non validi!");
		        request.setAttribute("errors", errors);
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
