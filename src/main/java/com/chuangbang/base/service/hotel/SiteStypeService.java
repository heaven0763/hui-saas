package com.chuangbang.base.service.hotel;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.common.usermodel.LineStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.hotel.SiteStype;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.dao.hotel.SiteStypeDao;

/**
 * 场地风格Service
 * @author heaven
 * @version 2016-11-21
 */
@Component
@Transactional(readOnly = true)
public class SiteStypeService extends BaseService<SiteStype,SiteStypeDao> {

	@Autowired
	private SiteStypeDao siteStypeDao;
	
	public SiteStype getEntity(Long id) {
		return siteStypeDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveSiteStype(SiteStype siteStype) {
		siteStypeDao.save(siteStype);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		siteStypeDao.delete(id);
	}

	public List<SupportingModel> getSiteStypes(String styles) {
		List<SupportingModel> list  = Lists.newArrayList();
		Map<String, Object> filterParams = Maps.newHashMap();
		List<SiteStype> stypes = this.getEntities(filterParams);
		for (SiteStype siteStype : stypes) {
			SupportingModel model = new SupportingModel(siteStype.getId(), siteStype.getCode(), siteStype.getName(), siteStype.getLogo(), 0L);
			list.add(model);
		}
		if(StringUtils.isNotBlank(styles)){
			String []ids = styles.split(",");
			for (String id : ids) {
				for (SupportingModel m : list) {
					if(id.equals(m.getId().toString())){
						m.setFlag(1L);
					}
				}
			}
		}
		
		return list;
	}
	
}
