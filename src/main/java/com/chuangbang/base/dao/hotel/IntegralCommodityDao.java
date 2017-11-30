package com.chuangbang.base.dao.hotel;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.hotel.IntegralCommodity;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 积分商品DAO接口
 * @author heaven
 * @version 2017-01-10
 */
public interface IntegralCommodityDao extends BaseRepository<IntegralCommodity, Long>,PagingAndSortingRepository<IntegralCommodity, Long>{

}