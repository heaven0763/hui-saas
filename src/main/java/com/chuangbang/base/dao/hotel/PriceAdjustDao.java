package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.PriceAdjust;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地价格调整DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface PriceAdjustDao extends BaseRepository<PriceAdjust, Long>,PagingAndSortingRepository<PriceAdjust, Long>{

	public List<PriceAdjust> findByAuditId(Long auditId);

}