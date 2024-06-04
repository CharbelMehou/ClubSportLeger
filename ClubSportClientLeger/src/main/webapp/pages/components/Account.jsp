<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utilisateurs"%>
<%@ page import="model.GravatarUtil"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mon Compte</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz1HkCw6s9eLrTzIW2H6V7E8R7q5oGFMFXc6DX9eT7E7" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 50px;
        margin-bottom: 50px;
    }
    .card {
        padding: 20px;
        margin-top: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    .card-header {
        background-color: #11559C !important;
        color: white !important;
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        border-radius: 10px 10px 0 0;
    }
    .card-body {
        background-color: white;
        display: flex;
        justify-content: space-between;
    }
    .user-details {
        flex: 1;
    }
    .avatar {
        flex: 0 0 150px;
        text-align: center;
    }
    .avatar img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        margin-bottom: 10px;
    }
    .user-detail {
        margin-bottom: 15px;
    }
    .user-detail label {
        font-weight: bold;
        color: #11559C;
    }
</style>
</head>
<body>
    <jsp:include page="Header.jsp" />
    
<div class="container">
    <div class="card">
        <div class="card-header">
            Mon Compte
        </div>
        <div class="card-body">
            <div class="user-details">
                <%
                Utilisateurs utilisateur = (Utilisateurs) session.getAttribute("utilisateur");

                if (request.getMethod().equalsIgnoreCase("POST")) {
                    // Récupérer les nouvelles valeurs du formulaire
                    String nom = request.getParameter("nom");
                    String prenom = request.getParameter("prenom");
                    String email = request.getParameter("email");
                    String motdepasse = request.getParameter("motdepasse");
                    String federation = request.getParameter("federation");
                    String clubs = request.getParameter("clubs");
                    String statut = request.getParameter("statut");

                    // Mettre à jour l'objet utilisateur
                    utilisateur.setNom(nom);
                    utilisateur.setPrenom(prenom);
                    utilisateur.setEmail(email);
                    utilisateur.setMotdepasse(motdepasse);
                    utilisateur.setFederation(federation);
                    utilisateur.setClubs(clubs);
                    utilisateur.setStatut(statut);

                    // Mettre à jour l'utilisateur dans la base de données
                    UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
                    boolean updateSuccessful = utilisateurDAO.updateUtilisateur(utilisateur);

                    if (updateSuccessful) {
                        session.setAttribute("utilisateur", utilisateur);
                        out.println("<div class='alert alert-success' role='alert'>Mise à jour réussie!</div>");
                    } else {
                        out.println("<div class='alert alert-danger' role='alert'>Échec de la mise à jour. Veuillez réessayer.</div>");
                    }
                }

                    String gravatarUrl = GravatarUtil.getGravatarUrl(utilisateur.getEmail());
                if (utilisateur != null) {
                    String roleString = "";
                    switch(utilisateur.getRole()) {
                        case 2:
                            roleString = "Administrateur";
                            break;
                        case 3:
                            roleString = "Acteurs du monde sportif";
                            break;
                        case 4:
                            roleString = "Les élus";
                            break;
                        default:
                            roleString = "Inconnu";
                            break;
                    }
                %>
                    <form action="Account.jsp" method="post">
                        <div class="user-detail">
                            <label for="nom">Nom :</label>
                            <input type="text" class="form-control" id="nom" name="nom" value="<%= utilisateur.getNom() %>">
                        </div>
                        <div class="user-detail">
                            <label for="prenom">Prénom :</label>
                            <input type="text" class="form-control" id="prenom" name="prenom" value="<%= utilisateur.getPrenom() %>">
                        </div>
                        <div class="user-detail">
                            <label for="email">Email :</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= utilisateur.getEmail() %>">
                        </div>
                        <div class="user-detail">
                            <label for="motdepasse">Mot de passe :</label>
                            <input type="password" class="form-control" id="motdepasse" name="motdepasse" value="<%= utilisateur.getMotdepasse() %>">
                        </div>
                        <div class="user-detail">
                            <label for="federation">Fédération :</label>
                            <input type="text" class="form-control" id="federation" name="federation" value="<%= utilisateur.getFederation() %>">
                        </div>
                        <div class="user-detail">
                            <label for="clubs">Clubs :</label>
                            <input type="text" class="form-control" id="clubs" name="clubs" value="<%= utilisateur.getClubs() %>">
                        </div>
                        <div class="user-detail">
                            <label for="statut">Statut :</label>
                            <input type="text" class="form-control" id="statut" name="statut" value="<%= utilisateur.getStatut() %>">
                        </div>
                        <div class="user-detail">
                            <label for="role">Rôle :</label>
                            <input type="text" class="form-control" id="role" name="role" value="<%= roleString %>" disabled>
                        </div>
                        <button type="submit" class="btn btn-primary">Mettre à jour</button>
                    </form>
                <%
                } else {
                %>
                    <p class="text-danger">Aucun utilisateur connecté.</p>
                <%
                }
                %>
            </div>
            <div class="avatar">
                <img src="<%= gravatarUrl %>" alt="Avatar Utilisateur">
                <p><strong>Avatar</strong></p>
            </div>
        </div>
    </div>
</div>
    <jsp:include page="Footer.jsp" />

</body>
</html>
