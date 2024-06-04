<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="model.Federation"%>
<%@ page import="dao.FederationDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<style>
.big-container{
	background-color: #e5e5f7;
	opacity: 0.8;
	background-image: radial-gradient(#232aab 0.5px, #e5e5f7 0.5px);
	background-size: 10px 10px;
	padding:40px;
}
.container {
	width: 80%; /* Largeur du formulaire */
	max-width: 600px; /* Largeur maximale */
	padding: 20px; /* Espacement intï¿½rieur */
	border-radius: 8px; /* Bord arrondi */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Ombre */
	background-color: #FFFFFF;
}
 
.card-body {
	background-color: #11559C; /* Couleur de fond */
}
 
.custom-btn {
	background-color: #11559C; /* Couleur de fond */
	border-color: #11559C; /* Couleur de bord */
	color: #ffffff; /* Couleur du texte */
}

.password-adverstising{
	background-color:#bae7e9;
	width:600px;
	margin-left:15px;
	margin-right:15px;	
	padding:10px;
	color:#8faab0;
}
.inscrire-container{
display:flex;
flex-direction:row;
justify-content:center
}
</style>
<title>Inscription</title>
</head>
<body>
	<jsp:include page="Header.jsp" />
	<div class="big-container"> 
	<div class="container">
		<div class="card bg-primary text-white">
			<div class="card-body">Veuillez saisir vos informations
				personnel</div>
		</div>
		<div></div>
		<form method="POST" action="AddUser.jsp">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label for="nom">Nom</label> <input type="text"
							class="form-control" id="nom" name="nom"
							placeholder="Entrez votre nom">
					</div>
				</div>
				<div class="col-md-8">
					<!-- Correction de la classe de colonne -->
					<div class="form-group">
						<label for="prenom">Prénom</label> <input type="text"
							class="form-control" id="prenom" name="prenom"
							placeholder="Entrez votre prénom">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label for="email">Email</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="Entrez votre email...">
					</div>
				</div>
				<div class="col-md-4">
					<!-- Correction de la classe de colonne -->
					<div class="form-group">
						<label for="password">Mot de passe</label> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="Entrez votre mot de passe">
					</div>
				</div>
			</div>
			<div class="row">
				<div class=" password-adverstising">
					<p>Votre mot de passe doit respecter les instructions suivantes :</p>
				    <ul>
				        <li>Contenir Minimum 12 caractères</li>
				        <li>Contenir au minimum une majuscule</li>
				        <li>Contenir des chiffres</li>
				        <li>Contenir au minimum un caractère spécial</li>
				    </ul>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<label for="federationSelect">Fédération :</label> <select
							id="federation" name="federation" class="form-control">
							<%
                                    FederationDAO dao = new FederationDAO();
                                    List<String> federationList = dao.getFederations();
                                    for (String federation : federationList) { %>
							<option value="<%= federation %>"><%= federation %></option>
							<% } %>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<!-- Correction de la classe de colonne -->
					<div class="form-group">
						<label for="club">Club</label> <input type="text"
							class="form-control" id="club" name="club"
							placeholder="Entrez le club">
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="federationSelect">Statut:</label> <select id="statut"
							name="statut" class="form-control">
							<option value="Président de Club">Président de Club</option>
							<option value="Entraineur">Entraineur</option>
							<option value="Maire">Maire</option>
							<option value="Deputé">Député</option>
						</select>
					</div>
				</div>
 
			</div>
			<div class="mb-3 form-check">
				<input type="checkbox" class="form-check-input" id="exampleCheck1">
				<label class="form-check-label" for="exampleCheck1">Check me
					out</label>
			</div>
			<div class="inscrire-container">
			<button type="submit" class="btn btn-primary custom-btn">Inscrire</button>
			</div>
		</form>
		<% String message = (String)request.getAttribute("message");
			String messageStatus = (String)request.getAttribute("messageStatus");			%>
    <% if(message != null && !message.isEmpty()) {
    	if(messageStatus.equals("bad")){
    	%>
        <div class="alert alert-danger">
            <strong>News!</strong> <%= message %>
        </div>
    <%}
    	else if(messageStatus.equals("good")){%>
        <div class="alert alert-success">
            <strong>News!</strong> <%= message %>
        </div>
    
   <%  }
    	} %>
	 </div>
	</div>
	
	<jsp:include page="Footer.jsp" />
</body>
</html>