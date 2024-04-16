package model;
/**
 * 
 */
public class CodeCoordonnees {
	private String InseeCode;
	private String ZipCode;
	private Double Latitude;
	private Double Longitude;
	/**
	 * @param inseeCode
	 * @param zipCode
	 * @param latitude
	 * @param longitude
	 */
	public CodeCoordonnees(String inseeCode, String zipCode, Double latitude, Double longitude) {
		super();
		InseeCode = inseeCode;
		ZipCode = zipCode;
		Latitude = latitude;
		Longitude = longitude;
	}
	/**
	 * @return the inseeCode
	 */
	public String getInseeCode() {
		return InseeCode;
	}
	/**
	 * @param inseeCode the inseeCode to set
	 */
	public void setInseeCode(String inseeCode) {
		InseeCode = inseeCode;
	}
	/**
	 * @return the zipCode
	 */
	public String getZipCode() {
		return ZipCode;
	}
	/**
	 * @param zipCode the zipCode to set
	 */
	public void setZipCode(String zipCode) {
		ZipCode = zipCode;
	}
	/**
	 * @return the latitude
	 */
	public Double getLatitude() {
		return Latitude;
	}
	/**
	 * @param latitude the latitude to set
	 */
	public void setLatitude(Double latitude) {
		Latitude = latitude;
	}
	/**
	 * @return the longitude
	 */
	public Double getLongitude() {
		return Longitude;
	}
	/**
	 * @param longitude the longitude to set
	 */
	public void setLongitude(Double longitude) {
		Longitude = longitude;
	}
	
	
	
	
}
