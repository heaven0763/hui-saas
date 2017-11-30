package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.District;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 商圈信息DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface DistrictDao extends BaseRepository<District, Long>,PagingAndSortingRepository<District, Long>{

}