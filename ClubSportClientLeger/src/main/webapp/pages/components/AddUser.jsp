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
	String motdepasse = request.getParameter("password");
	String federation = request.getParameter("federation");
	String club = request.getParameter("club");
	String statut = request.getParameter("statut");
 
	// Fonction pour hasher le mot de passe
	String hashedPass = hashPassword(motdepasse);
 
	UtilisateurDAO db = new UtilisateurDAO();
 
	if (nom == null || prenom == null || email == null || motdepasse == null || nom.isEmpty() || prenom.isEmpty()
			|| email.isEmpty() || motdepasse.isEmpty()) {
		String message = "Veuillez remplir toutes les informations";
		request.setAttribute("message", message);
		response.sendRedirect("AddUserForm.jsp");
	} else {
		if (db.utilisateurExists(email)) {
			String message = "L'utilisateur exite déjà";
			request.setAttribute("message", message);
			request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
		} else {
			if(validatePassword(motdepasse)){			
			if (db.adds(nom, prenom, email, hashedPass,federation,club,statut) == 0) {
				String message = "Votre demande d'inscription à été prise en compte";
				String messageStatus="good";
				String messages="Merci pour votre inscription sur notre site.Vous recevrez un autre mail de comfirmation d'ici 2 semaines.Bien cordialement";
				request.setAttribute("message", message);
				request.setAttribute("messageStatus", messageStatus);
				String subject = "Inscription sur le site du groupe 3";
				sendEmail(email,subject,messages);
				request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
			}
			} else {
				String message = "Le mot de passe ne respecte pas les instructions";
				String messageStatus="bad";
				request.setAttribute("message", message);
				request.setAttribute("messageStatus", messageStatus);
				request.getRequestDispatcher("AddUserForm.jsp").forward(request, response);
			}
		}
	}
	// TODO Auto-generated method stub
 
    %>
 
	<%!
        public String hashPassword(String password1) {
            try {
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hashedBytes = md.digest(password1.getBytes());
                return Base64.getEncoder().encodeToString(hashedBytes);
            } catch (NoSuchAlgorithmException e) {
                // Gérer l'exception NoSuchAlgorithmException
                e.printStackTrace();
                return null;
            }
        }
   		boolean validatePassword(String password) {
        // Vérification de la longueur (minimum 12 caractères)
        if (password.length() < 12) {
            return false;
        } 
        // Vérification de la présence d'au moins une majuscule et une minuscule
        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            }
        }
        if (!hasUpperCase || !hasLowerCase) {
            return false;
        }
        
        // Vérification de la présence de chiffres
        boolean hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) {
                hasDigit = true;
                break;
            }
        }
        if (!hasDigit) {
            return false;
        }
        
        // Vérification de la présence de caractères spéciaux
        String specialCharacters = "!@#$%^&*()-+=`~[]{}|;:',.<>/?";
        boolean hasSpecialCharacter = false;
        for (char c : password.toCharArray()) {
            if (specialCharacters.contains(String.valueOf(c))) {
                hasSpecialCharacter = true;
                break;
            }
        }
        if (!hasSpecialCharacter) {
            return false;
        }
        
        return true;
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