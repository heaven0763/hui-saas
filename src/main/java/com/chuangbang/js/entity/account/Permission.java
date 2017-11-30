package com.chuangbang.js.entity.account;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * Resource Base Access Control中的资源定义.
 * 
 * @author Heaven
 */
@Entity
@Table(name = "hui_permission")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Permission  extends IdEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/**
	 * 权限代码 
	 */
	public String permission;
	
	/**
	 * 权限名称  
	 */
	public String displayname;
	
	/**
	 * 权限说明
	 */
	public String memo;

	/**
	 * 父id
	 */
	private Long parentId;
	/**
	 * 菜单
	 */
	private Long menuId;
	
	
	
	/**
	 *  菜单名称
	 */
	public String menuName;
	
	private String type;
	
	@Column(length=255)
	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	@Column(length=255)
	public String getDisplayname() {
		return displayname;
	}

	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}
	@Column(length=500)
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Permission(String permission, String displayname, String memo,
			Long parentId) {
		super();
		this.permission = permission;
		this.displayname = displayname;
		this.memo = memo;
		this.parentId = parentId;
	}
	
	

	public Permission(String permission, String displayname, String memo, Long parentId, Long menuId) {
		super();
		this.permission = permission;
		this.displayname = displayname;
		this.memo = memo;
		this.parentId = parentId;
		this.menuId = menuId;
	}

	public Permission() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Long getMenuId() {
		return menuId;
	}
	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}

	@Transient
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	@Column(length=5)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

}
