package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.SiteStype;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地风格DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface SiteStypeDao extends BaseRepository<SiteStype, Long>,PagingAndSortingRepository<SiteStype, Long>{

}