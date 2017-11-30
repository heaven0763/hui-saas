package com.chuangbang.base.service.order;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.order.IntegralOrderDetailDao;
import com.chuangbang.base.entity.order.IntegralOrderDetail;
import com.chuangbang.framework.service.BaseService;

@Component("integralOrderDetailService")
@Transactional(readOnly=true)
public class IntegralOrderDetailService extends BaseService<IntegralOrderDetail, IntegralOrderDetailDao>{

}
