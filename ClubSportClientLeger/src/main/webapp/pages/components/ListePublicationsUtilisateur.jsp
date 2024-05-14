<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, model.Publications, dao.PublicationsDAO" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Publications</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">
 
<style>
    body {
        background-color: #e5e5f7;
        opacity: 0.8;
        background-image: linear-gradient(#444cf7 1px, transparent 1px),
            linear-gradient(to right, #444cf7 1px, #e5e5f7 1px);
        background-size: 20px 20px;
    }
</style>
 
</head>
<body>
    <jsp:include page="Header.jsp" />
    <div class="container">
        <div class="row">
            <%
                session=request.getSession();
                int id = (int) session.getAttribute("id");
                // Récupérer les publications depuis la base de données
                PublicationsDAO publicationsDAO = new PublicationsDAO();
                ArrayList<Publications> publications = publicationsDAO.getPublications(id);
                   
                // Parcourir les publications et les afficher
                for (Publications publication : publications) {
            %>
            <div class="col-md-3">
                <div class="card" style="max-width: 200px; margin-right: 10px;">
                    <img
                        src="data:image/jpeg;base64,<%= org.apache.tomcat.util.codec.binary.Base64.encodeBase64String(publication.getImage()) %>"
                        class="card-img-top img-thumbnail"
                        alt="<%= publication.getTitre() %>" width="150" height="100">
                    <div class="card-body">
                        <h6 class="card-title"><%= publication.getTitre() %></h6>
                        <p class="card-text"><%= publication.getPublication() %></p>
                        
                        <form action="UpdatePublicationsForm.jsp" method="POST">
                            <input type="hidden" name="titre" value="<%= publication.getTitre() %>">
                            <input type="hidden" name="contenu" value="<%= publication.getPublication() %>">
                            <button type="submit" class="btn btn-primary">Modifier</button>
                        </form>
                        
                        <form action="DeletePublicationController.jsp" method="GET">
                            <input type="hidden" name="titre"  id="titre"value="<%= publication.getTitre() %>">
                            <button type="submit" class="btn btn-danger">Supprimer</button>
                        </form>
                    </div>
                </div>
            </div>
 
            <%
                }
            %>
        </div>
    </div>
</body>
</html>