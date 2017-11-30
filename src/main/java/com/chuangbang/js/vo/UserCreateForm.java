package com.chuangbang.js.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class UserCreateForm {
	/**
	 * 会员用户账号
	 */
	@NotEmpty
	private String nickname;
	/**
	 * 真实姓名
	 */
	@NotEmpty
	private String username;
	/**
	 * 电话
	 */
	@NotEmpty
	private String mobile;
	/**
	 * 所属会员用户类型
	 */
	private String type;
	/**
	 * 所属用户角色id
	 */
	private Long groupId;
	/**
	 * 会员用户等级
	 */
	private String level;
	/**
	 * 会员简介
	 */
	private String description;
	/**
	 * 密码
	 */
	@NotEmpty
	private String password;
	/**
	 * 确认密码
	 */
	@NotEmpty
	private String passwordRepeat;
	/**
	 * 头像
	 */
	private String picUrl;
	/**
	 * App自定义背景
	 */
	private String bgimg;
	/**
	 * 是否锁定
	 */
	private String locked;
	/**
	 * 状态
	 */
	private String state;
	/**
	 * 阅览数
	 */
	private Long readingNum;
	/**
	 * 回复数
	 */
	private Long evaluateNum;
	/**
	 * 关注数
	 */
	private Long followNum;
	/**
	 * 逻辑删除标志
	 */
	private String isdel;
	/**
	 * 备注
	 */
	private String memo;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 角色名称
	 */
	private String groupName;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordRepeat() {
		return passwordRepeat;
	}

	public void setPasswordRepeat(String passwordRepeat) {
		this.passwordRepeat = passwordRepeat;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public String getBgimg() {
		return bgimg;
	}

	public void setBgimg(String bgimg) {
		this.bgimg = bgimg;
	}

	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Long getReadingNum() {
		return readingNum;
	}

	public void setReadingNum(Long readingNum) {
		this.readingNum = readingNum;
	}

	public Long getEvaluateNum() {
		return evaluateNum;
	}

	public void setEvaluateNum(Long evaluateNum) {
		this.evaluateNum = evaluateNum;
	}

	public Long getFollowNum() {
		return followNum;
	}

	public void setFollowNum(Long followNum) {
		this.followNum = followNum;
	}

	public String getIsdel() {
		return isdel;
	}

	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
}
