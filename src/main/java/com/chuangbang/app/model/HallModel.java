package com.chuangbang.app.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.base.entity.order.ScheduleBooking;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;


public class HallModel {

	/**
	 * 大厅编号
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
	 * 场地类型
	 */
	private String placeType;  

	/**
	 * 场地名称
	 */
	private String placeName;  


	/**
	 * 推荐指数
	 */
	private String recommendedIndex;  

	/**
	 * 场地说明
	 */
	private String description;  


	/**
	 * 场地封面图片	
	 */
	private String originalImg;
	/**
	 * 场地封面图片缩略图	
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
	 * 推荐场地
	 */
	private Integer isrecommend;  

	/**
	 * 优质场地
	 */
	private Integer isbest;  

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
	 * 装修时间
	 */
	private Date decorationTime;  

	/**
	 * 用电功率
	 */
	private String electricPower;  

	/**
	 * 大厅介绍
	 */
	private String introduction; 
	
	
	/**
	 * 排序编号
	 */
	private Integer sortOrder;
	/**
	 * 状态
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
	
	/**
	 * 档期
	 */
	List<ScheduleModel> schedules = Lists.newArrayList();
	/**
	 * 价格
	 */
	List<PlacePrice> prices = Lists.newArrayList();
	
	/**
	 * 配套设施
	 */
	List<SupportingModel> supportings = Lists.newArrayList();
	/**
	 * 大厅摆放
	 */
	List<SupportingModel> halldisplay = Lists.newArrayList();
	
	/**
	 * 图片列表
	 */
	List<SiteImg> imgs =Lists.newArrayList();
	/**
	 * 评论列表
	 */
	Map<String, Object> comments =Maps.newHashMap();
	
	/**
	 * 符合
	 */
	private String inLineWith;
	
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

	public Long getHotelId(){  
		return hotelId;  
	}  
	public void setHotelId(Long hotelId){  
		this.hotelId = hotelId;  
	}  
	
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getPlaceType(){  
		return placeType;  
	}  
	public void setPlaceType(String placeType){  
		this.placeType = placeType;  
	}  
	
	public String getPlaceName(){  
		return placeName;  
	}  
	public void setPlaceName(String placeName){  
		this.placeName = placeName;  
	}  
	
	public String getRecommendedIndex(){  
		return recommendedIndex;  
	}  
	public void setRecommendedIndex(String recommendedIndex){  
		this.recommendedIndex = recommendedIndex;  
	}  
	
	public String getDescription(){  
		return description;  
	}  
	public void setDescription(String description){  
		this.description = description;  
	}  
	
	public Double getZguiPrice(){  
		return zguiPrice;  
	}  
	public void setZguiPrice(Double zguiPrice){  
		this.zguiPrice = zguiPrice;  
	}  

	public Double getHotelPrice(){  
		return hotelPrice;  
	}  
	public void setHotelPrice(Double hotelPrice){  
		this.hotelPrice = hotelPrice;  
	}  

	public Integer getIsauth(){  
		return isauth;  
	}  
	public void setIsauth(Integer isauth){  
		this.isauth = isauth;  
	}  

	public Integer getIsrecommend(){  
		return isrecommend;  
	}  
	public void setIsrecommend(Integer isrecommend){  
		this.isrecommend = isrecommend;  
	}  

	public Integer getIsbest(){  
		return isbest;  
	}  
	public void setIsbest(Integer isbest){  
		this.isbest = isbest;  
	}  
	
	public String getHallArea(){  
		return hallArea;  
	}  

	public void setHallArea(String hallArea){  
		this.hallArea = hallArea;  
	}  

	public String getLength(){  
		return length;  
	}  

	public void setLength(String length){  
		this.length = length;  
	}  
	
	public String getWidth(){  
		return width;  
	}  
	public void setWidth(String width){  
		this.width = width;  
	}  
	
	public String getHeight(){  
		return height;  
	}  
	public void setHeight(String height){  
		this.height = height;  
	}  
	
	public String getFloor(){  
		return floor;  
	}  
	public void setFloor(String floor){  
		this.floor = floor;  
	}  

	public Integer getPillar(){  
		return pillar;  
	}  
	public void setPillar(Integer pillar){  
		this.pillar = pillar;  
	}  

	public Long getPeopleNum(){  
		return peopleNum;  
	}  
	public void setPeopleNum(Long peopleNum){  
		this.peopleNum = peopleNum;  
	}  

	public Date getDecorationTime(){  
		return decorationTime;  
	}  
	public void setDecorationTime(Date decorationTime){  
		this.decorationTime = decorationTime;  
	}  

	public String getElectricPower(){  
		return electricPower;  
	}  
	public void setElectricPower(String electricPower){  
		this.electricPower = electricPower;  
	}  

	public String getIntroduction(){  
		return introduction;  
	}  
	public void setIntroduction(String introduction){  
		this.introduction = introduction;  
	}  

	public Date getCreateDate(){  
		return createDate;  
	}  
	public void setCreateDate(Date createDate){  
		this.createDate = createDate;  
	}  

	public String getMemo(){  
		return memo;  
	}  
	public void setMemo(String memo){  
		this.memo = memo;  
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

	public Integer getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Date getAuthDate() {
		return authDate;
	}
	public void setAuthDate(Date authDate) {
		this.authDate = authDate;
	}

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "h.id as id, h.hotel_id as hotelId, h.place_type as placeType, h.place_name as placeName, h.recommended_index as recommendedIndex, h.description as description, location as location"
				+ ", h.original_img as originalImg, h.thumb_img as thumbImg, h.zgui_price as zguiPrice, h.hotel_price as hotelPrice, h.isauth as isauth, h.auth_date as authDate, h.isrecommend as isrecommend"
				+ ", h.isbest as isbest, h.hall_area as hallArea, h.length as length, h.width as width, h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.decoration_time as decorationTime"
				+ ", h.electric_power as electricPower, h.introduction as introduction, h.sort_order as sortOrder, h.state as state, h.create_date as createDate, h.memo as memo";
	}

	
	public List<ScheduleModel> getSchedules() {
		return schedules;
	}

	public void setSchedules(List<ScheduleModel> schedules) {
		this.schedules = schedules;
	}

	public List<PlacePrice> getPrices() {
		return prices;
	}

	public void setPrices(List<PlacePrice> prices) {
		this.prices = prices;
	}

	public List<SupportingModel> getSupportings() {
		return supportings;
	}

	public void setSupportings(List<SupportingModel> supportings) {
		this.supportings = supportings;
	}

	public List<SupportingModel> getHalldisplay() {
		return halldisplay;
	}

	public void setHalldisplay(List<SupportingModel> halldisplay) {
		this.halldisplay = halldisplay;
	}

	public List<SiteImg> getImgs() {
		return imgs;
	}

	public void setImgs(List<SiteImg> imgs) {
		this.imgs = imgs;
	}

	public Map<String, Object> getComments() {
		return comments;
	}

	public void setComments(Map<String, Object> comments) {
		this.comments = comments;
	}

	public String getInLineWith() {
		return inLineWith;
	}
	public void setInLineWith(String inLineWith) {
		this.inLineWith = inLineWith;
	}  
	
}


