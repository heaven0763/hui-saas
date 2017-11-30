package com.chuangbang.base.entity.hotel;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 商圈信息Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_District")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class District extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 地区编号	
	 */
	private Long regionId;  
	
	/**
	 * 商圈名称
	 */
	private String district;  
	
	/**
	 * 添加时间	
	 */
	private String addTime;  
	
	/**
	 * 排序编号
	 */
	private String sortOrder;  
	
	/**
	 * 地区名称	
	 */
	private String regionName;
	
  
    public Long getRegionId(){  
      return regionId;  
    }  
    
    public void setRegionId(Long regionId){  
      this.regionId = regionId;  
    }  
  
    public String getDistrict(){  
      return district;  
    }  
    
    public void setDistrict(String district){  
      this.district = district;  
    }  
  
    public String getAddTime(){  
      return addTime;  
    }  
    
    public void setAddTime(String addTime){  
      this.addTime = addTime;  
    }  
  
    public String getSortOrder(){  
      return sortOrder;  
    }  
    
    public void setSortOrder(String sortOrder){  
      this.sortOrder = sortOrder;  
    }

    @Transient
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}  
    
    
}


