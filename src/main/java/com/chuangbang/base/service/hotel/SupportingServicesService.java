package com.chuangbang.base.service.hotel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.base.entity.hotel.SupportingServices;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.dao.hotel.SupportingServicesDao;

/**
 * 配套服务Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class SupportingServicesService extends BaseService<SupportingServices,SupportingServicesDao> {

	@Autowired
	private SupportingServicesDao supportingServicesDao;
	@Autowired
	private CustomPageService customPageService;
	
	public SupportingServices getEntity(Long id) {
		return supportingServicesDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveSupportingServices(SupportingServices supportingServices) {
		supportingServicesDao.save(supportingServices);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		supportingServicesDao.delete(id);
	}

	public List<SupportingModel> findByKind(String kind) {
		PageBean<SupportingModel> pageBean = new PageBean<>();
		String columstr = "s.id as id, s.kind as kind, s.name as name, s.logo as logo, ifnull(NULL,0) flag";
		String fromWhere = " from hui_supporting_services s where 1=1 and s.kind='"+kind+"' ";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, SupportingModel.class, null);
	}
	
	public List<SupportingModel> findByKind(String kind,String itemId,String siteType) {
		PageBean<SupportingModel> pageBean = new PageBean<>();
		String columstr = "s.id as id, s.kind as kind, s.name as name, s.logo as logo";
		if("HALLDISPLAY".equals(kind)){
			columstr+= ", ifnull((select people_num from hui_hotel_hall_people_num where hall_id="+itemId+" and display_id=s.id),0) flag";
		}else if("HALLSUPPORT".equals(kind)){
			columstr+= ", (select spval from hui_site_service where site_id="+itemId+" and site_type='"+siteType+"' and service_id=s.id and kind ='"+kind+"') spval";
			columstr+= ", ifnull((select count(*) from hui_site_service where site_id="+itemId+" and site_type='"+siteType+"' and service_id=s.id and kind ='"+kind+"'),0) flag";
		}else{
			columstr+= ", ifnull((select count(*) from hui_site_service where site_id="+itemId+" and site_type='"+siteType+"' and service_id=s.id and kind ='"+kind+"'),0) flag";
		}
		
		String fromWhere = " from hui_supporting_services s where 1=1 and s.kind='"+kind+"' ";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, SupportingModel.class, null);
	}
	
	
	public List<HotelModel> getAllHotel(PageBean<HotelModel> pageBean) {
		String columstr = "s.id as id, s.kind as kind, s.name as name, s.logo as logo"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '9') ishave";
		String fromWhere = " from hui_Hotel h where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, HotelModel.class, null);
	}
	
	
	
}
