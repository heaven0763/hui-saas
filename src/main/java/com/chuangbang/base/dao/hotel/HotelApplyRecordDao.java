package com.chuangbang.base.dao.hotel;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelApplyRecord;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 申请记录DAO接口
 * @author xtp
 * @version 2017-08-09
 */
public interface HotelApplyRecordDao extends BaseRepository<HotelApplyRecord, Long>,PagingAndSortingRepository<HotelApplyRecord, Long>{
	
}
