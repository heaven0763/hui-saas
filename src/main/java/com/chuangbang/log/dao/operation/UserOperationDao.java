package com.chuangbang.log.dao.operation;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.log.entity.operation.UserOperation;

public interface UserOperationDao extends PagingAndSortingRepository<UserOperation, Long>, BaseRepository<UserOperation, Long>{

	@Query("from UserOperation u where u.operateTable=? and u.operateId=? order by u.operateTime desc" )
	List<UserOperation> findByOperateTableAndOperateId(String operateTable, String operateId);

}
