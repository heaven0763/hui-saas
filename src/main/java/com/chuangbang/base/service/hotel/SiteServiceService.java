package com.chuangbang.base.service.hotel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.SiteService;
import com.chuangbang.base.dao.hotel.SiteServiceDao;

/**
 * 场地图片Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class SiteServiceService extends BaseService<SiteService,SiteServiceDao> {

	@Autowired
	private SiteServiceDao siteServiceDao;
	
	public SiteService getEntity(Long id) {
		return siteServiceDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveSiteService(SiteService siteService) {
		siteServiceDao.save(siteService);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		siteServiceDao.delete(id);
	}
	
}
