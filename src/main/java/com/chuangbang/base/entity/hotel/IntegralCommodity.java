package com.chuangbang.base.entity.hotel;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 积分商品Entity
 * @author heaven
 * @version 2017-01-10
 */
@Entity
@Table(name = "hui_IntegralCommodity")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class IntegralCommodity extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	
	/**
	 * 商品名称
	 */
	private String name;  
	
	/**
	 * 所需积分
	 */
	private Integer integral;  
	
	/**
	 * 酒店价格
	 */
	private Double price;  
	
	/**
	 * 掌柜价格
	 */
	private Double zgprice;  
	
	/**
	 * 商品介绍
	 */
	private String pcontent;  
	
	/**
	 * 0:下架；1：上架
	 */
	private String state; 
	
	/**
	 * 状态 0:未审核；1：酒店主管审核；3：公司销售审核:5：运营总监审核；6：~不通过；
	 */
	private String checkState;  
	
	/**
	 * 审核日期 
	 */
	private Date hotelCheckDate; 
	/**
	 * 审核用户编号 
	 */
	private String hotelCheckhUserId;
	/**
	 * 审核用户姓名 
	 */
	private String hotelCheckhUserName;
	
	/**
	 * 审核备注
	 */
	private String hotelCheckhMemo;  
	
	/**
	 * 审核日期 
	 */
	private Date huiCheckDate; 
	/**
	 * 审核用户编号 
	 */
	private String huiCheckUserId;
	/**
	 * 审核用户姓名 
	 */
	private String huiCheckUserName;
	/**
	 * 审核备注
	 */
	private String huiCheckMemo;  
	
	/**
	 * 审核日期 
	 */
	private Date checkDate; 
	/**
	 * 审核用户编号 
	 */
	private String checkUserId;
	/**
	 * 审核用户姓名 
	 */
	private String checkUserName;
	/**
	 * 审核备注
	 */
	private String checkMemo;  
	
	/**
	 * 创建日期
	 */
	private Date createDate;  
	private String createUserId;
	/**
	 * 创建用户姓名 
	 */
	private String createUserName;
	/**
	 * 备注
	 */
	private String memo;  
	/**
	 * 图片路径
	 */
	private String img;
	
  
	private String hotelName;
	
    public Long getHotelId(){  
      return hotelId;  
    }  
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
  
    @Column(length=50)
    public String getName(){  
      return name;  
    }  
    public void setName(String name){  
      this.name = name;  
    }  
   
    @Column(columnDefinition="text")
    public String getPcontent(){  
      return pcontent;  
    }  
    public void setPcontent(String pcontent){  
      this.pcontent = pcontent;  
    }  
    
    @Column(length=5)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
    
    @Column(length=5)
    public String getCheckState() {
		return checkState;
	}
	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}
	
	@Column(length=500)
    public String getCheckMemo(){  
      return checkMemo;  
    }  
    public void setCheckMemo(String checkMemo){  
      this.checkMemo = checkMemo;  
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}

	public Integer getIntegral() {
		return integral;
	}
	public void setIntegral(Integer integral) {
		this.integral = integral;
	}

	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getZgprice() {
		return zgprice;
	}
	public void setZgprice(Double zgprice) {
		this.zgprice = zgprice;
	}

	public Date getHotelCheckDate() {
		return hotelCheckDate;
	}
	public void setHotelCheckDate(Date hotelCheckDate) {
		this.hotelCheckDate = hotelCheckDate;
	}
	
	@Column(length=50)
	public String getHotelCheckhUserId() {
		return hotelCheckhUserId;
	}
	public void setHotelCheckhUserId(String hotelCheckhUserId) {
		this.hotelCheckhUserId = hotelCheckhUserId;
	}
	
	@Column(length=50)
	public String getHotelCheckhUserName() {
		return hotelCheckhUserName;
	}
	public void setHotelCheckhUserName(String hotelCheckhUserName) {
		this.hotelCheckhUserName = hotelCheckhUserName;
	}
	
	@Column(length=500)
	public String getHotelCheckhMemo() {
		return hotelCheckhMemo;
	}
	public void setHotelCheckhMemo(String hotelCheckhMemo) {
		this.hotelCheckhMemo = hotelCheckhMemo;
	}

	public Date getHuiCheckDate() {
		return huiCheckDate;
	}
	public void setHuiCheckDate(Date huiCheckDate) {
		this.huiCheckDate = huiCheckDate;
	}
	
	@Column(length=50)
	public String getHuiCheckUserId() {
		return huiCheckUserId;
	}
	public void setHuiCheckUserId(String huiCheckUserId) {
		this.huiCheckUserId = huiCheckUserId;
	}
	
	@Column(length=50)
	public String getHuiCheckUserName() {
		return huiCheckUserName;
	}
	public void setHuiCheckUserName(String huiCheckUserName) {
		this.huiCheckUserName = huiCheckUserName;
	}
	
	@Column(length=500)
	public String getHuiCheckMemo() {
		return huiCheckMemo;
	}
	public void setHuiCheckMemo(String huiCheckMemo) {
		this.huiCheckMemo = huiCheckMemo;
	}

	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	
	@Column(length=50)
	public String getCheckUserId() {
		return checkUserId;
	}
	public void setCheckUserId(String checkUserId) {
		this.checkUserId = checkUserId;
	}
	
	@Column(length=50)
	public String getCheckUserName() {
		return checkUserName;
	}
	public void setCheckUserName(String checkUserName) {
		this.checkUserName = checkUserName;
	}
	
	@Column(length=50)
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	
	@Column(length=50)
	public String getCreateUserName() {
		return createUserName;
	}
	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}
	
	@Transient
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	
	
	
}


