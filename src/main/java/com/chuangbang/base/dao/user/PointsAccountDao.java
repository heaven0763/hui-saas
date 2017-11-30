package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.PointsAccount;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 积分账户DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface PointsAccountDao extends BaseRepository<PointsAccount, Long>,PagingAndSortingRepository<PointsAccount, Long>{
	public PointsAccount findByClientTypeAndClientId(String clientType, String clientId);
}