package com.chuangbang.framework.service.system;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.dao.system.SystemParameterDao;
import com.chuangbang.framework.entity.system.SystemParameter;
import com.chuangbang.framework.service.BaseService;

@Component("systemParameterService")

@Transactional(readOnly = true)
public class SystemParameterService extends BaseService<SystemParameter, SystemParameterDao>{

	private static Logger logger = LoggerFactory.getLogger(SystemParameterService.class);

	@Autowired
	private SystemParameterDao systemparameterDao;

	//-- User Manager --//
	public SystemParameter getSystemParameter(Long id) {
		return systemparameterDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveSystemParameter(SystemParameter entity) {
		systemparameterDao.save(entity);
	}
	
	@Transactional(readOnly = false)
	public boolean deleteSystemParameter(Long id) {
		SystemParameter systemParameter = systemparameterDao.findOne(id);
		if(!"1".equals(systemParameter.getCanbedel()) ){
			return false;
		}
		systemparameterDao.delete(id);
		return true;
	}

	public List<SystemParameter> getAllSystemParameter() {
		return systemparameterDao.findAll(new Sort(Direction.ASC, "id"));
	}
	
	public Page<SystemParameter> getSystemParameterByPage(PageRequest pr)
	{
		return systemparameterDao.findAll(pr);
	}
	
	public String getValueByCode(String code) {
		SystemParameter systemParamter = getByCode(code);
		return systemParamter == null? "" : systemParamter.getValue();
	}
	
	public SystemParameter getByCode(String code) {
		List<SystemParameter> list = systemparameterDao.findByCode(code);
		return list !=null && list.size() > 0? list.get(0) : null;
	}
	
}