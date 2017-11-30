package com.chuangbang.js.entity.account;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.ForeignKey;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;

/**
 * 权限组.
 * 
 * 注释见{@link User}.
 * 
 * @author
 */
@Entity
@Table(name = "hui_group")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Group extends IdEntity implements Serializable{

	private static final long serialVersionUID = 1L;

	private String groupId;

	private String name;

	private String memo;
	
	private Long pid;
	
	private Long deptId;

	@JsonIgnore
	private List<String> permissionList = Lists.newArrayList();

	@JsonIgnore
	private List<Permission> permissionEntityList = Lists.newArrayList();

	@JsonIgnore
	private List<String> menuIdList = Lists.newArrayList();

	@JsonIgnore
	private List<Menu> menuList = Lists.newArrayList();
	
	@JsonIgnore
	private List<User> users = Lists.newArrayList();

	@Column(name = "group_id")
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Transient
	public List<String> getPermissionList() {
		for (Permission permission : permissionEntityList) {
			permissionList.add(permission.getPermission());
		}
		return permissionList;
	}

	public void setPermissionList(List<String> permissionList) {
		this.permissionList = permissionList;
	}

	@ElementCollection
	@CollectionTable(name = "hui_GROUP_MENU", joinColumns = { @JoinColumn(name = "GroupId") })
	@Column(name = "MenuId")
	@ForeignKey(name = "none")
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<String> getMenuIdList() {
		return menuIdList;
	}

	public void setMenuIdList(List<String> menuIdList) {
		this.menuIdList = menuIdList;
	}

	@Transient
	public String getPermissionNames() {
		List<String> permissionNameList = Lists.newArrayList();
		for (Permission permission : permissionEntityList) {
			permissionNameList.add(permission.permission);
		}
		return StringUtils.join(permissionNameList, ",");
	}

	// 多对多定义
	@ManyToMany
	@JoinTable(name = "hui_GROUP_PERMISSION", joinColumns = { @JoinColumn(name = "GroupId") }, inverseJoinColumns = { @JoinColumn(name = "permission") })
	// Fecth策略定义
	@Fetch(FetchMode.SUBSELECT)
	@ForeignKey(name = "none")
	// 集合按id排序.
	@OrderBy("permission")
	// 集合中对象id的缓存.
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<Permission> getPermissionEntityList() {
		return permissionEntityList;
	}

	public void setPermissionEntityList(List<Permission> permissionEntityList) {
		this.permissionEntityList = permissionEntityList;
	}

	// 多对多定义
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name = "hui_GROUP_MENU", joinColumns = { @JoinColumn(name = "GroupId") }, inverseJoinColumns = { @JoinColumn(name = "MenuId") })
	// Fecth策略定义
	@Fetch(FetchMode.SUBSELECT)
	@ForeignKey(name = "none")
	// 集合按id排序.
	@OrderBy("orderId")
	// 集合中对象id的缓存.
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<Menu> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	@OneToMany(cascade={CascadeType.PERSIST,CascadeType.REFRESH},fetch=FetchType.LAZY)
	@JoinColumn(name="groupId",insertable=false,updatable=false)
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	

	@Transient
	@JsonIgnore
	public String getMenuIds() {
		StringBuilder sbd = new StringBuilder();
		for (Menu menu : menuList) {
			sbd.append(","+menu.getId());
		}
		return sbd.toString();
	}
	
	@Transient
	@JsonIgnore
	public String getPermissionIds() {
		StringBuilder sbd = new StringBuilder();
		for (Permission permission : permissionEntityList) {
			sbd.append(","+permission.getId());
		}
		return sbd.toString();
	}

	@Column(length=500)
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Long getDeptId() {
		return deptId;
	}
	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}
	
	
}
