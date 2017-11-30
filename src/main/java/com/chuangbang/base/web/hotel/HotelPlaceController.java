package com.chuangbang.base.web.hotel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.base.service.hotel.SupportingServicesService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 大厅/客房表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "/base/hotel")
public class HotelPlaceController extends BaseController {
      
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private  SupportingServicesService supportingServicesService;
	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private PlacePriceService placePriceService; 
	
	@ModelAttribute("hotelPlace")
	public HotelPlace getHotelPlace(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelPlaceService.getEntity(id);
		}
		return new HotelPlace();
	}
	
	@RequestMapping(value = "/hall/index")
	public String index(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		
		return "hotel/hallList";
	}
	@RequestMapping(value = "/hall/create")
	public String createForm(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("HALLSUPPORT");
		List<SupportingModel> halldisplay = this.supportingServicesService.findByKind("HALLDISPLAY");
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		model.addAttribute("action","添加");
		model.addAttribute("supportings",supportings);
		model.addAttribute("halldisplay",halldisplay);
		return "hotel/hallForm";
	}
	
	@RequestMapping(value = "/hall/save")
	public ModelAndView save(HttpServletRequest request,HotelPlace hotelPlace,String supportings,String halldisplays,String personNum,Integer pillarNum,String supportingsVal) {
		try{
			hotelPlaceService.saveHotelPlace(request,hotelPlace,supportings,halldisplays,pillarNum);
		}catch(Exception e){
			e.printStackTrace();
			return ajaxDoneError("保存失败！请重试！");
		}
		
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="/hall/list")
	@ResponseBody
	public DataGrid list(PageBean<HallModel> pageBean,HttpServletRequest request,String area,String person,String zgprice,String price,String decorationTime) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		if(StringUtils.isNotBlank(area)){
			String []areas = area.split(",");
			filterParams.put("GTE_h.hall_area", areas[0]);
			filterParams.put("LTE_h.hall_area", areas[1]);
		}
		
		if(StringUtils.isNotBlank(person)){
			String []persons = person.split(",");
			filterParams.put("GTE_h.people_num", persons[0]);
			filterParams.put("LTE_h.people_num", persons[1]);
		}
		if(StringUtils.isNotBlank(zgprice)){
			String []prices = zgprice.split(",");
			filterParams.put("GTE_h.zgui_price", prices[0]);
			filterParams.put("LTE_h.zgui_price", prices[1]);
		}
		if(StringUtils.isNotBlank(price)){
			String []prices = price.split(",");
			filterParams.put("GTE_h.hotel_price", prices[0]);
			filterParams.put("LTE_h.hotel_price", prices[1]);
		}
		if(StringUtils.isNotBlank(decorationTime)){
			filterParams.put("GTE_h.decoration_ime", decorationTime+" 00:00:00");
			filterParams.put("LTE_h.decoration_ime", decorationTime+" 23:59:59");
		}
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("EQ_hotel.reclaim_user_id", AccountUtils.getCurrentUserId());
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				filterParams.put("EQ_hotel.create_user_id", AccountUtils.getCurrentUserId());
			}
			Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
			if(hotel!=null){
				filterParams.put("EQ_hotel.id", hotel.getId());
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_hotel.pid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				filterParams.put("EQ_hotel.id", AccountUtils.getCurrentUserHotelId());
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_hotel.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}
		
		
		pageBean.set_filterParams(filterParams);
		List<HallModel> page = hotelPlaceService.getHallPageList(pageBean);
		//hotelScheduleService.batchSaveSchedule("2017-04-01", 90, page);
		//placePriceService.batchSaveSchedule("2017-06-01", 180, page);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "/hall/update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		this.groupSetting(model);
		HotelPlace hotelPlace = hotelPlaceService.getEntity(id);
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("HALLSUPPORT",hotelPlace.getId()+"","HALL");//this.supportingServicesService.findByKind("HALLSUPPORT");
		List<SupportingModel> halldisplay = this.supportingServicesService.findByKind("HALLDISPLAY",hotelPlace.getId()+"","HALL");
		model.addAttribute("action","修改");
		model.addAttribute("supportings",supportings);
		model.addAttribute("halldisplay",halldisplay);
		model.addAttribute("hall", hotelPlace);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("hotel", hotel);
		return new ModelAndView("hotel/hallForm");
	}
	
	@RequestMapping(value = "/hall/delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelPlaceService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	
	@RequestMapping(value = "/room/index")
	public String roomIndex(Model model) {
		this.groupSetting(model);
		return "hotel/roomList";
	}
	@RequestMapping(value = "/room/create")
	public String roomCreateForm(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("FACILITIES");
		List<SupportingModel> halldisplay = this.supportingServicesService.findByKind("MEDIA&TECH");
		model.addAttribute("action","添加");
		model.addAttribute("supportings",supportings);
		model.addAttribute("halldisplay",halldisplay);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel", hotel);
		return "hotel/roomForm";
	}
	
	@RequestMapping(value = "/room/save")
	public ModelAndView roomSave(HotelPlace hotelPlace,String techs,String facilities) {
		hotelPlaceService.saveHotelRoom(hotelPlace,techs,facilities);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="/room/list")
	@ResponseBody
	public DataGrid roomList(PageBean<RoomModel> pageBean,HttpServletRequest request,String zgprice,String price,String decorationTime) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		if(StringUtils.isNotBlank(zgprice)){
			String []prices = zgprice.split(",");
			filterParams.put("GTE_r.zgui_price", prices[0]);
			filterParams.put("LTE_r.zgui_price", prices[1]);
		}
		if(StringUtils.isNotBlank(price)){
			String []prices = price.split(",");
			filterParams.put("GTE_r.hotel_price", prices[0]);
			filterParams.put("LTE_r.hotel_price", prices[1]);
		}
		if(StringUtils.isNotBlank(decorationTime)){
			filterParams.put("GTE_r.decoration_ime", decorationTime+" 00:00:00");
			filterParams.put("LTE_r.decoration_ime", decorationTime+" 23:59:59");
		}
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("EQ_hotel.reclaim_user_id", AccountUtils.getCurrentUserId());
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				filterParams.put("EQ_hotel.create_user_id", AccountUtils.getCurrentUserId());
			}
			Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
			if(null!=hotel){
				filterParams.put("EQ_hotel.id", hotel.getId());
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_hotel.pid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				filterParams.put("EQ_hotel.id", AccountUtils.getCurrentUserHotelId());
			}
			//Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_hotel.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}
		
		pageBean.set_filterParams(filterParams);
		List<RoomModel> page = hotelPlaceService.getRoomPageList(pageBean);
		//placePriceService.batchSaveRoomSchedule("2017-06-01", 90, page);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "/room/update/{id}")
	public ModelAndView roomUpdate(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		this.groupSetting(model);
		HotelPlace hotelPlace = hotelPlaceService.getEntity(id);
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("FACILITIES",hotelPlace.getId()+"","ROOM");
		List<SupportingModel> halldisplay = this.supportingServicesService.findByKind("MEDIA&TECH",hotelPlace.getId()+"","ROOM");
		model.addAttribute("action","修改");
		model.addAttribute("supportings",supportings);
		model.addAttribute("halldisplay",halldisplay);
		model.addAttribute("room", hotelPlace);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel", hotel);
		return new ModelAndView("hotel/roomForm");
	}
	
	@RequestMapping(value = "/room/delete/{id}")
	public ModelAndView roomDelete(@PathVariable("id") Long id) {
		hotelPlaceService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
