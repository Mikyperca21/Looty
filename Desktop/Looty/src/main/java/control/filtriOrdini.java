package control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ordineBean;
import model.ordineDAO;
import model.utenteBean;
import model.utenteDAO;

@WebServlet("/filtriOrdini")
public class filtriOrdini extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ordineDAO ordineDao = new ordineDAO();
    private utenteDAO utenteDao = new utenteDAO();

    public filtriOrdini() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userIdStr = request.getParameter("userId");
            String dataInizio = request.getParameter("dataInizio");
            String dataFine = request.getParameter("dataFine");
            
            // controllo cosa ho
			boolean hasUserId = userIdStr != null && !userIdStr.isEmpty();
			/*
			 * boolean hasDataInizio = dataInizio != null && !dataInizio.isEmpty(); boolean
			 * hasDataFine = dataFine != null && !dataFine.isEmpty();
			 */
			// ci sono entrambe le date
			boolean hasFullDateRange = dataInizio != null && !dataInizio.isEmpty() && dataFine != null && !dataFine.isEmpty();
			
			// date parziali (o manca l'inizio o la fine)
			boolean hasPartialDate = (dataInizio != null && !dataInizio.isEmpty()) ^ (dataFine != null && !dataFine.isEmpty());
			
			Collection<ordineBean> ordini = new ArrayList<ordineBean>();
            
            if (!hasUserId && !hasFullDateRange && !hasPartialDate) { // non ha nulla
                // Lista utenti in JSON per select via AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                List<utenteBean> utenti = (List<utenteBean>) utenteDao.doRetrieveAll();

                StringBuilder json = new StringBuilder();
                json.append("[");
                for (int i = 0; i < utenti.size(); i++) {
                    utenteBean u = utenti.get(i);
                    json.append("{")
                        .append("\"id\":").append(u.getId()).append(",")
                        .append("\"nome\":\"").append(escapeJson(u.getNome())).append("\",")
                        .append("\"cognome\":\"").append(escapeJson(u.getCognome())).append("\"")
                        .append("}");
                    if (i < utenti.size() - 1) {
                        json.append(",");
                    }
                }
                json.append("]");
                response.getWriter().write(json.toString());
                return;
            }
            
            // manca almeno una delle due date
            if(hasPartialDate) {
            	sendBadRequest(response, "Range di date incompleto.");
                return;
            }
            
            if (!hasUserId && hasFullDateRange) { // ci vengono fornite solo le date
                ordini = ordineDao.doRetrieveByDate(dataInizio, dataFine);
            } else {
                int userId = Integer.parseInt(userIdStr);

                if (userId == 0 && !hasFullDateRange) { // tutti gli utenti, nessuna data
                    ordini = ordineDao.doRetrieveAll();
                } else if (userId == 0 && hasFullDateRange) { // tutti gli utenti con data
                    ordini = ordineDao.doRetrieveByDate(dataInizio, dataFine);
                } else if (userId != 0 && !hasFullDateRange) { // utente specifico, nessuna data
                    ordini = ordineDao.doRetrieveByUser(userId);
                } else if (userId != 0 && hasFullDateRange) { // utente specifico con date
                    ordini = ordineDao.doRetrieveFiltered(userId, dataInizio, dataFine);
                } else {
                    // Per sicurezza
                    sendBadRequest(response, "Richiesta non valida.");
                    return;
                }
                
                request.setAttribute("ordini", ordini);
            	request.getRequestDispatcher("/storicoOrdini.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }


    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
    }
    
    private void sendBadRequest(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"error\":\"" + escapeJson(message) + "\"}");
    }
}
