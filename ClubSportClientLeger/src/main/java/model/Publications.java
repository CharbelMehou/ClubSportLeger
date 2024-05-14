package model;
 
public class Publications {
	
	private String titre;
	private String publication;
	private byte[] image;
	private int idUtilisateur;
	
	/**
	 * Constructeur avec tous les champs
	 */
	public Publications(String titre, String publication, byte[] image, int idUtilisateur) {
		this.titre = titre;
		this.publication = publication;
		this.image = image;
		this.idUtilisateur = idUtilisateur;
	}
 
	/**
	 * @return le titre
	 */
	public String getTitre() {
		return titre;
	}
 
	/**
	 * @param titre à définir
	 */
	public void setTitre(String titre) {
		this.titre = titre;
	}
 
	/**
	 * @return la publication
	 */
	public String getPublication() {
		return publication;
	}
 
	/**
	 * @param publication à définir
	 */
	public void setPublication(String publication) {
		this.publication = publication;
	}
 
	/**
	 * @return l'image
	 */
	public byte[] getImage() {
		return image;
	}
 
	/**
	 * @param image à définir
	 */
	public void setImage(byte[] image) {
		this.image = image;
	}
 
	/**
	 * @return l'identifiant de l'utilisateur
	 */
	public int getIdUtilisateur() {
		return idUtilisateur;
	}
 
	/**
	 * @param idUtilisateur à définir
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}
}
 