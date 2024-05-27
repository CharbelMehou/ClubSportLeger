<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
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
    <jsp:include page="Header.jsp" />
 
    <div class="sub-part-navbar">
        <h1>LE PORTAIL DES CLUBS ET FÉDÉRATIONS</h1>
        <p>DECOUVREZ TOUTE L'ACTUALITÉ DES CLUBS ET FÉDERATIONS PROCHEs DE CHEZ VOUS</p>
        <div class="sub-part-navbar-bottom-side">
            <p>Affinez votre recherche</p>
        </div>
    </div>
 
    <form action="Acceuil.jsp" method="POST" id="searchForm">
    <div class="search-box">
        <!-- Sï¿½lection de fï¿½dï¿½ration -->
        <div class="dropdown">
            <label for="federationSelect">Fédération :</label>
            <select id="federationSelect" name="federation" class="form-control" onchange="this.form.submit()">
                <option value="">Toutes les fédérations</option>
                <%
                FederationDAO dao = new FederationDAO();
                List<String> federationList = dao.getFederations();
			    String nomfederation = request.getParameter("federation") != null ? request.getParameter("federation").trim() : "";
			    String nomCritere = request.getParameter("searchType") != null ? request.getParameter("searchType").trim() : "";
			    String nomRegion = request.getParameter("region") != null ? request.getParameter("region").trim() : "";
			    String nomCodePostal = request.getParameter("codePostal") != null ? request.getParameter("codePostal").trim() : "";
			    
                for (String federation : federationList) { %>
                    <option value="<%= federation %>"<%= federation.equals(nomfederation) ? "selected" : "" %>><%= federation.replace("''", "'") %></option>
                <% } %>
            </select>
        </div>
 
        <%
        // Récupération du terme de recherche
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
						<label for="regionSelect">Région :</label> 
						<select id="regionSelect" name="region" class="form-control" onchange="this.form.submit()">
							<option value="">Toute la France</option>
							<% List<String> regions = dao.getCommunes(nomfederation);
                           for (String region : regions) { %>
							<option value="<%= region %>"<%= region.equals(nomRegion) ? "selected" : "" %>><%= region.replace("''", "'") %></option>
							<% } %>
						</select>
					</div>
					
					<div class="dropdown" id="codePostalGroup" style="display: none;">
						<label for="codePostalInput">Code Postal :</label>
						<input
							type="text" id="codePostalInput" name="codePostal"
							class="form-control" <%= nomCodePostal.equals(nomRegion) ? "selected" : "" %>>
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
    <jsp:include page="FederationTable.jsp" />
    <jsp:include page="Footer.jsp" />
</body>
</html>