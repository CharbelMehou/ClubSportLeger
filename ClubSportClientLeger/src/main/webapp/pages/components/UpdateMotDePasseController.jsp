<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Base64"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="model.Utilisateurs"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
  
  
  <%
   session=request.getSession();
    String email=(String)session.getAttribute("email");
    String password=request.getParameter("motdepasse1");
    String password1=request.getParameter("motdepasse");
    
  if (password.equalsIgnoreCase(password1)){
	  UtilisateurDAO dao=new UtilisateurDAO();
	  String motdepasse=hashPassword(password);
	  dao.modifierMotDePasse(email,motdepasse);
	  String message = "Mot de passe changé";
      request.setAttribute("message", message);
      RequestDispatcher dispatcher = request.getRequestDispatcher("LoginForm.jsp");
      dispatcher.forward(request, response);
  }
  else{
	  String message = "Mot de passe imcompatible";
      request.setAttribute("message", message);
      RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateMotdePasseForm.jsp");
      dispatcher.forward(request, response);
	  
  }
  
  
  
  
  %>
  
  
  
  <%!
    public String hashPassword(String password) {
      try {
          MessageDigest md = MessageDigest.getInstance("SHA-256");
          byte[] hashedBytes = md.digest(password.getBytes());
          return Base64.getEncoder().encodeToString(hashedBytes);
      } catch (NoSuchAlgorithmException e) {
          // Gérer l'exception NoSuchAlgorithmException
          e.printStackTrace();
          return null;
      }
  }
  
  
  
  %>
</body>
</html>