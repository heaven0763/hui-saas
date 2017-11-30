package com.chuangbang.base.dao.order;

import com.chuangbang.base.entity.order.Receipt;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 水单资料DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface ReceiptDao extends BaseRepository<Receipt, Long>,PagingAndSortingRepository<Receipt, Long>{

}