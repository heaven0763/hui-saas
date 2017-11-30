package com.chuangbang.base.entity.hotel;

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
 * 地区信息Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_Region")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Region extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;

	/**
	 * 父编号
	 */
	private Long parentId;  
	
	/**
	 * 区域名称
	 */
	private String regionName;  
	
	/**
	 * 区域类型
	 */
	private String regionType;  
	
	/**
	 * 代理编号
	 */
	private String agencyId;  
	
	/**
	 * 字目
	 */
	private String zimu;  
	
	/**
	 * 热门
	 */
	@JsonIgnore
	private String isHot;  
	
	/**
	 * 推荐
	 */
	@JsonIgnore
	private String isTui;  
	
	/**
	 * 排序编号
	 */
	private String sortOrder;  
	
	/**
	 * 经度
	 */
	private Double longitude;  
	/**
	 * 纬度
	 */
	private Double latitude;  
	
	private String pName;
	
  
    public Long getParentId(){  
      return parentId;  
    }  
    
    public void setParentId(Long parentId){  
      this.parentId = parentId;  
    }  
  
    public String getRegionName(){  
      return regionName;  
    }  
    
    public void setRegionName(String regionName){  
      this.regionName = regionName;  
    }  
  
    public String getRegionType(){  
      return regionType;  
    }  
    
    public void setRegionType(String regionType){  
      this.regionType = regionType;  
    }  
  
    public String getAgencyId(){  
      return agencyId;  
    }  
    
    public void setAgencyId(String agencyId){  
      this.agencyId = agencyId;  
    }  
  
    public String getZimu(){  
      return zimu;  
    }  
    
    public void setZimu(String zimu){  
      this.zimu = zimu;  
    }  
  
    public String getIsHot(){  
      return isHot;  
    }  
    
    public void setIsHot(String isHot){  
      this.isHot = isHot;  
    }  
  
    public String getIsTui(){  
      return isTui;  
    }  
    
    public void setIsTui(String isTui){  
      this.isTui = isTui;  
    }  
  
    public String getSortOrder(){  
      return sortOrder;  
    }  
    
    public void setSortOrder(String sortOrder){  
      this.sortOrder = sortOrder;  
    }

    @Transient
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	@Override
	public String toString() {
		return "id as id, regionName as regionName, zimu as zimu, longitude as longitude, latitude as latitude";
	}  
    
}


