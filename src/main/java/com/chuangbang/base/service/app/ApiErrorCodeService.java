package com.chuangbang.base.service.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.app.ApiErrorCode;
import com.chuangbang.base.dao.app.ApiErrorCodeDao;

/**
 * 接口错误码Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ApiErrorCodeService extends BaseService<ApiErrorCode,ApiErrorCodeDao> {

	@Autowired
	private ApiErrorCodeDao apiErrorCodeDao;
	
	public ApiErrorCode getEntity(Long id) {
		return apiErrorCodeDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveApiErrorCode(ApiErrorCode apiErrorCode) {
		apiErrorCodeDao.save(apiErrorCode);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		apiErrorCodeDao.delete(id);
	}
	
}
