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

import com.chuangbang.base.entity.hotel.HotelHallPeopleNum;
import com.chuangbang.base.service.hotel.HotelHallPeopleNumService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 大厅容纳人数Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/hotel/hallpeoplenum")
public class HotelHallPeopleNumController extends BaseController {

	@Autowired
	private HotelHallPeopleNumService hotelHallPeopleNumService;
	
	@ModelAttribute("hotelHallPeopleNum")
	public HotelHallPeopleNum getHotelHallPeopleNum(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelHallPeopleNumService.getEntity(id);
		}
		return new HotelHallPeopleNum();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/hotelHallPeopleNumForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/hotelHallPeopleNumForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelHallPeopleNum hotelHallPeopleNum) {
		hotelHallPeopleNumService.saveHotelHallPeopleNum(hotelHallPeopleNum);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelHallPeopleNum> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<HotelHallPeopleNum> page = hotelHallPeopleNumService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		HotelHallPeopleNum hotelHallPeopleNum = hotelHallPeopleNumService.getEntity(id);
		model.addAttribute("hotelHallPeopleNum", hotelHallPeopleNum);
		return new ModelAndView("hotel/hotelHallPeopleNumForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelHallPeopleNumService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
