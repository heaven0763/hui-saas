package com.chuangbang.app.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class SiteImgModel {
	private Long id;
	private String name;
	private String type;
	private String ptypes;
	private String timgs;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date utime;
	private Long imgnum;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPtypes() {
		return ptypes;
	}
	public void setPtypes(String ptypes) {
		this.ptypes = ptypes;
	}
	public String getTimgs() {
		return timgs;
	}
	public void setTimgs(String timgs) {
		this.timgs = timgs;
	}
	public Date getUtime() {
		return utime;
	}
	public void setUtime(Date utime) {
		this.utime = utime;
	}
	public Long getImgnum() {
		return imgnum;
	}
	public void setImgnum(Long imgnum) {
		this.imgnum = imgnum;
	}
}
