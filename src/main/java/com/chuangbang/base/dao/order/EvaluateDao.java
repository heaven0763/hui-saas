package com.chuangbang.base.dao.order;

import com.chuangbang.base.entity.order.Evaluate;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 评价表DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface EvaluateDao extends BaseRepository<Evaluate, Long>,PagingAndSortingRepository<Evaluate, Long>{

}