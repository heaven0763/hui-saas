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

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.order.ScheduleBooking;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.ScheduleBookingService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 档期预定信息Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/hotel/booking")
public class ScheduleBookingController extends BaseController {

	@Autowired
	private ScheduleBookingService scheduleBookingService;
	@Autowired
	private HotelService hotelService;
	@ModelAttribute("scheduleBooking")
	public ScheduleBooking getScheduleBooking(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return scheduleBookingService.getEntity(id);
		}
		return new ScheduleBooking();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		if("HOTEL".equals(AccountUtils.getHotelUserType())){
			Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
			model.addAttribute("hotel", hotel);
		}
		return "hotel/scheduleBookingList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		this.groupSetting(model);
		return "hotel/scheduleBookingForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(ScheduleBooking scheduleBooking) {
		scheduleBookingService.saveScheduleBooking(scheduleBooking);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ScheduleBooking> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<ScheduleBooking> page = scheduleBookingService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		ScheduleBooking scheduleBooking = scheduleBookingService.getEntity(id);
		model.addAttribute("scheduleBooking", scheduleBooking);
		return new ModelAndView("hotel/scheduleBookingForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		scheduleBookingService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
