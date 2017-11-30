package com.chuangbang.base.service.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.BookingRecordModel;
import com.chuangbang.base.dao.hotel.ScheduleBookingDao;
import com.chuangbang.base.entity.order.ScheduleBooking;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 档期预定信息Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class ScheduleBookingService extends BaseService<ScheduleBooking,ScheduleBookingDao> {

	@Autowired
	private ScheduleBookingDao scheduleBookingDao;
	@Autowired
	private CustomPageService customPageService;
	
	
	public ScheduleBooking getEntity(Long id) {
		return scheduleBookingDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveScheduleBooking(ScheduleBooking scheduleBooking) {
		scheduleBookingDao.save(scheduleBooking);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		scheduleBookingDao.delete(id);
	}
	
	public List<BookingRecordModel> getAllBookingRecord(String orderNo,Long detailId,Long placeId,String type) {
		PageBean<BookingRecordModel> pageBean = new PageBean<>();
		Map<String, Object> filterMaps = Maps.newHashMap();
		filterMaps.put("EQ_s.order_no", orderNo);
		filterMaps.put("EQ_s.order_detail_id", detailId);
		filterMaps.put("EQ_s.place_id", placeId);
		filterMaps.put("EQ_s.type", type);
		pageBean.set_filterParams(filterMaps);
		String columstr = "s.id as id, s.place_date as placeDate, s.place_schedule as placeSchedule, s.price as price, s.quantity as quantity"
				+ ", s.meal_type as mealType, s.mealnum as mealnum, s.breakfast as breakfast, s.place_schedule_id as placeScheduleId";
		String fromWhere = " from hui_schedule_booking s where 1=1 ";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, BookingRecordModel.class, null);
	}
	
	public List<BookingRecordModel> getGroupBookingRecord(String orderNo,Long detailId,Long placeId,String type) {
		PageBean<BookingRecordModel> pageBean = new PageBean<>();
		String columstr = " s.id as id, s.place_date as placeDate, GROUP_CONCAT(s.place_schedule) as placeScheduleTxt, GROUP_CONCAT(h.place_schedule) as placeScheduleIds"
				+ ", sum(s.price) as price, sum(s.quantity) as quantity, GROUP_CONCAT(s.place_schedule_id) as placeScheduleId ";
		String fromWhere = " FROM hzg_saas.hui_schedule_booking s left join hui_hotel_schedule h on h.id=s.place_schedule_id where 1=1 ";
		fromWhere += " and s.order_no=? and s.order_detail_id=? and s.place_id =? and s.type=?";
		fromWhere += " group by s.place_date,s.order_no,s.place_id ";
		pageBean.setOrder("asc");
		List<Object> params = Lists.newArrayList();
		params.add(orderNo);
		params.add(detailId);
		params.add(placeId);
		params.add(type);
		return customPageService.getAll(pageBean, columstr, fromWhere, BookingRecordModel.class, params);
	}
	
	public List<ScheduleBooking> findByOrderNo(String orderNo){
		return scheduleBookingDao.findByOrderNo(orderNo);
	}

	public List<ScheduleBooking> findByPlaceDateAndState(String crtDay, String state) {
		// TODO Auto-generated method stub
		return scheduleBookingDao.findByPlaceDateAndState(crtDay, state);
	}
}
