package com.chuangbang.base.entity.app;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 应用表Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_application")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Application extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 应用编号
	 */
	private String appId;  
	
	/**
	 * 应用名称
	 */
	private String appName;  
	
	/**
	 * 应用图标
	 */
	private String appLogo;  
	
	/**
	 * 应用标识 
	 */
	private String appKey;  
	
	/**
	 * 应用状态  0:停用；1：使用中
	 */
	private String state;  
	
	/**
	 * 应用有效日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date effectiveDate;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	/**
	 * 公司编号
	 */
	private String companyId;
	/**
	 * 创建用户编号
	 */
	private String memberId;
	
  
    public String getAppId(){  
      return appId;  
    }  
    
    public void setAppId(String appId){  
      this.appId = appId;  
    }  
    @Column(length=50)
    public String getAppName(){  
      return appName;  
    }  
    
    public void setAppName(String appName){  
      this.appName = appName;  
    }  
    @Column(length=200)
    public String getAppLogo(){  
      return appLogo;  
    }  
    
    public void setAppLogo(String appLogo){  
      this.appLogo = appLogo;  
    }  
    @Column(length=50)
    public String getAppKey(){  
      return appKey;  
    }  
    
    public void setAppKey(String appKey){  
      this.appKey = appKey;  
    }  
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
    }  
  
    public Date getEffectiveDate(){  
      return effectiveDate;  
    }  
    
    public void setEffectiveDate(Date effectiveDate){  
      this.effectiveDate = effectiveDate;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    @Column(length=50)
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@Column(length=50)
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}  
}


