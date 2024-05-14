<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Base64"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.util.Random"%>
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	UtilisateurDAO db = new UtilisateurDAO();
	String email = request.getParameter("email");
	int code = generateVerificationCode();
	session = request.getSession();
	session.setAttribute("Code", code);
	session.setAttribute("email", email);
	String subject = "Code de vérification";
	String message = "Votre code de vérification est : " + code;
	if (db.utilisateurExist(email)) {
		sendEmail(email, subject, message);
		response.sendRedirect("VerificationCodeForm.jsp");
	} else {
		String sms = "ce mail n'est pas inscrit";
		// Ajoutez d'abord le message à la requête
		request.setAttribute("message", sms);
		// Puis effectuez la redirection vers la page de formulaire de connexion
		RequestDispatcher dispatcher = request.getRequestDispatcher("EmailForm.jsp");
		dispatcher.forward(request, response);
	}
	%>
 
	<%!private int generateVerificationCode() {
		Random random = new Random();
		return 1000 + random.nextInt(9000);
	}%>
	<%!private void sendEmail(String email, String subject, String message) {
	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp-mail.outlook.com");
	props.put("mail.smtp.port", "587");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.auth", "true");
 
	Session session = Session.getInstance(props, new Authenticator() {
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("clovis.neya@groupe-esigelec.org", "Viscloney@11082002");
		}
	});
 
	try {
		MimeMessage mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress("clovis.neya@groupe-esigelec.org"));
		mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
		mimeMessage.setSubject(subject);
		mimeMessage.setText(message);
 
		Transport.send(mimeMessage);
 
		System.out.println("E-mail envoyé avec succès !");
	} catch (MessagingException e) {
		e.printStackTrace();
	}
}%>
</body>
</html>