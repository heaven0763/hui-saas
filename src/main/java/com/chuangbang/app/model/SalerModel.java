package com.chuangbang.app.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;


public class SalerModel {

	
	private String id;
	/**
	 * 用户名
	 */
	private String username;
	/**
	 * 用户姓名
	 */
	private String rname;
	/**
	 * 电话
	 */
	private String mobile;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 
	 */
	private String wechat;
	/**
	 * 头像
	 */
	private String avatar;
	/**
	 * 简介
	 */
	private String description;
	/**
	 * 性别
	 */
	@JsonIgnore
	private String sex;
	
	/**
	 * 备注
	 */
	private String memo;
	
	/**
	 * 创建日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;
	
	/**
	 * 所属酒店编号；用户类型为userType时必填
	 */
	private String hotelId;
	/**
	 * 用户类型
	 */
	private String userType;
	/**
	 * 职务
	 */
	private String position;
	
	/**
	 * 单位性质
	 */
	private String companyNature;
	
	/**
	 * 单位名称
	 */
	private String companyName;
	/**
	 * 公司规模
	 */
	private String companyScale;
	/**
	 * 行业
	 */
	private String industry;

	
	public SalerModel() {
		super();
		// TODO Auto-generated constructor stub
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getRname() {
		return rname;
	}


	public void setRname(String rname) {
		this.rname = rname;
	}


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getWechat() {
		return wechat;
	}


	public void setWechat(String wechat) {
		this.wechat = wechat;
	}


	public String getAvatar() {
		return avatar;
	}


	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getMemo() {
		return memo;
	}


	public void setMemo(String memo) {
		this.memo = memo;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public String getHotelId() {
		return hotelId;
	}


	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}


	public String getUserType() {
		return userType;
	}


	public void setUserType(String userType) {
		this.userType = userType;
	}


	public String getPosition() {
		return position;
	}


	public void setPosition(String position) {
		this.position = position;
	}


	public String getCompanyNature() {
		return companyNature;
	}


	public void setCompanyNature(String companyNature) {
		this.companyNature = companyNature;
	}


	public String getCompanyName() {
		return companyName;
	}


	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}


	public String getCompanyScale() {
		return companyScale;
	}


	public void setCompanyScale(String companyScale) {
		this.companyScale = companyScale;
	}


	public String getIndustry() {
		return industry;
	}


	public void setIndustry(String industry) {
		this.industry = industry;
	}


	@Override
	public String toString() {
		return "SalerModel [id=" + id + ", username=" + username + ", rname=" + rname + ", mobile=" + mobile
				+ ", email=" + email + ", wechat=" + wechat + ", avatar=" + avatar + ", description=" + description
				+ ", sex=" + sex + ", memo=" + memo + ", createDate=" + createDate + ", hotelId=" + hotelId
				+ ", userType=" + userType + ", position=" + position + ", companyNature=" + companyNature
				+ ", companyName=" + companyName + ", companyScale=" + companyScale + ", industry=" + industry + "]";
	}

}