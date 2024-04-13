<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%
    // Récupération des paramètres du formulaire
    String libelleFederation = request.getParameter("searchTerm") != null ? request.getParameter("searchTerm").trim() : "";
    String nomDepartement = request.getParameter("departement") != null ? request.getParameter("departement").trim() : "";
    String nomRegion = request.getParameter("region") != null ? request.getParameter("region").trim() : "";
    String nomCommune = request.getParameter("commune") != null ? request.getParameter("commune").trim() : "";
    
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 15;
    FederationDAO dao = new FederationDAO();
    int totalRecords = dao.countFederations();
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

    ArrayList<Federation> federations;
    if (libelleFederation.isEmpty() && nomDepartement.isEmpty() && nomRegion.isEmpty() && nomCommune.isEmpty()) {
        federations = dao.getFederationsSortedByRegion(currentPage, pageSize);
    } else {
        federations = dao.getListFederation(libelleFederation, nomDepartement, nomRegion, nomCommune, currentPage, pageSize);
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
        <% for (Federation federation : federations) { %>
        <tr>
            <td><%= federation.getLibelleFederation() %></td>
            <td><%= federation.getNomDepartement() %></td>
            <td><%= federation.getNomRegion() %></td>
            <td><%= federation.getNomCommune() %></td>
        </tr>
        <% } %>
    </tbody>
</table>
<div class="pagination">
    <% 
    int startPage = Math.max(1, currentPage - 5);
    int endPage = Math.min(totalPages, currentPage + 4);
    if (currentPage > 1) { %>
        <a href="./Acceuil.jsp?page=<%= currentPage - 1 %>&pageSize=<%= pageSize %>">Précédente</a>
    <% } 
    for (int i = startPage; i <= endPage; i++) { %>
        <a href="./Acceuil.jsp?page=<%= i %>&pageSize=<%= pageSize %>" <%= i == currentPage ? "class='active'" : "" %>><%= i %></a>
    <% }
    if (currentPage < totalPages) { %>
        <a href="./Acceuil.jsp?page=<%= currentPage + 1 %>&pageSize=<%= pageSize %>">Suivante</a>
    <% } %>
</div>

</body>
</html>
