package dao;
 
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
 
import model.CodeCoordonnees;
import model.Publications;
import model.Utilisateurs;
 
/**
* 
*/
public class PublicationsDAO extends ConnexionDao {
 
	/**
	 *    
	 * @param titre
	 * @param contenu
	 * @param photo
	 * @param utilisateurId
	 * @return
	 */
	public int add(String titre, String contenu, byte[] photo, int utilisateurId) {
		String userInsertSQL = "INSERT INTO publications (titre, contenu, photo, utilisateurNom) VALUES (?, ?, ?, ?)";
 
		try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
				PreparedStatement userStmt = con.prepareStatement(userInsertSQL)) {
 
			// Insertion de la publication
			userStmt.setString(1, titre);
			userStmt.setString(2, contenu);
			userStmt.setBytes(3, photo);
			userStmt.setInt(4, utilisateurId);
			int rowsAffected = userStmt.executeUpdate();
 
			if (rowsAffected > 0) {
				System.out.println("Publication ajoutée avec succès !");
				return rowsAffected;
			} else {
				System.out.println("Erreur lors de l'ajout de la publication !");
				return 0;
			}
		} catch (SQLException ee) {
			ee.printStackTrace();
			return 0;
		}
	}
 
 
	/**
	 * 
	 * @return
	 */
	public ArrayList<Publications> getPublications() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Publications> returnValue = new ArrayList<Publications>();
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
 
			ps = con.prepareStatement("SELECT * FROM publications");
			// Exécution de la requête et traitement des résultats
			rs = ps.executeQuery();
			while (rs.next()) {
				// Création d'un objet CodeCoordonnees à partir des données de la base de données
				returnValue.add(new Publications(rs.getString("titre"),rs.getString("contenu"),rs.getBytes("photo"),rs.getInt("utilisateurNom")));
			}
		} catch (Exception ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ignore) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignore) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignore) {
			}
		}
		// Retourne la liste de codes de coordonnées obtenue
		return returnValue;
	}
 
 
	/**
	 * 
	 * @param id
	 * @return
	 */
	public ArrayList<Publications> getPublications(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Publications> returnValue = new ArrayList<Publications>();
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour récupérer les publications de l'utilisateur en fonction de son ID
			String query = "SELECT * FROM publications WHERE utilisateurNom = ?";
			ps = con.prepareStatement(query);
			ps.setInt(1, id);
			// Exécution de la requête et traitement des résultats
			rs = ps.executeQuery();
			while (rs.next()) {
				// Création d'un objet Publications à partir des données de la base de données
				returnValue.add(new Publications(
						rs.getString("titre"),
						rs.getString("contenu"),
						rs.getBytes("photo"),
						rs.getInt("utilisateurNom")
						));
			}
		} catch (Exception ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ignore) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignore) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignore) {
			}
		}
		// Retourne la liste de publications de l'utilisateur
		return returnValue;
	}
 
 
	/**
	 * Supprime les publications de l'utilisateur avec l'ID spécifié.
	 * @param id L'ID de l'utilisateur dont les publications doivent être supprimées.
	 */
	public void deletePublications(String id) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour supprimer les publications de l'utilisateur en fonction de son ID
			String query = "DELETE FROM publications WHERE titre = ?";
			ps = con.prepareStatement(query);
			ps.setString(1, id);
			// Exécution de la requête
			ps.executeUpdate();
		} catch (Exception ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignore) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignore) {
			}
		}
	}
 
 
	/**
	 * Met à jour une publication dans la base de données.
	 * 
	 * @param id l'identifiant de la publication à mettre à jour
	 * @param titre le nouveau titre de la publication
	 * @param contenu le nouveau contenu de la publication
	 * @param photo la nouvelle photo de la publication
	 * @return true si la mise à jour a réussi, false sinon
	 */
	public boolean updatePublication(int id, String titre, String contenu, byte[] photo) {
		Connection con = null;
		PreparedStatement ps = null;
		boolean success = false;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour mettre à jour la publication
			String query = "UPDATE publications SET titre = ?, contenu = ?, photo = ? WHERE id = ?";
			ps = con.prepareStatement(query);
			// Paramètres de la requête
			ps.setString(1, titre);
			ps.setString(2, contenu);
			ps.setBytes(3, photo);
			ps.setInt(4, id);
			// Exécution de la requête
			int rowsAffected = ps.executeUpdate();
			// Vérification du succès de la mise à jour
			if (rowsAffected > 0) {
				success = true;
			}
		} catch (Exception ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignore) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignore) {
			}
		}
		return success;
	}

	/**
	 * 
	 * @param id
	 * @return
	 */
	public int  getIdPublications(int id,String titre) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int returnValue =0;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour récupérer les publications de l'utilisateur en fonction de son ID
			String query = "SELECT id FROM publications WHERE utilisateurNom = ? AND titre= ?";
			ps = con.prepareStatement(query);
			ps.setInt(1, id);
			ps.setString(2, titre);
			// Exécution de la requête et traitement des résultats
			rs = ps.executeQuery();
			while (rs.next()) {
				// Création d'un objet Publications à partir des données de la base de données
				returnValue =rs.getInt("id");
			}
		} catch (Exception ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ignore) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignore) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignore) {
			}
		}
		// Retourne la liste de publications de l'utilisateur
		return returnValue;
	}
 
	/**
	 * Méthode permettant de récupérer un utilisateur à partir de son email et de son mot de passe
	 * 
	 * @param email l'email de l'utilisateur
	 * @param password le mot de passe de l'utilisateur
	 * @return l'objet Utilisateur correspondant aux informations fournies;
	 *         null si aucun utilisateur ne correspond aux informations fournies
	 */
	public Utilisateurs getUtilisateur(String titre, String contenu) {
		Utilisateurs utilisateur = null;
		Connection con = null;
		PreparedStatement ps = null;
		PreparedStatement logStmt = null;
		ResultSet rs = null;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			ps = con.prepareStatement("SELECT * FROM utilisateur WHERE id=(SELECT utilisateurNom FROM publications WHERE titre=? AND contenu=?)");
			ps.setString(1, titre);
			ps.setString(2, contenu);
			rs = ps.executeQuery();
			// Si un utilisateur correspondant est trouvé
			if (rs.next()) {
				String nom = rs.getString("nom");
				String prenom = rs.getString("prenom");
				String email = rs.getString("email");
				String password = rs.getString("motdepasse");
				String federation = rs.getString("federation");
				String club = rs.getString("club");
				String statut = rs.getString("statut");
				int role = rs.getInt("role");
				utilisateur = new Utilisateurs(nom, prenom, email, password,federation,club,statut,role);
			}
		} catch (SQLException ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (logStmt != null) logStmt.close();
				if (con != null) con.close();
			} catch (SQLException ignore) {
				ignore.printStackTrace();
			}
		}
		// Retourne l'utilisateur trouvé ou null s'il n'y en a pas
		return utilisateur;
	}
 
 
}
