package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelMenu;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 酒店餐饮菜单DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface HotelMenuDao extends BaseRepository<HotelMenu, Long>,PagingAndSortingRepository<HotelMenu, Long>{

}