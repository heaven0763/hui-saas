package com.chuangbang.app.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class MessageModel {
	
	private Long id;
	/**
	 * 会员编号
	 */
	private String userId;  
	/**
	 * 会员姓名
	 */
	private String userName; 
	/**
	 * 会员头像
	 */
	private String userPhoto; 
	
	/**
	 * 留言主体类型  HOTEL,HALL,ROOM,HOTELDYNAMICE
	 */
	private String itemType;
	/**
	 * 留言主体
	 */
	private String itemId;  
	
	/**
	 * 留言
	 */
	private String msg;  
	
	
	/**
	 * 留言日期
	 */
	private Date msgDate;  
	
	/**
	 * 父编号
	 */
	@JsonIgnore
	private Long pid;

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Date getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(Date msgDate) {
		this.msgDate = msgDate;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	@Override
	public String toString() {
		return " m.id as id, m.user_id as userId, m.user_name as userName, m.user_photo as userPhoto, m.item_type as itemType"
				+ ", m.item_id as itemId, m.msg as msg, m.msg_date as msgDate, m.pid as pid";
	}  
	
	
	
}
