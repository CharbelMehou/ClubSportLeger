package dao;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Commune;
import model.Federation;
import dao.CommuneDAO;

public class FederationDAO extends ConnexionDao {
	
	       
	 public FederationDAO() {
	        super();
	    }
	 /**
	  * Pour recuperer une liste de federation sans filtre mais classer par ordre alphabétique 
	  * Cela incluant une pagination coté serveur
	  * @return ArrayList<Federation>
	  */
	 public ArrayList<Federation> getFederationsSortedByRegion(int page, int pageSize) {
		    ArrayList<Federation> federations = new ArrayList<>();
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    int offset = (page - 1) * pageSize;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT * FROM federation ORDER BY NomRegion ASC LIMIT ? OFFSET ?";
		        ps = con.prepareStatement(query);
		        ps.setInt(1, pageSize);
		        ps.setInt(2, offset);
		        rs = ps.executeQuery();

		        CommuneDAO communeDao = new CommuneDAO();
		        while (rs.next()) {
		            Commune commune = communeDao.getCommuneByCommuneCode(rs.getInt("CodeCommune"));
		            Federation federation = new Federation(
		                rs.getInt("CodeFederation"),
		                rs.getString("LibelleFederation"),
		                rs.getString("NomDepartement"),
		                rs.getString("NomRegion"),
		                rs.getInt("CodeCommune"),
		                commune.getNomCommune()
		            );
		            federations.add(federation);
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
		        close(con, ps, rs);
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
	 public ArrayList<Federation> getListFederation(String libelleFederation, String nomDepartement, String nomRegion, String nomCommune, int page, int pageSize) {
		    ArrayList<Federation> federations = new ArrayList<>();
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    CommuneDAO communeDao = new CommuneDAO();
		    Commune commune = null;
		    int offset = (page - 1) * pageSize;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM federation WHERE ");
		        ArrayList<String> conditions = new ArrayList<>();
		        ArrayList<Object> parameters = new ArrayList<>();

		        if (libelleFederation != null && !libelleFederation.isEmpty()) {
		            conditions.add("LibelleFederation LIKE ?");
		            parameters.add("%" + libelleFederation + "%");
		        }
		        if (nomDepartement != null && !nomDepartement.isEmpty()) {
		            conditions.add("NomDepartement LIKE ?");
		            parameters.add("%" + nomDepartement + "%");
		        }
		        if (nomRegion != null && !nomRegion.isEmpty()) {
		            conditions.add("NomRegion LIKE ?");
		            parameters.add("%" + nomRegion + "%");
		        }
		        if (nomCommune != null && !nomCommune.isEmpty()) {
		            conditions.add("CodeCommune IN (SELECT CodeCommune FROM commune WHERE NomCommune LIKE ?)");
		            parameters.add("%" + nomCommune + "%");
		        }

		        queryBuilder.append(String.join(" AND ", conditions));
		        queryBuilder.append(" ORDER BY NomRegion ASC LIMIT ? OFFSET ?");
		        ps = con.prepareStatement(queryBuilder.toString());

		        int index = 1;
		        for (Object param : parameters) {
		            ps.setObject(index++, param);
		        }
		        ps.setInt(index++, pageSize);
		        ps.setInt(index, offset);

		        rs = ps.executeQuery();

		        while (rs.next()) {
		            commune = communeDao.getCommuneByCommuneCode(rs.getInt("CodeCommune"));
		            Federation federation = new Federation(
		                rs.getInt("CodeFederation"),
		                rs.getString("LibelleFederation"),
		                rs.getString("NomDepartement"),
		                rs.getString("NomRegion"),
		                rs.getInt("CodeCommune"),
		                commune.getNomCommune()
		            );
		            federations.add(federation);
		        }
		    } catch (SQLException ee) {
		        ee.printStackTrace();
		    } finally {
		        close(con, ps, rs);
		    }
		    return federations;
		}

		private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		    try {
		        if (rs != null) rs.close();
		        if (ps != null) ps.close();
		        if (con != null) con.close();
		    } catch (SQLException ex) {
		        ex.printStackTrace();
		    }
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
		    CommuneDAO communeDao=new CommuneDAO();
	        Commune commune =null;
	        
		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT * FROM federation WHERE LibelleFederation = ?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, libelleFederation);
		        rs = ps.executeQuery();

		        if (rs.next()) {
	            	commune=communeDao.getCommuneByCommuneCode(rs.getInt("CodeCommune")); 
		            federation = new Federation(
		                rs.getInt("CodeFederation"),
		                rs.getString("LibelleFederation"),
		                rs.getString("NomDepartement"),
		                rs.getString("NomRegion"),
		                rs.getInt("CodeCommune"),
		                commune.getNomCommune()
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

}
