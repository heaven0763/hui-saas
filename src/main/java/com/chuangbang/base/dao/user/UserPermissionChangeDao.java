package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.UserPermissionChange;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 权限调整记录DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface UserPermissionChangeDao extends BaseRepository<UserPermissionChange, Long>,PagingAndSortingRepository<UserPermissionChange, Long>{

}