<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>D�connexion</title>
</head>
<body>
<%
    session.removeAttribute("utilisateur");
    response.sendRedirect("Acceuil.jsp");
%>
</body>
</html>
