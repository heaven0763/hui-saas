package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelHallPeopleNum;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 大厅容纳人数DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface HotelHallPeopleNumDao extends BaseRepository<HotelHallPeopleNum, Long>,PagingAndSortingRepository<HotelHallPeopleNum, Long>{

	public HotelHallPeopleNum findByHallIdAndDisplayId(Long id, Long valueOf);

}