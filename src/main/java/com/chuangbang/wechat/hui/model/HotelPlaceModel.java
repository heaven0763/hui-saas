package com.chuangbang.wechat.hui.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 大厅/客房表
 * @author mabelxiao
 * @version 2016-11-16
 */
public class HotelPlaceModel extends IdEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 所属酒店名称
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
	 * 位置
	 */
	private String location;

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
	 * 场地现场图
	 */
	private String sceneImg;  

	/**
	 * 舞台尺寸
	 */
	private String stageSize;  

	/**
	 * 场地柱子
	 */
	private Integer pillar;
	/**
	 * LED设备
	 */
	private Integer led;  

	/**
	 * 投影设备
	 */
	private Integer shadow;  

	/**
	 * 灯光设备
	 */
	private Integer lighting;  

	/**
	 * 音响设备
	 */
	private Integer audio;  


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
	 * 客房服务
	 */
	private String roomService;  

	/**
	 * 床规格
	 */
	private String 	bedSize;
	/**
	 * 床数量
	 */
	private Integer 	bedNum;
	/**
	 * 入住人数
	 */
	private Integer 	checkInNum;
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
	 * 有无早餐 0：无；1：有
	 */
	private Integer breakfast;
	
	/**
	 * 排序编号
	 */
	private Integer sortOrder;
	/**
	 * 状态
	 */
	private String state;
	/**
	 * 录入人员编号
	 */
	private String createUserId;  
	/**
	 * 录入人员
	 */
	private String createUserName;  
	/**
	 * 创建时间
	 */
	private Date createDate;  
	/**
	 * 备注
	 */
	private String memo;  


	public Long getHotelId(){  
		return hotelId;  
	}  

	public void setHotelId(Long hotelId){  
		this.hotelId = hotelId;  
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
	
	public String getLocation(){  
		return location;  
	}  

	public void setLocation(String location){  
		this.location = location;  
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
	public String getSceneImg(){  
		return sceneImg;  
	}  

	public void setSceneImg(String sceneImg){  
		this.sceneImg = sceneImg;  
	}  
	public String getStageSize(){  
		return stageSize;  
	}  

	public void setStageSize(String stageSize){  
		this.stageSize = stageSize;  
	}  

	public Integer getLed(){  
		return led;  
	}  

	public void setLed(Integer led){  
		this.led = led;  
	}  

	public Integer getShadow(){  
		return shadow;  
	}  
	public void setShadow(Integer shadow){  
		this.shadow = shadow;  
	}  

	public Integer getLighting(){  
		return lighting;  
	}  
	public void setLighting(Integer lighting){  
		this.lighting = lighting;  
	}  

	public Integer getAudio(){  
		return audio;  
	}  
	public void setAudio(Integer audio){  
		this.audio = audio;  
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

	public String getRoomService(){  
		return roomService;  
	}  
	public void setRoomService(String roomService){  
		this.roomService = roomService;  
	}  

	public String getCreateUserId(){  
		return createUserId;  
	}  

	public void setCreateUserId(String createUserId){  
		this.createUserId = createUserId;  
	}  

	public String getCreateUserName(){  
		return createUserName;  
	}  
	public void setCreateUserName(String createUserName){  
		this.createUserName = createUserName;  
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
	
	public String getWindow() {
		return window;
	}
	public void setWindow(String window) {
		this.window = window;
	}

	public Integer getBreakfast() {
		return breakfast;
	}

	public void setBreakfast(Integer breakfast) {
		this.breakfast = breakfast;
	}  
}


