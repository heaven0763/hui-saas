package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.ScheduleModel;
import com.chuangbang.base.dao.hotel.CategoryDao;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;

/**
 * 场地档期Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class HotelScheduleService extends BaseService<HotelSchedule,HotelScheduleDao> {

	@Autowired
	private HotelScheduleDao hotelScheduleDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private CustomPageService customPageService;
	
	public HotelSchedule getEntity(Long id) {
		return hotelScheduleDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelSchedule(HotelSchedule hotelSchedule) {
		hotelScheduleDao.save(hotelSchedule);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelScheduleDao.delete(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelSchedule(HotelSchedule hotelSchedule, String placeSchedule) {
		if("ALL".equals(placeSchedule)){
			List<Category> categories = this.categoryDao.findByKind("SCHEDULETIME");
			for (Category category : categories) {
				HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(hotelSchedule.getPlaceId(),hotelSchedule.getPlaceDate(),category.getId()+"");
				if(schedule==null){
					schedule = new HotelSchedule(hotelSchedule.getHotelId(), hotelSchedule.getHotelName(), hotelSchedule.getPlaceType(), hotelSchedule.getPlaceId(), hotelSchedule.getPlaceName(), category.getId()+"", hotelSchedule.getPlaceDate(), "0", AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
					this.hotelScheduleDao.save(schedule);
				}
			}
		}else{
			HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(hotelSchedule.getPlaceId(),hotelSchedule.getPlaceDate(),hotelSchedule.getPlaceSchedule());
			if(schedule==null){
				hotelSchedule.setState("0");
				hotelSchedule.setCreateUserId(AccountUtils.getCurrentUserId());
				hotelSchedule.setCreateUserName(AccountUtils.getCurrentRName());
				hotelSchedule.setCreateDate(new Date());
				hotelScheduleDao.save(hotelSchedule);
			}
		}
	}
	
	public void batchSaveSchedule(String strtDate,int days,List<HallModel> hallModels){
		List<Category> categories = this.categoryDao.findByKind("SCHEDULETIME");
		for (HallModel hallModel : hallModels) {
			for (int i = 0; i < days; i++) {
				String startDate = DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(strtDate),i), "yyyy-MM-dd");
				for (Category category : categories) {
					HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(hallModel.getId(),startDate,category.getId()+"");
					if(schedule==null){
						schedule = new HotelSchedule(hallModel.getHotelId(), hallModel.getHotelName(), "Schedule", hallModel.getId(), hallModel.getPlaceName(), category.getId()+"", startDate, "0", AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
						this.hotelScheduleDao.save(schedule);
					}
				}
			}
		}
		
	}
	public List<ScheduleModel> getSchedulePageList(Long placeId,String placeType,String placeDate) {
		PageBean<ScheduleModel> pageBean = new PageBean<>();
		String columstr =" s.id as id, s.hotel_id as hotelId, s.hotel_name as hotelName, s.place_type as placeType, s.place_id as placeId, s.place_name as placeName, s.place_schedule as placeSchedule"
				+ ", s.place_date as placeDate, p.online_price as onlinePrice, p.offline_price as offlinePrice, b.state as state, s.create_date as createDate, s.memo as memo, c.name as placeScheduleName,b.order_no as orderNo";
		String fromWhere = " from hui_hotel_schedule s left join hui_place_price p on p.place_id = s.place_id and p.place_schedule = s.place_date "
				+ " left join hui_category c on c.id = s.place_schedule left join hui_schedule_booking b on b.place_schedule_id = s.id "
				+ "where 1=1 and s.place_date ='"+placeDate+"'"
				+" and s.place_id = "+placeId;//+" and s.place_type = '"+placeType+"'";
		pageBean.setSort("s.place_id,s.place_date,s.place_schedule");
		pageBean.setOrder("ASC,ASC,ASC");
		return customPageService.getAll(pageBean, columstr, fromWhere, ScheduleModel.class,null);
	}
	public List<ScheduleModel> getSchedulePageList(PageBean<ScheduleModel> pageBean) {
		String columstr =" s.id as id, s.hotel_id as hotelId, s.hotel_name as hotelName, s.place_type as placeType, s.place_id as placeId, s.place_name as placeName, s.place_schedule as placeSchedule"
				+ ", s.place_date as placeDate, p.online_price as onlinePrice, p.offline_price as offlinePrice, s.state as state, s.create_date as createDate, s.memo as memo";
		String fromWhere = " from hui_hotel_schedule s left join hui_place_price p on p.place_id = s.place_id and p.place_schedule = s.place_date "
				+ " left join hui_category c on c.id = s.place_schedule where 1=1";
		return customPageService.page(pageBean, columstr, fromWhere, ScheduleModel.class,null);
	} 

	public List<ScheduleModel> getAllSchedule(PageBean<ScheduleModel> pageBean) {
		String columstr =" s.id as id, s.hotel_id as hotelId, s.hotel_name as hotelName, s.place_type as placeType, s.place_id as placeId, s.place_name as placeName, s.place_schedule as placeSchedule"
				+ ", s.place_date as placeDate, p.online_price as onlinePrice, p.offline_price as offlinePrice, s.state as state, s.create_date as createDate, s.memo as memo";
		String fromWhere = " from hui_hotel_schedule s left join hui_place_price p on p.place_id = s.place_id and p.place_schedule = s.place_date where 1=1";
		return customPageService.getAll(pageBean, columstr, fromWhere, ScheduleModel.class, null);
	}
	
	public ScheduleModel getSchedule(Long id) {
		String columstr =" s.id as id, s.hotel_id as hotelId, s.hotel_name as hotelName, s.place_type as placeType, s.place_id as placeId, s.place_name as placeName, s.place_schedule as placeSchedule"
				+ ", s.place_date as placeDate, p.online_price as onlinePrice, p.offline_price as offlinePrice, s.state as state, s.create_date as createDate, s.memo as memo";
		String fromWhere = " from hui_hotel_schedule s left join hui_place_price p on p.place_id = s.place_id and p.place_schedule = s.place_date where s.id="+id;
		return customPageService.getOne(columstr, fromWhere, ScheduleModel.class);
	}

	public HotelSchedule findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(Long hotelId, Long placeId,String placeDate, String placeSchedule) {
		return hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(hotelId, placeId,placeDate, placeSchedule);
	}
	public HotelSchedule findByPlaceIdAndPlaceDateAndPlaceSchedule(Long placeId,String placeDate, String placeSchedule) {
		return hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(placeId,placeDate, placeSchedule);
	}
	public JsonVo countBookingSchedule(Long hotelId, Long placeId, String placeDate) {
		String nnq="SELECT count(*),max(state) FROM hzg_saas.hui_hotel_schedule where hotel_id=? and place_id=? and place_date=? and state <> 2;";
		List<Object> params = Lists.newArrayList();
		params.add(hotelId);
		params.add(placeId);
		params.add(placeDate);
		List<Object> res = this.hotelScheduleDao.executeNativeQuery(nnq, params);
		if(null!=res&&res.size()>0){
			Object object[] = (Object[]) res.get(0);
			Integer cbsNum = Integer.valueOf(object[0]+"");
			String state = object[1]+"";
			Map<String, Object> map = Maps.newHashMap();
			map.put("cbsNum", cbsNum);
			map.put("placeDate", placeDate);
			map.put("hotelId", hotelId);
			map.put("placeId", placeId);
			map.put("state", state);
			return JsonUtils.success("success", map);
		}
		return JsonUtils.error("error");
	}
	
	
	public List<HotelSchedule> getHotelSchedulePageList(PageBean<HotelSchedule> pageBean) {
		String columstr =" s.id as id, s.hotelId as hotelId, s.placeId as placeId, s.placeName as placeName, s.placeSchedule as placeSchedule"
				+ ", s.placeDate as placeDate, s.state as state, s.city as city, s.num as num";
		String fromWhere = " from hui_hotel_schedule_view s where 1=1";
		return customPageService.page(pageBean, columstr, fromWhere, HotelSchedule.class,null);
	} 
	
}
