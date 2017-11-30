package com.chuangbang.base.service.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.app.Api;
import com.chuangbang.base.dao.app.ApiDao;

/**
 * 接口表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ApiService extends BaseService<Api,ApiDao> {

	@Autowired
	private ApiDao apiDao;
	
	public Api getEntity(Long id) {
		return apiDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveApi(Api api) {
		apiDao.save(api);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		apiDao.delete(id);
	}

	public Api findByUrl(String url) {
		// TODO Auto-generated method stub
		return apiDao.findByUrl(url);
	}
	
}
