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
	     * Permet de récupérer un utlisateur
	     * @param email
	     * @param password
	     * @return utilisateur
	     */
	 public Utilisateur getUtilisateur(String email, String password) {
		    Utilisateur utilisateur = null;
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    
		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        ps = con.prepareStatement("SELECT * FROM utilisateur WHERE Mail = ? AND Mdp = ?");
		        ps.setString(1, email);
		        ps.setString(2, password);
		        rs = ps.executeQuery();
		        
		        if (rs.next()) {
		        	int UtilisateurId=rs.getInt("UtilisateurId");
		            String Nom=rs.getString("Nom");
		            String Prenom =rs.getString("Prenom");
		            String Email=rs.getString("Mail");
		            String Password=rs.getString("Mdp");
		            int role=rs.getInt("Role");
		            
		            utilisateur = new Utilisateur(UtilisateurId,Nom,Prenom,Email,Password,role);
		            // Ajouter d'autres attributs de l'utilisateur si nécessaire
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
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
		    return utilisateur;
		}
    
	 /**
	  * Permet d'ajouter un utilsateur
	  * @param nom
	  * @param prenom
	  * @param email
	  * @param password
	  * @return 0
	  */
	 public int add(String nom, String prenom, String email, String password) {
		    Connection con = null;
		    PreparedStatement ps = null;
		    
		    try {
		    	con = DriverManager.getConnection(URL, LOGIN, PASS);
		    	ps = con.prepareStatement("INSERT INTO utilisateur (UtilisateurId, Mail, Mdp, Role, Nom, Prenom) VALUES (1, ?, ?, '1', ?, ?)");
		    	ps.setString(1, email);
		    	ps.setString(2, password);
		    	ps.setString(3, nom);
		    	ps.setString(4, prenom);
		        
		        int rowsAffected = ps.executeUpdate();
		        
		        if (rowsAffected > 0) {
		            System.out.println("Utilisateur ajouté avec succès !");
		        } else {
		            System.out.println("Erreur lors de l'ajout de l'utilisateur !");
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
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
		    return 0;
		}
	/**
	 * Pour verifier 
	 * @param email
	 * @return
	 */
	 public boolean utilisateurExists(String email) {
	        boolean exists = false;
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        
	        try {
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            ps = con.prepareStatement("SELECT COUNT(*) FROM utilisateur WHERE Mail = ?");
	            ps.setString(1, email);
	            rs = ps.executeQuery();
	            
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                if (count > 0) {
	                    exists = true;
	                }
	            }
	        } catch (SQLException ee) {
	            ee.printStackTrace();
	        } finally {
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
	        return exists;
	    }


}
