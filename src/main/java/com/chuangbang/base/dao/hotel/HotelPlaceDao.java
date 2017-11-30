package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelPlace;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 大厅/客房表DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface HotelPlaceDao extends BaseRepository<HotelPlace, Long>,PagingAndSortingRepository<HotelPlace, Long>{

	List<HotelPlace> findByPlaceType(String placeType);

	List<HotelPlace> findByHotelIdAndPlaceType(Long hotelId, String placeType);

}