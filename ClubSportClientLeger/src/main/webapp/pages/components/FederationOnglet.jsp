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
        .chart-container {
            display: flex;
            flex-direction: colum;
            padding: 10px;
            width:100vw;
            margin-bottom:20px;
        }
        .chart-container label{
        	color:#333;
        	font-size: 16px;
        }
        .chart-sub-container {
            display: flex;
            flex-direction: row;
            padding: 10px;
            width:48vw;
            margin-bottom:20px;
        }
  		#StatsIndicatorDiagram{
  		    width:200px;
            heigth:400px;
  		}
  		#LicensesRepartitionGraph{
  		    width:200px;
            heigth:400px;
  		}
        #spinner-container{
        	display:block;
        	flex-direction:row;
        	justify-content:center;
        	align-items:center;
        	heigth:100vh;
        	
        }
       #spinner {
           display: none;
           margin: auto;
		   width: 100px;
		   height: 100px;
		   border-radius: 50%;
		   border: 9px solid;
		   border-color: #dbdcef;
		   border-right-color: #11559C;
		   animation: spinner-d3wgkg 1s infinite linear;
		}
		@keyframes spinner-d3wgkg {
		   to {
		      transform: rotate(1turn);
		   }
		}
        #noData {
           display: none;
           margin: auto;
           width: 800px;
           height: 800px;
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
    .submitButton {
		  width: 200px;
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
	 .btn-export {
	  background-color: DodgerBlue;
	  border: none;
	  color: white;
	  padding: 12px 30px;
	  border-radius: 0 5px 5px 0;
	  cursor: pointer;
	  font-size: 20px;
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
                <select id="federationSelect" name="federation" class="">
                    <option value="">Toutes les fédérations</option>
                    <% 
                    FederationDAO dao = new FederationDAO();
                    ArrayList<Federation> federationList = dao.getAllFederations();
                    ArrayList<String> federations = FederationUtils.extractFederations(federationList);
                    for (String federation : federations) { %>
                        <option value="<%= federation %>"><%= federation %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de département -->
            <div class="">
                <label for="departementSelect">Département :</label>
                <select id="departementSelect" name="departement" class="">
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> departementList = FederationUtils.extractDepartements(federationList);
                    for (String departement : departementList) { %>
                        <option value="<%= departement %>"><%= departement %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de région -->
            <div class="">
                <label for="regionSelect">Région :</label>
                <select id="regionSelect" name="region" class="">
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> regionList = FederationUtils.extractRegions(federationList);
                    for (String region : regionList) { %>
                        <option value="<%= region %>"><%= region %></option>
                    <% } %>
                </select>
            </div>
            <!-- Sélection de commune -->
            <div class="">
                <label for="communeSelect">Commune :</label>
                <select id="communeSelect" name="commune" class="">
                    <option value="">Toute la France</option>
                    <% 
                    ArrayList<String> communeList = FederationUtils.extractCommunes(federationList);
                    for (String commune : communeList) { %>
                        <option value="<%= commune %>"><%= commune %></option>
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
	    String nomFederation = request.getParameter("federation");
	    String codeDepartement = request.getParameter("departement");
	    String nomRegion = request.getParameter("region");
	    String nomCommune = request.getParameter("commune");
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
				var filterString = "Fédération: " + '<%= nomFederation %>' + ", Département: " + '<%= codeDepartement %>' + ", Région: " + '<%= nomRegion %>' + ", Commune: " + '<%= nomCommune %>';
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
