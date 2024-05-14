<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Formulaire de publications</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
</head>
<body>
<jsp:include page="Header.jsp" />
 
<div class="col-md-12">
    <h1>Faire une publication</h1>
    <form action="../../AjoutPublication1" method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label for="titre" class="form-label">Titre de la publication</label>
            <input type="text" class="form-control" id="titre" name="titre" placeholder="Titre..." required>
        </div>
        <div class="form-group">
            <label for="contenu" class="form-label">Contenu de la publication</label>
            <textarea class="form-control" id="contenu" name="contenu" placeholder="Description du jeu..." style="resize: vertical;" rows="10" required></textarea>
        </div>
        <div class="form-group">
            <label for="photo" class="form-label">Photo (jpeg)</label>
            <input type="file" name="photo" id="photo" class="form-control" accept="image/jpeg">
        </div>
        <div class="form-group">
            <button class="btn btn-outline-primary" type="submit">Ajouter</button>
        </div>
    </form>
</div>
 
<jsp:include page="Footer.jsp" />
 
</body>
</html>