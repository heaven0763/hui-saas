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

import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地价格Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/hotel/price")
public class PlacePriceController extends BaseController {

	@Autowired
	private PlacePriceService placePriceService;
	
	@ModelAttribute("placePrice")
	public PlacePrice getPlacePrice(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return placePriceService.getEntity(id);
		}
		return new PlacePrice();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/placePriceList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/placePriceForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(PlacePrice placePrice) {
		if(placePrice.getId()==null&&
				this.placePriceService.findByPlaceIdAndPlaceSchedule(placePrice.getPlaceId(),placePrice.getPlaceSchedule())!=null){
			return ajaxDoneError("请勿重复添加价格");
		}
		placePriceService.savePlacePrice(placePrice);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	

	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PlacePrice> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if(searchparas.get("EQ_placeSchedule")==null){
			searchparas.remove("EQ_placeSchedule");
			String crtDay = DateTimeUtils.getCurrentDate();
			searchparas.put("GTE_placeSchedule", crtDay);
		}
		pageBean.set_filterParams(searchparas);
		pageBean.setSort("placeSchedule,placeId");
		pageBean.setOrder("asc,asc");
		Page<PlacePrice> page = placePriceService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		PlacePrice placePrice = placePriceService.getEntity(id);
		model.addAttribute("placePrice", placePrice);
		return new ModelAndView("hotel/placePriceForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		placePriceService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
