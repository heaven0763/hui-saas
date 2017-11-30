package com.chuangbang.base.entity.order;

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
 * 档期预定信息Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_scheduleBooking")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ScheduleBooking extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店编号
	 */
	private Long hotelId;  
	/**
	 * 订单编号
	 */
	private String orderNo; 
	/**
	 * 订单详细编号
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
	 * 状态 ：1	预订； 2	已支付订金；3 不可预订；4 取消
	 */
	private String state;
	/**
	 * 酒店销售编号
	 */
	private String hotelSaleId;  
	
	/**
	 * 酒店销售姓名
	 */
	private String hotelSaleName; 
	/**
	 * 酒店销售电话号码
	 */
	private String hotelSaleMobile; 
	/**
	 * 备注
	 */
	private String memo;  
	/**
	 * 订单来源应用编号0:saas系统内部
	 */
	private Long sourceAppId;
	
	private String breakfast;
	
	private Long mealnum;
	
	private String mealType;

	
    @Column(length=50)
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
    
    @Column(length=50)
    public String getOrganizer(){  
      return organizer;  
    }  
    public void setOrganizer(String organizer){  
      this.organizer = organizer;  
    } 
    
    @Column(length=50)
    public String getLinkman(){  
      return linkman;  
    }  
    public void setLinkman(String linkman){  
      this.linkman = linkman;  
    }  
    
    @Column(length=50)
    public String getContactNumber(){  
      return contactNumber;  
    }  
    public void setContactNumber(String contactNumber){  
      this.contactNumber = contactNumber;  
    }  
    
    @Column(length=50)
    public String getCompanySaleId(){  
      return companySaleId;  
    }  
    public void setCompanySaleId(String companySaleId){  
      this.companySaleId = companySaleId;  
    }  
    
    @Column(length=50)
    public String getCompanySaleName(){  
      return companySaleName;  
    }  
    public void setCompanySaleName(String companySaleName){  
      this.companySaleName = companySaleName;  
    }  
    
    @Column(length=50)
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
    
    @Column(length=500)
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
	
	@Column(length=50)
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
	
	@Column(length=5)
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	@Column(length=50)
	public String getPlaceDate() {
		return placeDate;
	}
	public void setPlaceDate(String placeDate) {
		this.placeDate = placeDate;
	}

	@Column(length=50)
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
	
	@Column(length=5)
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
	
	public ScheduleBooking(Long hotelId, String orderNo, Long orderDetailId, String type, Long placeId,
			Long placeScheduleId, String placeDate, String placeSchedule, Double price,Long quantity,Long sourceAppId, String clientFrom,
			String clientId, String organizer, String linkman, String contactNumber, String companySaleId,String companySaleName, String isdeposit,
			 Date depositDate, Date createDate, String state, String memo,String hotelSaleId,String hotelSaleName,String hotelSaleMobile
			 ,String breakfast,String mealType,Long mealnum) {
		super();
		this.hotelId = hotelId;
		this.orderNo = orderNo;
		this.orderDetailId = orderDetailId;
		this.type = type;
		this.placeId = placeId;
		this.placeScheduleId = placeScheduleId;
		this.placeDate = placeDate;
		this.placeSchedule = placeSchedule;
		this.price = price;
		this.quantity = quantity;
		this.sourceAppId = sourceAppId;
		this.clientFrom = clientFrom;
		this.clientId = clientId;
		this.organizer = organizer;
		this.linkman = linkman;
		this.contactNumber = contactNumber;
		this.companySaleId = companySaleId;
		this.companySaleName = companySaleName;
		this.isdeposit = isdeposit;
		this.depositDate = depositDate;
		this.createDate = createDate;
		this.state = state;
		this.hotelSaleId = hotelSaleId;
		this.hotelSaleName = hotelSaleName;
		this.hotelSaleMobile = hotelSaleMobile;
		this.memo = memo;
		this.breakfast = breakfast;
		this.mealType = mealType;
		this.mealnum = mealnum;
				
	}
	public ScheduleBooking(Long hotelId, String orderNo, Long placeScheduleId, String clientFrom, String clientId,
			String organizer, String linkman, String contactNumber, String companySaleId, String companySaleName,
			String isdeposit, Date depositDate, Date createDate, String memo,String state) {
		super();
		this.hotelId = hotelId;
		this.orderNo = orderNo;
		this.placeScheduleId = placeScheduleId;
		this.clientFrom = clientFrom;
		this.clientId = clientId;
		this.organizer = organizer;
		this.linkman = linkman;
		this.contactNumber = contactNumber;
		this.companySaleId = companySaleId;
		this.companySaleName = companySaleName;
		this.isdeposit = isdeposit;
		this.depositDate = depositDate;
		this.createDate = createDate;
		this.memo = memo;
		this.state = state;
	}
	public ScheduleBooking() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getHotelSaleId() {
		return hotelSaleId;
	}
	public void setHotelSaleId(String hotelSaleId) {
		this.hotelSaleId = hotelSaleId;
	}
	public String getHotelSaleName() {
		return hotelSaleName;
	}
	public void setHotelSaleName(String hotelSaleName) {
		this.hotelSaleName = hotelSaleName;
	}
	public String getHotelSaleMobile() {
		return hotelSaleMobile;
	}
	public void setHotelSaleMobile(String hotelSaleMobile) {
		this.hotelSaleMobile = hotelSaleMobile;
	}
	public Long getSourceAppId() {
		return sourceAppId;
	}
	public void setSourceAppId(Long sourceAppId) {
		this.sourceAppId = sourceAppId;
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
	
}


