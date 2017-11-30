package com.chuangbang.base.service.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.app.ApiParams;
import com.chuangbang.base.dao.app.ApiParamsDao;

/**
 * 接口参数表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ApiParamsService extends BaseService<ApiParams,ApiParamsDao> {

	@Autowired
	private ApiParamsDao apiParamsDao;
	
	public ApiParams getEntity(Long id) {
		return apiParamsDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveApiParams(ApiParams apiParams) {
		apiParamsDao.save(apiParams);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		apiParamsDao.delete(id);
	}
	
}
