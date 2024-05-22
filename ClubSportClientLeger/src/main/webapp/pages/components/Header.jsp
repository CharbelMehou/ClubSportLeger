<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utilisateurs"%>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../components/componentStyle.css">
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
                <a href="LogOut.jsp">Déconnexion</a>
            <% } %>
        </div>
    </div>
</nav>
</body>
</html>
