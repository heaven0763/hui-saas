package com.chuangbang.app.model;

import java.util.List;

import com.google.common.collect.Lists;

public class RoomOrderDetailModel {

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
	 * 
	 */
	private String roomType;
	/**
	 * 场地编号
	 */
	private Long placeId;
	
	/**
	 * 场地名称
	 */
	private String placeName;
	/**
	 * 金额
	 */
	private Double amount;
	/**
	 * 数量
	 */
	private Long quantity;
	
	/**
	 * 有无早餐 0：无；1：有
	 */
	private Integer breakfast;
	private String network;
	/**
	 * 场地封面图片缩略图	
	 */
	private String thumbImg;
	
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

	public Double getAmount() {
		return amount;
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

	public Integer getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(Integer breakfast) {
		this.breakfast = breakfast;
	}

	@Override
	public String toString() {
		return "o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName"
				+ ", o.amount as amount, o.quantity as quantity, r.breakfast as breakfast";
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public String getNetwork() {
		return network;
	}

	public void setNetwork(String network) {
		this.network = network;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}
	
	
}
