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

import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 酒店集团Controller
 * @author heaven
 * @version 2017-10-12
 */
@Controller
@RequestMapping(value = "base/hotel/group")
public class HotelGroupController extends BaseController {

	@Autowired
	private HotelGroupService hotelGroupService;
	
	@ModelAttribute("hotelGroup")
	public HotelGroup getHotelGroup(@RequestParam(value = "id", required = false) Long id) {
		if (id!=null) {
			return hotelGroupService.getEntity(id);
		}
		return new HotelGroup();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/hotelGroupList";
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/hotelGroupForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelGroup hotelGroup) {
		hotelGroupService.saveHotelGroup(hotelGroup);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelGroup> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<HotelGroup> page = hotelGroupService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		HotelGroup hotelGroup = hotelGroupService.getEntity(id);
		model.addAttribute("hotelGroup", hotelGroup);
		return new ModelAndView("hotel/hotelGroupForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelGroupService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
