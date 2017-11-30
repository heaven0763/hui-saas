package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.SiteImg;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地图片DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface SiteImgDao extends BaseRepository<SiteImg, Long>,PagingAndSortingRepository<SiteImg, Long>{

	List<SiteImg> findBySiteIdAndSiteType(Long siteId, String siteType);

	List<SiteImg> findByOriginalImg(String img);

	List<SiteImg> findBySiteIdAndSiteTypeAndPicType(Long id, String type, String pictype);

}