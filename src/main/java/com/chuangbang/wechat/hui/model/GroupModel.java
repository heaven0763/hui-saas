package com.chuangbang.wechat.hui.model;

import java.io.Serializable;
import java.util.List;

import com.chuangbang.framework.entity.IdEntity;
import com.chuangbang.js.entity.account.Permission;
import com.google.common.collect.Lists;

public class GroupModel extends IdEntity implements Serializable{

	private static final long serialVersionUID = 1L;

	private String groupId;

	private String name;

	private String memo;
	
	private Long pid;

	private List<Permission> permissions = Lists.newArrayList();

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

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

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

}
