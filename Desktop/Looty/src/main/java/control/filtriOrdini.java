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
            

			boolean hasUserId = userIdStr != null && !userIdStr.isEmpty();
			boolean hasDataInizio = dataInizio != null && !dataInizio.isEmpty();
			boolean hasDataFine = dataFine != null && !dataFine.isEmpty();
			
			Collection<ordineBean> ordini = new ArrayList<ordineBean>();
            
            if (userIdStr == null || userIdStr.isEmpty()) {
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
            } else {
                // Lista ordini in request e forward a JSP
            	int userId = Integer.parseInt(userIdStr);
            	 if (userId == 0 && (!hasDataInizio || !hasDataFine)) {
            		 ordini = ordineDao.doRetrieveAll();
            	 } else if (userId != 0 && (!hasDataInizio || !hasDataFine)) {
            	     ordini = ordineDao.doRetrieveByUser(userId);
            	 } else {
            	     ordini = ordineDao.doRetrieveFiltered(userId, dataInizio, dataFine);
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
}
