package com.chuangbang.js.service.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.js.dao.account.LogininfoDao;
import com.chuangbang.js.entity.account.Logininfo;



@Component

@Transactional(readOnly = true)
public class LogininfoService {

	private static Logger logger = LoggerFactory.getLogger(LogininfoService.class);

	private LogininfoDao logininfoDao;


	//-- User Manager --//
	public Logininfo getLogininfo(Long id) {
		return logininfoDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveLogininfo(Logininfo entity) {
		try{
			logininfoDao.save(entity);
		}catch(Throwable e){
			logger.error("记录登录日志错误：",e);
		}
	}

	@Transactional(readOnly = false)
	public void deleteLogininfo(Long id) {
		logininfoDao.delete(id);
	}

	@Autowired
	public void setLogininfoDao(LogininfoDao logininfoDao) {
		this.logininfoDao = logininfoDao;
	}

}

