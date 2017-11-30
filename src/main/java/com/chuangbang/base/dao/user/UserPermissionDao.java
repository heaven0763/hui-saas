package com.chuangbang.base.dao.user;

import java.util.Date;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 权限调整记录DAO接口
 * @author liaotingyao
 * @version 2016-11-15
 */
public interface UserPermissionDao extends BaseRepository<UserPermission, Long>,PagingAndSortingRepository<UserPermission, Long>{

	UserPermission findByUserIdAndPermissionIdAndType(String userId, String permissionId, String type);
	UserPermission findByUserIdAndPermissionIdAndTypeAndStartTimeAndEndTime(String userId, String permissionId,
			String type, Date startTime, Date endTime);

}