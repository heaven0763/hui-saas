package com.chuangbang.base.dao.order;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.order.OrderDetail;
import com.chuangbang.framework.dao.BaseRepository;

public interface OrderDetailDao  extends BaseRepository<OrderDetail, Long>,PagingAndSortingRepository<OrderDetail, Long> {
	
	public List<OrderDetail> findByOrderNo(String orderNo);

	public List<OrderDetail> findByOrderNoAndType(String orderNo, String type);

}
