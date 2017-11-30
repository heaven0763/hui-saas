package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.OfflinePartyPlace;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 线下活动场地DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface OfflinePartyPlaceDao extends BaseRepository<OfflinePartyPlace, Long>,PagingAndSortingRepository<OfflinePartyPlace, Long>{

}