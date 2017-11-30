package com.chuangbang.base.entity.hotel;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 场地风格Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_SiteStype")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SiteStype extends IdEntity {
	

	/**
	 * 风格代码	
	 */
	@JsonIgnore
	private String code;  
	
	/**
	 * 风格名称
	 */
	private String name;  
	
	/**
	 * 风格图标
	 */
	private String logo;  
	
	/**
	 * 添加时间
	 */
	@JsonIgnore
	private String addTime;  
	
  
    public String getCode(){  
      return code;  
    }  
    
    public void setCode(String code){  
      this.code = code;  
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
  
    public String getAddTime(){  
      return addTime;  
    }  
    
    public void setAddTime(String addTime){  
      this.addTime = addTime;  
    }  
}


