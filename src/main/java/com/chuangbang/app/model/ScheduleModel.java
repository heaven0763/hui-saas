package com.chuangbang.app.model;

import java.util.Date;


public class ScheduleModel {
	
	/**
	 * 档期编号
	 */
	Long id;
	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 场地类型
	 */
	private String placeType;  
	
	/**
	 * 场地编号
	 */
	private Long placeId;  
	
	/**
	 * 场地名称
	 */
	private String placeName;  
	
	/**
	 * 场地档期
	 */
	private String placeSchedule;  
	/**
	 * 场地档期
	 */
	private String placeScheduleName; 
	/**
	 * 场地日期
	 */
	private String placeDate; 
	
	/**
	 * 线上价格
	 */
	private Double onlinePrice;  
	
	/**
	 * 线下价格
	 */
	private Double offlinePrice;
	
	/**
	 * 场地状态  0:初始状态；1 标示已预订档期；2标示已交订金销售档期
	 */
	private String state;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo; 
	
	private String orderNo;
	
	//List<E>
	
    public ScheduleModel() {
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
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


	public String getPlaceType() {
		return placeType;
	}


	public void setPlaceType(String placeType) {
		this.placeType = placeType;
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


	public String getPlaceSchedule() {
		return placeSchedule;
	}


	public void setPlaceSchedule(String placeSchedule) {
		this.placeSchedule = placeSchedule;
	}


	public String getPlaceDate() {
		return placeDate;
	}


	public void setPlaceDate(String placeDate) {
		this.placeDate = placeDate;
	}


	public Double getOnlinePrice() {
		return onlinePrice;
	}


	public void setOnlinePrice(Double onlinePrice) {
		this.onlinePrice = onlinePrice;
	}


	public Double getOfflinePrice() {
		return offlinePrice;
	}


	public void setOfflinePrice(Double offlinePrice) {
		this.offlinePrice = offlinePrice;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
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

	public String getPlaceScheduleName() {
		return placeScheduleName;
	}
	public void setPlaceScheduleName(String placeScheduleName) {
		this.placeScheduleName = placeScheduleName;
	}


	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

    
}


