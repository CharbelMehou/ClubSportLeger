<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utilisateurs"%>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz1HkCw6s9eLrTzIW2H6V7E8R7q5oGFMFXc6DX9eT7E7" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
    /* Styles de la navbar */
    .navbar {
        background-color: #11559C; /* Bleu de l'en-tête */
        color: #ffffff;
        padding: 10px;
        min-height: 50px;
    }

    .navbar-links {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .navbar-link1, .navbar-link2 {
        display: flex;
        align-items: center;
    }

    .navbar-link1 {
        justify-content: flex-start;
    }

    .navbar-link2 {
        justify-content: flex-end;
    }

    .navbar a {
        text-decoration: none;
        color: #ffffff;
        margin-left: 20px;
        padding: 10px;
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .navbar span {
        text-decoration: none;
        color: #ffffff;
        margin-left: 20px;
        padding: 10px;
        font-size: 20px;
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .navbar a:hover,
    .navbar a:focus {
        background-color: #ffffff;
        color: #002F6C;
        border-radius: 5px;
    }

    /* Custom popup style */
    .custom-popup {
        background-color: #11559C !important;
        color: white !important;
    }

    /* Adjust dropdown menu position */
    .navbar-links .dropdown-menu {
        left: -50px !important;
    }

    /* Style for popup text */
    .popup-text {
        color: #002F6C;
    }

    /* Ensure the dropdown items also have the desired color */
    .dropdown-menu a {
        color: #002F6C !important;
    }

    .dropdown-menu a:hover,
    .dropdown-menu a:focus {
        background-color: #ffffff;
        color: #002F6C !important;
        border-radius: 5px;
    }
</style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-links">
        <div class="navbar-link1">
            <%
            Utilisateurs utilisateur = (Utilisateurs) session.getAttribute("utilisateur");
            if (utilisateur != null) {
            %>
                <span>Bienvenue, <%= utilisateur.getNom().toUpperCase() %></span>
            <%
            }
            %>
        </div>
        <div>
            <a href="Acceuil.jsp" class="middle-nav-link">Accueil</a>                   
            <a href="Maps.jsp?searchType=" class="middle-nav-link">Map</a>
            <a href="ListePublications.jsp">Actualités</a>
            <%
            if (utilisateur != null && utilisateur.getRole() == 3) {
            %>
                <a href="FederationOnglet.jsp" class="middle-nav-link">Statistiques</a> 
                <a href="ClassementPage.jsp" class="middle-nav-link">Classement</a>  
            <% } %>      
        </div>
        <div class="navbar-link2">
             <% if (utilisateur == null) { %>
                <a href="LoginForm.jsp">Se connecter</a>
             <% } else { 
             %>
             <% if (utilisateur.getRole() == 3) { %>
               <a href="PublicationForm.jsp">Publier</a>
               <a href="ListePublicationsUtilisateur.jsp">Administration des Publications</a>
             <% } %>
             <% if (utilisateur.getRole() == 2) { %>            
                <a href="ListeUtilisateurs.jsp">Administration des Utilisateurs</a>
                <a href="AddUserForm.jsp">Inscription des Utilisateurs</a>               
             <% } %>   
            <div class="dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Profil
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item popup-text" href="Account.jsp">Editer Profil</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item popup-text" href="LogOut.jsp">Déconnexion</a></li>
                </ul>
            </div> 
          <% } %>
        </div>
    </div>
</nav>

<% String message = (String)request.getAttribute("message"); %>
<% if(message != null && !message.isEmpty()) { %>
    <div class="alert custom-popup">
        <strong class="popup-text">Infos!</strong> <%= message %>
    </div>
<% } %>

</body>
</html>
