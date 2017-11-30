package com.chuangbang.base.web.hotel;

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

import com.chuangbang.base.entity.hotel.District;
import com.chuangbang.base.service.hotel.DistrictService;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 商圈信息Controller
 * @author heaven
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "base/hotel/district")
public class DistrictController extends BaseController {

	@Autowired
	private DistrictService districtService;
	@Autowired
	private RegionService regionService;
	
	@ModelAttribute("district")
	public District getDistrict(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return districtService.getEntity(id);
		}
		return new District();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/districtList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/districtForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(District district) {
		districtService.saveDistrict(district);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<District> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<District> page = districtService.getEntities(pageBean);
		for (District district : page.getContent()) {
			district.setRegionName(regionService.getEntity(district.getRegionId()).getRegionName());
		}
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		District district = districtService.getEntity(id);
		model.addAttribute("district", district);
		return new ModelAndView("hotel/districtForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		districtService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
