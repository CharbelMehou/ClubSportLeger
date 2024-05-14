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
<title>Code de validation</title>
 
<style>
.container {
	width: 100%; /* Largeur du formulaire */
	background-color: black;
	max-width: 700px; /* Largeur maximale */
	padding: 10px; /* Espacement intérieur */
	border-radius: 8px; /* Bord arrondi */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Ombre */
	height: 300px
}
 
.card-body {
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
 
.password{
display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
 
}
.input {
  max-width: 190px;
  width: 40px;
  height: 40px;
  outline: none;
  margin: 5px;
  transition: .5s;
  border: none;
  border-radius: 10px;
  padding: 10px;
  text-align: center;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  transform: rotate(90deg);
}
 
input:focus {
  width: 150px;
  transform: rotate(0);
}
 
.text{
  color:white;
 
}
 
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />
	<div class="container">
		<div class="card bg-primary text-white">
			<div class="card-body">Veuillez saisir vos identifiants</div>
		</div>
 
		<form action="VerificationCodeController.jsp" method="post">
			 <h2 class="text">Vérification du code </h2>
			<div class="password">
				<input type="text" maxlength="1" name="text1" id="text1" class="input">
                <input type="text" maxlength="1" name="text2" id="text2"class="input">
                <input type="text" maxlength="1" name="text3" id="text3" class="input">
				<input type="text" maxlength="1" name="text4" id="text4" class="input">
			</div>
 
			<button type="submit" class="btn btn-primary custom-btn">Vérifier</button>
		</form>
	</div>
<% String message = (String)request.getAttribute("message"); %>
    <% if(message != null && !message.isEmpty()) { %>
        <div class="alert alert-danger">
            <strong>News!</strong> <%= message %>
        </div>
    <% } %>
	<jsp:include page="Footer.jsp" />
</body>
</html>