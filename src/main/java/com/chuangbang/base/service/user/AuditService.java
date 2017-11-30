package com.chuangbang.base.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.user.Audit;
import com.chuangbang.base.dao.user.AuditDao;

/**
 * 审核表Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class AuditService extends BaseService<Audit,AuditDao> {

	@Autowired
	private AuditDao auditDao;
	
	public Audit getEntity(Long id) {
		return auditDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveAudit(Audit audit) {
		auditDao.save(audit);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		auditDao.delete(id);
	}
	
}
