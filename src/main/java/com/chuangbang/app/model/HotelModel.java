package com.chuangbang.app.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chuangbang.base.entity.hotel.SiteImg;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;


public class HotelModel{
	/**
	 * 酒店编号
	 */
	private Long id;  
	/**
	 * 所属集团编号
	 */
	private Long pid;  
	
	/**
	 * 所属集团名称
	 */
	private String pName;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 酒店类型
	 */
	private String hotelType;
	/**
	 * 酒店类型
	 */
	private String hotelTypeText;
	
	/**
	 * 酒店星级
	 */
	private String hotelStar;  
	/**
	 * 酒店星级
	 */
	private String hotelStarText;
	
	/**
	 * 酒店封面图片
	 */
	private String originalImg;  
	
	/**
	 * 酒店封面图片缩略图
	 */
	private String thumbImg;
	
	/**
	 * 场地风格	
	 */
	private String style;
	/**
	 * 交通标记	
	 */
	private String trafficSigns;
	/**
	 * 地标	
	 */
	private String landmarks;
	/**
	 * QQ号码	
	 */
	private String qq;
	/**
	 * 网址
	 */
	private String 	website;
	/**
	 * 地铁线路	
	 */
	private String line;

	
	/**
	 * 酒店所属省份
	 */
	private Integer province;
	
	private String provinceText;
	
	/**
	 * 酒店所属城市
	 */
	private Integer city;  
	
	private String cityText;
	/**
	 * 酒店所属区域
	 */
	private Integer district;  
	
	private String districtText;
	
	/**
	 * 酒店所属商圈
	 */
	private Integer tradeArea;  
	
	/**
	 * 酒店所属商圈
	 */
	private String tradeAreaText;
	/**
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
	/**
	 * 距离
	 */
	private Double distance;
	/**
	 * SEO关键词	
	 */
	private String keyword;
	/**
	 * SEO描述	
	 */
	private String description;
	/**
	 * 搜索关键词	
	 */
	private String search;
	
	/**
	 * 酒店简介
	 */
	private String introduction;  
	
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
	 * 最大大厅名称
	 */
	private String 	largestVenue;
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
	
	/**
	 * 特色服务
	 */
	private String specialService;  
	
	/**
	 * 推荐指数
	 */
	private String recommendedIndex;  
	
	/**
	 * 评论指数
	 */
	private String reviewIndex;
	/**
	 * 联系人
	 */
	private String contact;  
	
	/**
	 * 联系固话
	 */
	private String telephone;  
	
	/**
	 * 联系手机
	 */
	private String mobile;  
	/**
	 * 传真
	 */
	private String fax; 
	/**
	 * 邮箱
	 */
	private String email;  
	
	/**
	 * 场地标签
	 */
	private String tag;  
	
	/**
	 * 酒店状态
	 */
	private String state;  
	
	
	/**
	 * 认证时间	
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date certifiTime;
	/**
	 * 实地认证
	 */
	private Integer verify;
	/**
	 * 热门场地	
	 */
	private Integer isHot;
	/**
	 * 推荐场地	
	 */
	private Integer isTui;
	/**
	 * 优质场地	
	 */
	private Integer isbest;
	/**
	 * 浏览量	
	 */
	private Integer browse;
	/**
	 * 排序编号	
	 */
	private Integer sortOrder;

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
	/**
	 * 备注
	 */
	private String memo;  
	
	/**
	 * 申请加入状态
	 */
	private String applyState;
	
	/**
	 * 加入状态
	 */
	private String joinState;
	
	/**
	 * 申请记录id
	 */
	private String recordId;
	
	/**
	 * 申请记录中用户id
	 */
	private String userId;
	
	/**
	 * 申请记录中state
	 */
	private String recordState;
	
	/**
	 * 成交数
	 */
	Long dealNum;
	
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
	
	
	/**
	 * 大厅列表
	 */
	List<Map<String, Object>> halls = Lists.newArrayList();
	/**
	 * 客房列表
	 */
	List<RoomModel> rooms = Lists.newArrayList();
	/**
	 * 配套服务
	 */
	List<SupportingModel> supports = Lists.newArrayList();
	
	/**
	 * 场地风格
	 */
	List<SupportingModel> styles = Lists.newArrayList();
	/**
	 * 图片列表
	 */
	List<Map<String,Object>> imgs = Lists.newArrayList();
	
	/**
	 * 评论列表
	 */
	Map<String,Object> comments =Maps.newHashMap();
	
	/**
	 * 客房服务
	 */
	List<SupportingModel> roomservices = Lists.newArrayList();
	
