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
 * 订单详情Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_order_detail")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderDetail extends IdEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3235027745036049965L;
	
	/**
	 * 订单流水号
	 */
	private String orderNo; 
	
	/**
	 * 类型；场地、用餐       01	活动场地；02	住房；03	用餐
	 */
	private String type;
	
	/**
	 * 场地编号
	 */
	private Long placeId;
	
	/**
	 * 场地名称
	 */
	private String placeName;
	/**
	 * 是否是主会场
	 */
	private String ismain;
	
	/**
	 * 金额
	 */
	private Double amount;
	/**
	 * 数量
	 */
	private Long quantity;
	
	/**
	 * 服务费率%
	 */
	private Double commissionFeeRate;
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	/**
	 * 备注
	 */
	private String memo;
	
	
	public Long getPlaceId(){  
      return placeId;  
    }  
    public void setPlaceId(Long placeId){  
      this.placeId = placeId;  
    }  
  
    @Column(length=50)
    public String getPlaceName(){  
      return placeName;  
    }  
    public void setPlaceName(String placeName){  
      this.placeName = placeName;  
    }  
    
    
    @Column(length=50)
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	@Column(length=500)
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	@Column(length=50)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getIsmain() {
		return ismain;
	}
	public void setIsmain(String ismain) {
		this.ismain = ismain;
	}
	
	public Double getCommissionFeeRate() {
		return commissionFeeRate;
	}
	public void setCommissionFeeRate(Double commissionFeeRate) {
		this.commissionFeeRate = commissionFeeRate;
	}
	
	public OrderDetail() {
		super();
	}
	public OrderDetail(String orderNo, String type, Long placeId, String placeName, String ismain, Double amount,
			Long quantity, Double commissionFeeRate, Date createDate, String memo) {
		super();
		this.type = type;
		this.orderNo = orderNo;
		this.placeId = placeId;
		this.placeName = placeName;
		this.ismain = ismain;
		this.amount = amount;
		this.quantity = quantity;
		this.commissionFeeRate = commissionFeeRate;
		this.createDate = createDate;
		this.memo = memo;
	}
	
}
