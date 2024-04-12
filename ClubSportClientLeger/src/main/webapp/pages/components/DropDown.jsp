<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./components/componentStyle.css">
</head>
<body>
	<%
	    String buttonLabel = request.getParameter("buttonLabel");
	    ArrayList<String> links = (ArrayList<String>) request.getAttribute("links");
	%>
	<div class="dropdown">
	    <label  for="<%=buttonLabel.toLowerCase()%>"><%=buttonLabel%></label>
	    <select id="<%=buttonLabel.toLowerCase()%>" name="<%=buttonLabel.toLowerCase()%>" onchange="document.forms['searchForm'].submit();">
	        <option value="">Choisir un <%=buttonLabel%></option>
	        <% 
	        if (links != null) {
	            for (String link : links) {
	                out.println("<option value='" + link + "'>" + link + "</option>");
	            }
	        }
	        %>
	    </select>
	</div>
</body>
</html>