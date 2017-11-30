package com.chuangbang.base.dao.hotel;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.order.ScheduleBooking;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 档期预定信息DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface ScheduleBookingDao extends BaseRepository<ScheduleBooking, Long>,PagingAndSortingRepository<ScheduleBooking, Long>{

	public List<ScheduleBooking> findByHotelIdAndOrderNoAndClientId(Long hotelId, String orderNo, String clientId);

	public List<ScheduleBooking> findByorderDetailIdAndType(Long id, String type);

	public List<ScheduleBooking> findByHotelIdAndOrderNoAndClientIdAndType(Long hotelId, String orderNo,String clientId, String type);

	public List<ScheduleBooking> findByOrderNo(String orderNo);

	public List<ScheduleBooking> findByPlaceDateAndState(String crtDay, String state);
	
}