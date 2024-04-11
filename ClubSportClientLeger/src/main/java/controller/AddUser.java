package controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UtilisateurDAO;


/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String nom = request.getParameter("nom");
	        String prenom = request.getParameter("prenom");
	        String email = request.getParameter("email");
	        String motdepasse = request.getParameter("motdepasse");

	        // Fonction pour hasher le mot de passe
	        String hashedPass = hashPassword(motdepasse);

	        UtilisateurDAO db = new UtilisateurDAO();

	        if (nom == null || prenom == null || email == null || motdepasse == null || nom.isEmpty() || prenom.isEmpty()
	                || email.isEmpty() || motdepasse.isEmpty()) {
	            String message = "Please provide all the required information";
	            request.setAttribute("message", message);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/AddUserForm.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            if (db.utilisateurExists(email)) {
	                String message = "User with this email already exists";
	                request.setAttribute("message", message);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("/AddUserForm.jsp");
	                dispatcher.forward(request, response);
	            } else {
	                if (db.add(nom, prenom, email, hashedPass) == 0) {
	                    String message = "The user is added";
	                    request.setAttribute("message", message);
	                    RequestDispatcher dispatcher = request.getRequestDispatcher("/AddUserForm.jsp");
	                    dispatcher.forward(request, response);
	                } else {
	                    String message = "The user could not be added";
	                    request.setAttribute("message", message);
	                    RequestDispatcher dispatcher = request.getRequestDispatcher("/AddUserForm.jsp");
	                    dispatcher.forward(request, response);
	                }
	            }
	        }
		// TODO Auto-generated method stub
	}
	
	public String hashPassword(String password1) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password1.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            // Gérer l'exception NoSuchAlgorithmException
            e.printStackTrace();
            return null;
        }
    }

}
