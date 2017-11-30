package com.chuangbang.wechat.hui.web.order;

import java.util.Date;
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
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.wechat.hui.model.ScheduleBookingModel;
import com.google.common.collect.Lists;

/**
 * 大厅/客房Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/schedulebooking")
public class WxScheduleBookingController extends BaseController {

	@Autowired
	private HotelScheduleService hotelScheduleService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private HotelPlaceService hotelPlaceService;
	
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		List<Category> categories = this.categoryService.findByKind("HOTELTYPE");
		model.addAttribute("categories", categories);
		if(StringUtils.isNotBlank(AccountUtils.getCurrentUserHotelId())){
			Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
			model.addAttribute("hotel", hotel);
		}
		return "weixin/hotel/scheduleBookingIndex";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ScheduleBookingModel> pageBean,HttpServletRequest request,String fdate,String sdate) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("OR_EQ;p.hotel_id",hotelIds);
			}else{
				filterParams.put("EQ_p.hotel_id", AccountUtils.getCurrentUserHotelId());
			}
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_p.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}else{
		}
		String crtDate =StringUtils.isNotBlank(fdate)?fdate : DateTimeUtils.toDay(new Date());
		String sql =  "select p.id placeId,p.place_name placeName,p.hotel_name hotelName,b.client_from clientFrom,b.place_date placeDate,b.state state"
				+ ",b.hotel_sale_name hotelSaleName,b.source_app_id sourceAppId,p.description description"
				+ " from  "
				+ " ( select p1.id,p1.hotel_id,p1.place_name,h.hotel_name,h.province,h.city,h.hotel_type,h.company_id,p1.description "
				+ " from "
				+ " hui_hotel_place p1,hui_hotel h "
				+ " where p1.hotel_id = h.id and p1.place_type='HALL'"
				+ "  ) p"
				+ " left join "
				+ " (select b1.* from hui_schedule_booking b1  where b1.id in (select max(b2.id) from hui_schedule_booking b2 ";
		 sql += "where  b2.place_date>='"+crtDate+"' and b2.type='01' ";
		 if(StringUtils.isNotBlank(sdate)){
			 sql +=" and b2.place_date<='"+sdate+"'";
		 }
		 
		 sql += "group by b2.place_id ) ) b";
		 sql += " on b.place_id = p.id  where 1=1 ";
		
		 System.out.println(filterParams.toString());
		List<Object> paras = Lists.newArrayList();
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("p.hotel_id,p.id");
		pageBean.setOrder("desc,asc");
		List<ScheduleBookingModel> scheduleBookingModels = cusQueryService.page(pageBean, sql, ScheduleBookingModel.class, paras);
		return getDataGrid(pageBean, scheduleBookingModels);
	}
	
	@RequestMapping(value = "place/detail")
	public String placeDetail(HttpServletRequest request, Model model,Long placeId) {
		this.groupSetting(model);
		HallModel hotelPlace = hotelPlaceService.getHall(placeId);
		model.addAttribute("hotelPlace", hotelPlace);
		model.addAttribute("placeId", placeId);
		List<Category> ctimes = this.categoryService.findByKind("SCHEDULETIME");
		model.addAttribute("ctimes", ctimes);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/hotel/scheduleBookingDetail";
		}else{
			return "hotel/scheduleBookingDetail";
		}
	}
	
	
	
	@RequestMapping(value = "place/detail/list")
	@ResponseBody
	public JsonVo placeDetailList(PageBean<ScheduleBookingModel> pageBean,Model model,Long placeId,String place_date,Long place_schedule) {
		StringBuilder sbd = new StringBuilder();
		HotelSchedule hotelSchedule = this.hotelScheduleService.findByPlaceIdAndPlaceDateAndPlaceSchedule(placeId, place_date, place_schedule+"");
		
		sbd.append("  select s.id id,bu.place_id placeId,bu.place_date placeDate,s.place_schedule placeSchedule,bu.state state,bu.client_from  clientFrom");
		sbd.append(",bu.linkman linkman,bu.uid hotelSaleId,bu.rname hotelSaleName,bu.mobile hotelSalePhone,bu.place_schedule_id placeScheduleId,bu.source_app_id sourceAppId,bu.order_no orderNo");
		sbd.append("  from  hui_hotel_schedule s  ,  ");
		sbd.append("  (  ");
		sbd.append("  select b.id,b.place_id,b.place_schedule_id,b.state,b.hotel_sale_name,b.client_from,b.linkman,u.id uid,u.rname,u.mobile,b.place_date,b.source_app_id,b.order_no  ");
		sbd.append("  from hui_schedule_booking b   ");
		sbd.append("  left join hui_user u  ");
		sbd.append("  on b.hotel_sale_id = u.id ");
		sbd.append("  where b.place_id = ? and b.place_date = ? and b.type='01'");
		sbd.append("  )bu  ");
		sbd.append("  where bu.place_schedule_id = s.id ");
		//sbd.append(" and ( case s.state when 0 then bu.state=1 else bu.state = 2 end)  ");
		sbd.append("  and s.place_schedule = ?  ");
		List<Object> paras = Lists.newArrayList();
		paras.add(placeId);
		paras.add(place_date);
		paras.add(place_schedule);
		if(hotelSchedule!=null&&"2".equals(hotelSchedule.getState())){
			sbd.append("  and bu.state = ?  ");
			paras.add("2");
		}else{
			sbd.append("  and bu.state <= ?  ");
			paras.add("2");
		}
		pageBean.setSort("bu.state");
		List<ScheduleBookingModel> scheduleBookingModels = cusQueryService.getAll(pageBean, sbd.toString(), ScheduleBookingModel.class, paras);
		return JsonUtils.success("ok", scheduleBookingModels);
	}
	
	
	@RequestMapping(value = "place/booking")
	public String placeBooking(Model model,Long placeId,String placeDate,String placeSchedule,HttpServletRequest request) {
		this.groupSetting(model);
		HallModel hall = hotelPlaceService.getHall(placeId);
		model.addAttribute("hall", hall);
		model.addAttribute("placeId", placeId);
		model.addAttribute("placeDate", placeDate);
		model.addAttribute("sale", AccountUtils.getCurrentRName());
		List<Category> ctimes = this.categoryService.findByKind("SCHEDULETIME");
		model.addAttribute("ctimes", ctimes);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/hotel/scheduleBookingForm";
		}else{
			return "hotel/pscheduleBookingForm";
		}
		
	}
	
	
	@RequestMapping(value = "place/booking/save")
	@ResponseBody
	public JsonVo bookingSave(Long hotelId,Long placeId,Long scheduleId,String linkman,String company,String mobile,String activityTitle
			,String email,String scheduleTime,String scheduleTimeTxt,String placeDate){
	
		/*HotelSchedule hotelSchedule = this.hotelScheduleService.getEntity(scheduleId);
		if(hotelSchedule.getState().equals("2")){
			return JsonUtils.error("您慢了一步；该档期已被预订！");
		}*/
		HallModel hall = hotelPlaceService.getHall(placeId);
		//Category category = categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
		HotelModel hotel = this.hotelService.getHotel(hotelId);
		return orderService.bookingSave(hotel,hall,linkman,company,mobile,activityTitle,email,placeDate,scheduleTime,scheduleTimeTxt);
	}
	
	@RequestMapping(value = "place/ishaveschedule")
	@ResponseBody
	public JsonVo isHaveSchedule(Long hotelId,Long placeId,String placeDate){
		return hotelScheduleService.countBookingSchedule(hotelId,placeId,placeDate);
		//
	}
}
