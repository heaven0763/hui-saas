package com.chuangbang.log.entity.operation;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.chuangbang.framework.entity.IdEntity;
import com.chuangbang.log.entity.Auditable;
import com.google.common.collect.Lists;

@Entity
@Table(name="hui_log_operation")
public class UserOperation extends IdEntity implements Serializable,Auditable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5194127054461082233L;
	/** 用户名 */
	private java.lang.String userId;
	/** 用户名 */
	private java.lang.String userName;
	/** 客户端IP */
	private java.lang.String host;
	/** 操作类型 */
	private java.lang.String operateType;
	/** 操作表 */
	private java.lang.String operateTable;
	/** 操作id */
	private java.lang.String operateId;
	/** 操作前数据 */
	private java.lang.String oldData;
	/** 操作后 */
	private java.lang.String newData;
	/** 操作内容*/
	private java.lang.String operateContent;
	/** 操作时间 */
	private java.util.Date operateTime;
	
	
	@Column(length=50)
	public java.lang.String getUserName() {
		return userName;
	}
	public void setUserName(java.lang.String userName) {
		this.userName = userName;
	}
	
	@Column(length=255)
	public java.lang.String getHost() {
		return host;
	}
	public void setHost(java.lang.String host) {
		this.host = host;
	}
	
	@Column(length=100)
	public java.lang.String getOperateTable() {
		return operateTable;
	}
	public void setOperateTable(java.lang.String operateTable) {
		this.operateTable = operateTable;
	}
	
	@Column(length=4000)
	public java.lang.String getOperateContent() {
		return operateContent;
	}
	public void setOperateContent(java.lang.String operateContent) {
		this.operateContent = operateContent;
	}
	public java.util.Date getOperateTime() {
		return operateTime;
	}
	public void setOperateTime(java.util.Date operateTime) {
		this.operateTime = operateTime;
	}
	
	@Column(length=100)
	public java.lang.String getOperateId() {
		return operateId;
	}
	public void setOperateId(java.lang.String operateId) {
		this.operateId = operateId;
	}
	
	@Column(length=4000)
	public java.lang.String getOldData() {
		return oldData;
	}
	public void setOldData(java.lang.String oldData) {
		this.oldData = oldData;
	}
	
	@Column(length=4000)
	public java.lang.String getNewData() {
		return newData;
	}
	public void setNewData(java.lang.String newData) {
		this.newData = newData;
	}
	
	@Column(length=100)
	public java.lang.String getOperateType() {
		return operateType;
	}
	public void setOperateType(java.lang.String operateType) {
		this.operateType = operateType;
	}
	@Column(length=50)
	public java.lang.String getUserId() {
		return userId;
	}
	public void setUserId(java.lang.String userId) {
		this.userId = userId;
	}
	
	
	
}
