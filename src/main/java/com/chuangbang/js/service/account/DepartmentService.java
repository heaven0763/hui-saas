/**
 * Created on Mon Jun 04 16:35:16 CST 2012
 * Copyright chuangbang, 2012-2012, All rights reserved.
 */

package com.chuangbang.js.service.account;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.js.dao.account.DepartmentDao;
import com.chuangbang.js.entity.account.Department;

@Component
@Transactional(readOnly = true)
public class DepartmentService extends BaseService<Department, DepartmentDao>{

	private static Logger logger = LoggerFactory.getLogger(DepartmentService.class);

	@Autowired
	private DepartmentDao departmentDao;

	// -- User Manager --//
	public Department getDepartment(Long id) {
		return departmentDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveDepartment(Department entity) {
		departmentDao.save(entity);
	}

	@Transactional(readOnly = false)
	public void deleteDepartment(Long id) {
		departmentDao.delete(id);
	}

	@Override
	@Transactional(readOnly = false)
	public void batchDelete(Long[] ids){
		departmentDao.batchDelete(ids);
	}
	
	public Department findByUnitcode(String unitcode){
		return departmentDao.findByUnitcode(unitcode);
	}
	public Department findByUnitcode(String unitcode,Long shopId) {
		Map<String, Object> searchParams = Maps.newHashMap();
		searchParams.put("EQ_unitcode", unitcode);
		searchParams.put("EQ_shop.id", shopId);
		List<Department> departments = this.getEntities(searchParams);
		if(departments!=null&&departments.size()>0){
			return departments.get(0);
		}else{
			return null;
		}
	}
}