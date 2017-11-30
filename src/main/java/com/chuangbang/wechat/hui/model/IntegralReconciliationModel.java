package com.chuangbang.wechat.hui.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class IntegralReconciliationModel {

	private Long id;
	private Long  itemId;
	private String itemName; 
	private Double points; 
	private Double zgamount; 
	private Double jdamount; 
	private String orderNo; 
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate; 
	private String clientId; 
	private String clientName; 
	private String clientMobile; 
	private String area;
	private String settlementStatus;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public Double getPoints() {
		return points;
	}
	public void setPoints(Double points) {
		this.points = points;
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
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientMobile() {
		return clientMobile;
	}
	public void setClientMobile(String clientMobile) {
		this.clientMobile = clientMobile;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getSettlementStatus() {
		return settlementStatus;
	}
	public void setSettlementStatus(String settlementStatus) {
		this.settlementStatus = settlementStatus;
	} 
	
}
