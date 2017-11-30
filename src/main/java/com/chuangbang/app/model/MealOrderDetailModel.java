package com.chuangbang.app.model;

import java.util.List;

import com.google.common.collect.Lists;

public class MealOrderDetailModel {

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
	 * 金额
	 */
	private Double amount;
	/**
	 * 数量
	 */
	private Long quantity;
	
	/**
	 * 用餐类型
	 */
	private String mealType;
	
	
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
	
	public String getMealType() {
		return mealType;
	}
	public void setMealType(String mealType) {
		this.mealType = mealType;
	}

	@Override
	public String toString() {
		return "o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName"
				+ ", o.amount as amount, o.quantity as quantity, m.type as mealType";
	}
	
	
}
