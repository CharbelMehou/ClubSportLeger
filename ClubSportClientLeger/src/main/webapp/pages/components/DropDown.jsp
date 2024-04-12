<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./components/componentStyle.css">
</head>
<body>
	<div class="dropdown">
	    <button class="dropbtn"><%= request.getParameter("buttonLabel") %></button>
	    <div class="dropdown-content">
	        <a href="#"><%= request.getParameter("link1") %></a>
	        <a href="#"><%= request.getParameter("link2") %></a>
	        <a href="#"><%= request.getParameter("link3") %></a>
	    </div>
    </div>
</body>
</html>