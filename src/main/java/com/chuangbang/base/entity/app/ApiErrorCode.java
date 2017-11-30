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
 * 接口错误码Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_apiErrorCode")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ApiErrorCode extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;

	/**
	 * 类型
	 */
	private String type;  
	
	/**
	 * 错误码
	 */
	private String errorCode;  
	
	/**
	 * 说明
	 */
	private String description;  
	
	 @Column(length=50)
    public String getType(){  
      return type;  
    }  
    
    public void setType(String type){  
      this.type = type;  
    }  
    @Column(length=50)
    public String getErrorCode(){  
      return errorCode;  
    }  
    
    public void setErrorCode(String errorCode){  
      this.errorCode = errorCode;  
    }  
    
    @Column(length=500)
    public String getDescription(){  
      return description;  
    }  
    
    public void setDescription(String description){  
      this.description = description;  
    }  
}


