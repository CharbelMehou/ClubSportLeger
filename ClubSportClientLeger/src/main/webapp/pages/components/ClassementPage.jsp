<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%@ page import="dao.LicenseDAO" %>
<%@ page import="model.License" %>
<%@ page import="model.Utilisateurs"%>
<%@ page import="model.FederationUtils" %>
<%@ page import="utils.DepartementManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="model.LicenseUtils" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Arrays" %>

<%

    // Récupération des paramètres du formulaire
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 15;
    LicenseDAO dao = new LicenseDAO();
    
    String nomfederation = request.getParameter("federation")!=null? request.getParameter("federation"): "FF de Football";
    String sortOption = request.getParameter("sortOption")!=null? request.getParameter("sortOption") :"DESC";
    
    int totalRecords = dao.countLicencesRelatedToFederation(nomfederation);
    
    ArrayList<License> federationListTab=dao.getAllLicensesFromFederation(nomfederation,sortOption,currentPage,pageSize);
    
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
	
    DepartementManager manager=new DepartementManager();
    
    ArrayList<License> federationList = dao.getAllLicensesFromFilters(null,null,null,null);
    ArrayList<String> federations = LicenseUtils.extractFederations(federationList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Classement</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <style>
       * {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
		}
		
		body {
		    font-family: 'Arial', sans-serif;
		    height: 100vh;
		}
        .search-box {
	       background-color: #4B4B4B;
	       display: flex;
	       flex-direction: row;
	       justify-content: space-between;
	       height: 150px;
	       padding: 20px;
		   align-items: center;
	    }
	    .search-box label {
	       display: block; 
		   font-weight: bold;
		   margin-bottom: 5px;
		   color: white;  
	    }
	    .search-box select{
	       width:400px;              
		   padding: 8px;        
		   font-size: 14px;          
		   border: 1px solid #ccc;   
		   border-radius: 4px;       
		   box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
		   background-color: white;  
		   color: #333;              
		   margin-top: 5px;
		   cursor: pointer; 
	    }
	    .search-box2 {
	      display:flex;
	      flex-direction:row;
	      gap:20px;
	    }
	     #sortOptionSelect{
	       width:150px;              
		   padding: 8px;        
		   font-size: 14px;          
		   border: 1px solid #ccc;   
		   border-radius: 4px;       
		   box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
		   background-color: white;  
		   color: #333;              
		   margin-top: 5px;
		   cursor: pointer; 
	    }
	    
	    .search-box select:focus{
	       border-color: #11559C;
           outline: none;
	    }
	    .form-select {
	        background-color: #f8f9fa;
	        border: 1px solid #ccc;
	        border-radius: 4px;
	        padding: 8px;
	        color: #333;
	        width: 100%;
	    }
	    .form-select:focus {
            border-color: #80bdff;
	        outline: none;
	    }
	    .search-button {
	        background-color: #007bff;
	        color: white;
	        border: none;
	        padding: 10px 20px;
	        border-radius: 4px;
	        font-size: 18px;
	        cursor: pointer;
	        transition: background-color 0.3s;
	    }
	    .search-button:hover {
	        background-color: #0056b3;
	    }
        .submitButton {
		  width: 300px;
		  height: 50px;
		  border: 1px solid #11559C;
		  background: #11559C;
		  text-align: center;
		  margin-top: 30px;
		  color: #fff;
		  border-radius: 0 5px 5px 0;
		  cursor: pointer;
		  font-size: 20px;
		}
		.sub-part-navbar{
		 background-color: #e5e5f7;
	     opacity: 0.8;
	     background-image: radial-gradient(#11559C 0.8500000000000001px, #e5e5f7 0.8500000000000001px);
	     background-size: 17px 17px;
	     min-height: 170px;
	     display: flex;
	     flex-direction: column;
	     justify-content: space-between;
	     padding-top:10px;
	    }
	.sub-part-navbar h1,	
	.sub-part-navbar p{
		 margin-left: 40px;
		 font-weight:bold;
		 font-size:30px;
		 color: #11559C;
	}
	.sub-part-navbar-bottom-side{
	     background-color: #1E1E1E;
	     color: #ffffff;
	     height: 40px;
	     width: 250px;
	     display:flex;
	     align-items:center;
	 }
	 .sub-part-navbar-bottom-side p{
	     color: #ffffff;
	     font-size:15px;
	 }
	 
	 /*Style du tableau des fédérations par commune*/
	.table-federation-commune {
	        width: 100%;
	        border-collapse: separate;
	        border-spacing: 10px 0;
	        margin: 20px 0;
	    }
	
	.table-federation-commune th {
	        background-color: #11559C;
	        color: white;
	        padding: 10px;
	        text-align: left;
	    }
	
	.table-federation-commune td {
	        padding: 10px;
	        background-color: #f8f9fa;
	        border: 1px solid #dee2e6;
	    }
	.link-button {
		    background: none;
		    color: #11559C;
		    border: none;
		    padding: 0;
		    margin: 0;
		    font: inherit;
		    cursor: pointer;
		    text-decoration: underline; 
	}
	.link-button:hover, .link-button:focus {
	    text-decoration: none;
	}
	    
	 /*Style de la pagination*/
	 .pagination-container{
	    display:flex;
	 	justify-content:center
	 }
	 .pagination {
	    text-align: center;
	    margin-top: 20px;
	    margin-bottom: 20px;
	}
	
	.pagination a {
	    margin: 0 5px;
	    padding: 8px 16px;
	    background-color: #f4f4f4;
	    color: #333;
	    text-decoration: none;
	    border-radius: 5px;
	    border: 1px solid #ddd;
	}
	
	.pagination a.active {
	    background-color: #007BFF;
	    color: white;
	    border-color: #007BFF;
	}
	
	.pagination a:hover:not(.active) {
	    background-color: #ddd;
	}
	/* Styles de la navbar */
		.navbar {
		    background-color: #11559C;
		    color: #ffffff;
		    padding:10px;
		    min-height: 50px;    
		}
	
		.navbar-links {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    width: 100%;
		}
		.navbar-link1, .navbar-link2 {
		    display: flex;
		    align-items: center;
		}
		
		.navbar-link1 {
		    justify-content: flex-start;
		}
		
		.navbar-link2 {
		    justify-content: flex-end;
		}
		.navbar a{
		    text-decoration: none;
		    color: #ffffff;
		    margin-left: 20px;
		    padding: 10px;
		    font-weight:bold;
		    transition: background-color 0.3s ease;
		}
		.navbar span{
		    text-decoration: none;
		    color: #ffffff;
		    margin-left: 20px;
		    padding: 10px;
		    font-size:20px;
		    font-weight:bold;
		    transition: background-color 0.3s ease;
		}
		.navbar a:hover,
		.navbar a:focus {
		    background-color: #ffffff;
		    color: #002F6C;
		    border-radius: 5px;
		}
	 	  /*Style du footer*/
		.footer {
			  background-color: #333;
			  color: white;
			  display: flex;
			  justify-content: space-between;
			  padding: 20px; 
			  font-size: 0.8em;
			  margin-top:20px;
		}
		
		.footer div {
		  margin: 0 20px;
		 }
		
		.footer div ul {
		  list-style-type: none;
		  padding: 0;
		}
		
		.footer div ul li {
		  margin-bottom: 10px;
		}
    </style>
</head>
<body>

   <jsp:include page="Header.jsp" />
   
    <div class="sub-part-navbar">
        <h1>VISUALISER LE CLASSEMENT DES DEPARTEMENTS REGIONS ET COMMUNES</h1>
        <p>BASEE SUR LES PROPORTIONS DE LICENSIES DES FEDERATIONS SPORTIVES</p>
        <div class="sub-part-navbar-bottom-side">
            <p>Affinez votre recherche</p>
        </div>
   </div>
	<form action="ClassementPage.jsp" method="POST" id="searchForm" ">
	        <div class="search-box">
	            <!-- Sélection de fédération -->
	            <div class="search-box2">
		            <div class="">
		                <label for="federationSelect">Fédération :</label>
		                <select id="federationSelect" name="federation" class="">
		                    <option value="">Toutes les fédérations</option>
		                    <% 	               
		                    for (String federation : federations) { %>
		                        <option value="<%= federation %>"><%= federation.replace("''", "'") %></option>
		                    <% } %>
		                </select>
		            </div>
		            <div class="">
					    <label for="sortOptionSelect">Option de Tri :</label>
					    <select id="sortOptionSelect" name="sortOption"	>
					        <option value="DESC">Décroissant</option>
					        <option value="ASC">Croissant</option>				        
					    </select>
					</div>
	            </div> 
       
	            <!-- Bouton de soumission -->
	            <div class="submit-group">
	                <label for="distanceSelect">Rechercher les clubs :</label> 
	                <button type="submit" class="btn btn-primary">Rechercher</button>
	            </div>
	        </div>
	</form>
    <table class="table-federation-commune">
    <thead>
        <tr>
            <th><strong>Rang</strong></th>
            <th><strong>Département</strong></th>
            <th><strong>Région</strong></th>
            <th><strong>Commune</strong></th>
            <th><strong>Nb Total de licenciés</strong></th>
            <th><strong>Proportion H/F des licences</strong></th>
        </tr>
    </thead>
    <tbody>
        <% int rank = (currentPage - 1) * pageSize + 1; 
        
        for (License license : federationListTab) {
             %>
        <tr>
            <td><strong><%= rank++ %></strong></td>
            <td><%= manager.getDepartementName(license.getDepartement()) %></td>
            <td><%= license.getRegion().replace("''", "'") %></td>
            <td><%= license.getCommune().replace("''", "'") %></td>
            <td><%= license.getTotal() %></td>
            <td><%= LicenseUtils.calculateProportionHF(license,license.getTotal()) %></td>
        </tr>
        <% } %>
    </tbody>
</table>
<div class="pagination-container">
	<div class="pagination">
	    <% 
	    // Récupération et encodage des valeurs actuelles des filtres
	    int startPage = Math.max(1, currentPage - 5);
	    int endPage = Math.min(totalPages, currentPage + 4);
	
	    if (currentPage > 1) {
	    %>
	        <a href="ClassementPage.jsp?page=<%= currentPage - 1 %>&pageSize=<%= pageSize %>&federation=<%= nomfederation %>&sortOption=<%= sortOption %>">Précédente</a>
	    <% 
	    }
	    for (int i = startPage; i <= endPage; i++) {
	    %>
	        <a href="ClassementPage.jsp?page=<%= i %>&pageSize=<%= pageSize %>&federation=<%= nomfederation %>&sortOption=<%= sortOption %>" <%= i == currentPage ? "class='active'" : "" %>><%= i %></a>
	    <% 
	    }
	    if (currentPage < totalPages) {
	    %>
	        <a href="ClassementPage.jsp?page=<%= currentPage + 1 %>&pageSize=<%= pageSize %>&federation=<%= nomfederation %>&sortOption=<%= sortOption %>">Suivante</a>
	    <% 
	    } 
	    %>
	</div>
</div>
<jsp:include page="Footer.jsp" />
</body>
</html>