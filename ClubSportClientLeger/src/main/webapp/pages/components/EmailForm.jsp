<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">
<title>Email form</title>
 
<style>
.container{
    width: 100%; /* Largeur du formulaire */
    background-color:#FFFFFF ;
    max-width: 500px; /* Largeur maximale */
    padding: 10px; /* Espacement intérieur */
    border-radius: 8px; /* Bord arrondi */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Ombre */
    height: 300px
    
  }
.card-body{
   background-color: #11559C; /* Couleur de fond */
}
 
.custom-btn {
    background-color: #11559C; /* Couleur de fond */
    border-color: #11559C; /* Couleur de bord */
    color: #ffffff; /* Couleur du texte */
}
body {
	background-color: #e5e5f7;
	opacity: 0.8;
	background-image: radial-gradient(#232aab 0.5px, #e5e5f7 0.5px);
	background-size: 10px 10px;
}
</style>
</head>
<body>
<jsp:include page="Header.jsp" />
<div class="container">
    <div class="card bg-primary text-white">
        <div class="card-body">Veuillez saisir vos identifiants</div>
    </div>
 
    <form action="SendEmailCodeController.jsp" method="post">
        <h2>Saisissez votre email</h2>
      
        <div class="form-group">
            <label for="email">Adresse e-mail</label>
            <input type="text" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Entrez votre adresse e-mail">
        </div>
        
        <button type="submit" class="btn btn-primary custom-btn">Envoyez un code</button>
    </form>
    <% String message = (String)request.getAttribute("sms"); %>
    <% if(message != null && !message.isEmpty()) { %>
        <div class="alert alert-danger">
            <strong>News!</strong> <%= message %>
        </div>
    <% } %>
</div>
<jsp:include page="Footer.jsp" />
</body>
</html>