package com.chuangbang.framework.entity.dictionary;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;




@Entity
//
@Table(name = "hui_sys_dict")
//
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Dictionary extends IdEntity{

	/** 类型 */
	private java.lang.String kind;
	
	/** 编码 */
	private java.lang.String code;
	
	/** 父类型 */
	public java.lang.String supercode;
	
	/** 详值 */
	//@Max(value=1,message="详值长度不能大于1")
	private java.lang.String detail;
	
	/** 备注 */
	//@NotEmpty(message="备注不能为空")
	private java.lang.String notes;

	public Dictionary() {
	}


	public void setKind(java.lang.String value) {
		this.kind = value;
	}

	@Column(length=50)
	public java.lang.String getKind() {
		return this.kind;
	}
	public void setCode(java.lang.String value) {
		this.code = value;
	}

	@Column(length=50)
	public java.lang.String getCode() {
		return this.code;
	}
	public void setSupercode(java.lang.String value) {
		this.supercode = value;
	}

	@Column(length=50)
	public java.lang.String getSupercode() {
		return this.supercode;
	}
	public void setDetail(java.lang.String value) {
		this.detail = value;
	}

	@Column(length=500)
	public java.lang.String getDetail() {
		return this.detail;
	}
	public void setNotes(java.lang.String value) {
		this.notes = value;
	}

	@Column(length=1000)
	public java.lang.String getNotes() {
		return this.notes;
	}
}

