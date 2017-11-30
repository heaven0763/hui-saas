package com.chuangbang.js.dao.account;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.js.entity.account.Group;

/**
 * 权限组对象的Dao interface.
 * 
 * @author Heaven
 */

public interface GroupDao extends PagingAndSortingRepository<Group, Long>, GroupDaoCustom,BaseRepository<Group, Long> {
	public Group findByGroupId(String groupId);

	public List<Group> findByMemo(String memo);

	public Group findByName(String name);
}
