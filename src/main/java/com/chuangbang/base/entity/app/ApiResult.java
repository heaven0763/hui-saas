package com.chuangbang.base.entity.app;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 接口结果表Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_apiResult")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ApiResult extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 接口编号
	 */
	private Long apid;  
	
	/**
	 * 名称
	 */
	private String name;  
	
	/**
	 * 类型
	 */
	private String type;  
	
	/**
	 * 说明
	 */
	private String description;  
	
  
    public Long getApid(){  
      return apid;  
    }  
    
    public void setApid(Long apid){  
      this.apid = apid;  
    }  
    @Column(length=50)
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
    @Column(length=50)
    public String getType(){  
      return type;  
    }  
    
    public void setType(String type){  
      this.type = type;  
    }  
    @Column(length=500)
    public String getDescription(){  
      return description;  
    }  
    public void setDescription(String description){  
      this.description = description;  
    }  
}


