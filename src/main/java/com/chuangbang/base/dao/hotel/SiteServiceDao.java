package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.SiteService;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地图片DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface SiteServiceDao extends BaseRepository<SiteService, Long>,PagingAndSortingRepository<SiteService, Long>{

	public SiteService findBySiteIdAndSiteTypeAndServiceIdAndKind(Long siteId, String siteType, Long serviceId, String kind);

}