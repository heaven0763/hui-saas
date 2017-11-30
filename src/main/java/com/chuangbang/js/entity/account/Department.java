/**
 * Created on Mon Jun 04 16:35:16 CST 2012
 * Copyright chuangbang, 2012-2012, All rights reserved.
 */

package com.chuangbang.js.entity.account;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;




@Entity
//
@Table(name = "hui_DEPARTMENT",uniqueConstraints={@UniqueConstraint(columnNames="unitcode")})
//
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Department extends IdEntity {

	/** 部门代码 */
	private java.lang.String unitcode;
	
	/** 部门名称 */
	private java.lang.String unitname;
	
	/** 所属企业 */
	private java.lang.String districtCode;
	
	/** 父代码 */
	private java.lang.String superUnit;

	@Column(length=15)
	public java.lang.String getUnitcode() {
		return unitcode;
	}

	public void setUnitcode(java.lang.String unitcode) {
		this.unitcode = unitcode;
	}

	@Column(length=100)
	public java.lang.String getUnitname() {
		return unitname;
	}

	public void setUnitname(java.lang.String unitname) {
		this.unitname = unitname;
	}

	@Column(length=15)
	public java.lang.String getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(java.lang.String districtCode) {
		this.districtCode = districtCode;
	}
	@Column(length=15)
	public java.lang.String getSuperUnit() {
		return superUnit;
	}

	public void setSuperUnit(java.lang.String superUnit) {
		this.superUnit = superUnit;
	}

	
}

