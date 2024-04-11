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
	     * Permet de récupérer l'INSEE d'une commune à partir de son code postal
	     * 
	     * @param codepostal le code postal de la commune à récupérer
	     * @return l'INSEE de la commune trouvée;
	     *         null si aucune commune ne correspond à ce code postal 
	     */
	 public Utilisateur getUtilisateur(String email, String password) {
		    Utilisateur utilisateur = null;
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    
		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        ps = con.prepareStatement("SELECT * FROM utilisateur WHERE email = ? AND motdepasse = ?");
		        ps.setString(1, email);
		        ps.setString(2, password);
		        rs = ps.executeQuery();
		        
		        if (rs.next()) {
		            String Nom=rs.getString("nom");
		            String Prenom =rs.getString("prenom");
		            String Email=rs.getString("email");
		            String Password=rs.getString("motdepasse");
		            int role=rs.getInt("role");
		            
		            utilisateur = new Utilisateur(Nom,Prenom,Email,Password,role);
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
    
	 
	 public int add(String nom, String prenom, String email, String password) {
		    Connection con = null;
		    PreparedStatement ps = null;
		    
		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        ps = con.prepareStatement("INSERT INTO utilisateur (nom, prenom, email, motdepasse,role) VALUES (?, ?, ?, ?,1)");
		        ps.setString(1, nom);
		        ps.setString(2, prenom);
		        ps.setString(3, email);
		        ps.setString(4, password);
		        
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
	
	 public boolean utilisateurExists(String email) {
	        boolean exists = false;
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        
	        try {
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            ps = con.prepareStatement("SELECT COUNT(*) FROM utilisateur WHERE email = ?");
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
