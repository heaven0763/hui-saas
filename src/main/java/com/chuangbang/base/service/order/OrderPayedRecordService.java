package com.chuangbang.base.service.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.order.OrderPayedRecord;
import com.chuangbang.base.dao.order.OrderPayedRecordDao;

/**
 * 订单付款记录Service
 * @author heaven
 * @version 2017-10-26
 */
@Component
@Transactional(readOnly = true)
public class OrderPayedRecordService extends BaseService<OrderPayedRecord,OrderPayedRecordDao> {

	@Autowired
	private OrderPayedRecordDao orderPayedRecordDao;
	
	public OrderPayedRecord getEntity(Long id) {
		return orderPayedRecordDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveOrderPayedRecord(OrderPayedRecord orderPayedRecord) {
		orderPayedRecordDao.save(orderPayedRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		orderPayedRecordDao.delete(id);
	}
	
}
