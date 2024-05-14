<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.ArrayList, model.Publications, dao.PublicationsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Afficher les publications</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="../style.css">
<style>
 
    #background-video {
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
        width: 100%;
        height: auto;
        z-index: -1; /* Assurez-vous que la vidéo reste en arrière-plan */
    }
 
    .content {
        padding: 20px; /* Ajoutez de l'espace pour éviter que le contenu ne soit caché par la vidéo */
        color: white; /* Changez la couleur du texte pour qu'elle soit visible sur la vidéo */
    }
    
    </style>
</head>
<body>
	<video autoplay muted loop id="background-video">
		<source src="../../images/video.mp4" type="video/mp4">
		<!-- Chemin de votre vidéo -->
	</video>
	<jsp:include page="Header.jsp" />
 
	<!-- Overlay -->
	<div class="container mt-4">
	<div class="row">
	<div id="overlay" class="overlay">
		<div class="overlay-content">
			<form action="#">
				<h1>De qui s'agit-il ?</h1>
				<label for="nom">Nom</label> <input type="text" class="form-control"
					id="nom" name="nom" readonly> <br> <br>
				<div class="form-group">
					<label for="nom">Prenom</label> <input type="text"
						class="form-control" id="prenom" name="prenom" readonly>
				</div>
				<br> <br>
				<div class="form-group">
					<label for="nom">Fédération</label> <input type="text"
						class="form-control" id="federation" name="federation" readonly>
				</div>
				<br> <br>
				<div class="form-group">
					<label for="nom">Club</label> <input type="text"
						class="form-control" id="club" name="club" readonly>
				</div>
				<br> <br>
				<div class="form-group">
					<label for="nom">Statut</label> <input type="text"
						class="form-control" id="statut" name="statut" readonly>
				</div>
				<br> <br>
			</form>
		</div>
	</div>
</div>
</div>
	<div class="container mt-4">
		<div class="row">
			<%
            // Récupérer les publications depuis la base de données
            PublicationsDAO publicationsDAO = new PublicationsDAO();
            ArrayList<Publications> publications = publicationsDAO.getPublications();
       
            // Parcourir les publications et les afficher
            for (Publications publication : publications) {
            %>
			<div class="container">
				<div class="row">
					<div class="col-md-8 mx-auto">
						<div class="card mb-3">
							<div class="card-header d-flex align-items-center bg-white">
								<button type="submit" id="avatar-btn" aria-haspopup="true"
									onclick="toggleOverlay(this)"
									class="style-scope ytd-topbar-menu-button-renderer btn btn-light"
									aria-label="Menu du compte"
									data-prenom="<%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getPrenom()%>"
									data-nom="<%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getNom()%>"
									data-federation="<%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getFederation()%>"
									data-club="<%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getClubs()%>"
									data-statut="<%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getStatut()%>">
									<yt-img-shadow height="32" width="32"
										class="style-scope ytd-topbar-menu-button-renderer no-transition"
										loaded="" style="background-color: transparent;">
									<img id="img" draggable="false"
										class="style-scope yt-img-shadow rounded-circle"
										alt="Image d'avatar" height="32" width="32"
										src="../../images/photo.jpg"> </yt-img-shadow>
								</button>
								<h5 class="card-title ml-3 mb-0"><%= publicationsDAO.getUtilisateur(publication.getTitre(), publication.getPublication()).getNom()%></h5>
							</div>
 
							<div class="card-body">
								<h5 class="card-title"><%= publication.getTitre()%></h5>
								<p class="card-text"><%= publication.getPublication()%></p>
								<img
									src="data:image/jpeg;base64,<%= org.apache.tomcat.util.codec.binary.Base64.encodeBase64String(publication.getImage())%>"
									class="card-img-top" alt="<%= publication.getTitre()%>">
							</div>
							<!-- Éléments d'interaction en bas -->
							<div class="card-footer bg-white">
								<button type="button" class="btn btn-outline-primary">
									<i class="bi bi-hand-thumbs-up"></i> Like
								</button>
								<button type="button" class="btn btn-outline-secondary">
									<i class="bi bi-hand-thumbs-down"></i> Unlike
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
 
			<%
                }
            %>
		</div>
	</div>
	<script>
        function toggleOverlay(button) {
            var overlay = document.getElementById("overlay");
            var nomInput = document.getElementById("nom");
            var nom = button.getAttribute("data-nom");
            var prenomInput = document.getElementById("prenom");
            var prenom = button.getAttribute("data-prenom");
            var federationInput = document.getElementById("federation");
            var federation = button.getAttribute("data-federation");
            var clubInput = document.getElementById("club");
            var club = button.getAttribute("data-club");
            var statutInput = document.getElementById("statut");
            var statut = button.getAttribute("data-statut");
            
 
            if (overlay.style.left === "-100%") {
                overlay.style.display = "block";
                overlay.style.left = "0";
                nomInput.value = nom; // Mettre à jour la valeur de l'input avec le nom
                prenomInput.value=prenom
                federationInput.value=federation
                clubInput.value=club
                statutInput.value=statut
            } else {
                overlay.style.left = "-100%";
                setTimeout(function () {
                    overlay.style.display = "none";
                    nomInput.value = ""; // Réinitialiser la valeur de l'input lors de la fermeture de l'overlay
                    prenomInput.value="";
                    federationInput.value="";
                    clubInput.value="";
                    statutInput.value="";
                }, 500); // Délai correspondant à la transition
            }
        }
    </script>
</body>
</html>