	private Double tradeKicker; 
	public Double getTradeKicker() {
		return tradeKicker;
	}
	public void setTradeKicker(Double tradeKicker) {
		this.tradeKicker = tradeKicker;
	}

	private String reclaimUserName;
	
	private Double roomPrice;
	private Double hallPrice;
	private Integer qsbednum;
	private Integer dualbednum;
	private Double tbmealAmount;
	private Double buffetAmount;
	
    public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getPid(){  
      return pid;  
    }  
    public void setPid(Long pid){  
      this.pid = pid;  
    }  
    public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getHotelName(){  
      return hotelName;  
    }  
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }  
    
    public String getHotelType(){  
      return hotelType;  
    }  
    public void setHotelType(String hotelType){  
      this.hotelType = hotelType;  
    }  
    
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
	
	
    public String getAddress(){  
      return address;  
    }  
    public void setAddress(String address){  
      this.address = address;  
    }  

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
    
    public String getSpecialService(){  
      return specialService;  
    }  
    public void setSpecialService(String specialService){  
      this.specialService = specialService;  
    }  
    
    public String getRecommendedIndex(){  
      return recommendedIndex;  
    }  
    public void setRecommendedIndex(String recommendedIndex){  
      this.recommendedIndex = recommendedIndex;  
    }  
    
    public String getReviewIndex(){  
      return reviewIndex;  
    }  
    public void setReviewIndex(String reviewIndex){  
      this.reviewIndex = reviewIndex;  
    }  
    
    public String getEmail(){  
      return email;  
    }  
    public void setEmail(String email){  
      this.email = email;  
    }  
    
    public String getTag(){  
      return tag;  
    }  
    public void setTag(String tag){  
      this.tag = tag;  
    }  
    
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
    
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
    
	public String getTrafficSigns() {
		return trafficSigns;
	}
	public void setTrafficSigns(String trafficSigns) {
		this.trafficSigns = trafficSigns;
	}
    
	public String getLandmarks() {
		return landmarks;
	}
	public void setLandmarks(String landmarks) {
		this.landmarks = landmarks;
	}
    
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
    
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
    
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
	public Long getDealNum() {
		return dealNum;
	}
	public void setDealNum(Long dealNum) {
		this.dealNum = dealNum;
	}
	public List<Map<String, Object>> getHalls() {
		return halls;
	}
	public void setHalls(List<Map<String, Object>> halls) {
		this.halls = halls;
	}
	public List<RoomModel> getRooms() {
		return rooms;
	}
	public void setRooms(List<RoomModel> rooms) {
		this.rooms = rooms;
	}
	public List<SupportingModel> getSupports() {
		return supports;
	}
	public void setSupports(List<SupportingModel> supports) {
		this.supports = supports;
	}
	public List<Map<String,Object>> getImgs() {
		return imgs;
	}
	public void setImgs(List<Map<String,Object>> imgs) {
		this.imgs = imgs;
	}
	public String getHotelTypeText() {
		return hotelTypeText;
	}
	public void setHotelTypeText(String hotelTypeText) {
		this.hotelTypeText = hotelTypeText;
	}
	public String getHotelStarText() {
		return hotelStarText;
	}
	public void setHotelStarText(String hotelStarText) {
		this.hotelStarText = hotelStarText;
	}
	public String getProvinceText() {
		return provinceText;
	}
	public void setProvinceText(String provinceText) {
		this.provinceText = provinceText;
	}
	public String getCityText() {
		return cityText;
	}
	public void setCityText(String cityText) {
		this.cityText = cityText;
	}
	
	public String getTradeAreaText() {
		return tradeAreaText;
	}
	public void setTradeAreaText(String tradeAreaText) {
		this.tradeAreaText = tradeAreaText;
	}
	
	public String getDistrictText() {
		return districtText;
	}
	public void setDistrictText(String districtText) {
		this.districtText = districtText;
	}
	
	public Double getDistance() {
		if(distance==null){
			distance = 0.0D;
		}
		return distance;
	}
	public void setDistance(Double distance) {
		this.distance = distance;
	}
	public List<SupportingModel> getStyles() {
		return styles;
	}
	public void setStyles(List<SupportingModel> styles) {
		this.styles = styles;
	}
	
	public List<SupportingModel> getRoomservices() {
		return roomservices;
	}
	public void setRoomservices(List<SupportingModel> roomservices) {
		this.roomservices = roomservices;
	}
	
	public Map<String, Object> getComments() {
		return comments;
	}
	public void setComments(Map<String, Object> comments) {
		this.comments = comments;
	}
	public String getApplyState() {
		return applyState;
	}
	public void setApplyState(String applyState) {
		this.applyState = applyState;
	}
	public String getRecordId() {
		return recordId;
	}
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getJoinState() {
		return joinState;
	}
	public void setJoinState(String joinState) {
		this.joinState = joinState;
	}
	public String getRecordState() {
		return recordState;
	}
	public void setRecordState(String recordState) {
		this.recordState = recordState;
	}
	public String getReclaimUserName() {
		return reclaimUserName;
	}
	public void setReclaimUserName(String reclaimUserName) {
		this.reclaimUserName = reclaimUserName;
	}
	
	public String getMeetingRemark() {
		return meetingRemark;
	}
	public void setMeetingRemark(String meetingRemark) {
		this.meetingRemark = meetingRemark;
	}
	public String getHouseRemark() {
		return houseRemark;
	}
	public void setHouseRemark(String houseRemark) {
		this.houseRemark = houseRemark;
	}
	public String getDinnerRemark() {
		return dinnerRemark;
	}
	public void setDinnerRemark(String dinnerRemark) {
		this.dinnerRemark = dinnerRemark;
	}
	
	public Double getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(Double roomPrice) {
		this.roomPrice = roomPrice;
	}
	
	public Double getHallPrice() {
		return hallPrice;
	}
	public void setHallPrice(Double hallPrice) {
		this.hallPrice = hallPrice;
	}
	
	public Integer getQsbednum() {
		return qsbednum;
	}
	public void setQsbednum(Integer qsbednum) {
		this.qsbednum = qsbednum;
	}
	
	public Integer getDualbednum() {
		return dualbednum;
	}
	public void setDualbednum(Integer dualbednum) {
		this.dualbednum = dualbednum;
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
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "HotelModel [id=" + id + ", pid=" + pid + ", pName=" + pName + ", hotelName=" + hotelName
				+ ", hotelType=" + hotelType + ", hotelTypeText=" + hotelTypeText + ", hotelStar=" + hotelStar
				+ ", hotelStarText=" + hotelStarText + ", originalImg=" + originalImg + ", thumbImg=" + thumbImg
				+ ", style=" + style + ", trafficSigns=" + trafficSigns + ", landmarks=" + landmarks + ", qq=" + qq
				+ ", website=" + website + ", line=" + line + ", province=" + province + ", provinceText="
				+ provinceText + ", city=" + city + ", cityText=" + cityText + ", district=" + district
				+ ", districtText=" + districtText + ", tradeArea=" + tradeArea + ", tradeAreaText=" + tradeAreaText
				+ ", address=" + address + ", longitude=" + longitude + ", latitude=" + latitude + ", distance="
				+ distance + ", keyword=" + keyword + ", description=" + description + ", search=" + search
				+ ", introduction=" + introduction + ", decorationTime=" + decorationTime + ", hallNum=" + hallNum
				+ ", roomNum=" + roomNum + ", largestVenue=" + largestVenue + ", averagePrice=" + averagePrice
				+ ", hallMaxArea=" + hallMaxArea + ", maxPeopleNum=" + maxPeopleNum + ", specialService="
				+ specialService + ", recommendedIndex=" + recommendedIndex + ", reviewIndex=" + reviewIndex
				+ ", contact=" + contact + ", telephone=" + telephone + ", mobile=" + mobile + ", fax=" + fax
				+ ", email=" + email + ", tag=" + tag + ", state=" + state + ", certifiTime=" + certifiTime
				+ ", verify=" + verify + ", isHot=" + isHot + ", isTui=" + isTui + ", isbest=" + isbest + ", browse="
				+ browse + ", sortOrder=" + sortOrder + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ ", memo=" + memo + ", applyState=" + applyState + ", joinState=" + joinState + ", recordId="
				+ recordId + ", userId=" + userId + ", recordState=" + recordState + ", dealNum=" + dealNum
				+ ", meetingRemark=" + meetingRemark + ", houseRemark=" + houseRemark + ", dinnerRemark=" + dinnerRemark
				+ ", halls=" + halls + ", rooms=" + rooms + ", supports=" + supports + ", styles=" + styles + ", imgs="
				+ imgs + ", comments=" + comments + ", roomservices=" + roomservices + ", tradeKicker=" + tradeKicker
				+ ", reclaimUserName=" + reclaimUserName + ", roomPrice=" + roomPrice + ", hallPrice=" + hallPrice
				+ ", qsbednum=" + qsbednum + ", dualbednum=" + dualbednum + ", tbmealAmount=" + tbmealAmount
				+ ", buffetAmount=" + buffetAmount + "]";
	}
	
	
	
}


