package com.chuangbang.app.model;

public class BookingRecordModel {
	/**
	 * 编号
	 */
	private Long id;
	/**
	 * 档期日期/入住时间/用餐时间
	 */
	private String placeDate;
	/**
	 * 档期时间
	 */
	private String placeSchedule;
	/**
	 * 档期时间编号
	 */
	private String placeScheduleIds;
	/**
	 * 档期时间
	 */
	private String placeScheduleTxt;
	/**
	 * 单价
	 */
	private Double price;
	/**
	 * 数量
	 */
	private Long quantity;
	
	
	private String breakfast;
	
	private Long mealnum;
	
	private String mealType;

	private String placeScheduleId;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getPlaceDate() {
		return placeDate;
	}
	public void setPlaceDate(String placeDate) {
		this.placeDate = placeDate;
	}
	public String getPlaceSchedule() {
		return placeSchedule;
	}
	public void setPlaceSchedule(String placeSchedule) {
		this.placeSchedule = placeSchedule;
	}
	
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	
	public String getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(String breakfast) {
		this.breakfast = breakfast;
	}
	public Long getMealnum() {
		return mealnum;
	}
	public void setMealnum(Long mealnum) {
		this.mealnum = mealnum;
	}
	public String getMealType() {
		return mealType;
	}
	public void setMealType(String mealType) {
		this.mealType = mealType;
	}
	
	public String getPlaceScheduleId() {
		return placeScheduleId;
	}
	public void setPlaceScheduleId(String placeScheduleId) {
		this.placeScheduleId = placeScheduleId;
	}
	
	public String getPlaceScheduleTxt() {
		return placeScheduleTxt;
	}
	public void setPlaceScheduleTxt(String placeScheduleTxt) {
		this.placeScheduleTxt = placeScheduleTxt;
	}
	
	public String getPlaceScheduleIds() {
		return placeScheduleIds;
	}
	public void setPlaceScheduleIds(String placeScheduleIds) {
		this.placeScheduleIds = placeScheduleIds;
	}
	@Override
	public String toString() {
		return "s.id as id, s.place_date as placeDate, s.place_schedule as placeSchedule, s.price as price, s.quantity as quantity";
	}
	
}
