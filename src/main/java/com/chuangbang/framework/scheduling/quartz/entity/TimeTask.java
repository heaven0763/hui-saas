package com.chuangbang.framework.scheduling.quartz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 定时任务管理Entity
 * @author HeavenChen
 * @version 2015-04-22
 */
@Entity
@Table(name = "hui_timetask")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class TimeTask extends IdEntity{
	/**
	 * 任务ID
	 */
	private String taskId;  
	
	/**
	 * 对应的class,必须实现org.quartz.Job接口，调用execute()方法
	 */
	private String clazz;
	
	/**
	 * 任务描述
	 */
	private String taskDescribe;  
	
	/**
	 * cron表达式
	 */
	private String cronExpression;  
	
	/**
	 * 任务组
	 */
	private String groupName;
	
	/**
	 * 是否生效了0未生效,1生效了
	 */
	private String isEffect;  
	
	/**
	 * 是否运行0停止,1运行
	 */
	private String isStart;  
	
	/**
	 * 创建时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createDate;  
	
	/**
	 * 创建人ID
	 */
	private String createBy;  
	
	/**
	 * 创建人名称
	 */
	private String createName;  
	
	/**
	 * 修改时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date updateDate;  
	
	/**
	 * 修改人ID
	 */
	private String updateBy;  
	
	/**
	 * 修改人名称
	 */
	private String updateName;  
	
	private String accountId;
  
    public String getTaskId(){  
      return taskId;  
    }  
    
    public void setTaskId(String taskId){  
      this.taskId = taskId;  
    }  
  
    public String getTaskDescribe(){  
      return taskDescribe;  
    }  
    
    public void setTaskDescribe(String taskDescribe){  
      this.taskDescribe = taskDescribe;  
    }  
  
    public String getCronExpression(){  
      return cronExpression;  
    }  
    
    public void setCronExpression(String cronExpression){  
      this.cronExpression = cronExpression;  
    }  
  
    public String getIsEffect(){  
      return isEffect;  
    }  
    
    public void setIsEffect(String isEffect){  
      this.isEffect = isEffect;  
    }  
  
    public String getIsStart(){  
      return isStart;  
    }  
    
    public void setIsStart(String isStart){  
      this.isStart = isStart;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
  
    public String getCreateBy(){  
      return createBy;  
    }  
    
    public void setCreateBy(String createBy){  
      this.createBy = createBy;  
    }  
  
    public String getCreateName(){  
      return createName;  
    }  
    
    public void setCreateName(String createName){  
      this.createName = createName;  
    }  
  
    public Date getUpdateDate(){  
      return updateDate;  
    }  
    
    public void setUpdateDate(Date updateDate){  
      this.updateDate = updateDate;  
    }  
  
    public String getUpdateBy(){  
      return updateBy;  
    }  
    
    public void setUpdateBy(String updateBy){  
      this.updateBy = updateBy;  
    }  
  
    public String getUpdateName(){  
      return updateName;  
    }  
    
    public void setUpdateName(String updateName){  
      this.updateName = updateName;  
    }

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}  
    
	
}


