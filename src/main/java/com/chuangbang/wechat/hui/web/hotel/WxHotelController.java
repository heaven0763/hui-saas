package com.chuangbang.wechat.hui.web.hotel;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.HotelSelModel;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.SiteStypeService;
import com.chuangbang.base.service.hotel.SupportingServicesService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.wechat.hui.model.SimpleModel;
import com.google.common.collect.Lists;

/**
 * 酒店Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "/wexin/hotel")
public class WxHotelController extends BaseController {

	@Autowired
	private HotelService hotelService;
	@Autowired
	private SiteStypeService siteStypeService;
	@Autowired
	private  SupportingServicesService supportingServicesService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	@ModelAttribute("hotel")
	public Hotel getHotel(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelService.getEntity(id);
		}
		return new Hotel();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		return "hotel/hotelList";
	}
	
	@RequestMapping(value ="queryByName")
	@ResponseBody
	public JsonVo queryByName(String name){
		String sql = "select id,hotel_name name from hui_hotel where hotel_name like ?  ";
		List<Object> paras = Lists.newArrayList();
		paras.add("%" + name + "%");
		List<SimpleModel> simpleModels = cusQueryService.getAll(new PageBean(), sql, SimpleModel.class,paras);
		return JsonUtils.success("",simpleModels);
	}
	
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelModel> pageBean,HttpServletRequest request,String area,String person,String price,String decorationTime) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		
		if(StringUtils.isNotBlank(area)){
			String []areas = area.split(",");
			filterParams.put("GTE_h.hall_max_area", areas[0]);
			filterParams.put("LTE_h.hall_max_area", areas[1]);
		}
		
		if(StringUtils.isNotBlank(person)){
			String []persons = person.split(",");
			filterParams.put("GTE_h.max_people_num", persons[0]);
			filterParams.put("LTE_h.max_people_num", persons[1]);
		}
		if(StringUtils.isNotBlank(price)){
			String []prices = price.split(",");
			filterParams.put("GTE_h.average_price", prices[0]);
			filterParams.put("LTE_h.average_price", prices[1]);
		}
		if(StringUtils.isNotBlank(decorationTime)){
			filterParams.put("GTE_h.decoration_ime", decorationTime+" 00:00:00");
			filterParams.put("LTE_h.decoration_ime", decorationTime+" 23:59:59");
		}
		
		pageBean.set_filterParams(filterParams);
		List<HotelModel> page = hotelService.getHotelPageList(pageBean,null,null);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Hotel hotel = hotelService.getEntity(id);
		List<SupportingModel> styles = this.siteStypeService.getSiteStypes(hotel.getStyle());
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("HOTELSUPORTING",hotel.getId()+"","HOTEL");
		List<SupportingModel> roomservices = this.supportingServicesService.findByKind("ROOMSERVICE",hotel.getId()+"","HOTEL");
		
		model.addAttribute("action","修改");
		model.addAttribute("styles",styles);
		model.addAttribute("supportings",supportings);
		model.addAttribute("roomservices",roomservices);
		model.addAttribute("hotel", hotel);
		return new ModelAndView("hotel/hotelForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	
	@RequestMapping(value ="listAll")
	@ResponseBody
	public DataGrid listAll(PageBean<HotelSelModel> pageBean,HttpServletRequest request,String hotelName) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_h.pid",AccountUtils.getCurrentUser().getPhtlid());
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
			/*if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("EQ_h.reclaim_user_id", AccountUtils.getCurrentUserId());
			}*/
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_h.company_id", AccountUtils.getCurrentUserCompanyId());
		}else{
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel_finance")){
				filterParams.put("EQ_h.pid",AccountUtils.getCurrentUser().getPhtlid());
			}
		}
		if(StringUtils.isNotBlank(hotelName)){
			try {
				hotelName = new String(hotelName.getBytes("ISO-8859-1"),"UTF-8");
				filterParams.put("LIKE_h.hotel_name", hotelName);
			} catch (UnsupportedEncodingException e) {
			}
		}
		pageBean.set_filterParams(filterParams);
		List<HotelSelModel> page = hotelService.getAllHotelForSel(pageBean);
		return getDataGrid(pageBean, page);
	}
	
}
