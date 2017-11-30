package com.chuangbang.plugins.sms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

@Entity
@Table(name = "cb_sms_record")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SmsRecord extends IdEntity{
    private String mobile;   
    private String subject;   
    private String content;   
    private String sendId;
    private String smsType;
    private String itemId;
    private String memo;
    private Date sendTime;
    
	public SmsRecord() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SmsRecord(String mobile, String subject, String content, String sendId, String smsType, String itemId,
			String memo, Date sendTime) {
		super();
		this.mobile = mobile;
		this.subject = subject;
		this.content = content;
		this.sendId = sendId;
		this.smsType = smsType;
		this.itemId = itemId;
		this.memo = memo;
		this.sendTime = sendTime;
	}
	
	@Column(length=500)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Column(length=500)
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	@Column(length=500)
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Column(length=100)
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	
	@Column(length=20)
	public String getSmsType() {
		return smsType;
	}
	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}
	
	@Column(length=50)
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	
	@Column(length=500)
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	
	
    
    
}