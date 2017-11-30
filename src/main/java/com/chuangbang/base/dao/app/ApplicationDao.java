package com.chuangbang.base.dao.app;

import com.chuangbang.base.entity.app.Application;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 应用表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ApplicationDao extends BaseRepository<Application, Long>,PagingAndSortingRepository<Application, Long>{

	public Application findByAppKey(String key);
	public Application findByAppId(String appId);

}