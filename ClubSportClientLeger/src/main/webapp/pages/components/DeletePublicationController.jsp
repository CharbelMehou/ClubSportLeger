<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.PublicationsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
// Récupérer l'ID de la publication à supprimer depuis les paramètres de la requête
String id = request.getParameter("titre");
 
// Appeler la méthode de suppression de la publication dans la base de données
PublicationsDAO publicationsDAO = new PublicationsDAO();
publicationsDAO.deletePublications(id);
 
// Rediriger l'utilisateur vers une page de confirmation ou une autre page appropriée
response.sendRedirect("ListePublicationsUtilisateur.jsp");
%>
</body>
</html>