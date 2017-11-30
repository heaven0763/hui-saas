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

/**
 * 日志表Entity
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Log extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 日志类型
	 */
	private String logType;  
	
	/**
	 * 操作类型
	 */
	private String actionType;  
	
	/**
	 * 操作人员编号
	 */
	private String userId;  
	
	/**
	 * 操作人员姓名
	 */
	private String userName;  
	
	/**
	 * 操作事项类型
	 */
	private String operateType;  
	
	/**
	 * 操作事项编号
	 */
	private String operateId;  
	
	/**
	 * 操作类型
	 */
	private String operateContent;  
	
	/**
	 * 操作时间
	 */
	private Date operateTime;  
	
	/**
	 * 客户端IP
	 */
	private String host;  
	
	@Column(length=50)
    public String getLogType(){  
      return logType;  
    }  
    
    public void setLogType(String logType){  
      this.logType = logType;  
    }  
    @Column(length=50)
    public String getActionType(){  
      return actionType;  
    }  
    
    public void setActionType(String actionType){  
      this.actionType = actionType;  
    }  
    @Column(length=50)
    public String getUserId(){  
      return userId;  
    }  
    
    public void setUserId(String userId){  
      this.userId = userId;  
    }  
    @Column(length=50)
    public String getUserName(){  
      return userName;  
    }  
    
    public void setUserName(String userName){  
      this.userName = userName;  
    }  
    @Column(length=50)
    public String getOperateType(){  
      return operateType;  
    }  
    
    public void setOperateType(String operateType){  
      this.operateType = operateType;  
    }  
    @Column(length=50)
    public String getOperateId(){  
      return operateId;  
    }  
    
    public void setOperateId(String operateId){  
      this.operateId = operateId;  
    }  
    @Column(columnDefinition="text")
    public String getOperateContent(){  
      return operateContent;  
    }  
    
    public void setOperateContent(String operateContent){  
      this.operateContent = operateContent;  
    }  
  
    public Date getOperateTime(){  
      return operateTime;  
    }  
    public void setOperateTime(Date operateTime){  
      this.operateTime = operateTime;  
    }  
    @Column(length=50)
    public String getHost(){  
      return host;  
    }  
    public void setHost(String host){  
      this.host = host;  
    }

	public Log() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Log(String logType, String actionType, String userId, String userName, String operateType, String operateId,
			String operateContent, Date operateTime, String host) {
		super();
		this.logType = logType;
		this.actionType = actionType;
		this.userId = userId;
		this.userName = userName;
		this.operateType = operateType;
		this.operateId = operateId;
		this.operateContent = operateContent;
		this.operateTime = operateTime;
		this.host = host;
	}  
}


