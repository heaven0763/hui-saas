package com.chuangbang.js.dao.account;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.Permission;

public interface PermissionDao extends PagingAndSortingRepository<Permission, Long>,BaseRepository<Permission, Long>{
	
	public Permission findByPermission(String permission);
	
	public List<Permission> findByParentId(Long parentId);

	public List<Permission> findByMenuId(Long menuId);
}
