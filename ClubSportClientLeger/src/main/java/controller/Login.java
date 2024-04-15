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
import javax.servlet.http.HttpSession;

import dao.UtilisateurDAO;


/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String email = request.getParameter("email");
	    String motdepasse = request.getParameter("motdepasse");

	    // Fonction pour hasher le mot de passe
	    String hashedPass = hashPassword(motdepasse);

	    UtilisateurDAO db = new UtilisateurDAO();
	    HttpSession session = request.getSession();

	    if (email == null || motdepasse == null || email.isEmpty() || motdepasse.isEmpty()) {
	        String message = "Please provide both email and password";
	        request.setAttribute("message", message);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/components/LoginForm.jsp");
	        dispatcher.forward(request, response);
	    } else {
	        if (db.getUtilisateur(email, hashedPass) != null) {
	            session.setAttribute("email", email);
	            session.setAttribute("motdepasse", hashedPass);
	            String message = "Vous etes connecté";
	            // Ajoutez d'abord le message à la requête
	            request.setAttribute("message", message);
	            // Puis effectuez la redirection vers la page de formulaire de connexion
	            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/components/AddUserForm.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            String message = "Invalid email or password";
	            // Ajoutez d'abord le message à la requête
	            request.setAttribute("message", message);
	            // Puis effectuez la redirection vers la page de formulaire de connexion
	            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/components/AddUserForm.jsp");
	            dispatcher.forward(request, response);
	        }
	    }
	}

	

//Fonction pour hasher le mot de passe
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
