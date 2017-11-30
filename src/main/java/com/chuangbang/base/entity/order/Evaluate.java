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
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 评价表Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_evaluate")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Evaluate extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 评价类型
	 */
	private String evaluateType;  
	
	/**
	 * 是否订单评价
	 */
	private String isorder;  
	
	/**
	 * 订单流水号
	 */
	private String orderNo;  
	
	/**
	 * 城市
	 */
	private String city;  
	
	/**
	 * 星级
	 */
	private String star;  
	
	/**
	 * 区域
	 */
	private String area;  
	
	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	/**
	 * 评价对象类型
	 */
	private String itemType;
	/**
	 * 评价对象编号
	 */
	private String itemId;
	/**
	 * 评价对象名称
	 */
	private String itemName;
	
	/**
	 * 商品评价
	 */
	private Integer goodsEvaluation;
	/**
	 * 服务态度
	 */
	private Integer attitude;
	/**
	 * 响应速度
	 */
	private Integer responseSpeed;
	
	/**
	 * 设施评价
	 */
	private Integer facilities;  
	
	/**
	 * 卫生评价
	 */
	private Integer hygiene;  
	
	/**
	 * 服务评价
	 */
	private Integer service;  
	
	/**
	 * 位置评价
	 */
	private Integer location;  
	
	/**
	 * 综合评价
	 */
	private Integer comprehensive;  
	
	/**
	 * 平台体验感
	 */
	private Integer experience;  
	
	/**
	 * 公司跟进服务
	 */
	private Integer follow;  
	
	/**
	 * 获取优惠
	 */
	private Integer benefit;  
	/**
	 * 评价标签
	 */
	private String tag;
	/**
	 * 评价内容
	 */
	private String econtent;  
	
	/**
	 * 销售人员编号
	 */
	private String saleId;  
	
	/**
	 * 销售人员姓名
	 */
	private String saleName;  
	
	/**
	 * 销售人员职位
	 */
	private String salePosition;  
	
	/**
	 * 销售人员联系电话
	 */
	private String saleMobile;  
	
	/**
	 * 评论人群
	 */
	private String euserType;  
	
	/**
	 * 评论人编号
	 */
	private String userId;  
	
	/**
	 * 评论人姓名
	 */
	private String userName;  
	
	/**
	 * 是否匿名
	 */
	private String isanonymous;  
	
	/**
	 * 评论时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date evaluateDate;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 回复人员id
	 */
	private String replyUserId;
	
	/**
	 * 回复时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date replyDate;
	
	/**
	 * 回复内容
	 */
	private String replyContent;
	
	/**
	 * 备注
	 */
	private String memo;  
	
	public String getReplyUserId() {
		return replyUserId;
	}

	public void setReplyUserId(String replyUserId) {
		this.replyUserId = replyUserId;
	}

	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	@Column(length=50)
    public String getEvaluateType(){  
      return evaluateType;  
    }  
    
    public void setEvaluateType(String evaluateType){  
      this.evaluateType = evaluateType;  
    }  
    @Column(length=50)
    public String getIsorder(){  
      return isorder;  
    }  
    
    public void setIsorder(String isorder){  
      this.isorder = isorder;  
    }  
    @Column(length=50)
    public String getOrderNo(){  
      return orderNo;  
    }  
    
    public void setOrderNo(String orderNo){  
      this.orderNo = orderNo;  
    }  
    @Column(length=50)
    public String getCity(){  
      return city;  
    }  
    
    public void setCity(String city){  
      this.city = city;  
    }  
    @Column(length=50)
    public String getStar(){  
      return star;  
    }  
    
    public void setStar(String star){  
      this.star = star;  
    }  
    @Column(length=50)
    public String getArea(){  
      return area;  
    }  
    
    public void setArea(String area){  
      this.area = area;  
    }  
  
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
    @Column(length=50)
    public String getHotelName(){  
      return hotelName;  
    }  
    
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }  
  
    public Integer getFacilities(){  
      return facilities;  
    }  
    
    public void setFacilities(Integer facilities){  
      this.facilities = facilities;  
    }  
  
    public Integer getHygiene(){  
      return hygiene;  
    }  
    
    public void setHygiene(Integer hygiene){  
      this.hygiene = hygiene;  
    }  
  
    public Integer getService(){  
      return service;  
    }  
    
    public void setService(Integer service){  
      this.service = service;  
    }  
  
    public Integer getLocation(){  
      return location;  
    }  
    
    public void setLocation(Integer location){  
      this.location = location;  
    }  
  
    public Integer getComprehensive(){  
      return comprehensive;  
    }  
    
    public void setComprehensive(Integer comprehensive){  
      this.comprehensive = comprehensive;  
    }  
  
    public Integer getExperience(){  
      return experience;  
    }  
    
    public void setExperience(Integer experience){  
      this.experience = experience;  
    }  
  
    public Integer getFollow(){  
      return follow;  
    }  
    
    public void setFollow(Integer follow){  
      this.follow = follow;  
    }  
  
    public Integer getBenefit(){  
      return benefit;  
    }  
    
    public void setBenefit(Integer benefit){  
      this.benefit = benefit;  
    }  
  
    public String getEcontent(){  
      return econtent;  
    }  
    
    public void setEcontent(String econtent){  
      this.econtent = econtent;  
    }  
  
    public String getSaleId(){  
      return saleId;  
    }  
    
    public void setSaleId(String saleId){  
      this.saleId = saleId;  
    }  
  
    public String getSaleName(){  
      return saleName;  
    }  
    
    public void setSaleName(String saleName){  
      this.saleName = saleName;  
    }  
  
    public String getSalePosition(){  
      return salePosition;  
    }  
    
    public void setSalePosition(String salePosition){  
      this.salePosition = salePosition;  
    }  
  
    public String getSaleMobile(){  
      return saleMobile;  
    }  
    
    public void setSaleMobile(String saleMobile){  
      this.saleMobile = saleMobile;  
    }  
  
    public String getEuserType(){  
      return euserType;  
    }  
    
    public void setEuserType(String euserType){  
      this.euserType = euserType;  
    }  
  
    public String getUserId(){  
      return userId;  
    }  
    
    public void setUserId(String userId){  
      this.userId = userId;  
    }  
    @Column(length=50)
    public String getUserName(){  
      return userName;  
    }  
    public void setUserName(String userName){  
      this.userName = userName;  
    }  
    
    @Column(length=50)
    public String getIsanonymous(){  
      return isanonymous;  
    }  
    public void setIsanonymous(String isanonymous){  
      this.isanonymous = isanonymous;  
    }  
  
    public Date getEvaluateDate(){  
      return evaluateDate;  
    }  
    public void setEvaluateDate(Date evaluateDate){  
      this.evaluateDate = evaluateDate;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
    
    @Column(length=50)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=50)
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	
	@Column(length=50)
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	
	@Column(length=50)
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getGoodsEvaluation() {
		return goodsEvaluation;
	}

	public void setGoodsEvaluation(Integer goodsEvaluation) {
		this.goodsEvaluation = goodsEvaluation;
	}

	public Integer getAttitude() {
		return attitude;
	}

	public void setAttitude(Integer attitude) {
		this.attitude = attitude;
	}

	public Integer getResponseSpeed() {
		return responseSpeed;
	}

	public void setResponseSpeed(Integer responseSpeed) {
		this.responseSpeed = responseSpeed;
	}
	@Column(length=500)
	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Evaluate() {
		super();
	}

	public Evaluate(String evaluateType, String isorder, String orderNo, String city, String star, 
			Long hotelId, String hotelName, String itemType, String itemId, String itemName, Integer goodsEvaluation,
			Integer attitude, Integer responseSpeed, Integer facilities, Integer hygiene, Integer service,
			Integer location, Integer comprehensive, Integer experience, Integer follow, Integer benefit, String tag,
			String econtent, String euserType,String userId, String userName, String isanonymous, Date evaluateDate, Date createDate, String memo) {
		super();
		this.evaluateType = evaluateType;
		this.isorder = isorder;
		this.orderNo = orderNo;
		this.city = city;
		this.star = star;
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.itemType = itemType;
		this.itemId = itemId;
		this.itemName = itemName;
		this.goodsEvaluation = goodsEvaluation;
		this.attitude = attitude;
		this.responseSpeed = responseSpeed;
		this.facilities = facilities;
		this.hygiene = hygiene;
		this.service = service;
		this.location = location;
		this.comprehensive = comprehensive;
		this.experience = experience;
		this.follow = follow;
		this.benefit = benefit;
		this.tag = tag;
		this.econtent = econtent;
		this.euserType = euserType;
		this.userId = userId;
		this.userName = userName;
		this.isanonymous = isanonymous;
		this.evaluateDate = evaluateDate;
		this.createDate = createDate;
		this.memo = memo;
	}  
    
    
}


