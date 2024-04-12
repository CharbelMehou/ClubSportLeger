package dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import model.Utilisateur;
import java.net.InetAddress;
import java.net.UnknownHostException;


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
		    PreparedStatement logPs = null; // Separate PreparedStatement for logging
		    ResultSet rs = null;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        ps = con.prepareStatement("SELECT * FROM utilisateur WHERE Mail = ? AND Mdp = ?");
		        ps.setString(1, email);
		        ps.setString(2, password);
		        rs = ps.executeQuery();
		        
		        // Get the IP address for logging
		        String ipAddress = "";
		        try {
		            InetAddress localhost = InetAddress.getLocalHost();
		            ipAddress = localhost.getHostAddress();
		            System.out.println("Adresse IP de la machine locale : " + ipAddress);
		        } catch (UnknownHostException e) {
		            e.printStackTrace();
		        }

		        LocalDateTime now = LocalDateTime.now();
		        Timestamp timestamp = Timestamp.valueOf(now);

		        // Prepare the log statement in advance
		        logPs = con.prepareStatement("INSERT INTO logs (IP, Mail, IsFailed, Date) VALUES (?, ?, ?, ?)");
		        logPs.setString(1, ipAddress);
		        logPs.setString(2, email);

		        if (rs.next()) {
		            int UtilisateurId = rs.getInt("UtilisateurId");
		            String Nom = rs.getString("Nom");
		            String Prenom = rs.getString("Prenom");
		            String Email = rs.getString("Mail");
		            String Password = rs.getString("Mdp");
		            int role = rs.getInt("Role");

		            utilisateur = new Utilisateur(UtilisateurId, Nom, Prenom, Email, Password, role);

		            // Log success
		            logPs.setBoolean(3, false);
		            logPs.setTimestamp(4, timestamp);
		            logPs.executeUpdate();
		        } else {
		            // Log failure
		            logPs.setBoolean(3, true);
		            logPs.setTimestamp(4, timestamp);
		            logPs.executeUpdate();
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (ps != null) ps.close();
		            if (logPs != null) logPs.close(); // Ensure logPs is also closed
		            if (con != null) con.close();
		        } catch (SQLException ignore) {
		            ignore.printStackTrace();
		        }
		    }
		    return utilisateur;
		}
    
	 
	 public int add(String nom, String prenom, String email, String password) {
		    Connection con = null;
		    PreparedStatement ps = null;
		    String role="1";
		    nom="essaie";
		    prenom="essaie";
		    email="esssiae@gmail.com";
		    password="password";
		    try {
		    	con = DriverManager.getConnection(URL, LOGIN, PASS);
		    	ps = con.prepareStatement("INSERT INTO utilisateur (Mail, Mdp, Role, Nom, Prenom) VALUES (?,?,?,?,?)");
		    	
		    	ps.setString(1, email);
		        ps.setString(2, password);
		        ps.setString(3, role);
		        ps.setString(4, nom);
		        ps.setString(5, prenom);
		        
		        
		        int rowsAffected = ps.executeUpdate();
		        
		        if (rowsAffected > 0) {
		            System.out.println("Utilisateur ajouté avec succès !");
		        } else {
		            System.out.println("Erreur lors de l'ajout de l'utilisateur !");
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		        System.out.println("ps"+ps);
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
