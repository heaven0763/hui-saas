package com.chuangbang.base.service.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.base.entity.order.Receipt;
import com.chuangbang.base.dao.order.ReceiptDao;

/**
 * 水单资料Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class ReceiptService extends BaseService<Receipt,ReceiptDao> {

	@Autowired
	private ReceiptDao receiptDao;
	
	public Receipt getEntity(Long id) {
		return receiptDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveReceipt(Receipt receipt) {
		receiptDao.save(receipt);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		receiptDao.delete(id);
	}
	
}
