package com.chuangbang.base.entity.user;

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
 * 权限记录Entity
 * @author liaotingyao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_userPermission")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserPermission extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 人员编号
	 */
	private String userId;  
	
	/**
	 * 人员姓名
	 */
	private String userName;  
	
	/**
	 *	权限 id
	 */
	private String permissionId;
	/**
	 * 权限名称
	 */
	private String permissions;
	/**
	 * 权限名称
	 */
	private String permissionName;
	
	/**
	 * 开始时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date startTime;
	
	/**
	 * 结束时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date endTime;
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注	
	 */
	private String memo;
	/**
	 * 0:临时权限；1：永久权限
	 */
	private String type;
	
	/**
	 * 调整时间
	 */
	private Date adjustDate;  
	
	/**
	 * 调整人编号
	 */
	private String adjustUid;
	
	/**
	 * 1：微信权限；2：pc权限
	 */
	private String isweixin;
	
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
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
    
	public String getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}
	public String getPermissionName() {
		return permissionName;
	}
	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	@Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=5)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public UserPermission(String userId, String userName, String permissionId, String permissionName, Date startTime,
			Date endTime, Date createDate, String memo, String type,String adjustUid,Date adjustDate,String permissions,String isweixin) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.permissionId = permissionId;
		this.permissionName = permissionName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.createDate = createDate;
		this.memo = memo;
		this.type = type;
		this.adjustUid = adjustUid;
		this.adjustDate = adjustDate;
		this.permissions = permissions;
		this.isweixin = isweixin;
	}
	
	public UserPermission() {
		super();
	}
	public Date getAdjustDate() {
		return adjustDate;
	}
	public void setAdjustDate(Date adjustDate) {
		this.adjustDate = adjustDate;
	}
	public String getAdjustUid() {
		return adjustUid;
	}
	public void setAdjustUid(String adjustUid) {
		this.adjustUid = adjustUid;
	}
	public String getPermissions() {
		return permissions;
	}
	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}
	public String getIsweixin() {
		return isweixin;
	}
	public void setIsweixin(String isweixin) {
		this.isweixin = isweixin;
	}
	@Override
	public String toString() {
		return " p.id as id, p.user_id as userId, p.user_name as userName, p.permission_id as permissionId, p.permissions as permissions"
				+ ", p.permission_name as permissionName, p.start_time as startTime, p.end_time as endTime, p.create_date as createDate"
				+ ", p.memo as memo, p.type as type, p.adjust_date as adjustDate, p.adjust_uid as adjustUid, p.isweixin as isweixin";
	}  
	
	
	
}


