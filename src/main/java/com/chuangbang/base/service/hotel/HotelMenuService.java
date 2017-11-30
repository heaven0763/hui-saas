package com.chuangbang.base.service.hotel;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.dao.hotel.HotelMenuDao;

/**
 * 酒店餐饮菜单Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class HotelMenuService extends BaseService<HotelMenu,HotelMenuDao> {

	@Autowired
	private HotelMenuDao hotelMenuDao;
	
	public HotelMenu getEntity(Long id) {
		return hotelMenuDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelMenu(HotelMenu hotelMenu) {
		if(null==hotelMenu.getId()){
			hotelMenu.setCreateDate(new Date());
		}
		hotelMenuDao.save(hotelMenu);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelMenuDao.delete(id);
	}
	
}
