package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelMenuDetail;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 酒店餐饮菜单明细DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface HotelMenuDetailDao extends BaseRepository<HotelMenuDetail, Long>,PagingAndSortingRepository<HotelMenuDetail, Long>{

	public List<HotelMenuDetail> findByMenuId(Long id);

}