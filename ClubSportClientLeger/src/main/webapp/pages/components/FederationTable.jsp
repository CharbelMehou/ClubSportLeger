<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%
    // R�cup�ration des param�tres du formulaire
    String libelleFederation = request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "";
    String nomDepartement = request.getParameter("departement") != null ? request.getParameter("departement") : "";
    String nomRegion = request.getParameter("region") != null ? request.getParameter("region") : "";
    String nomCommune = request.getParameter("commune") != null ? request.getParameter("commune") : "";

    // Cr�ation d'une instance de FederationDAO et r�cup�ration des f�d�rations filtr�es
    FederationDAO dao = new FederationDAO();
    
    ArrayList<Federation> federations = new ArrayList<Federation>();
    
	if(libelleFederation ==null || nomDepartement==null || nomRegion==null || nomCommune==null ){
	    federations = dao.getFederationsSortedByRegion();
	}
	else{
		federations = dao.getListFederation(libelleFederation, nomDepartement, nomRegion, nomCommune);
	}
    // Affichage des r�sultats dans un tableau HTML
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="componentStyle.css">
</head>
<body>
<table class="table-federation-commune">
        <thead>
            <tr>
                <th>F�d�ration</th>
                <th>D�partement</th>
                <th>R�gion</th>
                <th>Commune</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Federation federation : federations) {
            %>
            <tr>
                <td><%= federation.getLibelleFederation() %></td>
                <td><%= federation.getNomDepartement() %></td>
                <td><%= federation.getNomRegion() %></td>
                <td><%= federation.getNomCommune() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>