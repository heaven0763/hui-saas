package com.chuangbang.framework.entity.system;

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
@Table(name = "hui_sys_params")
//
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SystemParameter extends IdEntity{

	/** 代码 */
	private java.lang.String code;
	/** 值 */
	private java.lang.String value;
	/** 备注 */
	private java.lang.String note;
	/** 是否可删除 */
	private java.lang.String canbedel;


	public void setCode(java.lang.String value) {
		this.code = value;
	}

	@Column(length=255)
	public java.lang.String getCode() {
		return this.code;
	}
	public void setValue(java.lang.String value) {
		this.value = value;
	}

	@Column(length=1000)
	public java.lang.String getValue() {
		return this.value;
	}
	public void setNote(java.lang.String value) {
		this.note = value;
	}

	@Column(length=1000)
	public java.lang.String getNote() {
		return this.note;
	}

	@Column(length=1)
	public java.lang.String getCanbedel() {
		return canbedel;
	}

	public void setCanbedel(java.lang.String canbedel) {
		this.canbedel = canbedel;
	}
	
	
}

