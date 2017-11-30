package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.ApiParams;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 接口参数表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ApiParamsDao extends BaseRepository<ApiParams, Long>,PagingAndSortingRepository<ApiParams, Long>{

}