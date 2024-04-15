<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utilisateur"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./components/componentStyle.css">
</head>
<body>
<nav class="navbar">
    <div class="navbar-links" style="display: flex; justify-content: space-between; width: 100%;">
        <div class="navbar-link1">
            <% if (session.getAttribute("utilisateur") != null) { %>
                <span>Bienvenue, <%= ((Utilisateur) session.getAttribute("utilisateur")).getNom().toUpperCase() %></span>
            <% } %>
        </div>
        <div class="navbar-link2">
            <% if (session.getAttribute("utilisateur") == null) { %>
                <a href="components/LoginForm.jsp">Se connecter</a>
            <% } else { %>
                <a href="components/AddUserForm.jsp">Inscrire un admin</a>
                <a href="components/LogOut.jsp">Déconnexion</a>
            <% } %>
        </div>
    </div>
</nav>
</body>
</html>
