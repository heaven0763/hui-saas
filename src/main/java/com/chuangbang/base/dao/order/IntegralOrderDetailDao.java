package com.chuangbang.base.dao.order;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.order.IntegralOrderDetail;
import com.chuangbang.framework.dao.BaseRepository;

public interface IntegralOrderDetailDao extends BaseRepository<IntegralOrderDetail, Long>,PagingAndSortingRepository<IntegralOrderDetail, Long>{

	List<IntegralOrderDetail> findByOrderNo(String orderNo);

}
