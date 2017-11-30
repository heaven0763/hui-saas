package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.Api;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 接口表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ApiDao extends BaseRepository<Api, Long>,PagingAndSortingRepository<Api, Long>{

	public Api findByUrl(String url);

}