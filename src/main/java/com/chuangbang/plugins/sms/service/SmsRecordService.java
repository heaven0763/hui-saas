package com.chuangbang.plugins.sms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.plugins.sms.dao.SmsRecordDao;
import com.chuangbang.plugins.sms.entity.SmsRecord;

@Component
@Transactional(readOnly = true)
public class SmsRecordService extends BaseService<SmsRecord, SmsRecordDao>{
	@Autowired
	private SmsRecordDao smsRecordDao;
	
	public SmsRecord getEntity(Long id) {
		return smsRecordDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveSmsRecord(SmsRecord smsRecord) {
		smsRecordDao.save(smsRecord);
	}
	

	@Transactional(readOnly = false)
	public void delete(Long id) {
		smsRecordDao.delete(id);
	}
	
}
