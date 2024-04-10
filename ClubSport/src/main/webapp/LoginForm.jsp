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
<title>Formulaire de Connexion</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.card {
    margin-bottom: 20px;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    margin-top: 20px;
}

label {
    display: block;
    margin-bottom: 8px;
}

input {
    width: 100%;
    padding: 8px;
    margin-bottom: 16px;
    box-sizing: border-box;
}

button {
    background-color: #4caf50;
    color: #fff;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.alert {
    margin-top: 20px;
}
</style>
</head>
<body>
    <div class="card bg-primary text-white">
        <div class="card-body">Veuillez saisir vos informations personnel</div>
    </div>

    <form action="././Login" method="post">
        <h2>Connexion</h2>
      
        <div class="form-group">
            <label for="email">Adresse e-mail</label>
            <input type="text" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Entrez votre adresse e-mail">
        </div>
        <div class="form-group">
            <label for="motdepasse">Mot de passe</label>
            <input type="password" class="form-control" id="motdepasse" name="motdepasse" placeholder="Mot de passe">
        </div>
        <button type="submit" class="btn btn-primary">Creer</button>
    </form>

    <% String message = (String)request.getAttribute("message"); %>
    <% if(message != null && !message.isEmpty()) { %>
        <div class="alert alert-danger">
            <strong>News!</strong> <%= message %>
        </div>
    <% } %>
</body>
</html>
