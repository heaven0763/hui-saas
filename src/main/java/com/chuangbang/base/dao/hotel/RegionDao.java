package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.Region;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 地区信息DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface RegionDao extends BaseRepository<Region, Long>,PagingAndSortingRepository<Region, Long>{

	List<Region> findByRegionName(String quyu);

}