package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.License;

public class LicenseDAO extends ConnexionDao{
	
	public LicenseDAO() {
        super();
    }
	
	public License getLicenseByDepartementAndRegionAndCommuneAndFederation(String codeDepartement,String nomCommune,String nomRegion,String nomFederation) {
    		Connection con = null;
		    PreparedStatement ps = null;
		    ResultSet rs = null;
		    License license = null;

		    try {
		        con = DriverManager.getConnection(URL, LOGIN, PASS);
		        String query = "SELECT * FROM licence WHERE Departement=? AND Commune=? AND Region=? AND Federation=?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, codeDepartement);
		        ps.setString(2, nomCommune);
		        ps.setString(3, nomRegion);
		        ps.setString(4, nomFederation);
		        
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            license = new License(
		                rs.getString("Code_Commune"),
		                rs.getString("Commune"),
		                rs.getString("Departement"),
		                rs.getString("Region"),
		                rs.getString("Code"),
		                rs.getString("Federation"),
		                rs.getInt("F_1_4_ans"),
		                rs.getInt("F_5_9_ans"),
		                rs.getInt("F_10_14_ans"),
		                rs.getInt("F_15_19_ans"),
		                rs.getInt("F_20_24_ans"),
		                rs.getInt("F_25_29_ans"),
		                rs.getInt("F_30_34_ans"),
		                rs.getInt("F_35_39_ans"),
		                rs.getInt("F_40_44_ans"),
		                rs.getInt("F_45_49_ans"),
		                rs.getInt("F_50_54_ans"),
		                rs.getInt("F_55_59_ans"),
		                rs.getInt("F_60_64_ans"),
		                rs.getInt("F_65_69_ans"),
		                rs.getInt("F_70_74_ans"),
		                rs.getInt("F_75_79_ans"),
		                rs.getInt("F_80_99_ans"),
		                rs.getInt("H_1_4_ans"),
		                rs.getInt("H_5_9_ans"),
		                rs.getInt("H_10_14_ans"),
		                rs.getInt("H_15_19_ans"),
		                rs.getInt("H_20_24_ans"),
		                rs.getInt("H_25_29_ans"),
		                rs.getInt("H_30_34_ans"),
		                rs.getInt("H_35_39_ans"),
		                rs.getInt("H_40_44_ans"),
		                rs.getInt("H_45_49_ans"),	                
		                rs.getInt("H_50_54_ans"),
		                rs.getInt("H_55_59_ans"),
		                rs.getInt("H_60_64_ans"),
		                rs.getInt("H_65_69_ans"),
		                rs.getInt("H_70_74_ans"),
		                rs.getInt("H_75_79_ans"),
		                rs.getInt("H_80_99_ans"),
		                rs.getInt("Total")		                
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
		    return license;
	}
}
