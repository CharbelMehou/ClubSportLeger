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
 
@WebServlet("/UpdatePublication")
@MultipartConfig
public class UpdatePublication extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public UpdatePublication() {
        super();
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idTitre = (Integer) session.getAttribute("idPublication");
        String titre = request.getParameter("titre");
        String contenu = request.getParameter("contenu");
 
        System.out.println(""+titre+""+idTitre+"");
        Part filePart = request.getPart("photo");
        byte[] photo = null;
 
        if (filePart != null && filePart.getSize() > 0) {
            InputStream inputStream = filePart.getInputStream();
            photo = inputStream.readAllBytes();
 
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
        publications.updatePublication(idTitre, titre, contenu, photo);
        response.sendRedirect("pages/components/ListePublicationsUtilisateur.jsp");
    }
 
 
}

