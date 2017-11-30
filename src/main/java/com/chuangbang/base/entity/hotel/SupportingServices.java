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
 * 配套服务Entity
 * @author heaven
 * @version 2016-11-21
 */
@Entity
@Table(name = "hui_SupportingServices")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SupportingServices extends IdEntity {
	
	/**
	 * 服务类型
	 */
	private String kind;  
	
	/**
	 * 服务名称
	 */
	private String name;  
	
	/**
	 * 服务	logo
	 */
	private String logo;  
	
	/**
	 * 父编号
	 */
	@JsonIgnore
	private Long parentId;  
	
  
    public String getKind(){  
      return kind;  
    }  
    
    public void setKind(String kind){  
      this.kind = kind;  
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
  
    public Long getParentId(){  
      return parentId;  
    }  
    
    public void setParentId(Long parentId){  
      this.parentId = parentId;  
    }

	@Override
	public String toString() {
		return "s.id as id, s.kind as kind, s.name as name, s.logo as logo";
	}  
    
    
    
}


