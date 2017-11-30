package com.chuangbang.app.model;

import java.util.List;

import com.google.common.collect.Lists;

public class HallOrderDetailModel {

	/**
	 * 编号
	 */
	private Long id;
	/**
	 * 订单流水号
	 */
	private String orderNo;
	/**
	 * 
	 */
	private String type;
	/**
	 * 场地编号
	 */
	private Long placeId;
	
	/**
	 * 场地名称
	 */
	private String placeName;
	/**
	 * 是否是主会场
	 */
	private String ismain;
	/**
	 * 金额
	 */
	private Double amount;
	/**
	 * 数量
	 */
	private Long quantity;
	
	/**
	 * 服务费率%
	 */
	private Double commissionFeeRate;
	
	/**
	 * 场地面积
	 */
	private String hallArea;  

	/**
	 * 长
	 */
	private String length;  

	/**
	 * 宽
	 */
	private String width;  

	/**
	 * 高
	 */
	private String height;  


	/**
	 * 所在楼层
	 */
	private String floor;  
	
	/**
	 * 场地柱子
	 */
	private Integer pillar;

	/**
	 * 容纳人数
	 */
	private Long peopleNum;
	/**
	 * 场地封面图片缩略图	
	 */
	private String thumbImg;
	private String pillars;
	private List<BookingRecordModel> bookingRecordModels = Lists.newArrayList();

	public List<BookingRecordModel> getBookingRecordModels() {
		return bookingRecordModels;
	}

	public void setBookingRecordModels(List<BookingRecordModel> bookingRecordModels) {
		this.bookingRecordModels = bookingRecordModels;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getPlaceId() {
		return placeId;
	}

	public void setPlaceId(Long placeId) {
		this.placeId = placeId;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getIsmain() {
		return ismain;
	}

	public void setIsmain(String ismain) {
		this.ismain = ismain;
	}

	public Double getAmount() {
		return amount != null? amount : 0.00;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

	public Double getCommissionFeeRate() {
		return commissionFeeRate;
	}

	public void setCommissionFeeRate(Double commissionFeeRate) {
		this.commissionFeeRate = commissionFeeRate;
	}

	public String getHallArea() {
		return hallArea;
	}

	public void setHallArea(String hallArea) {
		this.hallArea = hallArea;
	}

	public String getLength() {
		return length;
	}

	public void setLength(String length) {
		this.length = length;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public Integer getPillar() {
		return pillar;
	}

	public void setPillar(Integer pillar) {
		this.pillar = pillar;
	}

	public Long getPeopleNum() {
		return peopleNum;
	}

	public void setPeopleNum(Long peopleNum) {
		this.peopleNum = peopleNum;
	}

	@Override
	public String toString() {
		return "o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName, o.ismain as ismain, o.amount as amount"
				+ ", o.quantity as quantity, o.commission_fee_rate as commissionFeeRate, h.hall_area as hallArea, h.length as length, h.width as width"
				+ ", h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum";
	}

	public String getThumbImg() {
		return thumbImg;
	}
	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public String getPillars() {
		return pillars;
	}
	public void setPillars(String pillars) {
		this.pillars = pillars;
	}
	
	
	
}
