<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.CodeCoordonnees"%>
<%@ page import="dao.CodeDAO"%>
<%@ page import="dao.FederationDAO"%>
<%@ page import="model.CalculDistance"%>
<!DOCTYPE html>
<html>
<head>
  
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Carte</title>
    <!-- Inclure la feuille de style de Leaflet -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <!-- Inclure la bibliothèque JavaScript de Leaflet -->
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <style>
         #map {
            height: 700px;
             width:70vw;
             margin-bottom:20px;
             margin-top:20px;
        }
        .map-container{
        display:flex;
        justify-content:center;
        align-items:center;
        }
        .search-box {
	       display: flex;
	       flex-direction: row;
	       justify-content: space-between;
		   align-items: center;
	    }
	    .search-box label {
	       display: block; 
		   font-weight: bold;
		   margin-bottom: 5px;
		   color: white;  
	    }
	    .search-box select{           
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
        .submit-group{
        display:flex;
        flex-direction:column;
        }
        .form-container{
        background-color: #4B4B4B;
		height: 100px;
		margin-bottom:50px;
        }
        .form-sub-container{
        display:flex;
        flex-direction:row;
        justify-content:space-between;
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
    </style>
</head>
<body>
<jsp:include page="Header.jsp" />
<div class="sub-part-navbar">
        <h1>EXPLOREZ LES DONNÉES GÉOGRAPHIQUES DES FÉDÉRATIONS</h1>
        <p>DES DÉPARTEMENTS RÉGIONS ET COMMUNES PROCHES DE CHEZ VOUS</p>
        <div class="sub-part-navbar-bottom-side">
            <p>Affinez votre recherche</p>
        </div>
</div>
<div class="form-container">
        <form id="searchForm" class="mb-5" method="post" action="Maps.jsp">
            <div class="search-box">
                    <div class="form-group">
                        <label for="federationSelect">Fédération :</label> <select
                            id="federation" name="federation" class="form-control">
                            <option value="">Toutes les fédérations</option>
                            <%
                                FederationDAO a = new FederationDAO();
                                List<String> federations = a.getFederations();
                                String selectedFederation = request.getParameter("federation");
                                for (String federation : federations) {
                            %>
                            <option value="<%=federation%>"
                                <%= federation.equals(selectedFederation) ? "selected" : "" %>><%=federation%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="searchTypeSelect">Rechercher par :</label> <select
                            id="searchTypeSelect" name="searchType" class="form-control"
                            onchange="toggleSearchType()">
                            <option value="region" <%= "region".equals(request.getParameter("searchType")) ? "selected" : "" %>>Région</option>
                            <option value="codePostal" <%= "codePostal".equals(request.getParameter("searchType")) ? "selected" : "" %>>Code Postal</option>
                            <option value="position" <%= "position".equals(request.getParameter("searchType")) ? "selected" : "" %>>Par rapport à votre position</option>
                        </select>
                    </div>
                
                    <div class="form-group" id="regionGroup"
                        <% if ("region".equals(request.getParameter("searchType"))) { %>style="display: block;"
                        <% } else { %>style="display: none;" <% } %>>
                        <label for="regionSelect">Région :</label> <select
                            id="regionSelect" name="region" class="form-control">
                            <option value="">Toute la France</option>
                            <%
                                List<String> regions = a.getCommunes();
                                String selectedRegion = request.getParameter("region");
                                for (String region : regions) {
                            %>
 
                            <option value="<%=region%>"
                                <%= region.equals(selectedRegion) ? "selected" : "" %>><%=region%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group" id="codePostalGroup"
                        <% if ("codePostal".equals(request.getParameter("searchType"))) { %>style="display: block;"
                        <% } else { %>style="display: none;" <% } %>>
                        <label for="codePostalInput">Code Postal :</label> <input
                            type="text" id="codePostalInput" name="codePostal"
                            class="form-control" value="<%= request.getParameter("codePostal") %>">
                    </div>
                    <div class="form-group" id="distanceSliderGroup"
                        <% if ("position".equals(request.getParameter("searchType"))) { %>style="display: block;"
                        <% } else { %>style="display: none;" <% } %>>
                        <label for="distanceSelect">Distance (km) :</label> <select
                            id="distanceSelect" name="distance" class="form-control"
                            onchange="updateSearchRadius(this.value)">
                            <option value="10000" <%= "10000".equals(request.getParameter("distance")) ? "selected" : "" %>>A proximité km</option>
                            <option value="20000" <%= "20000".equals(request.getParameter("distance")) ? "selected" : "" %>>20 km</option>
                            <option value="50000" <%= "50000".equals(request.getParameter("distance")) ? "selected" : "" %>>50 km</option>
                            <option value="100000" <%= "100000".equals(request.getParameter("distance")) ? "selected" : "" %>>100 km</option>
                            <option value="200000" <%= "200000".equals(request.getParameter("distance")) ? "selected" : "" %>>200 km</option>
                            <option value="500000" <%= "500000".equals(request.getParameter("distance")) ? "selected" : "" %>>500 km</option>                                    
                        </select>
                    </div>          
                <div class="submit-group">
                   <label for="distanceSelect">Rechercher les clubs :</label> 
                   <button type="submit" class="btn btn-primary">Rechercher</button>
               </div>
            </div>          
        </form>
    </div>
    <script>
        // Fonction pour afficher les éléments en fonction du type de recherche sélectionné
        function toggleSearchType() {
            var searchType = document.getElementById('searchTypeSelect').value;
            document.getElementById('distanceSliderGroup').style.display = searchType === 'position' ? 'block' : 'none';
            document.getElementById('regionGroup').style.display = searchType === 'region' ? 'block' : 'none';
            document.getElementById('codePostalGroup').style.display = searchType === 'codePostal' ? 'block' : 'none';
        }
        
        // Fonction pour rechercher les clubs
        function searchClubs() {
            var searchType = document.getElementById('searchTypeSelect').value;
            var federation = document.getElementById('federation').value;
            var region = document.getElementById('regionSelect').value;
            var codePostal = document.getElementById('codePostalInput').value;
            var distance = document.getElementById('distanceSelect').value;
        }
        
        // Appel de la fonction toggleSearchType pour afficher les éléments au chargement de la page
        toggleSearchType();
    </script>
<div class="map-container">
<div id="map">
<script>
    <%  
        session = request.getSession();
        String regio = request.getParameter("region");
        String federatio = request.getParameter("federation");
        String critère= request.getParameter("searchType");
        String codePostal =  request.getParameter("codePostal");
        String distanceParameter = request.getParameter("distance");
        Double proximite = null;
 
        if (distanceParameter != null && !distanceParameter.isEmpty()) {
            proximite = Double.parseDouble(distanceParameter);
        } else {
            // Gérer le cas où le paramètre "distance" est null ou vide
            proximite=10000.0;
        }
 
 
        CodeDAO dao1 = new CodeDAO();
        List<CodeCoordonnees> stat =new ArrayList <CodeCoordonnees>();
        
        if(critère.equals("region")) {
            stat = dao1.getClubsLites(regio, federatio);
        }
        else if(critère.equals("codePostal")) { 
            stat = dao1.getClubsLitesByCodePostal(codePostal, federatio);
        }
        else if(critère.equals("position")) { 
            CalculDistance calcul=new CalculDistance(6371);
            List<CodeCoordonnees> coordonnees =dao1.getClubsLitesFederation( federatio);
            Double lat =49.42438814251053;
            Double lng = 1.0676001814288485;
            for(int i=0;i<coordonnees.size();i++){
            	
            	Double longitude = coordonnees.get(i).getLongitude();
            	Double latitude = coordonnees.get(i).getLatitude();
            	Double distance=calcul.calculateDistanceInMeters(lat, lng, latitude, longitude);
             if(proximite>distance){
            	 stat.add(coordonnees.get(i));
             }
            }            
        }
        
        if (stat != null && !stat.isEmpty()) { %>
            var map = L.map('map').setView([48.8566, 2.3522], 7); 
 
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributeurs'
            }).addTo(map);
 
            // Parcourir les données et ajouter des marqueurs avec des popups
            <% for (int i=0;i<stat.size();i++) { %>
                var marker = L.marker([<%= stat.get(i).getLatitude() %>, <%= stat.get(i).getLongitude() %>])
                    .addTo(map)
                   .bindPopup('<b>Clubs</b><br>Adresse : <%= stat.get(i).getZipCode() %><br>Région : <%= regio %><br>Féderation : <%= federatio %><br>Latitude : <%= stat.get(i).getLatitude() %><br>Longitude : <%= stat.get(i).getLongitude() %>')
 
                // Ajouter un événement click pour ouvrir la popup
                marker.on('click', function() {
                    this.openPopup();
                });
            <% } %>
        <% } else { %>
            var map = L.map('map').setView([48.8566, 2.3622], 6);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributeurs'
            }).addTo(map);
        <% } %>
 
        // Fonction pour ajouter un marqueur avec un popup pour la position de l'utilisateur
        function addCurrentUserMarker(lat, lng) {
            var redMarker = L.divIcon({
                className: 'custom-div-icon',
                html: "<div style='background-color:#FF5733; width: 25px; height: 25px; border-radius: 50%;'></div>",
                iconSize: [25, 25]
            });
 
            var marker = L.marker([lat, lng], { icon: redMarker }).addTo(map)
                .bindPopup('<b>Votre position actuelle</b><br>Latitude: ' + lat + '<br>Longitude: ' + lng)
                .openPopup();
 
            // Ajouter un cercle jaune autour de la position de l'utilisateur avec un rayon de 5 km
            L.circle([lat, lng], {
                color: 'yellow',
                fillColor: '#FFFF00',
                fillOpacity: 0.5,
                radius:<%=proximite%>
            }).addTo(map);
        }
 
        // Appeler la fonction getPosition() pour obtenir la position de l'utilisateur
        function getPosition() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var latitude = position.coords.latitude;
                    var longitude = position.coords.longitude;
                    addCurrentUserMarker(latitude, longitude);
                }, function(error) {
                    console.error('Erreur de géolocalisation:', error);
                }, { enableHighAccuracy: true }); // Activer la haute précision
            } else {
                alert("La géolocalisation n'est pas prise en charge par votre navigateur.");
            }
        }
 
        // Appeler la fonction getPosition() pour obtenir la position de l'utilisateur lors du chargement de la carte
        getPosition();
    </script>
</div>
</div>
   <jsp:include page="Footer.jsp" />
</body>
</html>