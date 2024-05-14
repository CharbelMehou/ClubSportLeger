<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="model.Utilisateurs"%>
<%@ page import="dao.UtilisateurDAO"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Listes des Utilisateurs</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
body {
	
}
.container{
padding:20px;
}
</style>
</head>
<body>
 
	<jsp:include page="Header.jsp" flush="true" />
 <div class="container">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<% String message = (String)request.getAttribute("message"); %>
	<% if(message != null && !message.isEmpty()) { %>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
		  <strong>Oups!</strong><%=message%>
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
    <% } %>
	
	<%
	String param = request.getParameter("cm");
	UtilisateurDAO dao = new UtilisateurDAO();
	ArrayList<Utilisateurs> list = dao.getAllUsers();
	;
	if (list.size() != 0) {
	%>
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">Nom</th>
				<th scope="col">Prenom</th>
				<th scope="col">Email</th>
				<th scope="col">Federation</th>
				<th scope="col">Statut</th>
			</tr>
			<%
			for (Utilisateurs user : list) {
			%>
		</thead>
 
 
		<tbody>
			<tr>
				<td><%=user.getNom()%></td>
				<td><%=user.getPrenom()%></td>
				<td><%=user.getEmail()%></td>
				<td><%=user.getFederation()%></td>
				<td><%=user.getStatut()%></td>
				<td>
			         <div class="dropdown">
						<a class="btn btn-secondary dropdown-toggle" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Options </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="ValidateUserController.jsp?nom=<%=java.net.URLEncoder.encode(user.getNom(), "UTF-8")%>&prenom=<%=java.net.URLEncoder.encode(user.getPrenom(), "UTF-8")%>&email=<%=java.net.URLEncoder.encode(user.getEmail(), "UTF-8")%>&motdepasse=<%=java.net.URLEncoder.encode(user.getMotdepasse(), "UTF-8")%>&federation=<%=java.net.URLEncoder.encode(user.getFederation(), "UTF-8")%>&club=<%=java.net.URLEncoder.encode(user.getClubs(), "UTF-8")%>&statut=<%=java.net.URLEncoder.encode(user.getStatut(), "UTF-8")%>">Valider</a></li>
 
						</ul>
					</div>
				</td>
			</tr>
		</tbody>
		<%
		}
		%>
	</table>
	<%
	} else {
	%>
	<div class=text-center>
		<h1>Aucune personnes ne s'est incrit</h1>
	</div>
	<%
	}
	%>
 </div> 
</body>
</html>