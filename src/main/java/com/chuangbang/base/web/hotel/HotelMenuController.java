package com.chuangbang.base.web.hotel;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.util.WebUtils;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.entity.hotel.HotelMenuDetail;
import com.chuangbang.base.service.hotel.HotelMenuDetailService;
import com.chuangbang.base.service.hotel.HotelMenuService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 酒店餐饮菜单Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/hotel/menu")
public class HotelMenuController extends BaseController {

	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private HotelMenuDetailService hotelMenuDetailService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("hotelMenu")
	public HotelMenu getHotelMenu(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelMenuService.getEntity(id);
		}
		return new HotelMenu();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		return "hotel/hotelMenuList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel", hotel);
		return "hotel/hotelMenuForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelMenu hotelMenu) {
		hotelMenuService.saveHotelMenu(hotelMenu);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelMenu> pageBean,HttpServletRequest request) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		/*if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("EQ_reclaim_user_id", AccountUtils.getCurrentUserId());
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_h.pid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				filterParams.put("EQ_h.id", AccountUtils.getCurrentUserHotelId());
			}
		}*/
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
			if(hotel!=null){
				filterParams.put("EQ_hotelId", hotel.getId());
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			filterParams.put("OR_EQ;hotelId",hotelIds);
		}
		
		pageBean.set_filterParams(filterParams);
		Page<HotelMenu> page = hotelMenuService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		HotelMenu hotelMenu = hotelMenuService.getEntity(id);
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel", hotel);
		model.addAttribute("hotelMenu", hotelMenu);
		return new ModelAndView("hotel/hotelMenuForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelMenuService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	
	@RequestMapping(value = "detail/index")
	public String detailIndex(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel", hotel);
		return "hotel/hotelMenuDetailList";
	}
	@RequestMapping(value = "detail/create/{menuId}")
	public String detailCreateForm(@PathVariable("menuId") Long menuId,Model model) {
		this.groupSetting(model);
		HotelMenu hotelMenu = this.hotelMenuService.getEntity(menuId);
		model.addAttribute("hotelMenu", hotelMenu);
		return "hotel/hotelMenuDetailForm";
	}
	
	@RequestMapping(value = "detail/save")
	public ModelAndView detailSave(HotelMenuDetail hotelMenuDetail) {
		hotelMenuDetailService.saveHotelMenuDetail(hotelMenuDetail);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="detail/list")
	@ResponseBody
	public DataGrid detailList(PageBean<HotelMenuDetail> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<HotelMenuDetail> page = hotelMenuDetailService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "detail/update/{id}")
	public ModelAndView detailUpdate(@PathVariable("id") Long id, Model model) {
		HotelMenuDetail hotelMenuDetail = hotelMenuDetailService.getEntity(id);
		HotelMenu hotelMenu = this.hotelMenuService.getEntity(hotelMenuDetail.getId());
		model.addAttribute("hotelMenuDetail", hotelMenuDetail);
		model.addAttribute("hotelMenu", hotelMenu);
		return new ModelAndView("hotel/hotelMenuDetailForm");
	}
	
	@RequestMapping(value = "detail/delete/{id}")
	public ModelAndView detailDelete(@PathVariable("id") Long id) {
		hotelMenuDetailService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
}
