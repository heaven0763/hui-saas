package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.Hotel;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 酒店DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface HotelDao extends BaseRepository<Hotel, Long>,PagingAndSortingRepository<Hotel, Long>{

	List<Hotel> findByReclaimUserId(String reclaimUserId);

}