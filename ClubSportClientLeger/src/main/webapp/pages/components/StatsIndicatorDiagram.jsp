<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="model.License, dao.LicenseDAO"%>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistiques par Tranche d'ï¿½ge</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<canvas id="StatsIndicatorDiagram" width="400" height="400"></canvas>
<%
    String nomFederation = request.getParameter("federation");
    String codeDepartement = request.getParameter("departement");
    String nomRegion = request.getParameter("region");
    String nomCommune = request.getParameter("commune");

    LicenseDAO licenseDao = new LicenseDAO();
    License license = licenseDao.getLicenseByDepartementAndRegionAndCommuneAndFederation(codeDepartement, nomCommune, nomRegion, nomFederation);

    // Stats des hommes pazr tranches d'ï¿½ges
    int[] maleData = {
        license.getH_1_4_ans(), license.getH_5_9_ans(), license.getH_10_14_ans(), license.getH_15_19_ans(), license.getH_20_24_ans(), license.getH_25_29_ans(), license.getH_30_34_ans(),
        license.getH_35_39_ans(), license.getH_40_44_ans(), license.getH_45_49_ans(), license.getH_50_54_ans(), license.getH_55_59_ans(), license.getH_60_64_ans(), license.getH_65_69_ans(),
        license.getH_70_74_ans(), license.getH_75_79_ans(), license.getH_80_99_ans()
    };
    // Stats des femmes pazr tranches d'ï¿½ges

    int[] femaleData = {
        license.getF_1_4_ans(), license.getF_5_9_ans(), license.getF_10_14_ans(), license.getF_15_19_ans(), license.getF_20_24_ans(), license.getF_25_29_ans(), license.getF_30_34_ans(),
        license.getF_35_39_ans(), license.getF_40_44_ans(), license.getF_45_49_ans(), license.getF_50_54_ans(), license.getF_55_59_ans(), license.getF_60_64_ans(), license.getF_65_69_ans(),
        license.getF_70_74_ans(), license.getF_75_79_ans(), license.getF_80_99_ans()
    };
%>
<script>
    var ageLabels = ['1-4 ans', '5-9 ans', '10-14 ans', '15-19 ans', '20-24 ans', '25-29 ans', '30-34 ans', '35-39 ans', '40-44 ans', '45-49 ans', '50-54 ans', '55-59 ans', '60-64 ans', '65-69 ans', '70-74 ans', '75-79 ans', '80+ ans'];
    var maleData = <%= Arrays.toString(maleData) %>;
    var femaleData = <%= Arrays.toString(femaleData) %>;

    var statsctx = document.getElementById("StatsIndicatorDiagram").getContext('2d');

    var ageGroupChart = new Chart(statsctx, {
        type: 'bar',
        data: {
            labels: ageLabels,
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
        },
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
</body>
</html>
