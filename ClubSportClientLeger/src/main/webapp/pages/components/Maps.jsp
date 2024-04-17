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
    <!-- Ajouter le CSS pour spécifier la taille de la carte -->
    <style>
        /* Utiliser la taille de la fenêtre pour la carte */
        html, body, #map {
            height: 85%;
            margin: 0;
        }
    </style>
</head>
<body>
 <jsp:include page="Header1.jsp" />
<div class="container mt-6">
        <form id="searchForm" class="mb-5" method="post" action="Maps.jsp">
            <div class="row">

                <div class="col-md-3">
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
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="searchTypeSelect">Rechercher par :</label> <select
                            id="searchTypeSelect" name="searchType" class="form-control"
                            onchange="toggleSearchType()">
                            <option value="region" <%= "region".equals(request.getParameter("searchType")) ? "selected" : "" %>>Région</option>
                            <option value="codePostal" <%= "codePostal".equals(request.getParameter("searchType")) ? "selected" : "" %>>Code Postal</option>
                            <option value="position" <%= "position".equals(request.getParameter("searchType")) ? "selected" : "" %>>Par rapport à votre position</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
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
                                    
                            <!-- Ajoutez autant d'options que vous le souhaitez -->
                        </select>
                    </div>
                </div>
                
                  <div class="col-md-3">
                <label for="distanceSelect">Rechercher les clubs :</label> <button
                    type="submit" class="btn btn-primary">Rechercher</button>
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
        else if(critère.equals("codePostal")) { // Modification de la condition
            stat = dao1.getClubsLitesByCodePostal(codePostal, federatio);
        }
        else if(critère.equals("position")) { // Nouvelle ligne
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
            
        	// Ajoutez ici la logique pour gérer la recherche par proximité
        }
        
        if (stat != null && !stat.isEmpty()) { %>
            var map = L.map('map').setView([48.8566, 2.3522], 5); // Zoom initial ajusté à 5

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
            var map = L.map('map').setView([48.8566, 2.3522], 5); // Zoom initial ajusté à 5

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
                radius:<%=proximite%>// en mètres
            }).addTo(map);
        }

        // Appeler la fonction getPosition() pour obtenir la position de l'utilisateur
        function getPosition() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var latitude = position.coords.latitude;
                    var longitude = position.coords.longitude;
                    addCurrentUserMarker(latitude, longitude); // Ajouter le marqueur avec le popup pour la position de l'utilisateur
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
   <jsp:include page="Footer.jsp" />
</body>
</html>
