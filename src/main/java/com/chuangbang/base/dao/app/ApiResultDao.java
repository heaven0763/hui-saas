package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.ApiResult;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 接口结果表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ApiResultDao extends BaseRepository<ApiResult, Long>,PagingAndSortingRepository<ApiResult, Long>{

}