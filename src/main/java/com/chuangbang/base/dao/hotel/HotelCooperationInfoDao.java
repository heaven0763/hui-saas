package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地合作信息DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface HotelCooperationInfoDao extends BaseRepository<HotelCooperationInfo, Long>,PagingAndSortingRepository<HotelCooperationInfo, Long>{

	public HotelCooperationInfo findByHotelId(Long hotelId);

}