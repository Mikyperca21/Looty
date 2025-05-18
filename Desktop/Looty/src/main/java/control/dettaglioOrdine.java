package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.indirizzoBean;
import model.indirizzoDAO;
import model.metodoPagamentoBean;
import model.metodoPagamentoDAO;
import model.ordineBean;
import model.ordineDAO;
import model.ordineProdottoBean;

@WebServlet("/dettaglioOrdine")
public class dettaglioOrdine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public dettaglioOrdine() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
		
		ordineDAO dao = new ordineDAO(); 
		ordineBean ordine = null;
		try {
			ordine = dao.doRetrieveById(idOrdine);
			request.setAttribute("ordine", ordine);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		metodoPagamentoDAO daoPagamento = new metodoPagamentoDAO();
		indirizzoDAO daoIndirizzo = new indirizzoDAO();
		
		try {
			metodoPagamentoBean metodoPagamento = daoPagamento.doRetrieveByID(ordine.getId_metodoPgamento());
			indirizzoBean indirizzo = daoIndirizzo.doRetrieveById(ordine.getId_indirizzo());
			request.setAttribute("indirizzo", indirizzo);
			request.setAttribute("meotodoPagamento", metodoPagamento);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		List<ordineProdottoBean> opb = new ArrayList<>();
		
		opb = dao.getDettagliOrdine(idOrdine);
		
		
		request.setAttribute("prodottiOrdine", opb);
		
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/dettagliOrdine.jsp");
	    dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
