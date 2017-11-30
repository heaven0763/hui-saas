package com.chuangbang.base.dao.order;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.order.IntegralOrder;
import com.chuangbang.framework.dao.BaseRepository;

public interface IntegralOrderDao extends BaseRepository<IntegralOrder, Long>,PagingAndSortingRepository<IntegralOrder, Long>{

	public IntegralOrder findByOrderNo(String orderNo);

}
