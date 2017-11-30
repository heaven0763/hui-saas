package com.chuangbang.wechat.hui.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 地区信息model
 * @author heaven
 * @version 2016-11-21
 */
public class RegionModel extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;

	
	/**
	 * 区域名称
	 */
	private String regionName;  
	
	
	/**
	 * 字目
	 */
	private String zimu;  
	

	public String getRegionName() {
		return regionName;
	}


	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getZimu() {
		return zimu;
	}


	public void setZimu(String zimu) {
		this.zimu = zimu;
	}

   
}


