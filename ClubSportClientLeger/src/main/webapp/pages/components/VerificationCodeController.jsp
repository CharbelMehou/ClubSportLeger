<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
   session=request.getSession();
   int code1= Integer.parseInt(request.getParameter("text1"));
   int code2= Integer.parseInt(request.getParameter("text2"));
   int code3= Integer.parseInt(request.getParameter("text3"));
   int code4= Integer.parseInt(request.getParameter("text4"));
   int code=code1*1000 +code2*100 +code3*10+code4;
   int codes=(Integer)session.getAttribute("Code");
   if(code==codes){
	   response.sendRedirect("UpdateMotDePasseForm.jsp");
   }
   else{
	   String message = "Veuillez fournir votre adresse e-mail et votre mot de passe";
       request.setAttribute("message", message);
       RequestDispatcher dispatcher = request.getRequestDispatcher("VerificationCodeForm.jsp");
       dispatcher.forward(request, response);
   }
   
%>
</body>
</html>