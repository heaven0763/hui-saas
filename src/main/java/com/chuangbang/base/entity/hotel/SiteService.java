package com.chuangbang.base.entity.hotel;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 场地图片Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_SiteService")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteService extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	
	/**
	 * 场地类型	
	 */
	private String siteType;  
	
	/**
	 * 场地编号
	 */
	private Long siteId;  
	
	/**
	 * 服务类型
	 */
	private String kind;  
	
	/**
	 * 服务编号
	 */
	private Long serviceId;  
	
	/**
	 * 服务名称
	 */
	private String name;  
	
	/**
	 * 服务	logo
	 */
	private String logo;  
	
	/**
	 * 服务值
	 */
	private String spval; 
  
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
  
    public String getSiteType(){  
      return siteType;  
    }  
    
    public void setSiteType(String siteType){  
      this.siteType = siteType;  
    }  
  
    public Long getSiteId(){  
      return siteId;  
    }  
    
    public void setSiteId(Long siteId){  
      this.siteId = siteId;  
    }  
  
    public String getKind(){  
      return kind;  
    }  
    
    public void setKind(String kind){  
      this.kind = kind;  
    }  
  
    public Long getServiceId(){  
      return serviceId;  
    }  
    
    public void setServiceId(Long serviceId){  
      this.serviceId = serviceId;  
    }  
  
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
  
    public String getLogo(){  
      return logo;  
    }  
    
    public void setLogo(String logo){  
      this.logo = logo;  
    }
    
	public String getSpval() {
		return spval;
	}
	public void setSpval(String spval) {
		this.spval = spval;
	}

	public SiteService(Long hotelId, String siteType, Long siteId, String kind, Long serviceId, String name,
			String logo) {
		super();
		this.hotelId = hotelId;
		this.siteType = siteType;
		this.siteId = siteId;
		this.kind = kind;
		this.serviceId = serviceId;
		this.name = name;
		this.logo = logo;
	}

	public SiteService() {
		super();
		// TODO Auto-generated constructor stub
	}  
    
    
    
}


