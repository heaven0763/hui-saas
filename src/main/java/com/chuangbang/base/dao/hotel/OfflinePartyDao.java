package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.OfflineParty;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 线下活动DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface OfflinePartyDao extends BaseRepository<OfflineParty, Long>,PagingAndSortingRepository<OfflineParty, Long>{

}