package dao;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
 
import model.CodeCoordonnees;
 
// Classe représentant l'accès aux données pour les codes de coordonnées
public class CodeDAO extends ConnexionDao {
    // Constructeur par défaut
    public CodeDAO() {
        super();
    }
    /**
     * Méthode permettant d'obtenir une liste de codes de coordonnées en fonction de la région et de la fédération
     * @param nomRegion le nom de la région
     * @param nomFederation le nom de la fédération
     * @return une liste de codes de coordonnées correspondant aux critères spécifiés
     */
    public ArrayList<CodeCoordonnees> getClubsLites(String nomRegion, String nomFederation) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<CodeCoordonnees> returnValue = new ArrayList<CodeCoordonnees>();
        try {
            // Connexion à la base de données
            con = DriverManager.getConnection(URL, LOGIN, PASS);
            // Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
            if (!nomRegion.isEmpty()) {
                ps = con.prepareStatement("SELECT * FROM codecoordonnee WHERE Insee_code IN (SELECT Code_Commune FROM federation WHERE Region = ? AND Federation = ?)");
                ps.setString(1, nomRegion);
                ps.setString(2, nomFederation);
            } else {
                ps = con.prepareStatement("SELECT * FROM codecoordonnee WHERE Insee_code IN (SELECT Code_Commune FROM federation WHERE  Federation = ?)");
                ps.setString(1, nomFederation);
            }
            // Exécution de la requête et traitement des résultats
            rs = ps.executeQuery();
            while (rs.next()) {
                // Création d'un objet CodeCoordonnees à partir des données de la base de données
                returnValue.add(new CodeCoordonnees(rs.getString("Insee_code"), rs.getString("Zip_code"), rs.getDouble("Latitude"), rs.getDouble("Longitude")));
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
        // Retourne la liste de codes de coordonnées obtenue
        return returnValue;
    }

    public ArrayList<CodeCoordonnees> getClubsLitesFederation( String nomFederation) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<CodeCoordonnees> returnValue = new ArrayList<CodeCoordonnees>();
        try {
            // Connexion à la base de données
            con = DriverManager.getConnection(URL, LOGIN, PASS);
            // Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
                ps = con.prepareStatement("SELECT * FROM codecoordonnee WHERE Insee_code IN (SELECT Code_Commune FROM federation WHERE  Federation = ?)");
                ps.setString(1, nomFederation);
            // Exécution de la requête et traitement des résultats
            rs = ps.executeQuery();
            while (rs.next()) {
                // Création d'un objet CodeCoordonnees à partir des données de la base de données
                returnValue.add(new CodeCoordonnees(rs.getString("Insee_code"), rs.getString("Zip_code"), rs.getDouble("Latitude"), rs.getDouble("Longitude")));
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
        // Retourne la liste de codes de coordonnées obtenue
        return returnValue;
    }
    public ArrayList<CodeCoordonnees> getClubsLitesByCodePostal(String CodePostal, String nomFederation) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<CodeCoordonnees> returnValue = new ArrayList<CodeCoordonnees>();
        try {
            // Connexion à la base de données
            con = DriverManager.getConnection(URL, LOGIN, PASS);
            // Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
            if (!CodePostal.isEmpty()) {
                ps = con.prepareStatement("SELECT * FROM codecoordonnee WHERE Insee_code IN (SELECT Code_Commune FROM federation WHERE Code_Commune IN (SELECT insee FROM commune WHERE codepostal =?)   AND Federation = ?)");
                ps.setString(1, CodePostal);
                ps.setString(2, nomFederation);
            } else {
                ps = con.prepareStatement("SELECT * FROM codecoordonnee WHERE Insee_code IN (SELECT Code_Commune FROM federation WHERE  Federation = ?)");
                ps.setString(1, nomFederation);
            }
            // Exécution de la requête et traitement des résultats
            rs = ps.executeQuery();
            while (rs.next()) {
                // Création d'un objet CodeCoordonnees à partir des données de la base de données
                returnValue.add(new CodeCoordonnees(rs.getString("Insee_code"), rs.getString("Zip_code"), rs.getDouble("Latitude"), rs.getDouble("Longitude")));
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
        // Retourne la liste de codes de coordonnées obtenue
        return returnValue;
    }
}