package com.chuangbang.base.web.hotel;

import java.util.List;
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
import com.chuangbang.base.entity.hotel.HotelDynamic;
import com.chuangbang.base.service.hotel.HotelDynamicService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 酒店动态Controller
 * @author heaven
 * @version 2016-12-07
 */
@Controller
@RequestMapping(value = "base/hotel/dynamic")
public class HotelDynamicController extends BaseController {

	@Autowired
	private HotelDynamicService hotelDynamicService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("hotelDynamic")
	public HotelDynamic getHotelDynamic(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return hotelDynamicService.getEntity(id);
		}
		return new HotelDynamic();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/hotelDynamicList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,HttpServletRequest request) {
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType().toUpperCase())&&AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
			Hotel hotel = hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
			model.addAttribute("mhotel",hotel);
		}
		
		return "hotel/hotelDynamicForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelDynamic hotelDynamic) {
		try {
			hotelDynamicService.saveHotelDynamic(hotelDynamic);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ajaxDoneError("发布不成功！");
		}
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelDynamic> pageBean,HttpServletRequest request) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		

		if(AccountUtils.getHotelUserType().equals("HOTEL")){
			searchParams.put("EQ_h.id", AccountUtils.getCurrentUserHotelId());
		}else if(AccountUtils.getHotelUserType().equals("GROUP")){
			searchParams.put("EQ_h.pid", AccountUtils.getCurrentUserhotelPId());
		}else if(AccountUtils.getCurrentUserType().equals("HUI")){
			
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_h.company_id", AccountUtils.getCurrentUserCompanyId());
		}else{
			
		}
		pageBean.set_filterParams(searchParams);
		pageBean.setOrder("desc");
		List<HotelDynamic> page = hotelDynamicService.getPageHotelDynamicList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		HotelDynamic hotelDynamic = hotelDynamicService.getEntity(id);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		model.addAttribute("hotelDynamic", hotelDynamic);
		return new ModelAndView("hotel/hotelDynamicForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelDynamicService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
