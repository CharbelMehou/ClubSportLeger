package controller;
 
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
 
import dao.PublicationsDAO;
 
@WebServlet("/AjoutPublication1")
@MultipartConfig
public class AjoutPublication1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	public AjoutPublication1() {
		super();
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String titre = request.getParameter("titre");
		String contenu = request.getParameter("contenu");
 
		int id = (Integer) session.getAttribute("id");
		Part filePart = request.getPart("photo");
		byte[] photo = null;
 
		if (filePart != null && filePart.getSize() > 0) {
			InputStream inputStream = filePart.getInputStream();
			photo = inputStream.readAllBytes();
 
			// Stockage du fichier dans le répertoire "images" dans le répertoire "webapp"
			String nomFichier = filePart.getSubmittedFileName();
			String cheminStockage = getServletContext().getRealPath("/images/") + nomFichier;
			try (OutputStream outputStream = new FileOutputStream(cheminStockage)) {
				outputStream.write(photo);
			} catch (IOException e) {
				e.printStackTrace();
				// Gérer l'exception de stockage
			} 
		}
 
 
		PublicationsDAO publications = new PublicationsDAO();
		publications.add(titre, contenu, photo, id);
		response.sendRedirect("pages/components/ListePublicationsUtilisateur.jsp");
	}
}

