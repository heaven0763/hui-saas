package com.chuangbang.plugins.baidu.yun.map.model;

public class UnGeocoderSearchResponse {

	private Coordinate location;
	private String formatted_address;
	private String business;
	private AddressComponent addressComponent;
	private Poi[] pois;
	private PoiRegion[] poiRegions;
	private String sematic_description;
	private String cityCode;
	
	public Coordinate getLocation() {
		return location;
	}
	public void setLocation(Coordinate location) {
		this.location = location;
	}
	public String getFormatted_address() {
		return formatted_address;
	}
	public void setFormatted_address(String formatted_address) {
		this.formatted_address = formatted_address;
	}
	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public AddressComponent getAddressComponent() {
		return addressComponent;
	}
	public void setAddressComponent(AddressComponent addressComponent) {
		this.addressComponent = addressComponent;
	}
	public Poi[] getPois() {
		return pois;
	}
	public void setPois(Poi[] pois) {
		this.pois = pois;
	}
	public PoiRegion[] getPoiRegions() {
		return poiRegions;
	}
	public void setPoiRegions(PoiRegion[] poiRegions) {
		this.poiRegions = poiRegions;
	}
	public String getSematic_description() {
		return sematic_description;
	}
	public void setSematic_description(String sematic_description) {
		this.sematic_description = sematic_description;
	}
	public String getCityCode() {
		return cityCode;
	}
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
}
