package com.chuangbang.app.model;

public class CommentSumModel{
	
	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	/**
	 * 评价对象类型
	 */
	private String itemType;
	/**
	 * 评价对象编号
	 */
	private String itemId;
	
	/**
	 * 商品评价
	 */
	private Double goodsEvaluation;
	/**
	 * 服务态度
	 */
	private Double attitude;
	/**
	 * 响应速度
	 */
	private Double responseSpeed;
	
	/**
	 * 设施评价
	 */
	private Double facilities;  
	
	/**
	 * 卫生评价
	 */
	private Double hygiene;  
	
	/**
	 * 服务评价
	 */
	private Double service;  
	
	/**
	 * 位置评价
	 */
	private Double location;  
	
	/**
	 * 综合评价
	 */
	private Double comprehensive;  
	
	/**
	 * 平台体验感
	 */
	private Double experience;  
	
	/**
	 * 公司跟进服务
	 */
	private Double follow;  
	
	/**
	 * 获取优惠
	 */
	private Double benefit;  
	/**
	 * 评价标签
	 */
	private String tag;
	public Long getHotelId() {
		return hotelId;
	}
	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public Double getGoodsEvaluation() {
		return goodsEvaluation;
	}
	public void setGoodsEvaluation(Double goodsEvaluation) {
		this.goodsEvaluation = goodsEvaluation;
	}
	public Double getAttitude() {
		return attitude;
	}
	public void setAttitude(Double attitude) {
		this.attitude = attitude;
	}
	public Double getResponseSpeed() {
		return responseSpeed;
	}
	public void setResponseSpeed(Double responseSpeed) {
		this.responseSpeed = responseSpeed;
	}
	public Double getFacilities() {
		return facilities;
	}
	public void setFacilities(Double facilities) {
		this.facilities = facilities;
	}
	public Double getHygiene() {
		return hygiene;
	}
	public void setHygiene(Double hygiene) {
		this.hygiene = hygiene;
	}
	public Double getService() {
		return service;
	}
	public void setService(Double service) {
		this.service = service;
	}
	public Double getLocation() {
		return location;
	}
	public void setLocation(Double location) {
		this.location = location;
	}
	public Double getComprehensive() {
		return comprehensive;
	}
	public void setComprehensive(Double comprehensive) {
		this.comprehensive = comprehensive;
	}
	public Double getExperience() {
		return experience;
	}
	public void setExperience(Double experience) {
		this.experience = experience;
	}
	public Double getFollow() {
		return follow;
	}
	public void setFollow(Double follow) {
		this.follow = follow;
	}
	public Double getBenefit() {
		return benefit;
	}
	public void setBenefit(Double benefit) {
		this.benefit = benefit;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	
}


