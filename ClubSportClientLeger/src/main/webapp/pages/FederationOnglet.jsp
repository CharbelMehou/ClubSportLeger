<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Federation" %>
<%@ page import="model.FederationUtils" %>
<%@ page import="dao.FederationDAO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="utils.DepartementManager" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="./components/Header.jsp" />

<form action="./components/EluDataVisualisator.jsp" method="POST" id="searchForm">
    <div class="search-box">
        <!-- Sélection de fédération -->
        <div class="form-group">
            <label for="federationSelect">Fédération :</label>
            <select id="federationSelect" name="federation" class="form-control">
                <option value="">Toutes les fédérations</option>
                <%
                FederationDAO dao = new FederationDAO();
                ArrayList<Federation> federationList = dao.getAllFederations();
                ArrayList<String> fédérations = FederationUtils.extractFederations(federationList);                
                ArrayList<String> departementList = FederationUtils.extractDepartements(federationList);
                ArrayList<String> regionList = FederationUtils.extractRegions(federationList);
                ArrayList<String> communeList = FederationUtils.extractCommunes(federationList);
                DepartementManager manager=new DepartementManager();
                
                for (String federation : fédérations) { %>
                    <option value="<%= federation %>"><%= federation.replace("''", "'") %></option>
                <% } %>
            </select>
        </div>
        
        <!-- Dropdown Département --> 
        <div class="form-group">
            <label for="departementSelect">Département :</label>
            <select id="departementSelect" name="departement" class="form-control">
                <option value="">Toute la France</option>
                <% for (String departement : departementList) { System.out.println(departement);%>
                    
                    <option value="<%= departement %>"><%= manager.getDepartementName(departement).replace("''", "'")%></option>
                <% } %> 
            </select>
        </div>
        <!-- Dropdown Région -->
        <div class="form-group">
            <label for="regionSelect">Région :</label>
            <select id="regionSelect" name="region" class="form-control">
                <option value="">Toute la France</option>
                	<% 
                           for (String region : regionList) { %>
							<option value="<%= region %>"><%= region.replace("''", "'") %></option>
							<% } %>
            </select>
        </div>
        <!-- Dropdown Commune -->
        <div class="form-group">
            <label for="communeSelect">Commune :</label>
            <select id="communeSelect" name="commune" class="form-control">
                <option value="">Toute la France</option>
                <% for (String commune : communeList) { %>
                    <option value="<%= commune %>"><%= commune.replace("''", "'") %></option>
                <% } %>
            </select>
        </div>
        
        <!-- Bouton de soumission -->
        <div class="form-group">
            <button type="submit" onclick="showSpinner()" class="btn btn-primary">Rechercher</button>
        </div>
    </div>
</form>
<script>
	function showSpinner() {
	    document.getElementById('spinner').style.display = 'block';
	}
</script>
<jsp:include page="./components/EluDataVisualisator.jsp" />
<jsp:include page="./components/Footer.jsp" />
</body>
</html>