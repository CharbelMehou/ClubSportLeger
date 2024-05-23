<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statistiques des fédérations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">

    
    <style>
  		#StatsIndicatorDiagram{
  		    width:200px;
            heigth:400px;
  		}
  		#LicensesRepartitionGraph{
  		    width:200px;
            heigth:400px;
  		}
    </style>
    <script>
	    function showSpinner() {
	        document.getElementById('spinner').style.display = 'block';
	        document.querySelector('.chart-container').style.display = 'none';
	        document.getElementById('noData').style.display = 'none';
	    }
	
	    function handleDataLoaded(hasData) {
	        document.getElementById('spinner').style.display = 'none';
	        if (hasData==true) {
	            document.querySelector('.chart-container').style.display = 'flex';
	        } else {
	            document.getElementById('noData').style.display = 'block';
	        }
	    }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<jsp:include page="Header.jsp" />
    
<div class="sub-part-navbar">
        <h1>DECOUVREZ LES DONNEES RELATIVES AUX FEDERATIONS</h1>
        <p>DES DEPARTEMENTS REGIONS ET COMMUNES PROCHE DE CHEZ VOUS</p>
        <div class="sub-part-navbar-bottom-side">
            <p>Affinez votre recherche</p>
        </div>
 </div>
    <form action="FederationOnglet.jsp" method="POST" id="searchForm" onsubmit="showSpinner()">
        <div class="search-box">
            <!-- Sélection de fédération -->
            <div class="">
                <label for="federationSelect">Fédération :</label>
                <select id="federationSelect" name="federation" class="" onchange="this.form.submit()">
                    <option value="">Toutes les fédérations</option>
                    <% 
                    FederationDAO dao = new FederationDAO();
                    ArrayList<Federation> federationList = dao.getAllFederations();
                    ArrayList<String> federations = FederationUtils.extractFederations(federationList);
            	   
                    String nomFederation = request.getParameter("federation")!=null? request.getParameter("federation"): "FF de Football";
            	    String codeDepartement = request.getParameter("departement");
            	    String nomRegion = request.getParameter("region");
            	    String nomCommune = request.getParameter("commune");
            	    
                    for (String federation : federations) { %>
                        <option value="<%= federation %>"<%= federation.equals(nomFederation) ? "selected" : "" %>><%= federation %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de région -->
            <div class="">
                <label for="regionSelect">Région :</label>
                <select id="regionSelect" name="region" class="" onchange="this.form.submit()" >
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> regionList = FederationUtils.extractRegions(federationList,nomFederation);
                    for (String region : regionList) { %>
                        <option value="<%= region %>"<%= region.equals(nomRegion) ? "selected" : "" %>><%= region %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de département -->
            <div class="">
                <label for="departementSelect">Département :</label>
                <select id="departementSelect" name="departement" class="" onchange="this.form.submit()">
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> departementList = FederationUtils.extractDepartements(federationList,nomRegion);
                    DepartementManager departementManager =new DepartementManager();
                    for (String departement : departementList) { %>
                        <option value="<%= departement %>"<%= departement.equals(codeDepartement) ? "selected" : "" %>><%= departementManager.getDepartementName(departement) %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de commune -->
            <div class="">
                <label for="communeSelect">Commune :</label>
                <select id="communeSelect" name="commune" class="">
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> communeList = FederationUtils.extractCommunes(federationList,codeDepartement);
                    for (String commune : communeList) { %>
                        <option value="<%= commune %>"<%= commune.equals(nomCommune) ? "selected" : "" %>><%= commune %></option>
                    <% } %>
                </select>
            </div>
            <!-- Bouton de soumission -->
            <div class="submit-group">
                <label for="distanceSelect">Rechercher les clubs :</label> 
                <button type="submit" class="btn btn-primary">Rechercher</button>
            </div>
        </div>
    </form>
    <div id="spinner-container">
      <div id="spinner"></div>
    </div>
    <img id="noData" src="./Pics/NoData.jpg" alt="No Data Available"/>  
       <%
		boolean allDataLoaded=false;
		%>
		<script>
     		handleDataLoaded(allDataLoaded);
		</script>	
		<% 
	    LicenseDAO licenseDao = new LicenseDAO();
	    
	    ArrayList<License> licenseList = licenseDao.getAllLicensesFromFilters(codeDepartement, nomCommune, nomRegion, nomFederation);
	    double totalHommes = LicenseUtils.getTotalAllMales(licenseList);
        double totalFemmes =  LicenseUtils.getTotalAllFemales(licenseList);
        double totalLicenses =  LicenseUtils.getTotalAllLicenses(licenseList);
        double pourcentageHommes = totalLicenses != 0 ? (totalHommes / totalLicenses) * 100 : 0;
        double pourcentageFemmes = totalLicenses != 0 ? (totalFemmes /  totalLicenses) * 100 : 0;
        
       // Stats des hommes pazr tranches d'âges
        int[] maleData = {
        		LicenseUtils.getTotalAllH_1_4_ans(licenseList), LicenseUtils.getTotalAllH_5_9_ans(licenseList), LicenseUtils.getTotalAllH_10_14_ans(licenseList), LicenseUtils.getTotalAllH_15_19_ans(licenseList), LicenseUtils.getTotalAllH_20_24_ans(licenseList), LicenseUtils.getTotalAllH_25_29_ans(licenseList), LicenseUtils.getTotalAllH_30_34_ans(licenseList),
        		LicenseUtils.getTotalAllH_35_39_ans(licenseList), LicenseUtils.getTotalAllH_40_44_ans(licenseList), LicenseUtils.getTotalAllH_45_49_ans(licenseList), LicenseUtils.getTotalAllH_50_54_ans(licenseList), LicenseUtils.getTotalAllH_55_59_ans(licenseList), LicenseUtils.getTotalAllH_60_64_ans(licenseList), LicenseUtils.getTotalAllH_65_69_ans(licenseList),
        		LicenseUtils.getTotalAllH_70_74_ans(licenseList), LicenseUtils.getTotalAllH_75_79_ans(licenseList), LicenseUtils.getTotalAllH_80_99_ans(licenseList)
        };
        // Stats des femmes pazr tranches d'âges

        int[] femaleData = {
        		LicenseUtils.getTotalAllF_1_4_ans(licenseList), LicenseUtils.getTotalAllF_5_9_ans(licenseList), LicenseUtils.getTotalAllF_10_14_ans(licenseList), LicenseUtils.getTotalAllF_15_19_ans(licenseList), LicenseUtils.getTotalAllF_20_24_ans(licenseList), LicenseUtils.getTotalAllF_25_29_ans(licenseList), LicenseUtils.getTotalAllF_30_34_ans(licenseList),
        		LicenseUtils.getTotalAllF_35_39_ans(licenseList), LicenseUtils.getTotalAllF_40_44_ans(licenseList), LicenseUtils.getTotalAllF_45_49_ans(licenseList), LicenseUtils.getTotalAllF_50_54_ans(licenseList), LicenseUtils.getTotalAllF_55_59_ans(licenseList), LicenseUtils.getTotalAllF_60_64_ans(licenseList), LicenseUtils.getTotalAllF_65_69_ans(licenseList),
        		LicenseUtils.getTotalAllF_70_74_ans(licenseList), LicenseUtils.getTotalAllF_75_79_ans(licenseList), LicenseUtils.getTotalAllF_80_99_ans(licenseList)
            };
        allDataLoaded=true;
	    if (allDataLoaded==true) {
	 %>
               <script>
            	 document.addEventListener("DOMContentLoaded", function() {
	                handleDataLoaded(true);
	            });
	          </script>
	          <div id="export-container"> 
	          	<form id="exportForm" action="GeneratePDF.jsp" method="POST">
				    <input type="hidden" id="image1" name="image1">
				    <input type="hidden" id="image2" name="image2">
				    <input type="hidden" id="filters" name="filters">
				    <input type="hidden" id="fileName" name="fileName">
					<button onclick="prepareAndSubmit()" class="btn-export" ><i class="fa fa-download"></i> Export PDF </button>
				</form>
	          	
	          </div>
                <div class='chart-container'>
                	<label> </label>
	                <div class='chart-sub-container'>
		                <canvas id='LicensesRepartitionGraph'></canvas>
		                <canvas id='StatsIndicatorDiagram'></canvas>
	                </div>
                </div>
                <script>
                const ctx = document.getElementById('LicensesRepartitionGraph').getContext('2d');                 
                var pourcentageH = <%= pourcentageHommes %>;
                var pourcentageF = <%= pourcentageFemmes %>; 
                const genderChartData = {
                    labels: ['Hommes', 'Femmes'],
                    datasets: [{
                        label: 'Répartition Licenses Hommes-Femmes',
                        data: [pourcentageH,pourcentageF],
                        backgroundColor: ['rgba(54, 162, 235, 0.6)', 'rgba(255, 99, 132, 0.6)'],
                        borderColor: ['rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)'],
                        borderWidth: 1
                    }]
                };

                const genderChart = new Chart(ctx, {
                    type: 'pie',
                    data: genderChartData,
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'Répartition Licenses Hommes-Femmes'
                            }
                        }
                    }
                });

                </script>
                
              <script> 
                const statsCtx = document.getElementById("StatsIndicatorDiagram").getContext('2d');
     	        var maleData = <%= Arrays.toString(maleData) %>;
		        var femaleData = <%= Arrays.toString(femaleData) %>;

		        const ageChartData = {
		            labels: ['1-4 ans', '5-9 ans', '10-14 ans', '15-19 ans', '20-24 ans', '25-29 ans', '30-34 ans', '35-39 ans', '40-44 ans', '45-49 ans', '50-54 ans', '55-59 ans', '60-64 ans', '65-69 ans', '70-74 ans', '75-79 ans', '80+ ans'],
		            datasets: [{
		                label: 'Hommes',
		                data: maleData,
		                backgroundColor: 'rgba(54, 162, 235, 0.5)',
		                borderColor: 'rgba(54, 162, 235, 1)',
		                borderWidth: 1
		            }, {
		                label: 'Femmes',
		                data: femaleData,
		                backgroundColor: 'rgba(255, 99, 132, 0.5)',
		                borderColor: 'rgba(255, 99, 132, 1)',
		                borderWidth: 1
		            }]
		        };

		        const ageChart = new Chart(statsCtx, {
		            type: 'bar',
		            data: ageChartData,
		            options: {
		                plugins: {
		                    title: {
		                        display: true,
		                        text: 'Répartition License par âge et par sexe'
		                    }
		                },
		                scales: {
		                    y: {	
		                        beginAtZero: true
		                    }
		                }
		            }
		        });
    		</script>
    		<script>
    		function prepareAndSubmit() {
    		    // Construire la chaîne de filtres
				var filterString = "Fédération: " + '<%= nomFederation %>' + ", Département: " + '<%= departementManager.getDepartementName(codeDepartement) %>' + " , Région: " + '<%= nomRegion %>' + ", Commune: " + '<%=nomCommune %>';
				var fileName ='<%= nomFederation %>' + "_" + '<%= codeDepartement %>' + "_" + '<%= nomRegion %>' + "_" + '<%= nomCommune %>';

				document.getElementById('filters').value = filterString;
    		    document.getElementById('fileName').value = fileName;

    		    // Convertir les graphiques en images Base64 et les attribuer aux champs cachés
    		    var image1 = document.getElementById('LicensesRepartitionGraph').toDataURL('image/png');
    		    var image2 = document.getElementById('StatsIndicatorDiagram').toDataURL('image/png');
    		    document.getElementById('image1').value = image1;
    		    document.getElementById('image2').value = image2;

    		    // Soumettre le formulaire
    		    document.getElementById('exportForm').submit();
    		}
				</script>
    		         
                <%
    } else {
        out.println("<script>document.addEventListener(\"DOMContentLoaded\", function() {handleDataLoaded(false);});</script>");
    }
 %>
	<jsp:include page="Footer.jsp" />
</body>
</html>
