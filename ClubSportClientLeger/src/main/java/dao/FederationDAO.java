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
	  * @return ArrayList<Federation>
	  */
	 public ArrayList<Federation> getFederationsSortedByRegion() {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<Federation> federations = new ArrayList<>();

	        try {
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            String query = "SELECT * FROM federation ORDER BY NomRegion ASC";
	            ps = con.prepareStatement(query);
	            rs = ps.executeQuery();

	            while (rs.next()) {
	                Federation federation = new Federation(
	                    rs.getInt("CodeFederation"),
	                    rs.getString("LibelleFederation"),
	                    rs.getString("NomDepartement"),
	                    rs.getString("NomRegion")
	                );
	                federations.add(federation);
	            }
	        } catch (SQLException ee) {
	            ee.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (ps != null) ps.close();
	                if (con != null) con.close();
	            } catch (SQLException ignore) {
	                ignore.printStackTrace();
	            }
	        }
	        return federations;
	    }
	 
	    /**
	     * Pour recupérer une liste de federation en fonction des filtres 
	     * @param codeFederation
	     * @param libelleFederation
	     * @param nomDepartement
	     * @param nomRegion
	     * @param codeCommune
	     * @return ArrayList<Federation>
	     */
	 public ArrayList<Federation> getListFederation(int codeFederation, String libelleFederation, String nomDepartement, String nomRegion, int codeCommune) {
	        Connection con = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        ArrayList<Federation> federations = new ArrayList<>();

	        try {
	            con = DriverManager.getConnection(URL, LOGIN, PASS);
	            String query = "SELECT * FROM federation WHERE CodeFederation = ? OR LibelleFederation LIKE ? OR NomDepartement LIKE ? OR NomRegion LIKE ? OR CodeCommune = ?";
	            ps = con.prepareStatement(query);
	            ps.setInt(1, codeFederation);
	            ps.setString(2, "%" + libelleFederation + "%");
	            ps.setString(3, "%" + nomDepartement + "%");
	            ps.setString(4, "%" + nomRegion + "%");
	            ps.setInt(5, codeCommune);
	            rs = ps.executeQuery();

	            while (rs.next()) {
	                Federation federation = new Federation(
	                    rs.getInt("CodeFederation"),
	                    rs.getString("LibelleFederation"),
	                    rs.getString("NomDepartement"),
	                    rs.getString("NomRegion")
	                );
	                federations.add(federation);
	            }
	        } catch (SQLException ee) {
	            ee.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (ps != null) ps.close();
	                if (con != null) con.close();
	            } catch (SQLException ignore) {
	                ignore.printStackTrace();
	            }
	        }
	        return federations;
	    }
	 
	 /**
	  * Pour recupérerer une federation
	  * @param libelleFederation
	  * @return federation
	  */
	 public Federation getFederation(String libelleFederation) {
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    Federation federation = null;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT * FROM federation WHERE LibelleFederation = ?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, libelleFederation);
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            federation = new Federation(
		                rs.getInt("CodeFederation"),
		                rs.getString("LibelleFederation"),
		                rs.getString("NomDepartement"),
		                rs.getString("NomRegion")
		            );
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (ps != null) ps.close();
		            if (con != null) con.close();
		        } catch (SQLException ignore) {
		            ignore.printStackTrace();
		        }
		    }
		    return federation;
		}
}
