package com.chuangbang.base.entity.hotel;

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
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 酒店Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_hotel")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Hotel extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/** 1
	 * 所属集团编号
	 */
	private Long pid;  
	
	/**1
	 * 所属集团名称
	 */
	private String pname;  
	
	/**1
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**1
	 * 酒店类型
	 */
	private String hotelType;  
	/**
	 * 酒店性质
	 */
	private String hotelNature;
	/**1
	 * 酒店星级
	 */
	private String hotelStar;  
	
	/**
	 * 酒店封面图片
	 */
	private String originalImg;  
	
	/**
	 * 酒店封面图片缩略图
	 */
	private String thumbImg;
	
	/**1
	 * 场地风格	
	 */
	private String style;
	/**1
	 * 交通标记	
	 */
	private String trafficSigns;
	/**1
	 * 地标	
	 */
	private String landmarks;
	/**1
	 * QQ号码	
	 */
	private String qq;
	/**1
	 * 网址
	 */
	private String 	website;
	/**1
	 * 地铁线路	
	 */
	private String line;

	
	/**1
	 * 酒店所属省份
	 */
	private Integer province;
	
	/**1
	 * 酒店所属城市
	 */
	private Integer city;  
	
	/**1
	 * 酒店所属区域
	 */
	private Integer district;  
	
	/**1
	 * 酒店所属商圈
	 */
	private Integer tradeArea;  
	
	/**1
	 * 酒店详细地址
	 */
	private String address;  
	/**
	 * 酒店经度
	 */
	private Double longitude;  
	/**
	 * 酒店纬度
	 */
	private Double latitude;  
	
	/**1
	 * SEO关键词	
	 */
	private String keyword;
	/**1
	 * SEO描述	
	 */
	private String description;
	/**1
	 * 搜索关键词	
	 */
	private String search;

	
	
	/**1
	 * 酒店简介
	 */
	private String introduction;  
	
	/**1
	 * 装修时间
	 */
	private Date decorationTime;  
	
	/**1
	 * 大厅数量
	 */
	private Integer hallNum;  
	
	/**1
	 * 客房数量
	 */
	private Integer roomNum;  
	
	
	/**1
	 * 最大大厅名称
	 */
	private String 	largestVenue;
	/**1
	 * 平均价格	
	 */
	private String averagePrice;

	
	/**1
	 * 大厅最大面积
	 */
	private String hallMaxArea;  
	
	/**1
	 * 最大可容納人数
	 */
	private Integer maxPeopleNum;  
	
	
	
	/**1
	 * 特色服务
	 */
	private String specialService;  
	
	/**1
	 * 推荐指数
	 */
	private String recommendedIndex;  
	
	/**1
	 * 评论指数
	 */
	private String reviewIndex;
	
	
	/**1
	 * 联系人
	 */
	private String contact;  
	
	/**1
	 * 联系固话
	 */
	private String telephone;  
	
	/**1
	 * 联系手机
	 */
	private String mobile;  
	/**1
	 * 传真
	 */
	private String fax; 
	/**1
	 * 邮箱
	 */
	private String email;  
	
	
	/**1
	 * 场地标签
	 */
	private String tag;  
	
	/**1
	 * 酒店状态
	 */
	private String state;  
	
	
	/**1
	 * 认证时间	
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date certifiTime;
	/**1
	 * 实地认证
	 */
	private Integer verify;
	/**1
	 * 热门场地	
	 */
	private Integer isHot;
	/**1
	 * 推荐场地	
	 */
	private Integer isTui;
	/**1
	 * 优质场地	
	 */
	private Integer isbest;
	
	/**
	 * 浏览量	
	 */
	private Integer browse;
	/**1
	 * 排序编号	
	 */
	private Integer sortOrder;

	/**1
	 * 酒店开拓人员编号
	 */
	private String reclaimUserId;  
	
	/**
	 * 酒店开拓人员姓名
	 */
	private String reclaimUserName;  
	
	/**
	 * 录入人员编号
	 */
	private String createUserId;  
	
	/**
	 * 录入人员姓名
	 */
	private String createUserName;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date updateDate;
	
	/**1
	 * 备注
	 */
	private String memo;  
	
	
	private Long companyId;
	
	/**
	 * 会场预定备注
	 */
	private String meetingRemark;
	/**
	 * 住房预定备注
	 */
	private String houseRemark;
	/**
	 * 用餐预定备注
	 */
	private String dinnerRemark;
  
	private String logo;
	/**
	 * 目的
	 */
	private String purpose;
	/**
	 * 交易保证金
	 */
	private Double tradeKicker;
	
	/**
	 * 围餐餐标
	 */
	private Double tbmealAmount;
	
	/**
	 * 自助餐餐标
	 */
	private Double buffetAmount;
    public Long getPid(){  
      return pid;  
    }  
    public void setPid(Long pid){  
      this.pid = pid;  
    }  
    
    @Column(length=50)
    public String getPname(){  
      return pname;  
    }  
    public void setPname(String pname){  
      this.pname = pname;  
    }  
    
    @Column(length=50)
    public String getHotelName(){  
      return hotelName;  
    }  
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }  
    
    @Column(length=50)
    public String getHotelType(){  
      return hotelType;  
    }  
    public void setHotelType(String hotelType){  
      this.hotelType = hotelType;  
    }  
    
    @Column(length=50)
    public String getHotelStar(){  
      return hotelStar;  
    }  
    public void setHotelStar(String hotelStar){  
      this.hotelStar = hotelStar;  
    }  
    
    public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}
	
	public Integer getDistrict() {
		return district;
	}
	public void setDistrict(Integer district) {
		this.district = district;
	}
	
	public Integer getTradeArea() {
		return tradeArea;
	}
	public void setTradeArea(Integer tradeArea) {
		this.tradeArea = tradeArea;
	}
	
	public Integer getProvince() {
		return province;
	}
	public void setProvince(Integer province) {
		this.province = province;
	}

	
	
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	
	
	@Column(length=500)
    public String getAddress(){  
      return address;  
    }  
    public void setAddress(String address){  
      this.address = address;  
    }  

    @Column(columnDefinition="text")
    public String getIntroduction(){  
      return introduction;  
    }  
    public void setIntroduction(String introduction){  
      this.introduction = introduction;  
    }  
  
    public Date getDecorationTime(){  
      return decorationTime;  
    }  
    public void setDecorationTime(Date decorationTime){  
      this.decorationTime = decorationTime;  
    }  
  
    public Integer getHallNum(){  
      return hallNum;  
    }  
    public void setHallNum(Integer hallNum){  
      this.hallNum = hallNum;  
    }  
  
    public Integer getRoomNum(){  
      return roomNum;  
    }  
    public void setRoomNum(Integer roomNum){  
      this.roomNum = roomNum;  
    }  
    
    @Column(length=50)
    public String getHallMaxArea(){  
      return hallMaxArea;  
    }  
    public void setHallMaxArea(String hallMaxArea){  
      this.hallMaxArea = hallMaxArea;  
    }  
  
    public Integer getMaxPeopleNum(){  
      return maxPeopleNum;  
    }  
    public void setMaxPeopleNum(Integer maxPeopleNum){  
      this.maxPeopleNum = maxPeopleNum;  
    }  
    
    @Column(columnDefinition="text")
    public String getSpecialService(){  
      return specialService;  
    }  
    public void setSpecialService(String specialService){  
      this.specialService = specialService;  
    }  
    
    @Column(length=50)
    public String getRecommendedIndex(){  
      return recommendedIndex;  
    }  
    public void setRecommendedIndex(String recommendedIndex){  
      this.recommendedIndex = recommendedIndex;  
    }  
    
    @Column(length=50)
    public String getReviewIndex(){  
      return reviewIndex;  
    }  
    public void setReviewIndex(String reviewIndex){  
      this.reviewIndex = reviewIndex;  
    }  
    
    
    @Column(length=50)
    public String getEmail(){  
      return email;  
    }  
    public void setEmail(String email){  
      this.email = email;  
    }  
    
    @Column(length=500)
    public String getTag(){  
      return tag;  
    }  
    public void setTag(String tag){  
      this.tag = tag;  
    }  
    
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
  
  
    public Integer getIsbest(){  
      return isbest;  
    }  
    public void setIsbest(Integer isbest){  
      this.isbest = isbest;  
    }  
    
    @Column(length=50)
    public String getReclaimUserId(){  
      return reclaimUserId;  
    }  
    public void setReclaimUserId(String reclaimUserId){  
      this.reclaimUserId = reclaimUserId;  
    }  
    
    @Column(length=50)
    public String getReclaimUserName(){  
      return reclaimUserName;  
    }  
    public void setReclaimUserName(String reclaimUserName){  
      this.reclaimUserName = reclaimUserName;  
    } 
    
    @Column(length=50)
    public String getCreateUserId(){  
      return createUserId;  
    }  
    public void setCreateUserId(String createUserId){  
      this.createUserId = createUserId;  
    }  
    
    @Column(length=50)
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
    
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=500)
	public String getOriginalImg() {
		return originalImg;
	}
	public void setOriginalImg(String originalImg) {
		this.originalImg = originalImg;
	}

    @Column(length=50)
	public String getThumbImg() {
		return thumbImg;
	}
	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}
    
    @Column(length=500)
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
    
    @Column(length=50)
	public String getTrafficSigns() {
		return trafficSigns;
	}
	public void setTrafficSigns(String trafficSigns) {
		this.trafficSigns = trafficSigns;
	}
    
    @Column(length=50)
	public String getLandmarks() {
		return landmarks;
	}
	public void setLandmarks(String landmarks) {
		this.landmarks = landmarks;
	}
    
    @Column(length=50)
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
    
    @Column(length=100)
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
    
    @Column(length=50)
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
    
   
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getLargestVenue() {
		return largestVenue;
	}
	public void setLargestVenue(String largestVenue) {
		this.largestVenue = largestVenue;
	}
	public String getAveragePrice() {
		return averagePrice;
	}
	public void setAveragePrice(String averagePrice) {
		this.averagePrice = averagePrice;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public Date getCertifiTime() {
		return certifiTime;
	}
	public void setCertifiTime(Date certifiTime) {
		this.certifiTime = certifiTime;
	}
	public Integer getVerify() {
		return verify;
	}
	public void setVerify(Integer verify) {
		this.verify = verify;
	}
	public Integer getIsHot() {
		return isHot;
	}
	public void setIsHot(Integer isHot) {
		this.isHot = isHot;
	}
	public Integer getIsTui() {
		return isTui;
	}
	public void setIsTui(Integer isTui) {
		this.isTui = isTui;
	}
	
	public Integer getBrowse() {
		return browse;
	}
	public void setBrowse(Integer browse) {
		this.browse = browse;
	}
	
	public Integer getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}
	
	@Column(length=50)
	public String getHotelNature() {
		return hotelNature;
	}
	public void setHotelNature(String hotelNature) {
		this.hotelNature = hotelNature;
	}
	
	public Long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	
	@Column(columnDefinition="text")
	public String getMeetingRemark() {
		return meetingRemark;
	}
	public void setMeetingRemark(String meetingRemark) {
		this.meetingRemark = meetingRemark;
	}
	
	@Column(columnDefinition="text")
	public String getHouseRemark() {
		return houseRemark;
	}
	public void setHouseRemark(String houseRemark) {
		this.houseRemark = houseRemark;
	}
	
	@Column(columnDefinition="text")
	public String getDinnerRemark() {
		return dinnerRemark;
	}
	public void setDinnerRemark(String dinnerRemark) {
		this.dinnerRemark = dinnerRemark;
	}
	
	@Column(length=500)
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	@Column(length=500)
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	
	public Double getTradeKicker() {
		return tradeKicker;
	}
	public void setTradeKicker(Double tradeKicker) {
		this.tradeKicker = tradeKicker;
	}
	
	
	public Double getTbmealAmount() {
		return tbmealAmount;
	}
	public void setTbmealAmount(Double tbmealAmount) {
		this.tbmealAmount = tbmealAmount;
	}
	public Double getBuffetAmount() {
		return buffetAmount;
	}
	public void setBuffetAmount(Double buffetAmount) {
		this.buffetAmount = buffetAmount;
	}
	@Override
	public String toString() {
		return "h.id as id,h.pid as pid, h.p_name as pName, h.hotel_name as h.hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.original_img as originalImg"
				+ ", h.thumb_img as thumbImg, h.style as style, h.traffic_signs as trafficSigns, h.landmarks as landmarks, h.qq as qq, h.website as website, h.line as line"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.keyword as keyword, h.description as description, h.search as search, h.introduction as introduction, h.decoration_time as decorationTime, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largestVenue as largestVenue, h.averagePrice as averagePrice, h.hallMaxArea as hallMaxArea, h.maxPeopleNum as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.mobile as mobile, h.fax as fax, h.email as email, h.tag as tag, h.state as state, h.certifi_time as certifiTime, h.verify as verify, h.is_hot as isHot"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.reclaim_user_id as reclaimUserId, h.reclaim_user_name as reclaimUserName"
				+ ", h.create_user_id as createUserId, h.create_user_name as createUserName, h.create_date as createDate, h.memo as memo"
				+ ", h.meeting_remark as meetingRemark, h.house_remark as houseRemark, h.dinner_remark as dinnerRemark";
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}  
    
}


