package com.chuangbang.base.service.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.app.Log;
import com.chuangbang.base.dao.app.LogDao;

/**
 * 日志表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class LogService extends BaseService<Log,LogDao> {

	@Autowired
	private LogDao logDao;
	
	public Log getEntity(Long id) {
		return logDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveLog(Log log) {
		logDao.save(log);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		logDao.delete(id);
	}
	
}
