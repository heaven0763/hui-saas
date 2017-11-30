package com.chuangbang.base.service.hotel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.OfflineParty;
import com.chuangbang.base.dao.hotel.OfflinePartyDao;

/**
 * 线下活动Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class OfflinePartyService extends BaseService<OfflineParty,OfflinePartyDao> {

	@Autowired
	private OfflinePartyDao offlinePartyDao;
	
	public OfflineParty getEntity(Long id) {
		return offlinePartyDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveOfflineParty(OfflineParty offlineParty) {
		offlinePartyDao.save(offlineParty);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		offlinePartyDao.delete(id);
	}
	
}
