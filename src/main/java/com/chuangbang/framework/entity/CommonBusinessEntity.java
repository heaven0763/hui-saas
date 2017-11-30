package com.chuangbang.framework.entity;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;


/***
 * 用于增加业务表统一字段
 */
@MappedSuperclass
public class CommonBusinessEntity extends IdEntity{
	
	/** 创建者id*/
	private java.lang.String creator;
	
	/** 最后更新人 */
	private java.lang.String lastupdateby;
	
	/** 创建时间 */
	private java.util.Date createtime;
	
	/** 最后更新时间 */
	private java.util.Date lastupdatetime;
	
	/** 创建单位级别 */
	private String createlevelcode;
	
	@Column(length= 50)
	public java.lang.String getCreator() {
		return creator;
	}
	public void setCreator(java.lang.String creator) {
		this.creator = creator;
	}
	
	@Column(length= 50)
	public java.lang.String getLastupdateby() {
		return lastupdateby;
	}
	public void setLastupdateby(java.lang.String lastupdateby) {
		this.lastupdateby = lastupdateby;
	}
	public java.util.Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(java.util.Date createtime) {
		this.createtime = createtime;
	}
	public java.util.Date getLastupdatetime() {
		return lastupdatetime;
	}
	public void setLastupdatetime(java.util.Date lastupdatetime) {
		this.lastupdatetime = lastupdatetime;
	}
	
	@Column(length= 15)
	public String getCreatelevelcode() {
		return createlevelcode;
	}
	public void setCreatelevelcode(String createlevelcode) {
		this.createlevelcode = createlevelcode;
	}
}
