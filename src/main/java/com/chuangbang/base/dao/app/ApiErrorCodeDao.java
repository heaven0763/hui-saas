package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.ApiErrorCode;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 接口错误码DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ApiErrorCodeDao extends BaseRepository<ApiErrorCode, Long>,PagingAndSortingRepository<ApiErrorCode, Long>{

}