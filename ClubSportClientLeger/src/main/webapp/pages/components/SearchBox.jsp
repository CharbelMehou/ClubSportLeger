<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Federation"%>
<%@ page import="dao.FederationDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./components/componentStyle.css">
</head>
<body>
 <div class="search-box"> 
	   <div class="search-bar">
	      <input type="text" class="search-input" placeholder="Rechercher une Federation">
	      <button type="submit" class="searchButton">
	        Rechercher
	     </button>
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
			<!-- Dropdown Departement -->
			<%
			    request.setAttribute("links", departements);
			%>
			<jsp:include page="DropDown.jsp">
			    <jsp:param name="buttonLabel" value="Departement" />
			</jsp:include>

			<!-- Dropdown Region -->
			<%
			    request.setAttribute("links", regions);
			%>
			<jsp:include page="DropDown.jsp">
			    <jsp:param name="buttonLabel" value="Region" />
			</jsp:include>

			<!-- Dropdown Commune -->
			<%
			    request.setAttribute("links", communes);
			%>
			<jsp:include page="DropDown.jsp">
			<jsp:param name="buttonLabel" value="Commune" />
			</jsp:include>		
	</div>
</body>
</html>