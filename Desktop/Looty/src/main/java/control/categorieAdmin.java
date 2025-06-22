package control;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.ElementoCarrello;
import model.categoriaBean;
import model.categoriaDAO;
import model.prodottoBean;

/**
 * Servlet implementation class categorieAdmin
 */
@WebServlet("/categorieAdmin")
public class categorieAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public categorieAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    categoriaDAO dao = new categoriaDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			List<categoriaBean> cats = (List<categoriaBean>) dao.doRetrieveAll();
			request.setAttribute("categorie", cats);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String action = request.getParameter("azione");
		
		System.out.println("azione"+action);
		try {
				if (action != null) {
					if(action.equalsIgnoreCase("inserisci")) {
					String nome = request.getParameter("nome");
					
					//System.out.println("NOME:"+nome);
					
					categoriaBean bean = new categoriaBean();
					bean.setNome(nome);
					dao.doSave(bean);
					response.sendRedirect(request.getContextPath() + "/categorieAdmin");
		            return;
				}
			 	if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					dao.doDelete(id);
					response.sendRedirect(request.getContextPath() + "/categorieAdmin");
		            return;
				}
			 	if(action.equalsIgnoreCase("modifica")) {
			 		String nuovoNome = request.getParameter("nome");
//			 		int id = Integer.parseInt(request.getParameter("id"));

			        if (nuovoNome == null) {
			            request.setAttribute("errorMessage", "Tutti i campi sono obbligatori!");
			            request.getRequestDispatcher("categorieAdmin.jsp").forward(request, response);
			            return;
			        }
			        
			        categoriaBean bean = new categoriaBean();
			        bean.setNome(nuovoNome);
			        dao.doUpdate(bean);
			 	}
			}	

		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/categorieAdmin.jsp");
	    dispatcher.forward(request, response);
		

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
