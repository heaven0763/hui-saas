package com.chuangbang.js.service.account;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.entity.account.Group;

@Component

@Transactional(readOnly = true)
public class GroupService extends BaseService<Group,GroupDao> {

	@Autowired
	private GroupDao groupDao;
	
	public Group findByGroupId(String groupId){
		return groupDao.findByGroupId(groupId);
	}
	
	public List<Group> findByMemo(String memo){
		return groupDao.findByMemo(memo);
	}
}

