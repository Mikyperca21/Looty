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
import model.indirizzoBean;
import model.indirizzoDAO;

@WebServlet("/registrazione")
public class registrazione extends HttpServlet {
    private static final long serialVersionUID = 1L;

    utenteDAO dao = new utenteDAO();
    indirizzoDAO indirizzoDao = new indirizzoDAO(); 

    public registrazione() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("utenteLoggato") != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Parametri utente
        String nome = request.getParameter("Nome");
        String cognome = request.getParameter("Cognome");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");

        // Parametri indirizzo
        String via = request.getParameter("Via");
        String citta = request.getParameter("Citta");
        String provincia = request.getParameter("Provincia");
        String capStr = request.getParameter("Cap");
        String paese = request.getParameter("Paese");
        String telefono = request.getParameter("Telefono");

        if (nome != null && cognome != null && email != null && password != null &&
            via != null && citta != null && provincia != null && capStr != null && paese != null && telefono != null) {

            try {
                utenteBean esistente = dao.doRetrieveByEmail(email);
                if (esistente != null && esistente.getId() != 0) {
                    request.setAttribute("errore", "Email già registrata");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                // Crea utente
                utenteBean bean = new utenteBean();
                bean.setNome(nome);
                bean.setCognome(cognome);
                bean.setEmail(email);
                bean.setPassword(password);
                bean.setRuolo(false);
                dao.doSave(bean);

                // Recupera utente salvato
                utenteBean utenteLoggato = dao.doRetrieveByEmail(email);

                // Crea indirizzo
                indirizzoBean indirizzo = new indirizzoBean();
                indirizzo.setVia(via);
                indirizzo.setCitta(citta);
                indirizzo.setProvincia(provincia);
                indirizzo.setCap(capStr);
                indirizzo.setPaese(paese);
                indirizzo.setTelefono(telefono);
                indirizzo.setIdUtente(utenteLoggato.getId());
                indirizzo.setIs_preferito(true); 
                indirizzoDao.doSave(indirizzo);

                // Setta utente in sessione
                session.setAttribute("utenteLoggato", utenteLoggato);

                RequestDispatcher dispatcher = request.getRequestDispatcher("ProfiloUtente.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("errore", "Errore durante la registrazione");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errore", "Compila tutti i campi obbligatori");
            RequestDispatcher dispatcher = request.getRequestDispatcher("Registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
