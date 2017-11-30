package com.chuangbang.base.dao.order;

import com.chuangbang.base.entity.order.ComissionRecord;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 返佣记录DAO接口
 * @author heaven
 * @version 2017-03-08
 */
public interface ComissionRecordDao extends BaseRepository<ComissionRecord, Long>,PagingAndSortingRepository<ComissionRecord, Long>{

	public ComissionRecord findByOrderNo(String orderNo);

}