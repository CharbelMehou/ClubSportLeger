<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <jsp:include page="./components/Header.jsp" />

    <div class="sub-part-navbar">
        <h1>LE PORTAIL DES CLUBS ET FEDERATIONS</h1>
        <p>DECOUVREZ TOUTE L'ACTUALITE DES CLUBS ET FEDERATIONS PROCHE DE CHEZ VOUS</p>
        <div class="sub-part-navbar-bottom-side">
            <p>Affinez votre recherche</p>
        </div>
    </div>

    <form action="Acceuil.jsp" method="POST" id="searchForm">
    <div class="search-box">
        <!-- Sélection de fédération -->
        <div class="dropdown">
            <label for="federationSelect">Fédération :</label>
            <select id="federationSelect" name="federation" class="form-control">
                <option value="">Toutes les fédérations</option>
                <% 
                FederationDAO dao = new FederationDAO();
                List<String> federationList = dao.getFederations();
                for (String federation : federationList) { %>
                    <option value="<%= federation %>"><%= federation.replace("''", "'") %></option>
                <% } %>
            </select>
        </div>

        <% 
        // Récupération du terme de recherche
        String federation = request.getParameter("federation") != null ? request.getParameter("federation").trim() : "";
        int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 15;


        %>
                    <div class="dropdown">
						<label for="searchTypeSelect">Rechercher par :</label> <select
							id="searchTypeSelect" name="searchType" class="form-control"
							onchange="toggleSearchType()">
							<option value="region">Région</option>
							<option value="codePostal">Code Postal</option>
						</select>
	                </div>
       						
					<div  class="dropdown" id="regionGroup">
						<label for="regionSelect">Région :</label> <select
							id="regionSelect" name="region" class="form-control">
							<option value="">Toute la France</option>
							<% List<String> regions = dao.getCommunes();
                           for (String region : regions) { %>
							<option value="<%= region %>"><%= region.replace("''", "'") %></option>
							<% } %>
						</select>
					</div>
					
					<div class="dropdown" id="codePostalGroup" style="display: none;">
						<label for="codePostalInput">Code Postal :</label> 
						<input
							type="text" id="codePostalInput" name="codePostal"
							class="form-control">
					</div>
							
					 <div class="submit-group">
			            <button type="submit" class="submitButton">Rechercher</button>
							       
					 </div>			
    </div>
</form>
<script>
    function toggleSearchType() {
        var searchType = document.getElementById('searchTypeSelect').value;
        if (searchType === 'region') {
            document.getElementById('regionGroup').style.display = 'block';
            document.getElementById('codePostalGroup').style.display = 'none';
        } else if (searchType === 'codePostal') {
            document.getElementById('regionGroup').style.display = 'none';
            document.getElementById('codePostalGroup').style.display = 'block';
        }
    }

    function searchClubs() {
        var searchType = document.getElementById('searchTypeSelect').value;
        var federation = document.getElementById('federation').value;
        var region = document.getElementById('regionSelect').value;
        var codePostal = document.getElementById('codePostalInput').value;
    }
</script>
    <jsp:include page="./components/FederationTable.jsp" />
    <jsp:include page="./components/Footer.jsp" />
</body>
</html>
