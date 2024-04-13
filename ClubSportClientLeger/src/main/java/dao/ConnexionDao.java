package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe d'acces a la base de donnees
 * 
 * @author ESIGELEC - TIC Department
 * @version 2.0
 */
public class ConnexionDao {
	/**
	 * Parametres de connexion a la base de donnees oracle URL, LOGIN et PASS sont
	 * des constantes
	 */

	final static String URL = "jdbc:mysql://localhost/projes8";
	final static String LOGIN = "root";
	final static String PASS = "root";

	/**
	 * Constructor
	 * 
	 */
	public ConnexionDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.err.println(
					"Impossible de charger le pilote de BDD, ne pas oublier d'importer le fichier .jar dans le projet");
		}
	}
}