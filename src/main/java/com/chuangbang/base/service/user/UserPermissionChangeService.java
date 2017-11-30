package com.chuangbang.base.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.user.UserPermissionChange;
import com.chuangbang.base.dao.user.UserPermissionChangeDao;

/**
 * 权限调整记录Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class UserPermissionChangeService extends BaseService<UserPermissionChange,UserPermissionChangeDao> {

	@Autowired
	private UserPermissionChangeDao userPermissionChangeDao;
	
	public UserPermissionChange getEntity(Long id) {
		return userPermissionChangeDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveUserPermissionChange(UserPermissionChange userPermissionChange) {
		userPermissionChangeDao.save(userPermissionChange);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		userPermissionChangeDao.delete(id);
	}
	
}
