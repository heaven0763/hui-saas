package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.HotelCooperationLog;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地返佣比例修改记录DAO接口
 * @author heaven
 * @version 2017-03-14
 */
public interface HotelCooperationLogDao extends BaseRepository<HotelCooperationLog, Long>,PagingAndSortingRepository<HotelCooperationLog, Long>{

}