package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.PlacePrice;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地价格DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface PlacePriceDao extends BaseRepository<PlacePrice, Long>,PagingAndSortingRepository<PlacePrice, Long>{

	public PlacePrice findByPlaceIdAndPlaceSchedule(Long placeId, String placeSchedule);

	public PlacePrice findByPlaceTypeAndPlaceIdAndPlaceSchedule(String placeType, Long placeId, String scheduleDate);

}