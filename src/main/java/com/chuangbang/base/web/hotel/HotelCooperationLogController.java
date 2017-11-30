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

import com.chuangbang.framework.web.BaseController;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.entity.hotel.HotelCooperationLog;
import com.chuangbang.base.service.hotel.HotelCooperationLogService;
import com.chuangbang.base.service.hotel.HotelService;

/**
 * 场地返佣比例修改记录Controller
 * @author heaven
 * @version 2017-03-14
 */
@Controller
@RequestMapping(value = "hotel/cooperationlog")
public class HotelCooperationLogController extends BaseController {

	@Autowired
	private HotelCooperationLogService hotelCooperationLogService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("hotelCooperationLog")
	public HotelCooperationLog getHotelCooperationLog(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return hotelCooperationLogService.getEntity(id);
		}
		return new HotelCooperationLog();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/hotelCooperationLogList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/hotelCooperationLogForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelCooperationLog hotelCooperationLog) {
		hotelCooperationLogService.saveHotelCooperationLog(hotelCooperationLog);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelCooperationLog> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<HotelCooperationLog> page = hotelCooperationLogService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		HotelCooperationLog hotelCooperationLog = hotelCooperationLogService.getHotelCooperationLog(id);
		HotelModel hotelModel = this.hotelService.getHotel(hotelCooperationLog.getHotelId());
		model.addAttribute("hotelCooperationLog", hotelCooperationLog);
		model.addAttribute("hotel", hotelModel);
		return new ModelAndView("hotel/hotelCooperationLogForm");
	}
	
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelCooperationLogService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
