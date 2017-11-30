package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelSchedule;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地档期DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface HotelScheduleDao extends BaseRepository<HotelSchedule, Long>,PagingAndSortingRepository<HotelSchedule, Long>{

	public HotelSchedule findByPlaceIdAndPlaceDateAndPlaceSchedule(Long placeId, String placeDate, String schedule);

	public HotelSchedule findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(Long hotelId, Long placeId,
			String placeDate, String placeSchedule);

	public List<HotelSchedule> findByHotelIdAndPlaceIdAndPlaceDate(Long hotelId, Long placeId, String placeDate);
}