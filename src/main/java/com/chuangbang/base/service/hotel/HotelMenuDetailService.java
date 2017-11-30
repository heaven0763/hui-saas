package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.HotelMenuDetail;
import com.chuangbang.base.dao.hotel.HotelMenuDetailDao;

/**
 * 酒店餐饮菜单明细Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class HotelMenuDetailService extends BaseService<HotelMenuDetail,HotelMenuDetailDao> {

	@Autowired
	private HotelMenuDetailDao hotelMenuDetailDao;
	
	public HotelMenuDetail getEntity(Long id) {
		return hotelMenuDetailDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelMenuDetail(HotelMenuDetail hotelMenuDetail) {
		if(hotelMenuDetail.getId()==null){
			hotelMenuDetail.setCreateDate(new Date());
		}
		hotelMenuDetailDao.save(hotelMenuDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelMenuDetailDao.delete(id);
	}

	public List<HotelMenuDetail> findByMenuId(Long id) {
		return hotelMenuDetailDao.findByMenuId(id);
	}
	
}
