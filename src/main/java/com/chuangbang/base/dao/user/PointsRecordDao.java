package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.PointsRecord;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 积分记录DAO接口
 * @author mabelxiao
 * @version 2016-11-15
 */
public interface PointsRecordDao extends BaseRepository<PointsRecord, Long>,PagingAndSortingRepository<PointsRecord, Long>{

}