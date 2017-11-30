package com.chuangbang.base.dao.order;

import com.chuangbang.base.entity.order.OrderPayedRecord;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 订单付款记录DAO接口
 * @author heaven
 * @version 2017-10-26
 */
public interface OrderPayedRecordDao extends BaseRepository<OrderPayedRecord, Long>,PagingAndSortingRepository<OrderPayedRecord, Long>{

}