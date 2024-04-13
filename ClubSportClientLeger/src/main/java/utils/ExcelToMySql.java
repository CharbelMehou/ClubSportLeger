//package utils;
//import java.io.File;
//import java.sql.*;
//import java.util.List;
//
//public class ExcelToMySql {
//    
//    final static String host = "localhost";
//    final static String nomBase = "projes8";   
//    final static String login = "root";   
//    final static String motDePasse = "root";
//    final static String separateur = ";";
//    final static String nomTable = "federation";
//    
//    public static void main(String[] args) {
//        Connection con = null;           
//        PreparedStatement stmt = null;
//        PreparedStatement stmtSelect = null;
//        ResultSet rs = null;
//        DepartementManager manager = new DepartementManager();
//        String nomDepartement = "";
//        
//        
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e2) {
//
//            System.err.println("pilote mysql non trouvé : com.mysql.cj.jdbc.Driver");
//            System.exit(-1);
//        }
//
//        try {
//            // Connexion avec choix de l'encodage
//            con = DriverManager.getConnection("jdbc:mysql://" + host + "/" + nomBase + "?characterEncoding=UTF-8",
//                    login, motDePasse);
//
//            List<String[]> lines = CSVReader.readCSV("src/main/java/utils/CSV/clubs-data2-2021.csv");
//            int i =0;
//            for (String[] line : lines) {
//                
//                // Requête pour récupérer idCommune
//                String selectQuery = "SELECT idCommune FROM Commune WHERE NomCommune = ?";
//                stmtSelect = con.prepareStatement(selectQuery);
//                stmtSelect.setString(1, line[1]); // Assumer que line[1] contient le NomCommune
//                rs = stmtSelect.executeQuery();
//
//                if (rs.next()) {
//                    int idCommune = rs.getInt("idCommune");
//
//                    // Préparation de la requête d'insertion
//                    String requete = "INSERT INTO " + nomTable + " (CodeFederation, LibelleFederation, NomDepartement, NomRegion, CodeCommune, idCommune) VALUES (?, ?, ?, ?, ?, ?)";
//                    stmt = con.prepareStatement(requete);
//                    
//                    stmt.setString(1, line[7]); // CodeFederation
//                    stmt.setString(2, line[8]); // LibelleFederation
//                    stmt.setString(3, manager.getDepartementName(line[4])); // NomDepartement
//                    stmt.setString(4, line[5]); // NomRegion
//                    stmt.setString(5, line[0]); // CodeCommune
//                    stmt.setInt(6, idCommune); // idCommune, récupéré de la requête précédente
//                    
//                    // Exécution de la requête
//                    stmt.executeUpdate();
//                } else {
//                    System.out.println("Aucune commune correspondante trouvée pour : " + line[8]);
//                }
//                i++; 
//             }
//            
//        } catch (Exception e) {
//            
//            e.printStackTrace();
//        } finally {
//            try {
//                if (rs != null) rs.close();
//                if (stmt != null) stmt.close();
//                if (stmtSelect != null) stmtSelect.close();
//                if (con != null) con.close();
//            } catch (SQLException se) {
//                se.printStackTrace();
//            }
//        }
//    }
//}
