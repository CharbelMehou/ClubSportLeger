<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Federation"%>
<%@ page import="dao.FederationDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceuil</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<jsp:include page="./components/Header.jsp" />
	
	<div class="sub-part-navbar">
        <h1>LE PORTAIL DES CLUBS ET FEDERATION</h1>
        <p>DECOUVRER TOUTE L'ACTUALITE DES CLUBS ET FEDERATION PROCHE DE CHEZ VOUS</p>
	    <div class="sub-part-navbar-bottom-side">
	    	<p>Affinez votre recherche</p>
	    </div>
    </div>
    
   <form action="Acceuil.jsp" method="GET" id="searchForm">
    <div class="search-box"> 
        
        <!-- Barre de recherche -->
        <div class="search-bar">
            <input type="text" name="searchTerm" class="search-input" placeholder="Rechercher une Fédération" onchange="this.form.submit()">
            <button type="submit" class="searchButton">Rechercher</button>
        </div>
        <%
            FederationDAO dao = new FederationDAO();
            ArrayList<Federation> federations = dao.getFederationsSortedByRegion();
            
            ArrayList<String> departements = new ArrayList<String>();
            ArrayList<String> regions = new ArrayList<String>();
            ArrayList<String> communes = new ArrayList<String>();
            
            for (Federation federation : federations) {
                departements.add(federation.getNomDepartement());
                regions.add(federation.getNomRegion());
                communes.add(federation.getNomCommune());
            }
            
            request.setAttribute("departements", departements);
            request.setAttribute("regions", regions);
            request.setAttribute("communes", communes);
        %>
        <!-- Dropdown Département -->
        <%
            request.setAttribute("links", departements);
        %>
        <jsp:include page="./components/DropDown.jsp">
            <jsp:param name="buttonLabel" value="Departement" />
            <jsp:param name="onchange" value="this.form.submit()" />
        </jsp:include>

        <!-- Dropdown Région -->
        <%
            request.setAttribute("links", regions);
        %>
        <jsp:include page="./components/DropDown.jsp">
            <jsp:param name="buttonLabel" value="Region" />
            <jsp:param name="onchange" value="this.form.submit()" />
        </jsp:include>

        <!-- Dropdown Commune -->
        <%
            request.setAttribute("links", communes);
        %>
        <jsp:include page="./components/DropDown.jsp">
            <jsp:param name="buttonLabel" value="Commune" />
            <jsp:param name="onchange" value="this.form.submit()" />
        </jsp:include>     
 		   </div>
	</form>

	<jsp:include page="./components/FederationTable.jsp" />
	<jsp:include page="./components/Footer.jsp" />
	
</body>
</html>