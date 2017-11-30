package com.chuangbang.base.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.user.PointsRecord;
import com.chuangbang.base.dao.user.PointsRecordDao;

/**
 * 积分记录Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class PointsRecordService extends BaseService<PointsRecord,PointsRecordDao> {

	@Autowired
	private PointsRecordDao pointsRecordDao;
	
	public PointsRecord getEntity(Long id) {
		return pointsRecordDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void savePointsRecord(PointsRecord pointsRecord) {
		pointsRecordDao.save(pointsRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		pointsRecordDao.delete(id);
	}
	
}
