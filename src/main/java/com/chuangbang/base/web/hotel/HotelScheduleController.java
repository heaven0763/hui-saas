package com.chuangbang.base.web.hotel;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
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
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Maps;

/**
 * 场地档期Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/hotel/schedule")
public class HotelScheduleController extends BaseController {

	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("hotelSchedule")
	public HotelSchedule getHotelSchedule(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelScheduleService.getEntity(id);
		}
		return new HotelSchedule();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		return "hotel/hotelScheduleList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		return "hotel/hotelScheduleForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelSchedule hotelSchedule,String action) {
		if("create".equals(action)){
			hotelScheduleService.saveHotelSchedule(hotelSchedule,hotelSchedule.getPlaceSchedule());
		}else{
			hotelScheduleService.saveHotelSchedule(hotelSchedule);
		}
		
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelSchedule> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				//searchparas.put("OR_EQ;hotelId", this.hotelService.findHotelIdsByReclaimUserId(AccountUtils.getCurrentUserId()));
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				//searchparas.put("EQ_createUserId", AccountUtils.getCurrentUserId());
			}
			/*Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
			if(hotel!=null){
				searchparas.put("EQ_hotelId", hotel.getId());
			}*/
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				searchparas.put("OR_EQ;hotelId", this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid()) );
			}else{
				searchparas.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("OR_EQ;hotelId", this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId()) );
		}
		pageBean.setSort("placeDate,placeId");
		pageBean.setOrder("asc,asc");
		List<HotelSchedule> page = hotelScheduleService.getHotelSchedulePageList(pageBean);
		/*for (HotelSchedule hotelSchedule : page) {
			hotelSchedule.setPlaceSchedule(categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule())).getName());
		}*/
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="detail/list")
	@ResponseBody
	public JsonVo list(HttpServletRequest request,Long placeId,String placeDate){
		Map<String, Object> searchparas = Maps.newHashMap();
		searchparas.put("EQ_placeId", placeId);
		searchparas.put("EQ_placeDate", placeDate);
		List<HotelSchedule> hotelSchedules = this.hotelScheduleService.getEntities(searchparas, new Sort(Direction.ASC, "placeSchedule"));
		for (HotelSchedule hotelSchedule : hotelSchedules) {
			hotelSchedule.setPlaceSchedule(categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule())).getName());
		}
		return JsonUtils.success("ok",hotelSchedules);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		HotelSchedule hotelSchedule = hotelScheduleService.getEntity(id);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		model.addAttribute("hotelSchedule", hotelSchedule);
		return new ModelAndView("hotel/hotelScheduleForm");
	}
	
	@RequestMapping(value = "batch/update")
	public ModelAndView batchUpdate(Model model,HttpServletRequest request) {
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		return new ModelAndView("hotel/hotelScheduleBatchForm");
	}
	
	@RequestMapping(value = "batch/save")
	public ModelAndView batchSave(Long hotelId, String sdate,String edate) throws ParseException {
		List<HallModel> hallModels = this.hotelPlaceService.getAllHall(new PageBean<HallModel>());
		int days = DateTimeUtils.daysBetween(sdate, edate);
 		hotelScheduleService.batchSaveSchedule(sdate, days, hallModels);
		return new ModelAndView("hotel/hotelScheduleForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelScheduleService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
