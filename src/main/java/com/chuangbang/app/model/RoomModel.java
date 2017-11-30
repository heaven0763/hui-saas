package com.chuangbang.app.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chuangbang.base.entity.hotel.SiteImg;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;


public class RoomModel {

	/**
	 * 客房编号
	 */
	private Long id;
	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;

	/**
	 * 客房类型
	 */
	private String placeType;  

	/**
	 * 客房名称
	 */
	private String placeName;  


	/**
	 * 推荐指数
	 */
	private String recommendedIndex;  

	/**
	 * 客房说明
	 */
	private String description;  

	/**
	 * 客房封面图片	
	 */
	private String originalImg;
	/**
	 * 客房封面图片缩略图	
	 */
	private String thumbImg;


	/**
	 * 掌柜价
	 */
	private Double zguiPrice;  

	/**
	 * 酒店价格
	 */
	private Double hotelPrice;  

	/**
	 * 实地认证
	 */
	private Integer isauth;  
	/**
	 * 认证时间
	 */
	private Date authDate;

	/**
	 * 推荐客房
	 */
	private Integer isrecommend;  

	/**
	 * 优质客房
	 */
	private Integer isbest;  

	/**
	 * 客房面积
	 */
	private String hallArea;  

	/**
	 * 所在楼层
	 */
	private String floor;  
	/**
	 * 装修时间
	 */
	private Date decorationTime;  
	/**
	 * 客房概述
	 */
	private String introduction; 
	/**
	 * 客房服务
	 */
	private String roomService;  

	/**
	 * 床规格
	 */
	private String bedSize;
	/**
	 * 床数量
	 */
	private Integer bedNum;
	/**
	 * 入住人数
	 */
	private Integer checkInNum;
	/**
	 * 24小时热水
	 */
	private String 	hotwater;
	/**
	 * 独立淋浴
	 */
	private String 	bathroom ;
	/**
	 * 毛巾
	 */
	private String 	towel;
	/**
	 * 免费饮用水
	 */
	private String 	freeWater;
	/**
	 * 免费洗漱用品	
	 */
	private String freeSupplies;
	/**
	 * 免费洗漱用品数量
	 */
	private Integer	freeSuppliesNum;
	/**
	 * 窗户
	 */
	private String window;
	
	/**
	 * 排序编号
	 */
	private Integer sortOrder;
	/**
	 * 状态
	 */
	private String state;
	/**
	 * 有无早餐 0：无；1：有
	 */
	private Integer breakfast;
	private String network;
	private String roomType;

	/**
	 * 创建时间
	 */
	private Date createDate;  
	/**
	 * 备注
	 */
	private String memo;
	/**
	 * 床数量
	 */
	private Integer roomNum;
	List<SupportingModel>  facilities = Lists.newArrayList();
	List<SupportingModel>  teshs = Lists.newArrayList();
	List<SiteImg>  imgs = Lists.newArrayList();
	Map<String, Object> comments = Maps.newHashMap();
	
	private Double tradeKicker; 
	public Double getTradeKicker() {
		return tradeKicker;
	}
	public void setTradeKicker(Double tradeKicker) {
		this.tradeKicker = tradeKicker;
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
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getRecommendedIndex() {
		return recommendedIndex;
	}
	public void setRecommendedIndex(String recommendedIndex) {
		this.recommendedIndex = recommendedIndex;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public Double getZguiPrice() {
		return zguiPrice;
	}
	public void setZguiPrice(Double zguiPrice) {
		this.zguiPrice = zguiPrice;
	}
	public Double getHotelPrice() {
		return hotelPrice;
	}
	public void setHotelPrice(Double hotelPrice) {
		this.hotelPrice = hotelPrice;
	}
	public Integer getIsauth() {
		return isauth;
	}
	public void setIsauth(Integer isauth) {
		this.isauth = isauth;
	}
	public Date getAuthDate() {
		return authDate;
	}
	public void setAuthDate(Date authDate) {
		this.authDate = authDate;
	}
	public Integer getIsrecommend() {
		return isrecommend;
	}
	public void setIsrecommend(Integer isrecommend) {
		this.isrecommend = isrecommend;
	}
	public Integer getIsbest() {
		return isbest;
	}
	public void setIsbest(Integer isbest) {
		this.isbest = isbest;
	}
	public String getHallArea() {
		return hallArea;
	}
	public void setHallArea(String hallArea) {
		this.hallArea = hallArea;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public Date getDecorationTime() {
		return decorationTime;
	}
	public void setDecorationTime(Date decorationTime) {
		this.decorationTime = decorationTime;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getRoomService() {
		return roomService;
	}
	public void setRoomService(String roomService) {
		this.roomService = roomService;
	}
	public String getBedSize() {
		return bedSize;
	}
	public void setBedSize(String bedSize) {
		this.bedSize = bedSize;
	}
	public Integer getBedNum() {
		return bedNum;
	}
	public void setBedNum(Integer bedNum) {
		this.bedNum = bedNum;
	}
	public Integer getCheckInNum() {
		return checkInNum;
	}
	public void setCheckInNum(Integer checkInNum) {
		this.checkInNum = checkInNum;
	}
	public String getHotwater() {
		return hotwater;
	}
	public void setHotwater(String hotwater) {
		this.hotwater = hotwater;
	}
	public String getBathroom() {
		return bathroom;
	}
	public void setBathroom(String bathroom) {
		this.bathroom = bathroom;
	}
	public String getTowel() {
		return towel;
	}
	public void setTowel(String towel) {
		this.towel = towel;
	}
	public String getFreeWater() {
		return freeWater;
	}
	public void setFreeWater(String freeWater) {
		this.freeWater = freeWater;
	}
	public String getFreeSupplies() {
		return freeSupplies;
	}
	public void setFreeSupplies(String freeSupplies) {
		this.freeSupplies = freeSupplies;
	}
	public Integer getFreeSuppliesNum() {
		return freeSuppliesNum;
	}
	public void setFreeSuppliesNum(Integer freeSuppliesNum) {
		this.freeSuppliesNum = freeSuppliesNum;
	}
	public Integer getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
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
	
	public String getWindow() {
		return window;
	}
	public void setWindow(String window) {
		this.window = window;
	}
	
	
	public List<SupportingModel> getFacilities() {
		return facilities;
	}
	public void setFacilities(List<SupportingModel> facilities) {
		this.facilities = facilities;
	}
	public List<SupportingModel> getTeshs() {
		return teshs;
	}
	public void setTeshs(List<SupportingModel> teshs) {
		this.teshs = teshs;
	}
	public List<SiteImg> getImgs() {
		return imgs;
	}
	public void setImgs(List<SiteImg> imgs) {
		this.imgs = imgs;
	}
	
	
	public Integer getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(Integer breakfast) {
		this.breakfast = breakfast;
	}
	@Override
	public String toString() {
		return "r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.description as description, r.original_img as originalImg, r.thumb_img as thumbImg, r.zgui_price as zguiPrice, r.hotel_price as hotelPrice, r.isauth as isauth"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime"
				+ ", r.introduction as introduction, r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.freeWater as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.sort_order as sortOrder, r.state as state, r.create_date as createDate, r.memo as memo";
	}
	public void setComments(Map<String, Object> comments) {
		this.comments=comments;
		
	}
	public Map<String, Object> getComments() {
		return comments;
	}
	public String getNetwork() {
		return network;
	}
	public void setNetwork(String network) {
		this.network = network;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public Integer getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}
	
}


