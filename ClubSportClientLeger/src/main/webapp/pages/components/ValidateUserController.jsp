<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UtilisateurDAO"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Base64"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajouter un utilisateur</title>
<body>
	<%
    String nom = request.getParameter("nom");
	String prenom = request.getParameter("prenom");
	String email = request.getParameter("email");
	String motdepasse = request.getParameter("motdepasse");
	String federation = request.getParameter("federation");
	String club = request.getParameter("club");
	String statut = request.getParameter("statut");
	UtilisateurDAO db = new UtilisateurDAO();
	if (db.utilisateurExist(email)) {
		String message = "L'utilisateur existait déjà";
		db.deleteUtilisateur(email,motdepasse);
		request.setAttribute("message", message);
		String messages="Merci pour votre inscription sur notre site.Mais malheusement votre demande n'a pas été validé.En effet ,il exite un compte avec votre email";
		String subject = "Invalidation de votre candidature";
		sendEmail(email,subject,messages);
		request.getRequestDispatcher("ListeUtilisateurs.jsp").forward(request, response);
	} else {
		db.ValidateUser(nom,prenom,email,motdepasse,federation,club,statut);
		db.deleteUtilisateur(email,motdepasse);
		String messages="Merci pour votre inscription sur notre site.Et félicitation votre demande a  été validé.";
		String subject = "Validation de votre candidature";
		sendEmail(email,subject,messages);
		response.sendRedirect("ListeUtilisateurs.jsp");
		}		
    %>
    
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
    } %>
</body>
</html>