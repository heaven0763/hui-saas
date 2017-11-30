package com.chuangbang.base.service.order;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.HallOrderDetailModel;
import com.chuangbang.app.model.MealOrderDetailModel;
import com.chuangbang.app.model.RoomOrderDetailModel;
import com.chuangbang.base.dao.order.OrderDetailDao;
import com.chuangbang.base.entity.order.OrderDetail;
import com.chuangbang.base.service.hotel.ScheduleBookingService;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Maps;
@Component
@Transactional(readOnly = true)
public class OrderDetailService extends BaseService<OrderDetail, OrderDetailDao> {
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private ScheduleBookingService scheduleBookingService;
	
	public OrderDetail getEntity(Long id) {
		return orderDetailDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveOrderDetail(OrderDetail orderDetail) {
		orderDetailDao.save(orderDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		orderDetailDao.delete(id);
	}

	public List<OrderDetail> findByOrderNo(String orderNo) {
		return orderDetailDao.findByOrderNo(orderNo);
	}
	
	public List<HallOrderDetailModel> getAllHallOrderDetail(String orderNo) {
		PageBean<HallOrderDetailModel> pageBean = new PageBean<>();
		Map<String, Object> filterMaps = Maps.newHashMap();
		filterMaps.put("EQ_o.order_no", orderNo);
		pageBean.set_filterParams(filterMaps);
		List<HallOrderDetailModel> list = getAllHallOrderDetail(pageBean);
		for (HallOrderDetailModel hallOrderDetailModel : list) {
			hallOrderDetailModel.setBookingRecordModels(scheduleBookingService.getGroupBookingRecord(orderNo, hallOrderDetailModel.getId(), hallOrderDetailModel.getPlaceId(), "01"));
		}
		return list;
	}
	public List<HallOrderDetailModel> getAllHallOrderDetail(PageBean<HallOrderDetailModel> pageBean) {
		String columstr ="o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName, o.ismain as ismain, o.amount as amount"
				+ ", o.quantity as quantity, o.commission_fee_rate as commissionFeeRate, h.hall_area as hallArea, h.length as length, h.width as width"
				+ ", h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.thumb_img as thumbImg";
		String fromWhere = " from hui_order_detail o left join hui_hotel_place h on h.id=o.place_id where 1=1 and o.type='01'";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, HallOrderDetailModel.class, null);
	}
	public List<RoomOrderDetailModel> getAllRoomOrderDetailModel(String orderNo) {
		PageBean<RoomOrderDetailModel> pageBean = new PageBean<>();
		Map<String, Object> filterMaps = Maps.newHashMap();
		filterMaps.put("EQ_o.order_no", orderNo);
		pageBean.set_filterParams(filterMaps);
		List<RoomOrderDetailModel> list = getAllRoomOrderDetailModel(pageBean);
		for (RoomOrderDetailModel roomOrderDetailModel : list) {
			roomOrderDetailModel.setBookingRecordModels(scheduleBookingService.getAllBookingRecord(orderNo, roomOrderDetailModel.getId(), roomOrderDetailModel.getPlaceId(), "02"));
		}
		return list;
	}
	public List<RoomOrderDetailModel> getAllRoomOrderDetailModel(PageBean<RoomOrderDetailModel> pageBean) {
		String columstr = "o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName"
				+ ", o.amount as amount, o.quantity as quantity, r.network as network, c.name as roomType, r.thumb_img as thumbImg ";
		String fromWhere = " from hui_order_detail o left join hui_hotel_place r on r.id=o.place_id "
				+ " left join hui_category c on c.id = r.room_type where 1=1 and o.type='02'";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, RoomOrderDetailModel.class, null);
	}
	
	public List<MealOrderDetailModel> getAllMealOrderDetailModel(String orderNo) {
		PageBean<MealOrderDetailModel> pageBean = new PageBean<>();
		Map<String, Object> filterMaps = Maps.newHashMap();
		filterMaps.put("EQ_o.order_no", orderNo);
		pageBean.set_filterParams(filterMaps);
		
		List<MealOrderDetailModel> list = getAllMealOrderDetailModel(pageBean);
		for (MealOrderDetailModel mealOrderDetailModel : list) {
			mealOrderDetailModel.setBookingRecordModels(scheduleBookingService.getAllBookingRecord(orderNo, mealOrderDetailModel.getId(), mealOrderDetailModel.getPlaceId(), "03"));
		}
		return list;
	}
	public List<MealOrderDetailModel> getAllMealOrderDetailModel(PageBean<MealOrderDetailModel> pageBean) {
		String columstr = "o.id as id, o.order_no as orderNo, o.type as type, o.place_id as placeId, o.place_name as placeName"
				+ ", o.amount as amount, o.quantity as quantity";
		String fromWhere = " from hui_order_detail o left join hui_hotel_menu m on m.id=o.place_id where 1=1 and o.type='03'";
		pageBean.setOrder("asc");
		return customPageService.getAll(pageBean, columstr, fromWhere, MealOrderDetailModel.class, null);
	}

	public List<OrderDetail> getAllOtherDetails(String orderNo) {
		List<OrderDetail> orderDetails = this.orderDetailDao.findByOrderNoAndType(orderNo,"09");
		return orderDetails;
	}
}
