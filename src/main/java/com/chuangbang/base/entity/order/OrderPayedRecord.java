package com.chuangbang.base.entity.order;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 订单付款记录Entity
 * @author heaven
 * @version 2017-10-26
 */
@Entity
@Table(name = "hui_OrderPayedRecord")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderPayedRecord extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	
	/**
	 * 订单编号
	 */
	private Long orderId;  
	
	/**
	 * 付款类型
	 */
	private String type;  
	
	/**
	 * 订单金额
	 */
	private Double amount;  
	
	/**
	 * 付款金额
	 */
	private Double payAmount;  
	
	/**
	 * 未付款金额
	 */
	private Double unpayAmount;  
	
	/**
	 * 已付款金额
	 */
	private Double payedAmount;  
	
	/**
	 * 付款时间
	 */
	private Date payDate;  
	
	/**
	 * 创建人员编号
	 */
	private String payedUserId;  
	
	/**
	 * 创建日期
	 */
	private Date createDate;  
	
	/**
	 * 创建日期
	 */
	private String memo;  
	
  
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
  
    public Long getOrderId(){  
      return orderId;  
    }  
    
    public void setOrderId(Long orderId){  
      this.orderId = orderId;  
    }  
  
    public String getType(){  
      return type;  
    }  
    
    public void setType(String type){  
      this.type = type;  
    }  
  
    @Column(columnDefinition="DECIMAL(18,2)")
    public Double getAmount(){  
      return amount;  
    }  
    
    public void setAmount(Double amount){  
      this.amount = amount;  
    }  
    @Column(columnDefinition="DECIMAL(18,2)")
    public Double getPayAmount(){  
      return payAmount;  
    }  
    
    public void setPayAmount(Double payAmount){  
      this.payAmount = payAmount;  
    }  
    @Column(columnDefinition="DECIMAL(18,2)")
    public Double getUnpayAmount(){  
      return unpayAmount;  
    }  
    
    public void setUnpayAmount(Double unpayAmount){  
      this.unpayAmount = unpayAmount;  
    }  
    @Column(columnDefinition="DECIMAL(18,2)")
    public Double getPayedAmount(){  
      return payedAmount;  
    }  
    
    public void setPayedAmount(Double payedAmount){  
      this.payedAmount = payedAmount;  
    }  
  
    public Date getPayDate(){  
      return payDate;  
    }  
    
    public void setPayDate(Date payDate){  
      this.payDate = payDate;  
    }  
  
    public String getPayedUserId(){  
      return payedUserId;  
    }  
    
    public void setPayedUserId(String payedUserId){  
      this.payedUserId = payedUserId;  
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

	public OrderPayedRecord(Long hotelId, Long orderId, String type, Double amount, Double payAmount,
			Double unpayAmount, Double payedAmount, Date payDate, String payedUserId, Date createDate, String memo) {
		super();
		this.hotelId = hotelId;
		this.orderId = orderId;
		this.type = type;
		this.amount = amount;
		this.payAmount = payAmount;
		this.unpayAmount = unpayAmount;
		this.payedAmount = payedAmount;
		this.payDate = payDate;
		this.payedUserId = payedUserId;
		this.createDate = createDate;
		this.memo = memo;
	}

	public OrderPayedRecord() {
		super();
		// TODO Auto-generated constructor stub
	}  
    
}


