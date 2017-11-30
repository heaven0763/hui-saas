package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelDynamic;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 酒店动态DAO接口
 * @author heaven
 * @version 2016-12-07
 */
public interface HotelDynamicDao extends BaseRepository<HotelDynamic, Long>,PagingAndSortingRepository<HotelDynamic, Long>{

}