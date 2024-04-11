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
	// � utiliser si vous �tes sur une machine personnelle :
	// final static String URL = "jdbc:oracle:thin:@oracle.esigelec.fr:1521:orcl";

	// � utiliser si vous �tes sur une machine de l'�cole :
	final static String URL = "jdbc:mysql://localhost/projet";

	final static String LOGIN = "root"; // remplacer les ********. Exemple C##BDD1_1
	final static String PASS = "root"; // remplacer les ********. Exemple BDD11

	/**
	 * Constructor
	 * 
	 */
	public ConnexionDao() {
		// chargement du pilote de bases de donnees
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.err.println(
					"Impossible de charger le pilote de BDD, ne pas oublier d'importer le fichier .jar dans le projet");
		}
	}
}