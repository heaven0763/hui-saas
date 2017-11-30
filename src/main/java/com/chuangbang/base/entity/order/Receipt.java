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
 * 水单资料Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_receipt")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Receipt extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 订单流水号
	 */
	private String orderNo;  
	
	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 活动日期
	 */
	private Date placeDate;  
	
	/**
	 * 消费总额
	 */
	private Double amount;  
	
	/**
	 * 会议场地消费
	 */
	private Double meetAmount;  
	
	/**
	 * 住宿消费
	 */
	private Double accommodationAmount;  
	
	/**
	 * 餐饮消费
	 */
	private Double cateringAmount;  
	
	/**
	 * 票据图片
	 */
	private String billImg;  
	
	/**
	 * 提交人员编号
	 */
	private String userId;  
	
	/**
	 * 提交人员姓名
	 */
	private String userName;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	@Column(length=50)
    public String getOrderNo(){  
      return orderNo;  
    }  
    public void setOrderNo(String orderNo){  
      this.orderNo = orderNo;  
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
  
    public Date getPlaceDate(){  
      return placeDate;  
    }  
    public void setPlaceDate(Date placeDate){  
      this.placeDate = placeDate;  
    }  
  
    public Double getAmount(){  
      return amount;  
    }  
    public void setAmount(Double amount){  
      this.amount = amount;  
    }  
  
    public Double getMeetAmount(){  
      return meetAmount;  
    }  
    public void setMeetAmount(Double meetAmount){  
      this.meetAmount = meetAmount;  
    }  
  
    public Double getAccommodationAmount(){  
      return accommodationAmount;  
    }  
    public void setAccommodationAmount(Double accommodationAmount){  
      this.accommodationAmount = accommodationAmount;  
    }  
  
    public Double getCateringAmount(){  
      return cateringAmount;  
    }  
    public void setCateringAmount(Double cateringAmount){  
      this.cateringAmount = cateringAmount;  
    }  
    
    @Column(columnDefinition="text")
    public String getBillImg(){  
      return billImg;  
    }  
    public void setBillImg(String billImg){  
      this.billImg = billImg;  
    }  
    
    @Column(length=50)
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
}


