<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.License"%>
<%@ page import="model.Federation"%>
<%@ page import="utils.DepartementManager"%>
<%@ page import="dao.LicenseDAO"%>
<%@ page import="dao.FederationDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<style>
  /* Ajoutez le style pour centrer le tableau */
  .center-table {
    margin: auto;
  }
</style>
</head>
<body>
<div class="container mt-6">
  <table class="dataDisplayer center-table"> <!-- Ajoutez la classe "center-table" -->
    <tbody>
      <% 
        String nomFederation = request.getParameter("federation");
        String codeDepartement = request.getParameter("departement");
        String nomRegion = request.getParameter("region");
        String nomCommune = request.getParameter("commune");
        
        DepartementManager manager= new DepartementManager();
        String nomDepartement=manager.getDepartementName(codeDepartement);
        License license=null;
        LicenseDAO licenseDao=new LicenseDAO();
        FederationDAO dao = new FederationDAO();
        Federation federation=null;
        federation=dao.getFederationByDepartementAndRegionAndCommune(nomFederation,codeDepartement,nomRegion,nomCommune);
        license=licenseDao.getLicenseByDepartementAndRegionAndCommuneAndFederation(codeDepartement, nomCommune, nomRegion,nomFederation);
      %>     
      <tr>
        <td><strong>Federation</strong></td>
        <td><%=nomFederation%></td>
      </tr>
      <tr>
        <td><strong>Département</strong></td>
        <td><%= nomDepartement %> (<%=codeDepartement%>)</td>
      </tr>
      <tr>
        <td><strong>Région</strong></td>
        <td><%= nomRegion %></td>
      </tr>
      <tr>
        <td><strong>Commune</strong></td>
        <td><%= nomCommune %></td>
      </tr>
      <tr>
        <td><strong>Nombre total de licenciés</strong></td>
        <td><%= license.getTotal() %></td>
      </tr>
      <tr>
        <td><strong>Nombre total de clubs sportifs</strong></td>
        <td><%= federation.getClubs() %></td>
      </tr>
      <tr>
        <td><strong>Nombre total d'Etablissements Professionnels Agréés (EPA)</strong></td>
        <td><%= federation.getEPA() %></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
