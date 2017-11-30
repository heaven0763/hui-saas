package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelGroup;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 酒店集团DAO接口
 * @author heaven
 * @version 2017-10-12
 */
public interface HotelGroupDao extends BaseRepository<HotelGroup, Long>,PagingAndSortingRepository<HotelGroup, Long>{

}