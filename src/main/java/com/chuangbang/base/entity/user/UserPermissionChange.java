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

/**
 * 权限调整记录Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_userPermissionChange")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserPermissionChange extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 被调整人编号
	 */
	private String userId;  
	
	/**
	 * 被调整人姓名
	 */
	private String userName;  
	
	/**
	 * 被调整人邮箱
	 */
	private String email;  
	
	/**
	 * 被调整人电话
	 */
	private String mobile;  
	
	/**
	 * 被调整人旧角色
	 */
	private Long oldgid;  
	
	/**
	 * 被调整人新角色
	 */
	private Long newgid;  
	
	/**
	 * 调整时间
	 */
	private Date adjustDate;  
	
	/**
	 * 调整人编号
	 */
	private String adjustUid;  
	
	/**
	 * 调整人姓名
	 */
	private String adjustUname;  
	
	/**
	 * 调整人旧角色
	 */
	private Long adjustOldgid;  
	
	/**
	 * 调整人新角色
	 */
	private Long adjustNewgid;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注	
	 */
	private String memo;  
	
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
    public String getEmail(){  
      return email;  
    }  
    public void setEmail(String email){  
      this.email = email;  
    }  
  
    @Column(length=50)
    public String getMobile(){  
      return mobile;  
    }  
    public void setMobile(String mobile){  
      this.mobile = mobile;  
    }  
  
    public Long getOldgid(){  
      return oldgid;  
    }  
    public void setOldgid(Long oldgid){  
      this.oldgid = oldgid;  
    }  
  
    public Long getNewgid(){  
      return newgid;  
    }  
    public void setNewgid(Long newgid){  
      this.newgid = newgid;  
    }  
  
    public Date getAdjustDate(){  
      return adjustDate;  
    }  
    
    public void setAdjustDate(Date adjustDate){  
      this.adjustDate = adjustDate;  
    }  
  
    @Column(length=50)
    public String getAdjustUid(){  
      return adjustUid;  
    }  
    public void setAdjustUid(String adjustUid){  
      this.adjustUid = adjustUid;  
    }  
    
    @Column(length=50)
    public String getAdjustUname(){  
      return adjustUname;  
    }  
    public void setAdjustUname(String adjustUname){  
      this.adjustUname = adjustUname;  
    }  
  
    public Long getAdjustOldgid(){  
      return adjustOldgid;  
    }  
    public void setAdjustOldgid(Long adjustOldgid){  
      this.adjustOldgid = adjustOldgid;  
    }  
  
    public Long getAdjustNewgid(){  
      return adjustNewgid;  
    }  
    public void setAdjustNewgid(Long adjustNewgid){  
      this.adjustNewgid = adjustNewgid;  
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
}


