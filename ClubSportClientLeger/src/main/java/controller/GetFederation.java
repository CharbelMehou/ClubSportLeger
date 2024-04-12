package controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FederationDAO;
import dao.UtilisateurDAO;
import model.Federation;


/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class GetFederation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFederation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FederationDAO dao = new FederationDAO();
        ArrayList<Federation> federations = dao.getFederationsSortedByRegion();
        request.setAttribute("federations", federations);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Acceuil.jsp");
        dispatcher.forward(request, response);
    }
}
