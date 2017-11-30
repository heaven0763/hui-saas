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
 * 档期预定信息
 * @author mabelxiao
 * @version 2016-11-16
 */
public class ScheduleBookingModel extends IdEntity implements Serializable {
	
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
	 * 订单编号
	 */
	private String orderNo; 
	/**
	 * 订单编号
	 */
	private Long orderDetailId; 
	/**
	 * 类型；场地、用餐       01	活动场地；02	住房；03	用餐
	 */
	private String type; 
	/**
	 * 所属场地编号
	 */
	private Long placeId;  
	
	/**
	 * 所属场地名称
	 */
	private String placeName;
	
	/**
	 * 场地档期
	 */
	private Long placeScheduleId;
	/**
	 * 档期日期/入住时间/用餐时间
	 */
	private String placeDate;
	/**
	 * 档期时间，上午，中午，下午，晚上
	 */
	private String placeSchedule;
	/**
	 * 单价
	 */
	private Double price;
	
	/**
	 * 客户来源
	 */
	private String clientFrom;  
	
	/**
	 * 客户编号
	 */
	private String clientId;  
	
	/**
	 * 活动主办单位
	 */
	private String organizer;  
	
	/**
	 * 联系人
	 */
	private String linkman;  
	
	/**
	 * 联系电话
	 */
	private String contactNumber;  
	
	/**
	 * 销售人员编号
	 */
	private String companySaleId;  
	
	/**
	 * 销售人员姓名
	 */
	private String companySaleName;  
	
	/**
	 * 是否已付定金
	 */
	private String isdeposit;  
	
	/**
	 * 预定日期
	 */
	private Date depositDate;  
	
	/**
	 * 创建时间
	 */
	private Date createDate; 
	/**
	 * 数量
	 */
	private Long quantity;
	
	/**
	 * 状态 ：1	预订； 2	已支付订金
	 */
	private String state;
	/**
	 * 备注
	 */
	private String memo;  
	
	private String hotelSaleId;
	private String hotelSaleName;
	
	/**
	 * 酒店跟进销售人员手机
	 */
	private String hotelSalePhone;
	
	/**
	 * 酒店跟进销售人员手机
	 */
	private String activityTitle;
	
	/**
	 * 订单来源应用编号0:saas系统内部
	 */
	private Long sourceAppId;
	
	private String description;
	
    public Long getSourceAppId() {
		return sourceAppId;
	}
	public void setSourceAppId(Long sourceAppId) {
		this.sourceAppId = sourceAppId;
	}
	public String getHotelSalePhone() {
		return hotelSalePhone;
	}
	public void setHotelSalePhone(String hotelSalePhone) {
		this.hotelSalePhone = hotelSalePhone;
	}
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getHotelSaleName() {
		return hotelSaleName;
	}
	public void setHotelSaleName(String hotelSaleName) {
		this.hotelSaleName = hotelSaleName;
	}
	public String getClientFrom(){  
      return clientFrom;  
    }  
    public void setClientFrom(String clientFrom){  
      this.clientFrom = clientFrom;  
    }  
  
    public String getClientId(){  
      return clientId;  
    }  
    public void setClientId(String clientId){  
      this.clientId = clientId;  
    }  
    
    public String getOrganizer(){  
      return organizer;  
    }  
    public void setOrganizer(String organizer){  
      this.organizer = organizer;  
    } 
    
    public String getLinkman(){  
      return linkman;  
    }  
    public void setLinkman(String linkman){  
      this.linkman = linkman;  
    }  
    
    public String getContactNumber(){  
      return contactNumber;  
    }  
    public void setContactNumber(String contactNumber){  
      this.contactNumber = contactNumber;  
    }  
    
    public String getCompanySaleId(){  
      return companySaleId;  
    }  
    public void setCompanySaleId(String companySaleId){  
      this.companySaleId = companySaleId;  
    }  
    
    public String getCompanySaleName(){  
      return companySaleName;  
    }  
    public void setCompanySaleName(String companySaleName){  
      this.companySaleName = companySaleName;  
    }  
    
    public String getIsdeposit(){  
      return isdeposit;  
    }  
    public void setIsdeposit(String isdeposit){  
      this.isdeposit = isdeposit;  
    }  
  
    public Date getDepositDate(){  
      return depositDate;  
    }  
    public void setDepositDate(Date depositDate){  
      this.depositDate = depositDate;  
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

	public Long getHotelId() {
		return hotelId;
	}
	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}
	
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Long getPlaceScheduleId() {
		return placeScheduleId;
	}
	public void setPlaceScheduleId(Long placeScheduleId) {
		this.placeScheduleId = placeScheduleId;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public Long getOrderDetailId() {
		return orderDetailId;
	}
	public void setOrderDetailId(Long orderDetailId) {
		this.orderDetailId = orderDetailId;
	}
	
	public String getHotelSaleId() {
		return hotelSaleId;
	}
	
	public void setHotelSaleId(String hotelSaleId) {
		this.hotelSaleId = hotelSaleId;
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
	public String getActivityTitle() {
		return activityTitle;
	}
	public void setActivityTitle(String activityTitle) {
		this.activityTitle = activityTitle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}


