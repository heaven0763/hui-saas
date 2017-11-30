package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.Audit;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 审核表DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface AuditDao extends BaseRepository<Audit, Long>,PagingAndSortingRepository<Audit, Long>{

}