package model;

public class Commune {
	
	private int CodeCommune;
	private String NomCommune;
	private int CodePostal;
	private float Latitude;
	private float Longitude;
	private String NomDepartement;
	private String NomRegion	;
	private int POPF0_4;
	private int POPF5_9;
	private int POPF10_14;
	private int POPF015_19;
	private int POPF20_29;
	private int POPF30_44;
	private int POPF45_59;
	private int POPF60_74;
	private int POPF75;
	private int POPH10_4;
	private int POPH15_9;
	private int POPH20_29;
	private int POPH30_34;
	private int POPH45_59;
	private int POPH60_74;
	private int POPH75;
	
	public Commune(int codeCommune, String nomCommune, int codePostal, String nomDepartement, String nomRegion) {
		super();
		CodeCommune = codeCommune;
		NomCommune = nomCommune;
		CodePostal = codePostal;
		NomDepartement = nomDepartement;
		NomRegion = nomRegion;
	}

	public Commune(int codeCommune, String nomCommune, int codePostal, float latitude, float longitude,
			String nomDepartement, String nomRegion, int pOPF0_4, int pOPF5_9, int pOPF10_14, int pOPF015_19,
			int pOPF20_29, int pOPF30_44, int pOPF45_59, int pOPF60_74, int pOPF75, int pOPH10_4, int pOPH15_9,
			int pOPH20_29, int pOPH30_34, int pOPH45_59, int pOPH60_74, int pOPH75) {
		CodeCommune = codeCommune;
		NomCommune = nomCommune;
		CodePostal = codePostal;
		Latitude = latitude;
		Longitude = longitude;
		NomDepartement = nomDepartement;
		NomRegion = nomRegion;
		POPF0_4 = pOPF0_4;
		POPF5_9 = pOPF5_9;
		POPF10_14 = pOPF10_14;
		POPF015_19 = pOPF015_19;
		POPF20_29 = pOPF20_29;
		POPF30_44 = pOPF30_44;
		POPF45_59 = pOPF45_59;
		POPF60_74 = pOPF60_74;
		POPF75 = pOPF75;
		POPH10_4 = pOPH10_4;
		POPH15_9 = pOPH15_9;
		POPH20_29 = pOPH20_29;
		POPH30_34 = pOPH30_34;
		POPH45_59 = pOPH45_59;
		POPH60_74 = pOPH60_74;
		POPH75 = pOPH75;
	}

	public int getCodeCommune() {
		return CodeCommune;
	}

	public void setCodeCommune(int codeCommune) {
		CodeCommune = codeCommune;
	}

	public String getNomCommune() {
		return NomCommune;
	}

	public void setNomCommune(String nomCommune) {
		NomCommune = nomCommune;
	}

	public int getCodePostal() {
		return CodePostal;
	}

	public void setCodePostal(int codePostal) {
		CodePostal = codePostal;
	}

	public float getLatitude() {
		return Latitude;
	}

	public void setLatitude(float latitude) {
		Latitude = latitude;
	}

	public float getLongitude() {
		return Longitude;
	}

	public void setLongitude(float longitude) {
		Longitude = longitude;
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

	public int getPOPF0_4() {
		return POPF0_4;
	}

	public void setPOPF0_4(int pOPF0_4) {
		POPF0_4 = pOPF0_4;
	}

	public int getPOPF5_9() {
		return POPF5_9;
	}

	public void setPOPF5_9(int pOPF5_9) {
		POPF5_9 = pOPF5_9;
	}

	public int getPOPF10_14() {
		return POPF10_14;
	}

	public void setPOPF10_14(int pOPF10_14) {
		POPF10_14 = pOPF10_14;
	}

	public int getPOPF015_19() {
		return POPF015_19;
	}

	public void setPOPF015_19(int pOPF015_19) {
		POPF015_19 = pOPF015_19;
	}

	public int getPOPF20_29() {
		return POPF20_29;
	}

	public void setPOPF20_29(int pOPF20_29) {
		POPF20_29 = pOPF20_29;
	}

	public int getPOPF30_44() {
		return POPF30_44;
	}

	public void setPOPF30_44(int pOPF30_44) {
		POPF30_44 = pOPF30_44;
	}

	public int getPOPF45_59() {
		return POPF45_59;
	}

	public void setPOPF45_59(int pOPF45_59) {
		POPF45_59 = pOPF45_59;
	}

	public int getPOPF60_74() {
		return POPF60_74;
	}

	public void setPOPF60_74(int pOPF60_74) {
		POPF60_74 = pOPF60_74;
	}

	public int getPOPF75() {
		return POPF75;
	}

	public void setPOPF75(int pOPF75) {
		POPF75 = pOPF75;
	}

	public int getPOPH10_4() {
		return POPH10_4;
	}

	public void setPOPH10_4(int pOPH10_4) {
		POPH10_4 = pOPH10_4;
	}

	public int getPOPH15_9() {
		return POPH15_9;
	}

	public void setPOPH15_9(int pOPH15_9) {
		POPH15_9 = pOPH15_9;
	}

	public int getPOPH20_29() {
		return POPH20_29;
	}

	public void setPOPH20_29(int pOPH20_29) {
		POPH20_29 = pOPH20_29;
	}

	public int getPOPH30_34() {
		return POPH30_34;
	}

	public void setPOPH30_34(int pOPH30_34) {
		POPH30_34 = pOPH30_34;
	}

	public int getPOPH45_59() {
		return POPH45_59;
	}

	public void setPOPH45_59(int pOPH45_59) {
		POPH45_59 = pOPH45_59;
	}

	public int getPOPH60_74() {
		return POPH60_74;
	}

	public void setPOPH60_74(int pOPH60_74) {
		POPH60_74 = pOPH60_74;
	}

	public int getPOPH75() {
		return POPH75;
	}

	public void setPOPH75(int pOPH75) {
		POPH75 = pOPH75;
	}
}
