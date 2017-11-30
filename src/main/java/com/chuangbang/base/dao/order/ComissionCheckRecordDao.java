package com.chuangbang.base.dao.order;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 返佣记录DAO接口
 * @author heaven
 * @version 2017-03-08
 */
public interface ComissionCheckRecordDao extends BaseRepository<ComissionCheckRecord, Long>,PagingAndSortingRepository<ComissionCheckRecord, Long>{

	public List<ComissionCheckRecord> findByRecordId(Long recordId);

}