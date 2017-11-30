package com.chuangbang.wechat.hui.web.hotel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelMenuService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

import freemarker.template.utility.StringUtil;

/**
 * 大厅/客房Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotelplace")
public class WxHotelPlaceController extends BaseController {

	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private CusQueryService cusQueryService;
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "weixin/hotel/scheduleIndex";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public JsonVo list(PageBean<HallModel> pageBean,HttpServletRequest request,Long hotelId) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		searchparas.put("EQ_h.hotel_id", hotelId);
		pageBean.set_filterParams(searchparas);
		
		List<HallModel> evaluates = hotelPlaceService.getAllHall(pageBean);
		
		return JsonUtils.success("",evaluates)  ;
	}
	
	@RequestMapping(value ="room/list")
	@ResponseBody
	public JsonVo roomlist(PageBean<RoomModel> pageBean,HttpServletRequest request,Long hotelId) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		searchparas.put("EQ_r.hotel_id", hotelId);
		pageBean.set_filterParams(searchparas);
		
		List<RoomModel> evaluates = hotelPlaceService.getAllRoom(pageBean);
		
		return JsonUtils.success("",evaluates)  ;
	}
	
	@RequestMapping(value ="meal/list")
	@ResponseBody
	public JsonVo meallist(PageBean<RoomModel> pageBean,HttpServletRequest request,Long hotelId) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_hotelId", hotelId);
		
		List<HotelMenu> menus = hotelMenuService.getEntities(filterParams);
		
		return JsonUtils.success("",menus)  ;
	}
	
	@RequestMapping(value ="getone")
	@ResponseBody
	public JsonVo getOne(HttpServletRequest request,Long id,String type,String date) {
		if("HALL".equals(type)){
			HallModel hallModel = hotelPlaceService.getHall(id);
			return JsonUtils.success("",hallModel);
		}else if("ROOM".equals(type)){
			if(StringUtils.isNotBlank(date)){
				RoomModel roomModel = hotelPlaceService.getRoom(id,date);
				return JsonUtils.success("",roomModel);
			}else{
				RoomModel roomModel = hotelPlaceService.getRoom(id);
				return JsonUtils.success("",roomModel);
			}
		}else if("MEAL".equals(type)){
			HotelMenu menu = hotelMenuService.getEntity(id);
			return JsonUtils.success("",menu);
		}else{
			return JsonUtils.error("类型不存在！");
		}
		
	}
	
}
