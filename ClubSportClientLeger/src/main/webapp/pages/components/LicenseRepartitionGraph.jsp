<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="model.License"%>
  <%@ page import="model.Federation"%>
  <%@ page import="dao.LicenseDAO"%>
  <%@ page import="dao.FederationDAO"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./components/componentStyle.css">
</head>
<body>
<%
	String nomFederation = request.getParameter("federation");
	String codeDepartement = request.getParameter("departement");
	String nomRegion = request.getParameter("region");
	String nomCommune = request.getParameter("commune");
	
	License license=null;
	LicenseDAO licenseDao=new LicenseDAO();
	FederationDAO dao = new FederationDAO();
	license=licenseDao.getLicenseByDepartementAndRegionAndCommuneAndFederation(codeDepartement, nomCommune, nomRegion,nomFederation);
%>
<canvas id="LicenseRepartitionGraph" width="400" height="400"></canvas>

<!-- Pour Charger Chart.js depuis CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	const ctx = document.getElementById('LicenseRepartitionGraph').getContext('2d');
	
	const totalHommes = <%= license.getTotalMales() %>;
	const totalFemmes = <%= license.getTotalFemales() %>;
	const totalLicenses = <%= license.getTotal() %>;
	const pourcentageHommes = totalLicenses ? (totalHommes / totalLicenses) * 100 : 0;
	const pourcentageFemmes = totalLicenses ? (totalFemmes / totalLicenses) * 100 : 0;
	
	const data = {
	  labels: [
	    'Hommes',
	    'Femmes',
	  ],
	  datasets: [{
	    label: 'Répartition Licenses Hommes-Femmes',
	    data: [pourcentageHommes, pourcentageFemmes],
	    backgroundColor: [
	      'rgba(54, 162, 235, 0.6)',
	      'rgba(255, 99, 132, 0.6)',
	    ],
	    borderColor: [
	      'rgba(54, 162, 235, 1)',
	      'rgba(255, 99, 132, 1)',
	    ],
	    borderWidth: 1,
	  }]
	};
	
	const monGraphique = new Chart(ctx, {
	  type: 'pie',
	  data: data,
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
	  },
	});
</script>
</body>
</html>