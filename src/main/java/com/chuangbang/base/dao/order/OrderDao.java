package com.chuangbang.base.dao.order;

import com.chuangbang.base.entity.order.Order;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 订单DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface OrderDao extends BaseRepository<Order, Long>,PagingAndSortingRepository<Order, Long>{

	public Order findByOrderNoAndSourceAppId(String orderNo, Long sourceAppId);

	public Order findByOrderNo(String orderNo);

}