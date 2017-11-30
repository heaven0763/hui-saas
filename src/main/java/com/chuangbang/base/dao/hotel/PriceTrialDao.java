package com.chuangbang.base.dao.hotel;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地价格调整DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface PriceTrialDao extends BaseRepository<PriceTrial, Long>,PagingAndSortingRepository<PriceTrial, Long>{

}