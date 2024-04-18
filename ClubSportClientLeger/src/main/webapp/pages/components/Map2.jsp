<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.CodeCoordonnees"%>
<%@ page import="dao.CodeDAO"%>
<%@ page import="dao.LicenseDAO"%>
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
    </style>
</head>
<body>
    <div id="map" class=" col-md-8"></div>
    <script>
        <%  
        String nomFederation = request.getParameter("federation");
        String codeDepartement = request.getParameter("departement");
        String nomRegion = request.getParameter("region");
        String nomCommune = request.getParameter("commune");
        String distanceParameter = request.getParameter("distance");
        Double proximite = (distanceParameter != null && !distanceParameter.isEmpty()) ? Double.parseDouble(distanceParameter) : 10000.0;
 
        LicenseDAO dao1 = new LicenseDAO();
        List<CodeCoordonnees> stat = dao1.getCodeLicenseByDepartementAndRegionAndCommuneAndFederation(codeDepartement, nomCommune, nomRegion, nomFederation);
        
        // Ajoutez ici la logique pour gérer la recherche par proximité
        %>
        var map = L.map('map').setView([48.8566, 2.3522], 5); // Zoom initial ajusté à 5
 
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributeurs'
        }).addTo(map);
 
        // Parcourir les données et ajouter des marqueurs avec des popups
        <% for (CodeCoordonnees coordonnees : stat) { %>
            var marker = L.marker([<%= coordonnees.getLatitude() %>, <%= coordonnees.getLongitude() %>])
                .addTo(map)
                .bindPopup('<b>Clubs</b><br>Adresse : <%= coordonnees.getZipCode() %>');
 
            // Ajouter un événement click pour ouvrir la popup
            marker.on('click', function() {
                this.openPopup();
            });
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
</body>
</html>