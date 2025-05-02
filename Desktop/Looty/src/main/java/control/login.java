package control;

import java.io.IOException;
import java.util.*;

import model.utenteBean;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		List<String> errors = new ArrayList<>();
		RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("login.jsp");
		
		if(email == null || email.trim().isEmpty()) {
			errors.add("L'email non può essere vuota!");
		}
		
		if(password == null || password.trim().isEmpty()) {
			errors.add("La password non può essere vuota!");
		}
		
		if(!errors.isEmpty()) { // se ci sono errori
			request.setAttribute("errors", errors);
			dispatcherToLoginPage.forward(request, response);
			return;
		}
		
		String hashPassword = utenteBean.toHash(password);
		String hashDB = "DAO";
		
		if(email.equals("admin@admin.com") && hashPassword.equals(hashDB)){ //admin
			request.getSession().setAttribute("isAdmin", Boolean.TRUE); //inserisco il token nella sessione
			response.sendRedirect("CatalogoAdmin.jsp");
		} else if (email.equals("user") && hashPassword.equals(hashDB)) { //user
			request.getSession().setAttribute("isAdmin", Boolean.FALSE); //inserisco il token nella sessione
			response.sendRedirect("common/protected.jsp");
		} else { 
			errors.add("Username o password non validi!");
			request.setAttribute("errors", errors);
			dispatcherToLoginPage.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}