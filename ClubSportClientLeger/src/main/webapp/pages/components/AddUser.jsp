<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Base64"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un utilisateur</title>
<body>
    <%
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String motdepasse = request.getParameter("motdepasse");

        // Fonction pour hasher le mot de passe
        String hashedPass = hashPassword(motdepasse);

        UtilisateurDAO db = new UtilisateurDAO();

        if (nom == null || prenom == null || email == null || motdepasse == null || nom.isEmpty() || prenom.isEmpty()
                || email.isEmpty() || motdepasse.isEmpty()) {
            String message = "Veuillez fournir toutes les informations requises";
            request.setAttribute("message", message);
            request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
        } else {
            if (db.utilisateurExists(email)) {
                String message = "Un utilisateur avec cet e-mail existe déjà";
                request.setAttribute("message", message);
                request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
            } else {
                if (db.add(nom, prenom, email, hashedPass) == 0) {
                    String message = "L'utilisateur est ajouté";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
                } else {
                    String message = "L'utilisateur n'a pas pu être ajouté";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
                }
            }
        }
    %>
    
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
