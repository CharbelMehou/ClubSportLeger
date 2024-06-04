package dao;
 
import java.sql.Connection;
 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
 
import model.Publications;
import model.Utilisateurs;
 
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
 
public class UtilisateurDAO extends ConnexionDao {
 
 
	public UtilisateurDAO() {
		super(); 
	}
 
	/**
	 * Méthode permettant de récupérer un utilisateur à partir de son email et de son mot de passe
	 * 
	 * @param email l'email de l'utilisateur
	 * @param password le mot de passe de l'utilisateur
	 * @return l'objet Utilisateur correspondant aux informations fournies;
	 *         null si aucun utilisateur ne correspond aux informations fournies
	 */
	public Utilisateurs getUtilisateur(String email, String password) {
		Utilisateurs utilisateur = null;
		Connection con = null;
		PreparedStatement ps = null;
		PreparedStatement logStmt = null;
		ResultSet rs = null;
		String logInsertSQL = "INSERT INTO logs (Email, Statut, Date, Ip) VALUES (?, ?, ?, ?)";
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		InetAddress address = null;
		try {
			address = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			ps = con.prepareStatement("SELECT * FROM utilisateur WHERE email = ? AND motdepasse = ?");
			ps.setString(1, email);
			ps.setString(2, password);
			rs = ps.executeQuery();
 
			// Préparation de la déclaration pour les logs
			logStmt = con.prepareStatement(logInsertSQL);
			logStmt.setString(1, email);
			logStmt.setString(3, formatter.format(date));
			logStmt.setString(4, address.getHostAddress());
 
			// Si un utilisateur correspondant est trouvé
			if (rs.next()) {
				String nom = rs.getString("nom");
				String prenom = rs.getString("prenom");
				String federation = rs.getString("federation");
				String club = rs.getString("club");
				String statut = rs.getString("statut");
				int role = rs.getInt("role");
				utilisateur = new Utilisateurs(nom, prenom, email, password,federation,club,statut,role);
 
				// Log successful login
				logStmt.setString(2, "success");
				logStmt.executeUpdate();
			} else {
				// Log failed login
				logStmt.setString(2, "failed");
				logStmt.executeUpdate();
			}
		} catch (SQLException ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (logStmt != null) logStmt.close();
				if (con != null) con.close();
			} catch (SQLException ignore) {
				ignore.printStackTrace();
			}
		}
		// Retourne l'utilisateur trouvé ou null s'il n'y en a pas
		return utilisateur;
	}
 
	/**
	 * 
	 * @param nom
	 * @param prenom
	 * @param email
	 * @param password
	 * @param federation
	 * @param clubs
	 * @param statut
	 * @return
	 */
	public int ValidateUser(String nom, String prenom, String email, String password, String federation, String clubs, String statut) {
	    String userInsertSQL = "INSERT INTO utilisateur(nom, prenom, email, motdepasse,federation,club,statut,role) VALUES (?, ?, ?, ?, ?, ?, ?,1)";
	    try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
	         PreparedStatement userStmt = con.prepareStatement(userInsertSQL)) {
 
	        // Insertion utilisateur
	        userStmt.setString(1, nom);
	        userStmt.setString(2, prenom);
	        userStmt.setString(3, email);
	        userStmt.setString(4, password);
	        userStmt.setString(5, federation);
	        userStmt.setString(6, clubs);
	        userStmt.setString(7, statut);
 
	        int rowsAffected = userStmt.executeUpdate();
 
	        if (rowsAffected > 0) {
	            System.out.println("Utilisateur ajouté avec succès !");
	        } else {
	            System.out.println("Erreur lors de l'ajout de l'utilisateur !");
	        }
 
	    } catch (SQLException ee) {
	        ee.printStackTrace();
	    }
	    return 0;
	}
 
	/**
	 * Méthode permettant de vérifier si un utilisateur existe déjà dans la base de données à partir de son email
	 * 
	 * @param email l'email de l'utilisateur à vérifier
	 * @return true si l'utilisateur existe déjà dans la base de données;
	 *         false sinon
	 */
	public boolean utilisateurExists(String email) {
		boolean exists = false;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			ps = con.prepareStatement("SELECT COUNT(*) FROM utilisateurprime WHERE email = ?");
			ps.setString(1, email);
			rs = ps.executeQuery();
			// Vérification du nombre de résultats retournés par la requête
			if (rs.next()) {
				int count = rs.getInt(1);
				if (count > 0) {
					exists = true;
				}
			}
		} catch (SQLException ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
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
		// Retourne un booléen indiquant si l'utilisateur existe déjà dans la base de données
		return exists;
	}
 
	/**
	 * Méthode permettant de vérifier si un utilisateur existe déjà dans la base de données à partir de son email
	 * 
	 * @param email l'email de l'utilisateur à vérifier
	 * @return true si l'utilisateur existe déjà dans la base de données;
	 *         false sinon
	 */
	public boolean utilisateurExist(String email) {
		boolean exists = false;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			ps = con.prepareStatement("SELECT COUNT(*) FROM utilisateur WHERE email = ?");
			ps.setString(1, email);
			rs = ps.executeQuery();
			// Vérification du nombre de résultats retournés par la requête
			if (rs.next()) {
				int count = rs.getInt(1);
				if (count > 0) {
					exists = true;
				}
			}
		} catch (SQLException ee) {
			// Gestion des exceptions
			ee.printStackTrace();
		} finally {
			// Fermeture des ressources
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
		// Retourne un booléen indiquant si l'utilisateur existe déjà dans la base de données
		return exists;
	}
	/**
	 * 
	 * @param email
	 * @param password
	 * @return
	 */
	public int getIdUtilisateur( String email, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int returnValue = 0 ;
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
 
			ps = con.prepareStatement("SELECT id FROM utilisateur WHERE email = ? AND motdepasse = ?");
			ps.setString(1, email);
			ps.setString(2, password);
 
			// Exécution de la requête et traitement des résultats
			rs = ps.executeQuery();
			while (rs.next()) {
				// Création d'un objet CodeCoordonnees à partir des données de la base de données
				returnValue = rs.getInt("id");	            }
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
 
	/**
	 * Méthode permettant d'ajouter un nouvel utilisateur à la base de données
	 * 
	 * @param nom le nom de l'utilisateur
	 * @param prenom le prénom de l'utilisateur
	 * @param email l'email de l'utilisateur
	 * @param password le mot de passe de l'utilisateur
	 * @return 0 si l'ajout a échoué;
	 *         une autre valeur si l'ajout a réussi (par exemple, le nombre de lignes affectées)
	 */
	public int adds(String nom, String prenom, String email, String password, String federation, String clubs, String statut) {
	    String userInsertSQL = "INSERT INTO utilisateurprime (nom, prenom, email, motdepasse, federation,club,statut,role) VALUES (?, ?, ?, ?, ?, ?, ?,1)";
	    try (Connection con = DriverManager.getConnection(URL, LOGIN, PASS);
	         PreparedStatement userStmt = con.prepareStatement(userInsertSQL)) {
 
	        // Insertion utilisateur
	        userStmt.setString(1, nom);
	        userStmt.setString(2, prenom);
	        userStmt.setString(3, email);
	        userStmt.setString(4, password);
	        userStmt.setString(5, federation);
	        userStmt.setString(6, clubs);
	        userStmt.setString(7, statut);
 
	        int rowsAffected = userStmt.executeUpdate();
 
	        if (rowsAffected > 0) {
	            System.out.println("Utilisateur ajouté avec succès !");
	        } else {
	            System.out.println("Erreur lors de l'ajout de l'utilisateur !");
	        }
 
	    } catch (SQLException ee) {
	        ee.printStackTrace();
	    }
	    return 0;
	}

	/**
	 * 
	 * @return
	 */
	public ArrayList<Utilisateurs> getAllUsers() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Utilisateurs> returnValue = new ArrayList<Utilisateurs>();
		try {
			// Connexion à la base de données
			con = DriverManager.getConnection(URL, LOGIN, PASS);
			// Requête SQL pour récupérer les codes de coordonnées en fonction de la région et de la fédération
 
			ps = con.prepareStatement("SELECT * FROM utilisateurprime");
			// Exécution de la requête et traitement des résultats
			rs = ps.executeQuery();
			while (rs.next()) {
				// Création d'un objet CodeCoordonnees à partir des données de la base de données
				returnValue.add(new Utilisateurs(rs.getString("nom"),rs.getString("prenom"),rs.getString("email"),rs.getString("motdepasse"),rs.getString("federation"),rs.getString("club"),rs.getString("statut"),rs.getInt("role")));
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
	
 
	public boolean deleteUtilisateur(String email, String password) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    PreparedStatement logStmt = null;
	    ResultSet rs = null;
	    String logInsertSQL = "INSERT INTO logs (Email, Statut, Date, Ip) VALUES (?, ?, ?, ?)";
	    Date date = new Date();
	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    InetAddress address = null;
	    try {
	        address = InetAddress.getLocalHost();
	    } catch (UnknownHostException e) {
	        e.printStackTrace();
	    }
	    try {
	        // Connexion à la base de données
	        con = DriverManager.getConnection(URL, LOGIN, PASS);
	        ps = con.prepareStatement("DELETE FROM utilisateurprime WHERE email = ? AND motdepasse = ?");
	        ps.setString(1, email);
	        ps.setString(2, password);
	        int rowsAffected = ps.executeUpdate();
 
	        // Préparation de la déclaration pour les logs
	        logStmt = con.prepareStatement(logInsertSQL);
	        logStmt.setString(1, email);
	        logStmt.setString(3, formatter.format(date));
	        logStmt.setString(4, address.getHostAddress());
 
	        // Si des lignes ont été affectées par la suppression
	        if (rowsAffected > 0) {
	            // Log successful deletion
	            logStmt.setString(2, "success");
	            logStmt.executeUpdate();
	            return true; // Utilisateur supprimé avec succès
	        } else {
	            // Log failed deletion
	            logStmt.setString(2, "failed");
	            logStmt.executeUpdate();
	            return false; // Aucun utilisateur correspondant trouvé
	        }
	    } catch (SQLException ee) {
	        // Gestion des exceptions
	        ee.printStackTrace();
	    } finally {
	        // Fermeture des ressources
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (logStmt != null) logStmt.close();
	            if (con != null) con.close();
	        } catch (SQLException ignore) {
	            ignore.printStackTrace();
	        }
	    }
	    return false; // Retourne faux en cas d'erreur ou d'exception
	}
 
	/**
	 * Modifie le mot de passe pour l'utilisateur avec l'e-mail spécifié.
	 * 
	 * @param email L'e-mail de l'utilisateur dont le mot de passe doit être modifié
	 * @param newPassword Le nouveau mot de passe à définir
	 * @return Le nombre de lignes affectées par la mise à jour (1 si la mise à jour a réussi, 0 sinon)
	 */
	public int modifierMotDePasse(String email, String newPassword) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    int rowsAffected = 0;
 
	    try {
	        // Connexion à la base de données
	        con = DriverManager.getConnection(URL, LOGIN, PASS);
 
	        // Requête SQL pour mettre à jour le mot de passe en fonction de l'e-mail
	        String sql = "UPDATE utilisateur SET motdepasse = ? WHERE email = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, newPassword);
	        ps.setString(2, email);
 
	        // Exécution de la requête de mise à jour
	        rowsAffected = ps.executeUpdate();
 
	    } catch (SQLException e) {
	        // Gestion des exceptions
	        e.printStackTrace();
	    } finally {
	        // Fermeture des ressources
	        try {
	            if (ps != null)
	                ps.close();
	        } catch (SQLException ignore) {
	        }
	        try {
	            if (con != null)
	                con.close();
	        } catch (SQLException ignore) {
	        }
	    }
 
	    return rowsAffected;
	}
	/**
     * Méthode pour mettre à jour le profil utilisateur avec de nouvelles informations.
     * 
     * @param utilisateur L'utilisateur avec les nouvelles informations à mettre à jour.
     * @return true si la mise à jour a réussi, false sinon.
     */
    public boolean updateUtilisateur(Utilisateurs utilisateur) {
        Connection con = null;
        PreparedStatement ps = null;
        boolean updated = false;

        try {
            con = DriverManager.getConnection(URL, LOGIN, PASS);
            String sql = "UPDATE utilisateur SET nom = ?, prenom = ?, email = ?, motdepasse = ?, federation = ?, club = ?, statut = ? , role = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, utilisateur.getNom());
            ps.setString(2, utilisateur.getPrenom());
            ps.setString(3, utilisateur.getEmail());
            ps.setString(4, utilisateur.getMotdepasse());
            ps.setString(5, utilisateur.getFederation());
            ps.setString(6, utilisateur.getClubs());
            ps.setString(7, utilisateur.getStatut());
            ps.setInt(8, utilisateur.getRole());
//            ps.setInt(9, utilisateur.getId());


            int rowsAffected = ps.executeUpdate();
            updated = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ignore) {
                ignore.printStackTrace();
            }
        }

        return updated;
    }
 
}