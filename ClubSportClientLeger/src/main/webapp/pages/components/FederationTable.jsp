<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%
    // Récupération des paramètres du formulaire
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 15;
    FederationDAO dao = new FederationDAO();
    int totalRecords = dao.countFederations();
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

    String critere = request.getParameter("searchType");
    String region = request.getParameter("region");
    String federation = request.getParameter("federation");
    String codePostal = request.getParameter("codePostal");
    
    ArrayList<Federation> federations = new ArrayList<>();
    if ("region".equals(critere)) {
    	federations = dao.getClubsLites(region, federation,currentPage,pageSize);
    } else {
    	federations = dao.getClubsLitesByCodePostal(codePostal, federation,currentPage,pageSize);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List of Federations</title>
<link rel="stylesheet" type="text/css" href="componentStyle.css">
</head>
<body>
<table class="table-federation-commune">
    <thead>
        <tr>
            <th>Fédération</th>
            <th>Département</th>
            <th>Région</th>
            <th>Commune</th>
        </tr>
    </thead>
    <tbody>
        <% for (Federation eachfederation : federations) { %>
        <tr>
            <td><%= eachfederation.getFederation() %></td>
            <td><%= eachfederation.getDepartement() %></td>
            <td><%= eachfederation.getRegion() %></td>
            <td><%= eachfederation.getCommune() %></td>
        </tr>
        <% } %>
    </tbody>
</table>
<div class="pagination">
    <% 
    // Récupération et encodage des valeurs actuelles des filtres
    String currentFederation = request.getParameter("federation") != null ? URLEncoder.encode(request.getParameter("federation"), "ISO-8859-1") : "";
    String currentSearchType = request.getParameter("searchType") != null ? URLEncoder.encode(request.getParameter("searchType"), "ISO-8859-1") : "";
    String currentRegion = request.getParameter("region") != null ? URLEncoder.encode(request.getParameter("region"), "ISO-8859-1") : "";
    String currentCodePostal = request.getParameter("codePostal") != null ? URLEncoder.encode(request.getParameter("codePostal"), "ISO-8859-1") : "";

    int startPage = Math.max(1, currentPage - 5);
    int endPage = Math.min(totalPages, currentPage + 4);

    if (currentPage > 1) {
    %>
        <a href="./Acceuil.jsp?page=<%= currentPage - 1 %>&pageSize=<%= pageSize %>&federation=<%= currentFederation %>&searchType=<%= currentSearchType %>&region=<%= currentRegion %>&codePostal=<%= currentCodePostal %>">Précédente</a>
    <% 
    }
    for (int i = startPage; i <= endPage; i++) {
    %>
        <a href="./Acceuil.jsp?page=<%= i %>&pageSize=<%= pageSize %>&federation=<%= currentFederation %>&searchType=<%= currentSearchType %>&region=<%= currentRegion %>&codePostal=<%= currentCodePostal %>" <%= i == currentPage ? "class='active'" : "" %>><%= i %></a>
    <% 
    }
    if (currentPage < totalPages) {
    %>
        <a href="./Acceuil.jsp?page=<%= currentPage + 1 %>&pageSize=<%= pageSize %>&federation=<%= currentFederation %>&searchType=<%= currentSearchType %>&region=<%= currentRegion %>&codePostal=<%= currentCodePostal %>">Suivante</a>
    <% 
    } 
    %>
</div>
</body>
</html>
