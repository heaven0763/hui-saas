package com.chuangbang.base.service.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.dao.hotel.CategoryDao;

/**
 * 场地风格Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class CategoryService extends BaseService<Category,CategoryDao> {

	@Autowired
	private CategoryDao categoryDao;
	
	public Category getEntity(Long id) {
		return categoryDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveCategory(Category category) {
		categoryDao.save(category);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		categoryDao.delete(id);
	}

	public List<Category> getCategories(String kind) {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_kind", kind);
		return this.getEntities(filterParams,new Sort(Direction.ASC, "sortOrder"));
	}

	public Category findByKindAndName(String kind, String placeSchedule) {
		return categoryDao.findByKindAndName(kind, placeSchedule);
	}

	public List<Category> findByKind(String kind) {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_kind", kind);
		return this.getEntities(filterParams, new Sort(Direction.ASC, "sortOrder"));
	}
	
}
