package model;

public class Federation {
	
	private int CodeFederation;
	private String LibelleFederation;
	private String NomDepartement;
	private String NomRegion;
	
	public Federation(int codeFederation, String libelleFederation, String nomDepartement, String nomRegion) {
		CodeFederation = codeFederation;
		LibelleFederation = libelleFederation;
		NomDepartement = nomDepartement;
		NomRegion = nomRegion;
	}
	public int getCodeFederation() {
		return CodeFederation;
	}
	public void setCodeFederation(int codeFederation) {
		CodeFederation = codeFederation;
	}
	public String getLibelleFederation() {
		return LibelleFederation;
	}
	public void setLibelleFederation(String libelleFederation) {
		LibelleFederation = libelleFederation;
	}
	public String getNomDepartement() {
		return NomDepartement;
	}
	public void setNomDepartement(String nomDepartement) {
		NomDepartement = nomDepartement;
	}
	public String getNomRegion() {
		return NomRegion;
	}
	public void setNomRegion(String nomRegion) {
		NomRegion = nomRegion;
	}
}
