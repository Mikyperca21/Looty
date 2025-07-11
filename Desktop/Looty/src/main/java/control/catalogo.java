package control;

import java.io.File;

import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.Carrello;
import model.ElementoCarrello;
import model.appartieneDAO;
import model.categoriaBean;
import model.categoriaDAO;
import model.prodottoBean;
import model.prodottoDAO;
import model.utenteBean;

//@WebServlet("/catalogo")
@MultipartConfig
public class catalogo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	prodottoDAO dao = new prodottoDAO();
	categoriaDAO cat = new categoriaDAO();
	public catalogo() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
		if (carrello == null) {
			carrello = new Carrello();
			request.getSession().setAttribute("carrello", carrello);
		}

		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					dao.doDeleteCatByProdotto(id);
					dao.doDelete(id);
				}
				if (action.equalsIgnoreCase("inserisci")) {
					String nome = request.getParameter("nome");
					String descrizione = request.getParameter("descrizione");
					Double prezzoS = Double.parseDouble(request.getParameter("prezzoS"));
					Double prezzoM = Double.parseDouble(request.getParameter("prezzoM"));
					Double prezzoL = Double.parseDouble(request.getParameter("prezzoL"));
					int quantita = Integer.parseInt(request.getParameter("quantita"));
					Part filePart = request.getPart("immagine");
			        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			        String[] categorie = request.getParameterValues("categoriaID");
			    
			       
			        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
			        File uploadDir = new File(uploadPath);
			        if (!uploadDir.exists()) uploadDir.mkdirs();

			      
			        filePart.write(uploadPath + File.separator + fileName);

			       
			        String relativePath = "images/" + fileName;


					prodottoBean bean = new prodottoBean();
					bean.setNome(nome);
					bean.setDescrizione(descrizione);
					bean.setPrezzoS(prezzoS);
					bean.setPrezzoM(prezzoM);
					bean.setPrezzoL(prezzoL);
					bean.setQuantita(quantita);
					bean.setImmagine(relativePath);
					int prodottoID = dao.doSave(bean);
					System.out.println("ID prodotto generato: " + prodottoID);

					
					appartieneDAO assegnaDAO = new appartieneDAO();
					
			        if (categorie != null) {
			            for (String catID : categorie) {
			                int categoryId = Integer.parseInt(catID);
			                //System.out.println(categoryId);
			                System.out.println("Associo categoria " + categoryId + " al prodotto " + prodottoID);
			                assegnaDAO.doSave(categoryId, prodottoID);
			            }
			        }
			        response.sendRedirect("catalogo");
			        return;
				}
				
				if(action.equalsIgnoreCase("modify")) {
				    int id = Integer.parseInt(request.getParameter("id"));
				    String nome = request.getParameter("nome");
				    String descrizione = request.getParameter("descrizione");
				    Double prezzoS = Double.parseDouble(request.getParameter("prezzoS"));
				    Double prezzoM = Double.parseDouble(request.getParameter("prezzoM"));
				    Double prezzoL = Double.parseDouble(request.getParameter("prezzoL"));
				    int quantita = Integer.parseInt(request.getParameter("quantita"));

				    Part filePart = request.getPart("immagine");
				    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

				    String relativePath = null;

				   
				    if (fileName != null && !fileName.isEmpty()) {
				        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
				        File uploadDir = new File(uploadPath);
				        if (!uploadDir.exists()) uploadDir.mkdirs();

				        filePart.write(uploadPath + File.separator + fileName);

				        relativePath = "images/" + fileName;
				    } else {
				       
				        prodottoBean existing = dao.doRetrieveByKey(id);
				        relativePath = existing.getImmagine();
				    }

				    prodottoBean bean = new prodottoBean();
				    bean.setCodice(id);
				    bean.setNome(nome);
				    bean.setDescrizione(descrizione);
				    bean.setPrezzoS(prezzoS);
				    bean.setPrezzoM(prezzoM);
				    bean.setPrezzoL(prezzoL);
				    bean.setQuantita(quantita);
				    bean.setImmagine(relativePath);

				    dao.doUpdate(bean);
				    
				 // Cancella tutte le associazioni esistenti
				    appartieneDAO assegnaDAO = new appartieneDAO();
				    assegnaDAO.doDeleteProdotto(id);

				    // Inserisci le nuove associazioni se presenti
				    String[] categorieSelezionate = request.getParameterValues("categorie[]");
				    if (categorieSelezionate != null) {
				        for (String catID : categorieSelezionate) {
				            int categoryId = Integer.parseInt(catID);
				            assegnaDAO.doSave(categoryId, id);
				        }
				    }

				}

				if(action.equalsIgnoreCase("aggiungiCarrello")) {
					int id = Integer.parseInt(request.getParameter("id"));
					String dimensione = request.getParameter("dimensione");
				    int quantita = Integer.parseInt(request.getParameter("quantita"));

				    prodottoBean prodotto = dao.doRetrieveByKey(id);
				    ElementoCarrello elemento = new ElementoCarrello(prodotto, dimensione, quantita);
				    carrello.aggiungiProdotto(elemento);
				    
				}
				if(action.equalsIgnoreCase("rimuoviCarrello")) {
					int id = Integer.parseInt(request.getParameter("id"));
					String dimensione = request.getParameter("dimensione");
					int quantita = Integer.parseInt(request.getParameter("quantita"));
					prodottoBean prodotto = dao.doRetrieveByKey(id);
					ElementoCarrello elemento = new ElementoCarrello (prodotto, dimensione, quantita);
					carrello.eliminaProdotto(elemento);;
					 RequestDispatcher dispatcher = request.getRequestDispatcher("Carrello.jsp");
				     dispatcher.forward(request, response);
				     
				}
				if(action.equalsIgnoreCase("perCategoria")) {
					int idCat = Integer.parseInt(request.getParameter("idCat"));
					Collection<prodottoBean> prodotti = new LinkedList<prodottoBean>();
					
					prodotti = dao.doRetrieveByCategoria(idCat);
					
					request.setAttribute("prodotti", prodotti);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("Catalogo.jsp");
				    dispatcher.forward(request, response);
				    
				    return;
				}								
				if (action.equalsIgnoreCase("modificaQuantitaCarrello")) {
				    int id = Integer.parseInt(request.getParameter("id"));
				    String dimensione = request.getParameter("dimensione");
				    int nuovaQuantita = Integer.parseInt(request.getParameter("quantita"));
				    String operazione = request.getParameter("operazione");

				    for (ElementoCarrello elemento : carrello.getProdotti()) {
				        if (elemento.getProdotto().getCodice() == id &&
				            elemento.getDimensione().equalsIgnoreCase(dimensione)) {
				            
				            if (operazione.equals("incrementa")) {
				                
				                elemento.setQuantita(nuovaQuantita + 1);
				            } else if (operazione.equals("decrementa")) {
				                
				                if (nuovaQuantita > 1) {
				                    elemento.setQuantita(nuovaQuantita - 1);
				                } else {
				                    carrello.eliminaProdotto(elemento);
				                }
				            }

				            break;
				        }
				    }
				    request.getSession().setAttribute("carrello", carrello);
				    request.setAttribute("carrello", carrello);
				    response.sendRedirect("Carrello.jsp");
				    return; 
				}
			}

		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		request.getSession().setAttribute("carrello", carrello);
		request.setAttribute("carrello", carrello);

		try {
			
			utenteBean quale = (utenteBean) request.getSession().getAttribute("utenteLoggato");
			
			Collection<prodottoBean> prodotti = dao.doRetrieveAll();
			Collection<categoriaBean> cats = cat.doRetrieveAll();
			request.setAttribute("prodotti", prodotti);
			request.setAttribute("categorie", cats);
			
			if (quale != null && quale.getRuolo()) {
			    // Utente loggato ed è un admin
			    RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/CatalogoAdmin.jsp");
			    dispatcher.forward(request, response);
			} else {
			    // Utente non loggato o non è un admin
			    RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Catalogo.jsp");
			    dispatcher.forward(request, response);
			}

		} catch (SQLException e) {
			throw new ServletException("Errore nel recupero dei prodotti " + e);
		}

	}

	private Object getRequestURI() {
		// TODO Auto-generated method stub
		return null;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
