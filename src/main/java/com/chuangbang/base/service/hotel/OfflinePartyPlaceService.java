package com.chuangbang.base.service.hotel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.OfflinePartyPlace;
import com.chuangbang.base.dao.hotel.OfflinePartyPlaceDao;

/**
 * 线下活动场地Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class OfflinePartyPlaceService extends BaseService<OfflinePartyPlace,OfflinePartyPlaceDao> {

	@Autowired
	private OfflinePartyPlaceDao offlinePartyPlaceDao;
	
	public OfflinePartyPlace getEntity(Long id) {
		return offlinePartyPlaceDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveOfflinePartyPlace(OfflinePartyPlace offlinePartyPlace) {
		offlinePartyPlaceDao.save(offlinePartyPlace);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		offlinePartyPlaceDao.delete(id);
	}
	
}
