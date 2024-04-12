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
        <p>DECOUVRER TOUTE L'ACTUALITÉ DES CLUBS ET FEDERATION PROCHE DE CHEZ VOUS</p>
	    <div class="sub-part-navbar-bottom-side">
	    	<p>Affinez votre recherche</p>
	    </div>
    </div>
    
    <div class="search-box"> 
	    <!-- Premier menu déroulant -->
		<jsp:include page="./components/DropDown.jsp">
		    <jsp:param name="buttonLabel" value="Departement" />
		    <jsp:param name="link1" value="value 1.1" />
		    <jsp:param name="link2" value="value 1.2" />
		    <jsp:param name="link3" value="value 1.3" />
		</jsp:include>
		
		<!-- Deuxième menu déroulant -->
		<jsp:include page="./components/DropDown.jsp">
		    <jsp:param name="buttonLabel" value="Federation" />
		    <jsp:param name="link1" value="value 2.1" />
		    <jsp:param name="link2" value="value 2.2" />
		    <jsp:param name="link3" value="value 2.3" />
		</jsp:include>
		
		<!-- Troisième menu déroulant -->
		<jsp:include page="./components/DropDown.jsp">
		    <jsp:param name="buttonLabel" value="Region" />
		    <jsp:param name="link1" value="value 3.1" />
		    <jsp:param name="link2" value="value 3.2" />
		    <jsp:param name="link3" value="value 3.3" />
		</jsp:include>
		
	   <!-- Barre de recherche -->
	   <div class="search-bar">
	      <input type="text" class="search-input" placeholder="What are you looking for?">
	      <button type="submit" class="searchButton">
	        Rechercher
	     </button>
	   </div>
	</div>
	 <table class="table-federation-commune">
        <thead>
            <tr>
                <th>Département</th>
                <th>Fédération</th>
                <th>Région</th>
            </tr>
        </thead>
        <tbody>
            <% 
                FederationDAO dao = new FederationDAO();
                ArrayList<Federation> federations = dao.getFederationsSortedByRegion();
                for (Federation federation : federations) {
            %>
            <tr>
                <td><%= federation.getNomDepartement() %></td>
                <td><%= federation.getLibelleFederation() %></td>
                <td><%= federation.getNomRegion() %></td>
            </tr>
            <% 
                }
            %>
        </tbody>
    </table>
	<jsp:include page="./components/Footer.jsp" />
	
</body>
</html>