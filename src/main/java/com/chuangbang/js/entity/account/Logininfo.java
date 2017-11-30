package com.chuangbang.js.entity.account;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.chuangbang.framework.entity.IdEntity;




@Entity
//
@Table(name = "hui_logininfo")
//
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Logininfo extends IdEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1207998415877149944L;

	/** 用户名 */
	private java.lang.String username;
	
	/** 客户端IP */
	private java.lang.String host;
	
	/** 操作内容 */
	private java.lang.String message;
	
	/** 操作时间 */
	private java.sql.Timestamp logtime;

	public void setUsername(java.lang.String value) {
		this.username = value;
	}

	@Column(length=100)
	public java.lang.String getUsername() {
		return this.username;
	}
	public void setHost(java.lang.String value) {
		this.host = value;
	}

	@Column(length=255)
	public java.lang.String getHost() {
		return this.host;
	}
	public void setMessage(java.lang.String value) {
		this.message = value;
	}

	@Column(length=4000)
	public java.lang.String getMessage() {
		return this.message;
	}
	public void setLogtime(java.sql.Timestamp value) {
		this.logtime = value;
	}

	public java.sql.Timestamp getLogtime() {
		return this.logtime;
	}
}

