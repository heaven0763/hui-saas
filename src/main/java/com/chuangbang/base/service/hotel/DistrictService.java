package com.chuangbang.base.service.hotel;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.hotel.District;
import com.chuangbang.base.dao.hotel.DistrictDao;

/**
 * 商圈信息Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class DistrictService extends BaseService<District,DistrictDao> {

	@Autowired
	private DistrictDao districtDao;
	
	public District getEntity(Long id) {
		return districtDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveDistrict(District district) {
		if(null==district.getId()){
			district.setAddTime(new Date().getTime()/1000+"");
		}
		districtDao.save(district);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		districtDao.delete(id);
	}
	
}
