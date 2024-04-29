<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Federation" %>
<%@ page import="dao.FederationDAO" %>
<%@ page import="model.LicenseUtils" %>
<%@ page import="model.License" %>
<%@ page import="dao.LicenseDAO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .chart-container {
        display: flex;
        flex-direction: row;
        justify-content: space-around; 
        align-items: center;
        flex-wrap: wrap;
    }
    canvas {
        box-sizing: border-box;
        padding: 10px;
    }
    .spinner {
   width: 56px;
   height: 56px;
   border-radius: 50%;
   border: 9px solid;
   border-color: #dbdcef;
   border-right-color: #11559c;
   animation: spinner-d3wgkg 1s infinite linear;
	}
	
	@keyframes spinner-d3wgkg {
	   to {
	      transform: rotate(1turn);
	   }
	}
</style>
</head>
<body>
<%
    String nomFederation = request.getParameter("federation");
    String codeDepartement = request.getParameter("departement");
    String nomRegion = request.getParameter("region");
    String nomCommune = request.getParameter("commune");

    ArrayList<License> licenseList = new ArrayList<License>();
    ArrayList<String> licenseFilterList = new ArrayList<String>();

    if (nomFederation != null && !nomFederation.trim().isEmpty()) licenseFilterList.add(nomFederation);
    if (codeDepartement != null && !codeDepartement.trim().isEmpty()) licenseFilterList.add(codeDepartement);
    if (nomRegion != null && !nomRegion.trim().isEmpty()) licenseFilterList.add(nomRegion);
    if (nomCommune != null && !nomCommune.trim().isEmpty()) licenseFilterList.add(nomCommune);

    boolean dataFiltersExist = !licenseFilterList.isEmpty();
    request.setAttribute("dataLoaded", false);  // Initialiser par défaut à false

    if (dataFiltersExist) {
        LicenseDAO licenseDao = new LicenseDAO();
        licenseList = licenseDao.getAllLicensesFromFilters(codeDepartement, nomCommune, nomRegion, nomFederation);
        request.setAttribute("dataLoaded", true);
    }
%>
<% if (!dataFiltersExist) { %>
    <img src="./Pics/NoData.jpg" alt="No Data Available" style="display: block; margin: auto; width:800px; heigth:800px"/>
<% } else if (!licenseList.isEmpty()) { %>
    <div class="chart-container">
        <canvas id="LicensesRepartitionGraph" width="200" height="200"></canvas>
        <canvas id="StatsIndicatorDiagram" width="200" height="200"></canvas>
    </div>

	<div id="spinner" style="display: none;">
	    <div class="spinner"></div>
	</div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx = document.getElementById('LicensesRepartitionGraph').getContext('2d');
        const totalHommes = <%= LicenseUtils.getTotalAllMales(licenseList) %>;
        const totalFemmes = <%= LicenseUtils.getTotalAllFemales(licenseList) %>;
        const totalLicenses = <%= LicenseUtils.getTotalAllLicenses(licenseList) %>;
        const pourcentageHommes = totalLicenses ? (totalHommes / totalLicenses) * 100 : 0;
        const pourcentageFemmes = totalLicenses ? (totalFemmes / totalLicenses) * 100 : 0;

        const genderChartData = {
            labels: ['Hommes', 'Femmes'],
            datasets: [{
                label: 'Répartition Licenses Hommes-Femmes',
                data: [pourcentageHommes, pourcentageFemmes],
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
        <%
        
        // Stats des hommes pazr tranches d'ï¿½ges
        int[] maleData = {
        		LicenseUtils.getTotalAllH_1_4_ans(licenseList), LicenseUtils.getTotalAllH_5_9_ans(licenseList), LicenseUtils.getTotalAllH_10_14_ans(licenseList), LicenseUtils.getTotalAllH_15_19_ans(licenseList), LicenseUtils.getTotalAllH_20_24_ans(licenseList), LicenseUtils.getTotalAllH_25_29_ans(licenseList), LicenseUtils.getTotalAllH_30_34_ans(licenseList),
        		LicenseUtils.getTotalAllH_35_39_ans(licenseList), LicenseUtils.getTotalAllH_40_44_ans(licenseList), LicenseUtils.getTotalAllH_45_49_ans(licenseList), LicenseUtils.getTotalAllH_50_54_ans(licenseList), LicenseUtils.getTotalAllH_55_59_ans(licenseList), LicenseUtils.getTotalAllH_60_64_ans(licenseList), LicenseUtils.getTotalAllH_65_69_ans(licenseList),
        		LicenseUtils.getTotalAllH_70_74_ans(licenseList), LicenseUtils.getTotalAllH_75_79_ans(licenseList), LicenseUtils.getTotalAllH_80_99_ans(licenseList)
        };
        // Stats des femmes pazr tranches d'ï¿½ges

        int[] femaleData = {
        		LicenseUtils.getTotalAllF_1_4_ans(licenseList), LicenseUtils.getTotalAllF_5_9_ans(licenseList), LicenseUtils.getTotalAllF_10_14_ans(licenseList), LicenseUtils.getTotalAllF_15_19_ans(licenseList), LicenseUtils.getTotalAllF_20_24_ans(licenseList), LicenseUtils.getTotalAllF_25_29_ans(licenseList), LicenseUtils.getTotalAllF_30_34_ans(licenseList),
        		LicenseUtils.getTotalAllF_35_39_ans(licenseList), LicenseUtils.getTotalAllF_40_44_ans(licenseList), LicenseUtils.getTotalAllF_45_49_ans(licenseList), LicenseUtils.getTotalAllF_50_54_ans(licenseList), LicenseUtils.getTotalAllF_55_59_ans(licenseList), LicenseUtils.getTotalAllF_60_64_ans(licenseList), LicenseUtils.getTotalAllF_65_69_ans(licenseList),
        		LicenseUtils.getTotalAllF_70_74_ans(licenseList), LicenseUtils.getTotalAllF_75_79_ans(licenseList), LicenseUtils.getTotalAllF_80_99_ans(licenseList)
            };
    %>
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
<% } else { %>
    <img src="./Pics/NoData.jpg" alt="No Data Available" style="display: block; margin: auto; width:800px; heigth:800px"/>
<% } %>
</body>
</html>
