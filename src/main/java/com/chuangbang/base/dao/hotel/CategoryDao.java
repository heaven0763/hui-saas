package com.chuangbang.base.dao.hotel;

import com.chuangbang.base.entity.hotel.Category;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 场地风格DAO接口
 * @author heaven
 * @version 2016-11-21
 */
public interface CategoryDao extends BaseRepository<Category, Long>,PagingAndSortingRepository<Category, Long>{

	public List<Category> findByKind(String kind);

	public Category findByKindAndName(String kind, String placeSchedule);
}