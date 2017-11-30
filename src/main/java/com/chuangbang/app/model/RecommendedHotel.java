package com.chuangbang.app.model;

import java.util.Date;

public class RecommendedHotel {
	/**
	 * 酒店编号
	 */
	private Long id;
	/**
	 * 酒店名称
	 */
	private String hotelName;
	
	/**
	 * 酒店封面图片
	 */
	private String originalImg;  
	
	/**
	 * 酒店封面图片缩略图
	 */
	private String thumbImg;
	
	/**
	 * 装修时间
	 */
	private Date decorationTime;  
	
	/**
	 * 大厅数量
	 */
	private Integer hallNum;  
	
	/**
	 * 客房数量
	 */
	private Integer roomNum;  
	/**
	 * 平均价格	
	 */
	private String averagePrice;

	
	/**
	 * 大厅最大面积
	 */
	private String hallMaxArea;  
	
	/**
	 * 最大可容納人数
	 */
	private Integer maxPeopleNum;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getOriginalImg() {
		return originalImg;
	}

	public void setOriginalImg(String originalImg) {
		this.originalImg = originalImg;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public Date getDecorationTime() {
		return decorationTime;
	}

	public void setDecorationTime(Date decorationTime) {
		this.decorationTime = decorationTime;
	}

	public Integer getHallNum() {
		return hallNum;
	}

	public void setHallNum(Integer hallNum) {
		this.hallNum = hallNum;
	}

	public Integer getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}

	public String getAveragePrice() {
		return averagePrice;
	}

	public void setAveragePrice(String averagePrice) {
		this.averagePrice = averagePrice;
	}

	public String getHallMaxArea() {
		return hallMaxArea;
	}

	public void setHallMaxArea(String hallMaxArea) {
		this.hallMaxArea = hallMaxArea;
	}

	public Integer getMaxPeopleNum() {
		return maxPeopleNum;
	}

	public void setMaxPeopleNum(Integer maxPeopleNum) {
		this.maxPeopleNum = maxPeopleNum;
	}

	@Override
	public String toString() {
		return "h.id as id, h.hotel_name as hotelName, h.original_img as originalImg, h.thumb_img as thumbImg, h.decoration_time as decorationTime, h.hall_num as hallNum, h.room_num as roomNum, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum";
	} 
	
	
	
}
