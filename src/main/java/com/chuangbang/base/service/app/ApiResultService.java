package com.chuangbang.base.service.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.app.ApiResult;
import com.chuangbang.base.dao.app.ApiResultDao;

/**
 * 接口结果表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ApiResultService extends BaseService<ApiResult,ApiResultDao> {

	@Autowired
	private ApiResultDao apiResultDao;
	
	public ApiResult getEntity(Long id) {
		return apiResultDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveApiResult(ApiResult apiResult) {
		apiResultDao.save(apiResult);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		apiResultDao.delete(id);
	}
	
}
