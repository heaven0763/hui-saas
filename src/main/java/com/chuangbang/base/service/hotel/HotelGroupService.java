package com.chuangbang.base.service.hotel;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.dao.hotel.HotelGroupDao;

/**
 * 酒店集团Service
 * @author heaven
 * @version 2017-10-12
 */
@Component
@Transactional(readOnly = true)
public class HotelGroupService extends BaseService<HotelGroup,HotelGroupDao> {

	@Autowired
	private HotelGroupDao hotelGroupDao;
	
	public HotelGroup getEntity(Long id) {
		return hotelGroupDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelGroup(HotelGroup hotelGroup) {
		if(hotelGroup.getId()==null){
			hotelGroup.setState("1");
			hotelGroup.setCreateUserId(AccountUtils.getCurrentUserId());
			hotelGroup.setCreateDate(new Date());
			hotelGroup.setCompanyId(AccountUtils.getCurrentUserCompanyId());
		}
		hotelGroupDao.save(hotelGroup);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelGroupDao.delete(id);
	}
	
}
