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
// R�cup�rer l'ID de la publication � supprimer depuis les param�tres de la requ�te
String id = request.getParameter("titre");
 
// Appeler la m�thode de suppression de la publication dans la base de donn�es
PublicationsDAO publicationsDAO = new PublicationsDAO();
publicationsDAO.deletePublications(id);
 
// Rediriger l'utilisateur vers une page de confirmation ou une autre page appropri�e
response.sendRedirect("ListePublicationsUtilisateur.jsp");
%>
</body>
</html>