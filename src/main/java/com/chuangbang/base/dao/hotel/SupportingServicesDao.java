package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.SupportingServices;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 配套服务DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface SupportingServicesDao extends BaseRepository<SupportingServices, Long>,PagingAndSortingRepository<SupportingServices, Long>{

	public List<SupportingServices> findByKind(String kind);

}