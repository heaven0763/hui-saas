package com.chuangbang.wechat.hui.web.hotel;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.plugins.baidu.yun.map.model.BaiduMapResult;
import com.chuangbang.plugins.baidu.yun.util.BaiduMapUtil;
import com.chuangbang.wechat.hui.model.RegionModel;


/**
 * 地区信息Controller
 * @author heaven
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "weixin/hotel/region")
public class WxRegionController extends BaseController {

	@Autowired
	private RegionService regionService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	@ModelAttribute("region")
	public Region getRegion(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return regionService.getEntity(id);
		}
		return new Region();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model,PageBean<Region> pageBean,HttpServletRequest request) throws UnsupportedEncodingException {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);	
		Page<Region> regions = this.regionService.getEntities(pageBean);
		for (Region region : regions) {
			BaiduMapResult baiduMapResult =  BaiduMapUtil.getGeocoding(region.getRegionName());
			if(baiduMapResult!=null&&baiduMapResult.getLocation()!=null){
				region.setLongitude(Double.valueOf(baiduMapResult.getLocation().getLng()));
				region.setLatitude(Double.valueOf(baiduMapResult.getLocation().getLat()));
				this.regionService.saveRegion(region);
			}
		}
		return "hotel/regionList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/regionForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Region region) {
		regionService.saveRegion(region);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Region> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Region> page = regionService.getEntities(pageBean);
		for (Region region : page.getContent()) {
			if(region.getParentId()!=null&&region.getParentId()!=0){
				region.setpName(regionService.getEntity(region.getParentId()).getRegionName());
			}
		}
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value ="listbyzimu")
	@ResponseBody
	public JsonVo listbyzimu(PageBean<RegionModel> pageBean,HttpServletRequest request) {
		String sql = "SELECT id,regionName,zimu FROM hui_region where zimu is not null and zimu !=''";
		pageBean.setOrder("asc,asc");
		pageBean.setSort("zimu,id");
		return JsonUtils.success("ok", cusQueryService.getAll(pageBean, sql, RegionModel.class, null))   ;
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Region region = regionService.getEntity(id);
		model.addAttribute("region", region);
		return new ModelAndView("hotel/regionForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		regionService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
