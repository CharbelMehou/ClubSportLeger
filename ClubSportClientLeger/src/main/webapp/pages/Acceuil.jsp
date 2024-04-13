<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
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

    <form action="Accueil.jsp" method="GET" id="searchForm">
        <div class="search-box">
            <!-- Barre de recherche -->
            <div class="search-bar">
                <input type="text" name="searchTerm" class="search-input" placeholder="Rechercher une Fédération" onchange="this.form.submit()">
                <button type="submit" class="searchButton">Rechercher</button>
            </div>
            <% 
                FederationDAO dao = new FederationDAO();
                String searchTerm = request.getParameter("searchTerm") != null ? request.getParameter("searchTerm").trim() : "";
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 15;

                ArrayList<Federation> federations = dao.getFederationsSortedByRegion(currentPage, pageSize);

                Set<String> departements = new HashSet<>();
                Set<String> regions = new HashSet<>();
                Set<String> communes = new HashSet<>();
                for (Federation federation : federations) {
                    departements.add(federation.getNomDepartement());
                    regions.add(federation.getNomRegion());
                    communes.add(federation.getNomCommune());
                }
                List<String> departementList = new ArrayList<>(departements);
                List<String> regionList = new ArrayList<>(regions);
                List<String> communeList = new ArrayList<>(communes);
            %>
            <!-- Dropdown Département -->
            <%
                request.setAttribute("links", departementList);
            %>
            <jsp:include page="./components/DropDown.jsp">
                <jsp:param name="buttonLabel" value="Departement" />
                <jsp:param name="onchange" value="this.form.submit()" />
            </jsp:include>

            <!-- Dropdown Région -->
            <%
                request.setAttribute("links", regionList);
            %>
            <jsp:include page="./components/DropDown.jsp">
                <jsp:param name="buttonLabel" value="Region" />
                <jsp:param name="onchange" value="this.form.submit()" />
            </jsp:include>

            <!-- Dropdown Commune -->
            <%
                request.setAttribute("links", communeList);
            %>
            <jsp:include page="./components/DropDown.jsp">
                <jsp:param name="buttonLabel" value="Commune" />
                <jsp:param name="onchange" value="this.form.submit()" />
            </jsp:include>     
        </div>
    </form>

    <jsp:include page="./components/FederationTable.jsp" />
    <jsp:include page="./components/Footer.jsp" />
</body>
</html>
