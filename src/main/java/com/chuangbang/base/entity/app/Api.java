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
 * 接口表Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_api")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Api extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 接口名称
	 */
	private String name;  
	
	/**
	 * 接口地址
	 */
	private String url;  
	
	/**
	 * 支持格式
	 */
	private String format;  
	
	/**
	 * 请求方式
	 */
	private String method;  
	
	/**
	 * 请求示例
	 */
	private String example;  
	
	/**
	 * 接口备注
	 */
	private String memo;  
	
	/**
	 * 请求参数
	 */
	private String params;  
	
	/**
	 * 返回结果
	 */
	private String result;  
	
	@Column(length=50)
    public String getName(){  
      return name;  
    }  
    
    public void setName(String name){  
      this.name = name;  
    }  
    @Column(length=500)
    public String getUrl(){  
      return url;  
    }  
    public void setUrl(String url){  
      this.url = url;  
    }  
    
    @Column(length=50)
    public String getFormat(){  
      return format;  
    }  
    public void setFormat(String format){  
      this.format = format;  
    }  
    
    @Column(length=50)
    public String getMethod(){  
      return method;  
    }  
    
    public void setMethod(String method){  
      this.method = method;  
    }  
    @Column(length=500)
    public String getExample(){  
      return example;  
    }  
    
    public void setExample(String example){  
      this.example = example;  
    }  
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }  
    
    @Column(length=500)
    public String getParams(){  
      return params;  
    }  
    public void setParams(String params){  
      this.params = params;  
    }  
    
    @Column(columnDefinition="text")
    public String getResult(){  
      return result;  
    }  
    public void setResult(String result){  
      this.result = result;  
    }  
}


