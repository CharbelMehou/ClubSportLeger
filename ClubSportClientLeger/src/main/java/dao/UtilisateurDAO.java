package dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Utilisateur;


public class UtilisateurDAO extends ConnexionDao {
	
	       
	 public UtilisateurDAO() {
	        super();
	    }
	    
	 /**
	     * Méthode permettant de récupérer un utilisateur à partir de son email et de son mot de passe
	     * 
	     * @param email l'email de l'utilisateur
	     * @param password le mot de passe de l'utilisateur
	     * @return l'objet Utilisateur correspondant aux informations fournies;
	     *         null si aucun utilisateur ne correspond aux informations fournies
	     */
	    public Utilisateur getUtilisateur(String email, String password) {
	        Utilisateur utilisateur = null;
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            ps = con.prepareStatement("SELECT * FROM utilisateur WHERE email = ? AND motdepasse = ?");
	            ps.setString(1, email);
	            ps.setString(2, password);
	            rs = ps.executeQuery();
	            // Si un utilisateur correspondant est trouvé, on crée un objet Utilisateur avec ses informations
	            if (rs.next()) {
	                String nom = rs.getString("nom");
	                String prenom = rs.getString("prenom");
	                int role = rs.getInt("role");
	                utilisateur = new Utilisateur(nom, prenom, email, password, role);
	                // Ajouter d'autres attributs de l'utilisateur si nécessaire
	            }
	        } catch (SQLException ee) {
	            // Gestion des exceptions
	            ee.printStackTrace();
	        } finally {
	            // Fermeture des ressources
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (ps != null) {
	                    ps.close();
	                }
	                if (con != null) {
	                    con.close();
	                }
	            } catch (SQLException ignore) {
	                ignore.printStackTrace();
	            }
	        }
	        // Retourne l'utilisateur trouvé ou null s'il n'y en a pas
	        return utilisateur;
	    }
	    /**
	     * Méthode permettant d'ajouter un nouvel utilisateur à la base de données
	     * 
	     * @param nom le nom de l'utilisateur
	     * @param prenom le prénom de l'utilisateur
	     * @param email l'email de l'utilisateur
	     * @param password le mot de passe de l'utilisateur
	     * @return 0 si l'ajout a échoué;
	     *         une autre valeur si l'ajout a réussi (par exemple, le nombre de lignes affectées)
	     */
	    public int add(String nom, String prenom, String email, String password) {
	        Connection con = null;
	        PreparedStatement ps = null;
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            ps = con.prepareStatement("INSERT INTO utilisateur (nom, prenom, email, motdepasse, role) VALUES (?, ?, ?, ?, 1)");
	            ps.setString(1, nom);
	            ps.setString(2, prenom);
	            ps.setString(3, email);
	            ps.setString(4, password);
	            // Exécution de la requête d'insertion
	            int rowsAffected = ps.executeUpdate();
	            // Affichage d'un message en cas de succès ou d'échec de l'opération
	            if (rowsAffected > 0) {
	                System.out.println("Utilisateur ajouté avec succès !");
	            } else {
	                System.out.println("Erreur lors de l'ajout de l'utilisateur !");
	            }
	        } catch (SQLException ee) {
	            // Gestion des exceptions
	            ee.printStackTrace();
	        } finally {
	            // Fermeture des ressources
	            try {
	                if (ps != null) {
	                    ps.close();
	                }
	                if (con != null) {
	                    con.close();
	                }
	            } catch (SQLException ignore) {
	                ignore.printStackTrace();
	            }
	        }
	        // Retourne un code indiquant le succès ou l'échec de l'opération
	        return 0;
	    }
	    /**
	     * Méthode permettant de vérifier si un utilisateur existe déjà dans la base de données à partir de son email
	     * 
	     * @param email l'email de l'utilisateur à vérifier
	     * @return true si l'utilisateur existe déjà dans la base de données;
	     *         false sinon
	     */
	    public boolean utilisateurExists(String email) {
	        boolean exists = false;
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            ps = con.prepareStatement("SELECT COUNT(*) FROM utilisateur WHERE email = ?");
	            ps.setString(1, email);
	            rs = ps.executeQuery();
	            // Vérification du nombre de résultats retournés par la requête
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                if (count > 0) {
	                    exists = true;
	                }
	            }
	        } catch (SQLException ee) {
	            // Gestion des exceptions
	            ee.printStackTrace();
	        } finally {
	            // Fermeture des ressources
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (ps != null) {
	                    ps.close();
	                }
	                if (con != null) {
	                    con.close();
	                }
	            } catch (SQLException ignore) {
	                ignore.printStackTrace();
	            }
	        }
	        // Retourne un booléen indiquant si l'utilisateur existe déjà dans la base de données
	        return exists;
	    }
}
