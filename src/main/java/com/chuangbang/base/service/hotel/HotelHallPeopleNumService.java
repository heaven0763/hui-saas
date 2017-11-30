package com.chuangbang.base.service.hotel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.HotelHallPeopleNum;
import com.chuangbang.base.dao.hotel.HotelHallPeopleNumDao;

/**
 * 大厅容纳人数Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class HotelHallPeopleNumService extends BaseService<HotelHallPeopleNum,HotelHallPeopleNumDao> {

	@Autowired
	private HotelHallPeopleNumDao hotelHallPeopleNumDao;
	
	public HotelHallPeopleNum getEntity(Long id) {
		return hotelHallPeopleNumDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelHallPeopleNum(HotelHallPeopleNum hotelHallPeopleNum) {
		hotelHallPeopleNumDao.save(hotelHallPeopleNum);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelHallPeopleNumDao.delete(id);
	}
	
}
