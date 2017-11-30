package com.chuangbang.wechat.hui.model;

public class UserEvaluateModel {

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
	 * 职务
	 */
	private String position;
	
	/**
	 * 综合评价
	 */
	private Integer comprehensive;
	
	/**
	 * 初评星级
	 */
	private Integer star ;

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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getComprehensive() {
		return comprehensive;
	}

	public void setComprehensive(Integer comprehensive) {
		this.comprehensive = comprehensive;
	}

	public Integer getStar() {
		return star;
	}

	public void setStar(Integer star) {
		this.star = star;
	}  
	
}