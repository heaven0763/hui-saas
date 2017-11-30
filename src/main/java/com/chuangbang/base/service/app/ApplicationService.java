package com.chuangbang.base.service.app;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.app.ApplicationDao;
import com.chuangbang.base.entity.app.Application;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.RandomStringUtil;

/**
 * 应用表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ApplicationService extends BaseService<Application,ApplicationDao> {

	@Autowired
	private ApplicationDao applicationDao;
	
	public Application getEntity(Long id) {
		return applicationDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveApplication(Application application) {
		if(null==application.getId()){
			application.setAppId(RandomStringUtil.nextNumString(8));
			application.setAppKey(RandomStringUtil.nextString(16));
			//application.setEffectiveDate(new Date("2099-12-31"));
			application.setCreateDate(new Date());
			application.setState("1");
		}
		applicationDao.save(application);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		applicationDao.delete(id);
	}
	
	public Application findByAppKey(String key){
		return applicationDao.findByAppKey(key);
	}
	
	public Application findByAppId(String key) {
		return applicationDao.findByAppId(key);
	}
}
