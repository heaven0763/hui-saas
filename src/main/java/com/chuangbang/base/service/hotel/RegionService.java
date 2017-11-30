package com.chuangbang.base.service.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.RegionModel;
import com.chuangbang.base.dao.hotel.RegionDao;
import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Maps;

/**
 * 地区信息Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class RegionService extends BaseService<Region,RegionDao> {

	@Autowired
	private RegionDao regionDao;
	@Autowired
	private CustomPageService customPageService;
	
	public Region getEntity(Long id) {
		return regionDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveRegion(Region region) {
		regionDao.save(region);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		regionDao.delete(id);
	}
	
	
	public List<Region> getCitys(Map<String, Object> filterParams){
		filterParams.put("EQ_regionType", "2");
		List<Region> regions = this.getEntities(filterParams);
		return regions;
	}

	public List<Region> getRegions(Map<String, Object> filterParams) {
		List<Region> regions = this.getEntities(filterParams);
		return regions;
	}

	public Region findByRegionName(String quyu) {
		Map<String, Object> filterParams =  Maps.newHashMap();
		filterParams.put("LIKE_regionName",quyu);
		List<Region> regions = this.getEntities(filterParams);
		if(regions!=null&&regions.size()>0){
			return regions.get(0);
		}
		return null;
	}
	
	public List<RegionModel> getAllRegionModel(PageBean<RegionModel> pageBean) {
		String columstr = "r.id as id, r.region_name as regionName, r.zimu as zimu, r.longitude as longitude, r.latitude as latitude, r.parent_id as parentId";
		String fromWhere = " from hui_region r where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, RegionModel.class, null);
	}
	
	public List<RegionModel> getPageRegionModel(PageBean<RegionModel> pageBean) {
		String columstr = "r.id as id, r.region_name as regionName, r.zimu as zimu, r.longitude as longitude, r.latitude as latitude, r.parent_id as parentId";
		String fromWhere = " from hui_region r where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, RegionModel.class, null);
	}
}
