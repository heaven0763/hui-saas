package com.chuangbang.base.entity.order;

import java.io.Serializable;
import java.util.Date;

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
@Table(name = "hui_integral_order_detail")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class IntegralOrderDetail extends IdEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3235027745036049965L;
	
	/**
	 * 订单流水号
	 */
	private String orderNo; 
	
	
	/**
	 * 积分商品编号
	 */
	private Long itemId;
	
	/**
	 * 积分商品名称
	 */
	private String itemName;
	
	/**
	 * 掌柜金额
	 */
	private Double zgamount;
	/**
	 * 酒店金额
	 */
	private Double jdamount;
	
	/**
	 * 兑换积分
	 */
	private Double points;
	/**
	 * 数量
	 */
	private Long quantity;
	/**
	 * 状态
	 */
	private String state;
	/**
	 * 创建时间
	 */
	private Date createDate;  
	/**
	 * 备注
	 */
	private String memo;
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Long getItemId() {
		return itemId;
	}
	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Double getZgamount() {
		return zgamount;
	}
	public void setZgamount(Double zgamount) {
		this.zgamount = zgamount;
	}
	public Double getJdamount() {
		return jdamount;
	}
	public void setJdamount(Double jdamount) {
		this.jdamount = jdamount;
	}
	public Double getPoints() {
		return points;
	}
	public void setPoints(Double points) {
		this.points = points;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public IntegralOrderDetail() {
		super();
		// TODO Auto-generated constructor stub
	}
	public IntegralOrderDetail(String orderNo, Long itemId, String itemName, Double zgamount, Double jdamount,
			Double points, Long quantity, String state, Date createDate, String memo) {
		super();
		this.orderNo = orderNo;
		this.itemId = itemId;
		this.itemName = itemName;
		this.zgamount = zgamount;
		this.jdamount = jdamount;
		this.points = points;
		this.quantity = quantity;
		this.state = state;
		this.createDate = createDate;
		this.memo = memo;
	}

	
}
