package model;
 
public class Utilisateurs {
    private String nom;
    private String prenom;
    private String email;
    private String motdepasse;
    private String federation;
    private String clubs;
    private String statut;
    private int role;
	/**
	 * @param nom
	 * @param prenom
	 * @param email
	 * @param motdepasse
	 * @param federation
	 * @param clubs
	 * @param statut
	 * @param role
	 */
	public Utilisateurs(String nom, String prenom, String email, String motdepasse, String federation, String clubs,
			String statut, int role) {
		super();
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.motdepasse = motdepasse;
		this.federation = federation;
		this.clubs = clubs;
		this.statut = statut;
		this.role = role;
	}
	/**
	 * @return the nom
	 */
	public String getNom() {
		return nom;
	}
	/**
	 * @param nom the nom to set
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	/**
	 * @return the prenom
	 */
	public String getPrenom() {
		return prenom;
	}
	/**
	 * @param prenom the prenom to set
	 */
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the motdepasse
	 */
	public String getMotdepasse() {
		return motdepasse;
	}
	/**
	 * @param motdepasse the motdepasse to set
	 */
	public void setMotdepasse(String motdepasse) {
		this.motdepasse = motdepasse;
	}
	/**
	 * @return the federation
	 */
	public String getFederation() {
		return federation;
	}
	/**
	 * @param federation the federation to set
	 */
	public void setFederation(String federation) {
		this.federation = federation;
	}
	/**
	 * @return the clubs
	 */
	public String getClubs() {
		return clubs;
	}
	/**
	 * @param clubs the clubs to set
	 */
	public void setClubs(String clubs) {
		this.clubs = clubs;
	}
	/**
	 * @return the statut
	 */
	public String getStatut() {
		return statut;
	}
	/**
	 * @param statut the statut to set
	 */
	public void setStatut(String statut) {
		this.statut = statut;
	}
	/**
	 * @return the role
	 */
	public int getRole() {
		return role;
	}
	/**
	 * @param role the role to set
	 */
	public void setRole(int role) {
		this.role = role;
	}
}