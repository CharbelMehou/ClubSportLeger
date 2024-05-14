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
            if (session.getAttribute("utilisateur") != null) {
            %>
                <span>Bienvenue, <%=((Utilisateurs) session.getAttribute("utilisateur")).getNom().toUpperCase()%></span>
            <%
            }
            %>
        </div>
        <div>
		    <a href="Acceuil.jsp" class="middle-nav-link">Accueil</a>    			   
			<a href="Maps.jsp?searchType=" class="middle-nav-link">Map</a>
			<%
			if ( session.getAttribute("utilisateur")!=null) {
			%>
		    	<a href="FederationOnglet.jsp" class="middle-nav-link">Statistiques</a> 
		    	<a href="ClassementPage.jsp" class="middle-nav-link">Classement</a> 	
		    		
			<% }%>		 
		 </div>
        <div class="navbar-link2">
            <% if (session.getAttribute("utilisateur") == null) { %>
                <a href="LoginForm.jsp">Se connecter</a>
            <% } else { %>
               <a href="ListePublications.jsp">Actualités</a>
                <a href="ListeUtilisateurs.jsp">Valider des inscriptions</a>
                <a href="LogOut.jsp">Déconnexion</a>
            <% } %>
        </div>
    </div>
</nav>
</body>
</html>
