package model;

public class Federation {
	
	private String CodeCommune;
	private String Commune;
	private String Departement;
	private String Region;
	private String StatutGeo;
	private String Code;
	private String Federation;
	private int clubs;
	private int EPA;
	private int Total;
	
	public Federation(String codeCommune, String commune, String departement, String region, String statutGeo,
			String code, String federation, int clubs, int ePA, int total) {
		CodeCommune = codeCommune;
		Commune = commune;
		Departement = departement;
		Region = region;
		StatutGeo = statutGeo;
		Code = code;
		Federation = federation;
		this.clubs = clubs;
		EPA = ePA;
		Total = total;
	}
	public String getCodeCommune() {
		return CodeCommune;
	}
	public void setCodeCommune(String codeCommune) {
		CodeCommune = codeCommune;
	}
	public String getCommune() {
		return Commune;
	}
	public void setCommune(String commune) {
		Commune = commune;
	}
	public String getDepartement() {
		return Departement;
	}
	public void setDepartement(String departement) {
		Departement = departement;
	}
	public String getRegion() {
		return Region;
	}
	public void setRegion(String region) {
		Region = region;
	}
	public String getStatutGeo() {
		return StatutGeo;
	}
	public void setStatutGeo(String statutGeo) {
		StatutGeo = statutGeo;
	}
	public String getCode() {
		return Code;
	}
	public void setCode(String code) {
		Code = code;
	}
	public String getFederation() {
		return Federation;
	}
	public void setFederation(String federation) {
		Federation = federation;
	}
	public int getClubs() {
		return clubs;
	}
	public void setClubs(int clubs) {
		this.clubs = clubs;
	}
	public int getEPA() {
		return EPA;
	}
	public void setEPA(int ePA) {
		EPA = ePA;
	}
	public int getTotal() {
		return Total;
	}
	public void setTotal(int total) {
		Total = total;
	}
	
	
}
