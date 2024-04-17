package model;

public class License {
	private String codeCommune;
	private String commune;
	private String departement;
	private String region;
	private String statutgeo;
	private String code;
	private String federation;
	
	private int F_1_4_ans;
	private int F_5_9_ans;
	private int F_10_14_ans;
	private int F_15_19_ans;
	private int F_20_24_ans;
	private int F_25_29_ans;
	private int F_30_34_ans;
	private int F_35_39_ans;
	private int F_40_44_ans;
	private int F_45_49_ans;
	private int F_50_54_ans;
	private int F_55_59_ans;
	private int F_60_64_ans;
	private int F_65_69_ans;
	private int F_70_74_ans;
	private int F_75_79_ans;
	private int F_80_99_ans;
	private int F_NR;
	
	private int H_1_4_ans;
	private int H_5_9_ans;
	private int H_10_14_ans;
	private int H_15_19_ans;
	private int H_20_24_ans;
	private int H_25_29_ans;
	private int H_30_34_ans;
	private int H_35_39_ans;
	private int H_40_44_ans;
	private int H_45_49_ans;
	private int H_50_54_ans;
	private int H_55_59_ans;
	private int H_60_64_ans;
	private int H_65_69_ans;
	private int H_70_74_ans;
	private int H_75_79_ans;
	private int H_80_99_ans;
	private int H_NR;
	private int NR_NR;
	private int Total;
	public License(String codeCommune, String commune, String departement, String region,String code,
			String federation, int f_1_4_ans, int f_5_9_ans, int f_10_14_ans, int f_15_19_ans, int f_20_24_ans,
			int f_25_29_ans, int f_30_34_ans, int f_35_39_ans, int f_40_44_ans, int f_45_49_ans, int f_50_54_ans,
			int f_55_59_ans, int f_60_64_ans, int f_65_69_ans, int f_70_74_ans, int f_75_79_ans, int f_80_99_ans,
			int h_1_4_ans, int h_5_9_ans, int h_10_14_ans, int h_15_19_ans, int h_20_24_ans, int h_25_29_ans,
			int h_30_34_ans, int h_35_39_ans, int h_40_44_ans, int h_45_49_ans, int h_50_54_ans, int h_55_59_ans,
			int h_60_64_ans, int h_65_69_ans, int h_70_74_ans, int h_75_79_ans, int h_80_99_ans, int total) {
		super();
		this.codeCommune = codeCommune;
		this.commune = commune;
		this.departement = departement;
		this.region = region;
		this.code = code;
		this.federation = federation;
		F_1_4_ans = f_1_4_ans;
		F_5_9_ans = f_5_9_ans;
		F_10_14_ans = f_10_14_ans;
		F_15_19_ans = f_15_19_ans;
		F_20_24_ans = f_20_24_ans;
		F_25_29_ans = f_25_29_ans;
		F_30_34_ans = f_30_34_ans;
		F_35_39_ans = f_35_39_ans;
		F_40_44_ans = f_40_44_ans;
		F_45_49_ans = f_45_49_ans;
		F_50_54_ans = f_50_54_ans;
		F_55_59_ans = f_55_59_ans;
		F_60_64_ans = f_60_64_ans;
		F_65_69_ans = f_65_69_ans;
		F_70_74_ans = f_70_74_ans;
		F_75_79_ans = f_75_79_ans;
		F_80_99_ans = f_80_99_ans;
		H_1_4_ans = h_1_4_ans;
		H_5_9_ans = h_5_9_ans;
		H_10_14_ans = h_10_14_ans;
		H_15_19_ans = h_15_19_ans;
		H_20_24_ans = h_20_24_ans;
		H_25_29_ans = h_25_29_ans;
		H_30_34_ans = h_30_34_ans;
		H_35_39_ans = h_35_39_ans;
		H_40_44_ans = h_40_44_ans;
		H_45_49_ans = h_45_49_ans;
		H_50_54_ans = h_50_54_ans;
		H_55_59_ans = h_55_59_ans;
		H_60_64_ans = h_60_64_ans;
		H_65_69_ans = h_65_69_ans;
		H_70_74_ans = h_70_74_ans;
		H_75_79_ans = h_75_79_ans;
		H_80_99_ans = h_80_99_ans;
		Total = total;
	}
	public String getCodeCommune() {
		return codeCommune;
	}
	public void setCodeCommune(String codeCommune) {
		this.codeCommune = codeCommune;
	}
	public String getCommune() {
		return commune;
	}
	public void setCommune(String commune) {
		this.commune = commune;
	}
	public String getDepartement() {
		return departement;
	}
	public void setDepartement(String departement) {
		this.departement = departement;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getFederation() {
		return federation;
	}
	public void setFederation(String federation) {
		this.federation = federation;
	}
	public int getF_1_4_ans() {
		return F_1_4_ans;
	}
	public void setF_1_4_ans(int f_1_4_ans) {
		F_1_4_ans = f_1_4_ans;
	}
	public int getF_5_9_ans() {
		return F_5_9_ans;
	}
	public void setF_5_9_ans(int f_5_9_ans) {
		F_5_9_ans = f_5_9_ans;
	}
	public int getF_10_14_ans() {
		return F_10_14_ans;
	}
	public void setF_10_14_ans(int f_10_14_ans) {
		F_10_14_ans = f_10_14_ans;
	}
	public int getF_15_19_ans() {
		return F_15_19_ans;
	}
	public void setF_15_19_ans(int f_15_19_ans) {
		F_15_19_ans = f_15_19_ans;
	}
	public int getF_20_24_ans() {
		return F_20_24_ans;
	}
	public void setF_20_24_ans(int f_20_24_ans) {
		F_20_24_ans = f_20_24_ans;
	}
	public int getF_25_29_ans() {
		return F_25_29_ans;
	}
	public void setF_25_29_ans(int f_25_29_ans) {
		F_25_29_ans = f_25_29_ans;
	}
	public int getF_30_34_ans() {
		return F_30_34_ans;
	}
	public void setF_30_34_ans(int f_30_34_ans) {
		F_30_34_ans = f_30_34_ans;
	}
	public int getF_35_39_ans() {
		return F_35_39_ans;
	}
	public void setF_35_39_ans(int f_35_39_ans) {
		F_35_39_ans = f_35_39_ans;
	}
	public int getF_40_44_ans() {
		return F_40_44_ans;
	}
	public void setF_40_44_ans(int f_40_44_ans) {
		F_40_44_ans = f_40_44_ans;
	}
	public int getF_45_49_ans() {
		return F_45_49_ans;
	}
	public void setF_45_49_ans(int f_45_49_ans) {
		F_45_49_ans = f_45_49_ans;
	}
	public int getF_50_54_ans() {
		return F_50_54_ans;
	}
	public void setF_50_54_ans(int f_50_54_ans) {
		F_50_54_ans = f_50_54_ans;
	}
	public int getF_55_59_ans() {
		return F_55_59_ans;
	}
	public void setF_55_59_ans(int f_55_59_ans) {
		F_55_59_ans = f_55_59_ans;
	}
	public int getF_60_64_ans() {
		return F_60_64_ans;
	}
	public void setF_60_64_ans(int f_60_64_ans) {
		F_60_64_ans = f_60_64_ans;
	}
	public int getF_65_69_ans() {
		return F_65_69_ans;
	}
	public void setF_65_69_ans(int f_65_69_ans) {
		F_65_69_ans = f_65_69_ans;
	}
	public int getF_70_74_ans() {
		return F_70_74_ans;
	}
	public void setF_70_74_ans(int f_70_74_ans) {
		F_70_74_ans = f_70_74_ans;
	}
	public int getF_75_79_ans() {
		return F_75_79_ans;
	}
	public void setF_75_79_ans(int f_75_79_ans) {
		F_75_79_ans = f_75_79_ans;
	}
	public int getF_80_99_ans() {
		return F_80_99_ans;
	}
	public void setF_80_99_ans(int f_80_99_ans) {
		F_80_99_ans = f_80_99_ans;
	}
	public int getH_1_4_ans() {
		return H_1_4_ans;
	}
	public void setH_1_4_ans(int h_1_4_ans) {
		H_1_4_ans = h_1_4_ans;
	}
	public int getH_5_9_ans() {
		return H_5_9_ans;
	}
	public void setH_5_9_ans(int h_5_9_ans) {
		H_5_9_ans = h_5_9_ans;
	}
	public int getH_10_14_ans() {
		return H_10_14_ans;
	}
	public void setH_10_14_ans(int h_10_14_ans) {
		H_10_14_ans = h_10_14_ans;
	}
	public int getH_15_19_ans() {
		return H_15_19_ans;
	}
	public void setH_15_19_ans(int h_15_19_ans) {
		H_15_19_ans = h_15_19_ans;
	}
	public int getH_20_24_ans() {
		return H_20_24_ans;
	}
	public void setH_20_24_ans(int h_20_24_ans) {
		H_20_24_ans = h_20_24_ans;
	}
	public int getH_25_29_ans() {
		return H_25_29_ans;
	}
	public void setH_25_29_ans(int h_25_29_ans) {
		H_25_29_ans = h_25_29_ans;
	}
	public int getH_30_34_ans() {
		return H_30_34_ans;
	}
	public void setH_30_34_ans(int h_30_34_ans) {
		H_30_34_ans = h_30_34_ans;
	}
	public int getH_35_39_ans() {
		return H_35_39_ans;
	}
	public void setH_35_39_ans(int h_35_39_ans) {
		H_35_39_ans = h_35_39_ans;
	}
	public int getH_40_44_ans() {
		return H_40_44_ans;
	}
	public void setH_40_44_ans(int h_40_44_ans) {
		H_40_44_ans = h_40_44_ans;
	}
	public int getH_45_49_ans() {
		return H_45_49_ans;
	}
	public void setH_45_49_ans(int h_45_49_ans) {
		H_45_49_ans = h_45_49_ans;
	}
	public int getH_50_54_ans() {
		return H_50_54_ans;
	}
	public void setH_50_54_ans(int h_50_54_ans) {
		H_50_54_ans = h_50_54_ans;
	}
	public int getH_55_59_ans() {
		return H_55_59_ans;
	}
	public void setH_55_59_ans(int h_55_59_ans) {
		H_55_59_ans = h_55_59_ans;
	}
	public int getH_60_64_ans() {
		return H_60_64_ans;
	}
	public void setH_60_64_ans(int h_60_64_ans) {
		H_60_64_ans = h_60_64_ans;
	}
	public int getH_65_69_ans() {
		return H_65_69_ans;
	}
	public void setH_65_69_ans(int h_65_69_ans) {
		H_65_69_ans = h_65_69_ans;
	}
	public int getH_70_74_ans() {
		return H_70_74_ans;
	}
	public void setH_70_74_ans(int h_70_74_ans) {
		H_70_74_ans = h_70_74_ans;
	}
	public int getH_75_79_ans() {
		return H_75_79_ans;
	}
	public void setH_75_79_ans(int h_75_79_ans) {
		H_75_79_ans = h_75_79_ans;
	}
	public int getH_80_99_ans() {
		return H_80_99_ans;
	}
	public void setH_80_99_ans(int h_80_99_ans) {
		H_80_99_ans = h_80_99_ans;
	}
	public int getTotal() {
		return Total;
	}
	public void setTotal(int total) {
		Total = total;
	}
	public int getTotalFemales() {
        return F_1_4_ans + F_5_9_ans + F_10_14_ans + F_15_19_ans + F_20_24_ans + F_25_29_ans + F_30_34_ans + F_35_39_ans + F_40_44_ans + F_45_49_ans + F_50_54_ans + F_55_59_ans + F_60_64_ans + F_65_69_ans + F_70_74_ans + F_75_79_ans + F_80_99_ans;
    }

    public int getTotalMales() {
        return H_1_4_ans + H_5_9_ans + H_10_14_ans + H_15_19_ans + H_20_24_ans + H_25_29_ans + H_30_34_ans + H_35_39_ans + H_40_44_ans + H_45_49_ans + H_50_54_ans + H_55_59_ans + H_60_64_ans + H_65_69_ans + H_70_74_ans + H_75_79_ans + H_80_99_ans;
    }
	
}
