<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Base64"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="model.Utilisateur"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
</head>
<body>
    <%
        String email = request.getParameter("email");
        String motdepasse = request.getParameter("motdepasse");

        // Fonction pour hasher le mot de passe
        String hashedPass = hashPassword(motdepasse);

        UtilisateurDAO db = new UtilisateurDAO();
         session = request.getSession();

        if (email == null || motdepasse == null || email.isEmpty() || motdepasse.isEmpty()) {
            String message = "Veuillez fournir votre adresse e-mail et votre mot de passe";
            request.setAttribute("message", message);
            RequestDispatcher dispatcher = request.getRequestDispatcher("LoginForm.jsp");
            dispatcher.forward(request, response);
        } else {
        	Utilisateur utilisateur = db.getUtilisateur(email, hashedPass);
            if (utilisateur != null) {
                session.setAttribute("utilisateur", utilisateur);
                String message = "Vous êtes connecté";
                request.setAttribute("message", message);
                response.sendRedirect("../Acceuil.jsp");
            } else {
                String message = "Adresse e-mail ou mot de passe invalide";
                request.setAttribute("message", message);
                response.sendRedirect("../Acceuil.jsp");
            }
        }
    %>
    <%-- Méthode pour hasher le mot de passe --%>
    <%!
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
    %>
</body>
</html>
