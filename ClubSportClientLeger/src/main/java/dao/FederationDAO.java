package dao;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import model.Federation;


public class FederationDAO extends ConnexionDao {
	
	       
	 public FederationDAO() {
	        super();
	    }
	 /**
	  * Pour recuperer une liste de federation sans filtre mais classer par ordre alphabétique 
	  * Cela incluant une pagination coté serveur
	  * @return ArrayList<Federation>
	  */
	 
	 
	 public int countFederations() {
		    int count = 0;
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT COUNT(*) AS total FROM federation";
		        ps = con.prepareStatement(query);
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            count = rs.getInt("total");
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (ps != null) ps.close();
		            if (con != null) con.close();
		        } catch (SQLException ex) {
		            ex.printStackTrace();
		        }
		    }

		    return count;
		}
	 
	 /**
	  * Permet de récupérer tous les départements présents dans la table des fédération
	  * @return departements
	  */
	 public ArrayList<String> getAllDepartements() {
		 ArrayList<String> departements = new ArrayList<>();
		    try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
		         PreparedStatement ps = con.prepareStatement("SELECT DISTINCT NomDepartement FROM federation ORDER BY NomDepartement ASC");
		         ResultSet rs = ps.executeQuery()) {
		        while (rs.next()) {
		            departements.add(rs.getString("NomDepartement"));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return departements;
		}
	 /**
	  * Permet de récupérer toutes les régions présentes dans la table des fédérations
	  * @return regions
	  */
		public ArrayList<String> getAllRegions() {
			ArrayList<String> regions = new ArrayList<>();
		    try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
		         PreparedStatement ps = con.prepareStatement("SELECT DISTINCT NomRegion FROM federation ORDER BY NomRegion ASC");
		         ResultSet rs = ps.executeQuery()) {
		        while (rs.next()) {
		            regions.add(rs.getString("NomRegion"));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return regions;
		}
		/**
		  * Permet de récupérer toutes les communes présentes dans la table des fédérations
		  * @return communes
		  */
		public ArrayList<String> getAllCommunes() {
			ArrayList<String> communes = new ArrayList<>();
		    try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
		         PreparedStatement ps = con.prepareStatement("SELECT DISTINCT NomCommune FROM commune ORDER BY NomCommune ASC");
		         ResultSet rs = ps.executeQuery()) {
		        while (rs.next()) {
		            communes.add(rs.getString("NomCommune"));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return communes;
		}
		
		/**
	     * Méthode permettant d'obtenir une liste de clubs en fonction de la région et de la fédération
	     * @param nomRegion le nom de la région
	     * @param nomFederation le nom de la fédération
	     * @return une liste de clubs correspondant aux critères spécifiés
	     */
	    public ArrayList<Federation> getClubsLites(String nomRegion, String nomFederation,int page, int pageSize) {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<Federation> federations = new ArrayList<Federation>();
	        int offset = (page - 1) * pageSize;
	        try {
	            
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            if (!nomRegion.isEmpty()) {
	                ps = con.prepareStatement("SELECT * FROM federation WHERE Region = ? AND Federation = ? LIMIT ? OFFSET ?");
	                ps.setString(1, nomRegion);
	                ps.setString(2, nomFederation);
	                ps.setInt(3, pageSize);
			        ps.setInt(4, offset);
	            } else {
	                ps = con.prepareStatement("SELECT * FROM federation WHERE  Federation = ? LIMIT ? OFFSET ?");
	                ps.setString(1, nomFederation);
	                ps.setInt(2, pageSize);
			        ps.setInt(3, offset);
	            }
	            rs = ps.executeQuery();
	            while (rs.next()) {
	            	federations.add(new Federation(
	            			rs.getString("Code_Commune"),
	            			rs.getString("Commune"), 
	            			rs.getString("Departement"),
	            			rs.getString("Region"),
	            			rs.getString("Statut_geo"),
	            			rs.getString("code"),
	            			rs.getString("Federation"),
	            			rs.getInt("Clubs"),
	            			rs.getInt("EPA"),
	            			rs.getInt("Total"))
	            			);
	            		}
	           
	        } catch (Exception ee) {
	            ee.printStackTrace();
	        } finally {
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
	        return federations;
	    }
	    /**
	     * 
	     * @param CodePostal
	     * @param nomFederation
	     * @return
	     */
	    
	    public ArrayList<Federation> getClubsLitesByCodePostal(String CodePostal, String nomFederation,int page, int pageSize) {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<Federation> returnValue = new ArrayList<Federation>();
	        int offset = (page - 1) * pageSize;
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            // Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
	            if (!CodePostal.isEmpty()) {
	                ps = con.prepareStatement("SELECT * FROM federation WHERE Code_Commune IN (SELECT insee FROM commune WHERE codepostal =?)   AND Federation = ? LIMIT ? OFFSET ?");
	                ps.setString(1, CodePostal);
	                ps.setString(2, nomFederation);
	                ps.setInt(3, pageSize);
			        ps.setInt(4, offset);
	            } else {
	                ps = con.prepareStatement("SELECT * FROM federation WHERE  Federation = ? LIMIT ? OFFSET ?");
	                ps.setString(1, nomFederation);
	                ps.setInt(2, pageSize);
			        ps.setInt(3, offset);
	            }
	            // Exécution de la requête et traitement des résultats
	            rs = ps.executeQuery();
	            while (rs.next()) {
	                // Création d'un objet CodeCoordonnees à partir des données de la base de données
	            	 returnValue.add(new Federation(rs.getString("Code_Commune"),
	            			 rs.getString("Commune"),
	            			 rs.getString("Departement"),
	            			 rs.getString("Region"),
	            			 rs.getString("Statut_geo"),
	            			 rs.getString("code"),
	            			 rs.getString("Federation"),
	            			 rs.getInt("Clubs"),
	            			 rs.getInt("EPA"),
	            			 rs.getInt("Total")));            }
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
	    public ArrayList<String> getCommunes() {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<String> returnValue = new ArrayList<String>();
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            // Requête SQL pour récupérer les clubs en fonction de la région et de la fédération
	            
	                ps = con.prepareStatement("SELECT  DISTINCT  Region FROM federation ");
	                
	            // Exécution de la requête et traitement des résultats
	            rs = ps.executeQuery();
	            while (rs.next()) {
	                // Création d'un objet Club à partir des données de la base de données
	                returnValue.add(rs.getString("Region"));
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
	        // Retourne la liste de clubs obtenue
	        return returnValue;
	    }
	    public ArrayList<String> getFederations() {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<String> returnValue = new ArrayList<String>();
	        try {
	            // Connexion à la base de données
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            // Requête SQL pour récupérer les clubs en fonction de la région et de la fédération
	            
	                ps = con.prepareStatement("SELECT DISTINCT Federation FROM federation ");
	                
	            // Exécution de la requête et traitement des résultats
	            rs = ps.executeQuery();
	            while (rs.next()) {
	                // Création d'un objet Club à partir des données de la base de données
	                returnValue.add(rs.getString("Federation"));
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
	        // Retourne la liste de clubs obtenue
	        return returnValue;
	    }

}
