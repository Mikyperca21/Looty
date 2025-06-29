package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.utenteBean;
import model.utenteDAO;

@WebServlet("/controlloEmail")
public class controlloEmail extends HttpServlet {
    private static final long serialVersionUID = 1L;
    utenteDAO dao = new utenteDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        boolean exists = false;

        if (email != null && !email.trim().isEmpty()) {
            try {
                utenteBean user = dao.doRetrieveByEmail(email);
                if (user != null && user.getId() != 0) {
                    exists = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"exists\": " + exists + "}");
        out.flush();
    }
}
