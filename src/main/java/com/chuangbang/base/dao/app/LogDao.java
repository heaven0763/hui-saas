package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.Log;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 日志表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface LogDao extends BaseRepository<Log, Long>,PagingAndSortingRepository<Log, Long>{

}