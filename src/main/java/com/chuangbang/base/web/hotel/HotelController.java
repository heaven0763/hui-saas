package com.chuangbang.base.web.hotel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.HotelSelModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.SiteStypeService;
import com.chuangbang.base.service.hotel.SupportingServicesService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.UserService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 酒店Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "/base/hotel")
public class HotelController extends BaseController {

	@Autowired
	private HotelService hotelService;
	@Autowired
	private SiteStypeService siteStypeService;
	@Autowired
	private  SupportingServicesService supportingServicesService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;
	
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
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HUI");
			filterParams.put("EQ_u.group_id", "3");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HOTEL");
			filterParams.put("EQ_u.group_id", "9");
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_u.company_id", AccountUtils.getCurrentUserCompanyId());
			filterParams.put("EQ_u.group_id", "3");
		}else{
			
		}
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		return "hotel/hotelList";
	}
	
	@RequestMapping(value = "manage/{id}")
	public String manage(@PathVariable("id") Long id,HttpServletRequest request, Model model) {
		this.groupSetting(model);
		Hotel hotel = hotelService.getEntity(id);
		WebUtils.setSessionAttribute(request, "mhotel", hotel);
		Menu parentMenu = menuService.getEntity(125L);
		model.addAttribute("hotelmenus",menuService.getSysAuthRootMenus(125L));
		model.addAttribute("mhotel",hotel);
		model.addAttribute("pmenu",parentMenu);
		return "hotelManage";
	}
	
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		this.groupSetting(model);
		List<SupportingModel> styles = this.siteStypeService.getSiteStypes("");
		List<SupportingModel>supportings = this.supportingServicesService.findByKind("HOTELSUPORTING");
		List<SupportingModel>roomservices = this.supportingServicesService.findByKind("ROOMSERVICE");
		List<Category> purposes = this.categoryService.findByKind("PURPOSE");
		model.addAttribute("purposes",purposes);
		model.addAttribute("action","添加");
		model.addAttribute("styles",styles);
		model.addAttribute("supportings",supportings);
		model.addAttribute("roomservices",roomservices);
		return "hotel/hotelForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("hotel")Hotel hotel,String supportings,String roomservices,Double tradeKickerAmount) {
		if(hotel.getTradeKicker()==0){
			
		}else{
			hotel.setTradeKicker(tradeKickerAmount);
		}
		hotelService.saveHotel(hotel,supportings,roomservices);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelModel> pageBean,HttpServletRequest request,String area,String person,String price,String decorationTime) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		
		if(StringUtils.isNotBlank(area)){
			String []areas = area.split(",");
			filterParams.put("GTE_h.hall_max_area", Integer.valueOf(areas[0]));
			filterParams.put("LTE_h.hall_max_area", Integer.valueOf(areas[1]));
		}
		
		if(StringUtils.isNotBlank(person)){
			String []persons = person.split(",");
			filterParams.put("GTE_h.max_people_num", Integer.valueOf(persons[0]));
			filterParams.put("LTE_h.max_people_num", Integer.valueOf(persons[1]));
		}
		if(StringUtils.isNotBlank(price)){
			String []prices = price.split(",");
			filterParams.put("GTE_h.average_price", Double.valueOf(prices[0]));
			filterParams.put("LTE_h.average_price", Double.valueOf(prices[1]));
		}
		if(StringUtils.isNotBlank(decorationTime)){
			filterParams.put("GTE_h.decoration_time", decorationTime+" 00:00:00");
			filterParams.put("LTE_h.decoration_time", decorationTime+" 23:59:59");
		}
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("EQ_h.reclaim_user_id", AccountUtils.getCurrentUserId());
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				filterParams.put("EQ_h.create_user_id", AccountUtils.getCurrentUserId());
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_h.pid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				filterParams.put("EQ_h.id", AccountUtils.getCurrentUserHotelId());
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_h.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(filterParams);
		pageBean.setOrder("desc");
		pageBean.setSort("h.update_date");
		List<HotelModel> page = hotelService.getSimpleHotelPageList(pageBean,null,null);
		/*for (HotelModel hotelModel : page) {
			HotelScheduleThread hotelScheduleThread = new HotelScheduleThread(365,"HOTEL",hotelModel.getId());
			hotelScheduleThread.start();
		}*/
		return getDataGrid(pageBean, page);
	}
	
	
	@RequestMapping(value ="applyHotelList")
	@ResponseBody
	public DataGrid applyHotelList(PageBean<Map<String, Object>> pageBean,HttpServletRequest request,int referer,String hotelName) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		List<Map<String, Object>> page = Lists.newArrayList();
		if(StringUtils.isNotBlank(hotelName)){
			filterParams.put("LIKE_t.name", hotelName);
			pageBean.set_filterParams(filterParams);
			page = hotelService.getPageTeams(pageBean);
		}
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="hotelList")
	@ResponseBody
	public DataGrid hotelList(PageBean<HotelModel> pageBean,HttpServletRequest request,String area,String person,String price,String decorationTime) {
		List<HotelModel> page = hotelService.getHotelPageList(pageBean,null,null);
		return getDataGrid(pageBean, page);
	}
	
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		Hotel hotel = hotelService.getEntity(id);
		List<SupportingModel> styles = this.siteStypeService.getSiteStypes(hotel.getStyle());
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("HOTELSUPORTING",hotel.getId()+"","HOTEL");
		List<SupportingModel> roomservices = this.supportingServicesService.findByKind("ROOMSERVICE",hotel.getId()+"","HOTEL");
		List<Category> purposes = this.categoryService.findByKind("PURPOSE");
		if(StringUtils.isNotBlank(hotel.getPurpose())){
			for (Category category : purposes) {
				if(hotel.getPurpose().contains(category.getId()+"")){
					category.setIshave("1");
				}
			}
		}
		model.addAttribute("purposes",purposes);
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
	
	@RequestMapping(value = "gethotel/{id}")
	@ResponseBody
	public Json getHotelInfo(@PathVariable("id") Long id) {
		Json json = new Json();
		Hotel hotel = hotelService.getEntity(id);
		json.setJson(true, "", hotel);
		return json;
	}
	
	
	@RequestMapping(value = "select/index")
	public String selectIndex(Model model) {
		this.groupSetting(model);
		return "hotel/selectHotelList";
	}
	
	
	@RequestMapping(value ="select/list")
	@ResponseBody
	public JsonVo selectList(HttpServletRequest request,String hotelName,Integer province,Integer city,Integer district) throws Exception {
		Map<String, Object> filterParams = this.getSearchParams(request);
		
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}else{
		}
		if(province==null&&city==null&&district==null){
			filterParams.put("EQ_h.city", this.getCity(request));
		}else{
			if(province!=null){
				filterParams.put("EQ_h.province", province);
			}
			if(city!=null){
				filterParams.put("EQ_h.city", city);
			}
			if(district!=null){
				filterParams.put("EQ_h.district", district);
			}
		}
		PageBean<HotelSelModel> pageBean = new PageBean<>();
		pageBean.set_filterParams(filterParams);
		List<HotelSelModel> hotels = this.hotelService.getAllHotelForSel(pageBean);
		return JsonUtils.success("ok", hotels);
	}
	
}
