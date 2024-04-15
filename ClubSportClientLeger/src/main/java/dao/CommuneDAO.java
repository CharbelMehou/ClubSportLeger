package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Commune;

public class CommuneDAO extends ConnexionDao {

	public CommuneDAO() {
        super();
    }
	
	 public Commune getCommuneByCommuneCode(int codeCommune) {
		    Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    Commune commune = null;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT * FROM commune WHERE CodeCommune = ?";
		        ps = con.prepareStatement(query);
		        ps.setInt(1, codeCommune);
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            commune = new Commune(
		                rs.getInt("CodeCommune"),
		                rs.getString("NomCommune"),
		                rs.getInt("CodePostal"),
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
		    return commune;
		}
	 
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
}
