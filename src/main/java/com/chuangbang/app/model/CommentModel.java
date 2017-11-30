package com.chuangbang.app.model;

import java.util.Date;

public class CommentModel{
	
	private Long id;

	/**
	 * 评价类型
	 */
	private String evaluateType;  
	
	/**
	 * 订单流水号
	 */
	private String orderNo; 
	/**
	 * 订单金额
	 */
	private String orderAmount;
	
	/**
	 * 星级
	 */
	private String star;  
	
	
	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 评价对象类型
	 */
	private String itemType;
	/**
	 * 评价对象编号
	 */
	private String itemId;
	/**
	 * 评价对象名称
	 */
	private String itemName;
	
	/**
	 * 商品评价
	 */
	private Integer goodsEvaluation;
	/**
	 * 服务态度
	 */
	private Integer attitude;
	/**
	 * 响应速度
	 */
	private Integer responseSpeed;
	
	/**
	 * 设施评价
	 */
	private Integer facilities;  
	
	/**
	 * 卫生评价
	 */
	private Integer hygiene;  
	
	/**
	 * 服务评价
	 */
	private Integer service;  
	
	/**
	 * 位置评价
	 */
	private Integer location;  
	
	/**
	 * 综合评价
	 */
	private Integer comprehensive;  
	
	/**
	 * 平台体验感
	 */
	private Integer experience;  
	
	/**
	 * 公司跟进服务
	 */
	private Integer follow;  
	
	/**
	 * 获取优惠
	 */
	private Integer benefit;  
	/**
	 * 评价标签
	 */
	private String tag;
	/**
	 * 评价内容
	 */
	private String econtent;  
	
	/**
	 * 评论人编号
	 */
	private String userId;  
	
	/**
	 * 评论人姓名
	 */
	private String userName;  
	
	/**
	 * 是否匿名
	 */
	private String isanonymous;  
	
	/**
	 * 评论时间
	 */
	private Date evaluateDate;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEvaluateType() {
		return evaluateType;
	}

	public void setEvaluateType(String evaluateType) {
		this.evaluateType = evaluateType;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(String orderAmount) {
		this.orderAmount = orderAmount;
	}

	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}

	public Long getHotelId() {
		return hotelId;
	}

	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
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

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getGoodsEvaluation() {
		return goodsEvaluation;
	}

	public void setGoodsEvaluation(Integer goodsEvaluation) {
		this.goodsEvaluation = goodsEvaluation;
	}

	public Integer getAttitude() {
		return attitude;
	}

	public void setAttitude(Integer attitude) {
		this.attitude = attitude;
	}

	public Integer getResponseSpeed() {
		return responseSpeed;
	}

	public void setResponseSpeed(Integer responseSpeed) {
		this.responseSpeed = responseSpeed;
	}

	public Integer getFacilities() {
		return facilities;
	}

	public void setFacilities(Integer facilities) {
		this.facilities = facilities;
	}

	public Integer getHygiene() {
		return hygiene;
	}

	public void setHygiene(Integer hygiene) {
		this.hygiene = hygiene;
	}

	public Integer getService() {
		return service;
	}

	public void setService(Integer service) {
		this.service = service;
	}

	public Integer getLocation() {
		return location;
	}

	public void setLocation(Integer location) {
		this.location = location;
	}

	public Integer getComprehensive() {
		return comprehensive;
	}

	public void setComprehensive(Integer comprehensive) {
		this.comprehensive = comprehensive;
	}

	public Integer getExperience() {
		return experience;
	}

	public void setExperience(Integer experience) {
		this.experience = experience;
	}

	public Integer getFollow() {
		return follow;
	}

	public void setFollow(Integer follow) {
		this.follow = follow;
	}

	public Integer getBenefit() {
		return benefit;
	}

	public void setBenefit(Integer benefit) {
		this.benefit = benefit;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getEcontent() {
		return econtent;
	}

	public void setEcontent(String econtent) {
		this.econtent = econtent;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIsanonymous() {
		return isanonymous;
	}

	public void setIsanonymous(String isanonymous) {
		this.isanonymous = isanonymous;
	}

	public Date getEvaluateDate() {
		return evaluateDate;
	}

	public void setEvaluateDate(Date evaluateDate) {
		this.evaluateDate = evaluateDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Override
	public String toString() {
		return "e.id as id, e.evaluate_type as evaluateType, e.order_no as orderNo, e.order_amount as orderAmount, e.star as star, e.hotel_id as hotelId, e.hotel_name as hotelName"
				+ ", e.item_type as itemType, e.item_id as itemId, e.item_name as itemName, e.goods_evaluation as goodsEvaluation, e.attitude as attitude, e.response_speed as responseSpeed"
				+ ", e.facilities as facilities, e.hygiene as hygiene, e.service as service, e.location as location, e.comprehensive as comprehensive, e.experience as experience"
				+ ", e.follow as follow, e.benefit as benefit, e.tag as tag, e.econtent as econtent, e.user_id as userId, e.user_name as userName, e.isanonymous as isanonymous"
				+ ", e.evaluate_date as evaluateDate, e.create_date as createDate, e.memo as memo";
	}  
	
	
}


