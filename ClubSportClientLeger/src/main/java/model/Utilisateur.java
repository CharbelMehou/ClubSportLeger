package model;
/**
 * 
 */
public class Utilisateur {
	private String nom;
	private String prenom;
	private String email;
	private String motDePasse;
	private int role;
	/**
	 * 
	 * @param nom
	 * @param prenom
	 * @param email
	 * @param motDePasse
	 */
	public Utilisateur(String nom, String prenom, String email, String motDePasse,int role) {
		super();
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.motDePasse = motDePasse;
		this.role=role;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getNom() {
		return nom;
	}
	/**
	 * 
	 * @param nom
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	/*****
	 * 
	 * @param prenom
	 */
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	/**
	 * 
	 * @return
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * 
	 * @param email
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * 
	 * @return
	 */
	public String getMotDePasse() {
		return motDePasse;
	}
	/**
	 * 
	 * @param motDePasse
	 */
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}
	/**
	 * 
	 * @return
	 */
	public int getRole() {
		return role;
	}
	/**
	 * 
	 * @param role
	 */
	public void setRole(int role) {
		this.role = role;
	}
	
	


}
