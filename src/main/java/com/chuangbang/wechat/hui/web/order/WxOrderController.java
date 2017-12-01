package com.chuangbang.wechat.hui.web.order;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.HallOrderDetailModel;
import com.chuangbang.app.model.MealOrderDetailModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.app.model.RoomOrderDetailModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.app.model.ScheduleModel;
import com.chuangbang.base.dao.order.ComissionCheckRecordDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.order.OrderDetail;
import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelMenuDetailService;
import com.chuangbang.base.service.hotel.HotelMenuService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.base.service.order.ComissionRecordService;
import com.chuangbang.base.service.order.OrderDetailService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.PointsAccountService;
import com.chuangbang.framework.entity.dictionary.Dictionary;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.dictionary.DictionaryService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.plugins.mail.SimpleMailSender;
import com.chuangbang.wechat.hui.model.OrderParam;
import com.chuangbang.wechat.hui.model.UserOperationModel;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;

import sun.misc.BASE64Decoder;

/**
 * 订单Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "weixin/order")
public class WxOrderController extends BaseController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private PointsAccountService pointsAccountService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PlacePriceService placePriceService;
	@Autowired
	private ComissionRecordService comissionRecordService;
	@Autowired
	private ComissionCheckRecordDao comissionCheckRecordDao;
	@Autowired
	private HotelMenuDetailService hotelMenuDetailService;
	@Autowired
	private HotelGroupService hotelGroupService;
	@ModelAttribute("order")
	public Order getOrder(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return orderService.getEntity(id);
		}
		return new Order();
	}
	
	
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		
		List<Dictionary> stateDicts = dictionaryService.findByKind("05");	//订单状态
		model.addAttribute("stateDicts",stateDicts);
		
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
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("reclaim_user_id", AccountUtils.getCurrentUserId());
			}
			Map<String, Object> res = orderService.count(filterParams);
			model.addAttribute("res",res);
		}
		
		return "weixin/order/orderIndex";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,HttpServletRequest request,String OFFTAG) throws Exception {
		this.groupSetting(model);
		Map<String, Object> filterParams = Maps.newHashMap();
		
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_companyId",AccountUtils.getCurrentUser().getCompanyId());
		}else{
			
		}
		filterParams.put("EQ_city", this.getCity(request));
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<Hotel> hotels = this.hotelService.getEntities(filterParams);
		model.addAttribute("hotels", hotels);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/orderForm";
		}else{
			model.addAttribute("OFFTAG", OFFTAG);
			return "order/orderForm";
		}
	}
	
	@RequestMapping(value = "items/index/{id}")
	public String itemsIndex(@PathVariable("id") Long id,Model model,HttpServletRequest request) {
		this.groupSetting(model);
		PageBean<HallModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_h.hotel_id", id);
		pageBean.set_filterParams(filterParams);
		List<HallModel> halls = this.hotelPlaceService.getAllHall(pageBean);
		model.addAttribute("halls", halls);
		
		PageBean<RoomModel> rpageBean = new PageBean<>();
		Map<String, Object> rfilterParams = Maps.newHashMap();
		rfilterParams.put("EQ_r.hotel_id", id);
		rpageBean.set_filterParams(rfilterParams);
		List<RoomModel> rooms = this.hotelPlaceService.getAllRoom(rpageBean);
		model.addAttribute("rooms", rooms);
		
		Map<String, Object> mfilterParams = Maps.newHashMap();
		mfilterParams.put("EQ_hotelId", id);
		List<HotelMenu> menus = this.hotelMenuService.getEntities(mfilterParams);
		for (HotelMenu hotelMenu : menus) {
			hotelMenu.setHotelMenuDetails(hotelMenuDetailService.findByMenuId(hotelMenu.getId()));
		}
		model.addAttribute("menus", menus);
		
		List<Category> ctimes = this.categoryService.findByKind("SCHEDULETIME");
		model.addAttribute("ctimes", ctimes);
		
		Hotel hotel = this.hotelService.getEntity(id);
		model.addAttribute("hotel", hotel);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/itemsIndex";
		}else{
			return "order/orderItemsForm";
		}
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Order order) {
		orderService.saveOrder(order);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Order> pageBean,HttpServletRequest request,String hotelType,String saleId,String allorders) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		System.out.println(searchparas.toString());
		System.out.println(">>>>>"+allorders);
		System.out.println("saleId>>>>>"+saleId);
		System.out.println(">>>>>"+AccountUtils.getHotelUserType()+">>>"+"HUI".equals(AccountUtils.getHotelUserType()));
		if("GROUP".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_h.pid", AccountUtils.getCurrentUserhotelPId());
			/*searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			if(StringUtils.isNotBlank(saleId)&&!"1".equals(allorders)){
				searchparas.put("EQ_o.hotel_sale_id", saleId);
			}else if(StringUtils.isNotBlank(saleId)&&"1".equals(allorders)){
				searchparas.put("NE_o.hotel_sale_id", saleId);
			}*/
		}else if("HOTEL".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			if(StringUtils.isNotBlank(saleId)&&!"1".equals(allorders)){
				searchparas.put("EQ_o.hotel_sale_id", saleId);
			}else if(StringUtils.isNotBlank(saleId)&&"1".equals(allorders)){
				searchparas.put("NE_o.hotel_sale_id", saleId);
			}
		}else if("HUI".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_o.company_sale_id", saleId);
		}else if("PARTNER".equals(AccountUtils.getHotelUserType().toUpperCase())){
			//searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
			searchparas.put("EQ_o.company_sale_id", saleId);
		}else{
			
		}
		
		if(searchparas.get("EQ_o.state")!=null && StringUtils.isNotBlank(searchparas.get("EQ_o.state")+"")){
			searchparas.remove("OR_EQ;o.state");
		}else{
			searchparas.remove("EQ_o.state");
		}
		
		if(StringUtils.isNotBlank(hotelType)){
			searchparas.put("EQ_h.hotel_type", hotelType);
		}
		
		searchparas.put("EQ_o.offline_state", "1");
		pageBean.set_filterParams(searchparas);
		if(AccountUtils.isRole("hotel_finance")){
			pageBean.setSort("o.state#11@01@02@021@04@06@07@03@05@10@12@13,o.settlement_status,o.activity_date");
			pageBean.setOrder("FIND_IN_SET,asc,desc");
		}else if(AccountUtils.isRole("hotel_sales_director")){
			pageBean.setSort("o.state#01@02@021@04@06@07@11@03@05@10@12@13,o.activity_date");
			pageBean.setOrder("FIND_IN_SET,desc");
		}else{
			pageBean.setSort("o.state#01@02@021@04@06@07@11@03@05@10@12@13,o.activity_date");
			pageBean.setOrder("FIND_IN_SET,desc");
		}
		
		List<Order> page = orderService.getPageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="commission/list")
	@ResponseBody
	public DataGrid commissionList(PageBean<Order> pageBean,HttpServletRequest request,String hotelType,String saleId,String allorders) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		System.out.println(searchparas.toString());
		System.out.println(">allorders>>>>"+allorders);
		if("HOTEL".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			if(StringUtils.isNotBlank(saleId)&&!"1".equals(allorders)){
				searchparas.put("EQ_o.hotel_sale_id", saleId);
			}else if(StringUtils.isNotBlank(saleId)&&"1".equals(allorders)){
				searchparas.put("NE_o.hotel_sale_id", saleId);
			}
			
			if(AccountUtils.isRole("hotel_sales")){
				searchparas.put("OR_EQ;o.commission_status","01");
				//searchparas.put("EQ_o.isupdate","0");
			}else if(AccountUtils.isRole("hotel_finance")){
				searchparas.put("OR_EQ;o.commission_status","01,04,05");
			}
			
		}else if("GROUP".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_h.pid", AccountUtils.getCurrentUserhotelPId());
			
			/*if(AccountUtils.isRole("hotel_sales")){
				searchparas.put("OR_EQ;o.commission_status","01");
				//searchparas.put("EQ_o.isupdate","0");
			}else if(AccountUtils.isRole("hotel_finance")){
				searchparas.put("OR_EQ;o.commission_status","01,04,05");
			}*/
			
		}else if("HUI".equals(AccountUtils.getHotelUserType())){
			searchparas.put("EQ_o.company_sale_id", saleId);//OR_EQ;h.reclaim_user_id;o.company_sale_id;o.company_follow_sale_id
			if(AccountUtils.isRole("company_sales")){
				searchparas.put("OR_EQ;o.commission_status","00,01,03");
			}else if(AccountUtils.isRole("company_finance")){
				searchparas.put("OR_EQ;o.commission_status","02,06");
			}
			
		}else if("PARTNER".equals(AccountUtils.getHotelUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}else{
			
		}
		if(searchparas.get("EQ_o.state")!=null && StringUtils.isNotBlank(searchparas.get("EQ_o.state")+"")){
			searchparas.remove("OR_EQ;o.state");
		}else{
			searchparas.remove("EQ_o.state");
		}
		
		if(searchparas.get("EQ_o.commission_status")!=null && StringUtils.isNotBlank(searchparas.get("EQ_o.commission_status")+"")){
			searchparas.remove("OR_EQ;o.commission_status");
			searchparas.remove("EQ_o.isupdate");
			if("ALL".equals(searchparas.get("EQ_o.commission_status")+"")){
				searchparas.remove("EQ_o.commission_status");
				searchparas.put("GTE_o.commission_status","01");
			}else{
				searchparas.put("OR_EQ;o.commission_status",searchparas.get("EQ_o.commission_status")+"");
				searchparas.remove("EQ_o.commission_status");
			}
		}else{
			searchparas.remove("EQ_o.commission_status");
		}
		
		if(StringUtils.isNotBlank(hotelType)){
			searchparas.put("EQ_h.hotel_type", hotelType);
		}
		System.out.println(searchparas.toString());
		System.out.println(searchparas.get("GTE_o.activity_date"));
		if(null==searchparas.get("GTE_o.activity_date")&&null==searchparas.get("LTE_o.activity_date")){
			searchparas.put("LT_o.activity_date",DateTimeUtils.getCurrentDate());
		}
		searchparas.put("EQ_o.offline_state", "1");
		pageBean.set_filterParams(searchparas);
		pageBean.setSort("o.commission_status#01@02@03@04@05@06@07,o.activity_date");
		pageBean.setOrder("FIND_IN_SET,desc");
		List<Order> page = orderService.getPageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id,Model model,HttpServletRequest request,String issend) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		
		List<HallOrderDetailModel> otherHalls = Lists.newArrayList();
		List<HallOrderDetailModel> halls = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		Double bookPriceCount = 0.00;
		Double bookServicePercent = 0.00;
		
		System.out.println(halls);
		for(HallOrderDetailModel h : halls){
			System.out.println(" h.getAmount()>>>>>"+ h.getAmount());
			bookPriceCount += h.getAmount();
			bookServicePercent = h.getCommissionFeeRate();
			if("1".equals(h.getIsmain())){
				System.out.println(h.getPlaceName());
				model.addAttribute("main_hotelplace", h);
			}else{
				otherHalls.add(h);
			}
		}
		
		Double roomPrice = 0.00;
		for(RoomOrderDetailModel r : rooms){
			roomPrice += r.getAmount();
		}
		
		Double mealPrice = 0.00;
		for(MealOrderDetailModel m : meals){
			mealPrice += m.getAmount();
		}
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		
		boolean iscomission = iscomission(order);
		System.out.println("iscomission>>>>>>>>>>>"+iscomission);
		model.addAttribute("iscomission", iscomission);
		model.addAttribute("mealPrice", mealPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("bookPriceCount", bookPriceCount);
		model.addAttribute("bookServicePercent", bookServicePercent);
		model.addAttribute("order", order);
		model.addAttribute("halls", halls);
		model.addAttribute("otherHalls", otherHalls);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		model.addAttribute("hotel", hotel);
		List<Category> ctimes = this.categoryService.findByKind("SCHEDULETIME");
		model.addAttribute("ctimes", ctimes);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return new ModelAndView("weixin/order/orderDetail");
		}else{
			return new ModelAndView("order/orderwxDetail");
		}
		
	}
	
	@RequestMapping(value = "mdetail/{orderNo}")
	public ModelAndView detail(@PathVariable("orderNo") String orderNo,Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Order order = orderService.findByOrderNo(orderNo);
		
		List<HallOrderDetailModel> otherHalls = Lists.newArrayList();
		List<HallOrderDetailModel> halls = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		Double bookPriceCount = 0.00;
		Double bookServicePercent = 0.00;
		
		System.out.println(halls);
		for(HallOrderDetailModel h : halls){
			bookPriceCount += h.getAmount();
			bookServicePercent = h.getCommissionFeeRate();
			if("1".equals(h.getIsmain())){
				System.out.println(h.getPlaceName());
				model.addAttribute("main_hotelplace", h);
			}else{
				otherHalls.add(h);
			}
		}
		
		Double roomPrice = 0.00;
		for(RoomOrderDetailModel r : rooms){
			roomPrice += r.getAmount();
		}
		
		Double mealPrice = 0.00;
		for(MealOrderDetailModel m : meals){
			mealPrice += m.getAmount();
		}
		
		
		
		boolean iscomission = iscomission(order);
		System.out.println("iscomission>>>>>>>>>>>"+iscomission);
		model.addAttribute("iscomission", iscomission);
		model.addAttribute("mealPrice", mealPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("bookPriceCount", bookPriceCount);
		model.addAttribute("bookServicePercent", bookServicePercent);
		model.addAttribute("order", order);
		model.addAttribute("halls", halls);
		model.addAttribute("otherHalls", otherHalls);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		
		List<Category> ctimes = this.categoryService.findByKind("SCHEDULETIME");
		model.addAttribute("ctimes", ctimes);
		
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		model.addAttribute("hotel", hotel);
		
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return new ModelAndView("weixin/order/orderDetail");
		}else{
			if(order.getHotelSaleId().equals(AccountUtils.getCurrentUserId())){
				return new ModelAndView("order/orderwxDetail");
			}else{
				return new ModelAndView("redirect:/base/order/detail/"+order.getId());
			}
		}
		
	}
	
	private boolean iscomission(Order order) {
		boolean iscomission = false;
		if(order.getCommissionStatus().equals("01")&&"HOTEL".equals(AccountUtils.getCurrentUserType())){
			Hotel hotel = this.hotelService.getEntity(order.getHotelId());
			
			if("1".equals(hotel.getHotelNature())&&AccountUtils.getCurrentUserHotelId().equals(hotel.getId()+"")
					&&SecurityUtils.getSubject().hasRole("hotel_finance")){
				iscomission = true;
			}else if("2".equals(hotel.getHotelNature())){
				HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
				if(cooperationInfo.getCommissionRights().equals("1")){
					if(AccountUtils.getCurrentUserHotelId().equals(hotel.getId()+"")
							&&SecurityUtils.getSubject().hasRole("hotel_finance")){
						iscomission = true;
					}
				}else if(cooperationInfo.getCommissionRights().equals("2")){
					if(AccountUtils.getCurrentUser().getCompanyId().equals(hotel.getPid())
							&&SecurityUtils.getSubject().hasRole("group_finance")){
						iscomission = true;
					}
				}
			}
		}
		return iscomission;
	}

	@RequestMapping(value = "modify/logs/{id}")
	public String modifylogs(@PathVariable("id") Long id,Model model) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		model.addAttribute("order", order);
		return "weixin/order/orderModifyLogs";
	}
	
	@RequestMapping(value ="modify/logs/listAll")
	@ResponseBody
	public DataGrid modifyLogsListAll(PageBean<Order> pageBean,HttpServletRequest request) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		String sql = "select l.operate_type operateType,l.old_data oldData,l.new_data newData,l.operate_time operateTime,u.rname rname,u.position position"
				+ " from hui_log_operation l left join hui_user u on l.user_name = u.username"
				+ " where l.operate_table ='Order'  ";
		List<Object> paras = Lists.newArrayList();
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("l.id");
		List<UserOperationModel> userOperationModels= cusQueryService.getAll(pageBean, sql, UserOperationModel.class, paras);
		System.out.println(userOperationModels.size());
		return getDataGrid(pageBean, userOperationModels);
	}
	
	
	@RequestMapping(value = "deduct/index")
	public String deductIndex(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		List<Dictionary> stateDicts = dictionaryService.findByKind("06");	//订单状态
		model.addAttribute("stateDicts",stateDicts);
		
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HUI");
			filterParams.put("EQ_u.group_id", "3");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HOTEL");
			filterParams.put("EQ_u.group_id", "9");
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
		}else{
			
		}
	
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("reclaim_user_id", AccountUtils.getCurrentUserId());
			}
			Map<String, Object> res = orderService.countComission(filterParams);
			model.addAttribute("res",res);
		}
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/deductIndex";
		}else{
			return "order/deductList";
		}
	}
	
	@RequestMapping(value = "deduct/detail/{id}")
	public ModelAndView deductDetail(@PathVariable("id") Long id,Model model,HttpServletRequest request) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		PointsAccount account = this.pointsAccountService.findByClientTypeAndClientId("HOTEL",order.getHotelId()+"");
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		
		model.addAttribute("order", order);
		model.addAttribute("hotel", hotel);
		model.addAttribute("account", account);
		if(!order.getCommissionStatus().equals("00")){
			ComissionRecord comissionRecord = comissionRecordService.findByOrderNo(order.getOrderNo());
			model.addAttribute("comissionRecord", comissionRecord);
		}
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return new ModelAndView("weixin/order/deductDetail");
		}else{
			return new ModelAndView("order/deductDetail");
		}
	}
	
	@RequestMapping(value = "reconciliation/index")
	public String reconciliationIndex(Model model) {
		this.groupSetting(model);
		
		List<Dictionary> stateDicts = dictionaryService.findByKind("06");	//订单返佣状态
		model.addAttribute("stateDicts",stateDicts);
		Map<String, Object> filterParams = Maps.newHashMap();
		
		
		PageBean<SalerModel> pageBean = new PageBean<>();
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HUI");
			filterParams.put("EQ_u.group_id", "3");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HOTEL");
			filterParams.put("EQ_u.group_id", "9");
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
		}else{
			
		}
		
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				filterParams.put("reclaim_user_id", AccountUtils.getCurrentUserId());
			}
			Map<String, Object> res = orderService.count(filterParams);
			model.addAttribute("res",res);
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams = Maps.newHashMap();
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_h.pid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				filterParams.put("EQ_h.id", AccountUtils.getCurrentUserHotelId());
				if(SecurityUtils.getSubject().hasRole("hotel_sales")){
					filterParams.put("EQ_o.hotel_sale_id", AccountUtils.getCurrentUserId());
				}
			}
			Map<String, Object> res = orderService.count(filterParams);
			model.addAttribute("res",res);
		}
		
		return "weixin/order/reconciliationIndex";
	}
	
	@RequestMapping(value = "reconciliation/detail/{id}")
	public ModelAndView reconciliationDetail(@PathVariable("id") Long id,PageBean<Order> pageBean,Model model) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		PointsAccount account = this.pointsAccountService.findByClientTypeAndClientId("HOTEL",order.getHotelId()+"");
		boolean isgetinvoice = false;
		if(order.getCommissionStatus().equals("03")&&SecurityUtils.getSubject().hasRole("company_sales")){
			if(hotel.getReclaimUserId().equals(AccountUtils.getCurrentUserId())){
				isgetinvoice = true;
			}
		}
		System.out.println("iscomissddddion>>>>>>>>>>>"+!order.getCommissionStatus().equals("00"));
		if(!order.getCommissionStatus().equals("00")){
			ComissionRecord comissionRecord = comissionRecordService.findByOrderNo(order.getOrderNo());
			if("1".equals(comissionRecord.getIsupdate())&&null!=comissionRecord.getUpdateId()){
				ComissionCheckRecord comissionCheckRecord = comissionCheckRecordDao.findOne(comissionRecord.getUpdateId());
				model.addAttribute("comissionCheckRecord", comissionCheckRecord);
			}
			model.addAttribute("comissionRecord", comissionRecord);
		}
		boolean iscomission = iscomission(order);
		System.out.println("iscomission>>>>>>>>>>>"+iscomission);
		model.addAttribute("iscomission", iscomission);
		
		model.addAttribute("isgetinvoice", isgetinvoice);
		model.addAttribute("order", order);
		model.addAttribute("hotel", hotel);
		model.addAttribute("account", account);
		return new ModelAndView("weixin/order/reconciliationDetail");
	}
	
	@RequestMapping(value = "reconciliation/origindetail/{id}")
	public ModelAndView reconciliationOriginDetail(@PathVariable("id") Long id,PageBean<Order> pageBean,Model model) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		PointsAccount account = this.pointsAccountService.findByClientTypeAndClientId("HOTEL",order.getHotelId()+"");
		boolean isgetinvoice = false;
		if(order.getCommissionStatus().equals("03")&&SecurityUtils.getSubject().hasRole("company_sales")){
			if(hotel.getReclaimUserId().equals(AccountUtils.getCurrentUserId())){
				isgetinvoice = true;
			}
		}
		System.out.println("iscomissddddion>>>>>>>>>>>"+!order.getCommissionStatus().equals("00"));
		if(!order.getCommissionStatus().equals("00")){
			ComissionRecord comissionRecord = comissionRecordService.findByOrderNo(order.getOrderNo());
			model.addAttribute("comissionRecord", comissionRecord);
		}
		boolean iscomission = iscomission(order);
		System.out.println("iscomission>>>>>>>>>>>"+iscomission);
		model.addAttribute("iscomission", iscomission);
		
		model.addAttribute("isgetinvoice", isgetinvoice);
		model.addAttribute("order", order);
		model.addAttribute("hotel", hotel);
		model.addAttribute("account", account);
		return new ModelAndView("weixin/order/reconciliationOriginDetail");
	}
	
	
	
	@RequestMapping(value = "site/adjustment/status")
	public String adjustmentStatusIndex(Model model,HttpServletRequest request) {
		this.groupSetting(model);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/adjustmentStatusIndex";
		}else{
			return "order/orderAdjustmentList";
		}
	}
	
	
	@RequestMapping(value = "site/adjustment/agree")
	@ResponseBody
	public JsonVo adjustmentStatusAgree(Model model,Long id,String reason) {
		return orderService.adjustmentStatusAgree("1",id,reason,"");
	}
	
	@RequestMapping(value = "site/adjustment/reject")
	@ResponseBody
	public JsonVo adjustmentStatusReject(Model model,Long id,String reason) {
		return orderService.adjustmentStatusAgree("0",id,reason,"");
	}

	/**
	 * 会掌柜销售领取发票
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "invoice/get/{id}")
	@ResponseBody
	@RequiresRoles(value="company_sales")
	public JsonVo invoiceGet(@PathVariable("id") Long id) {
		return orderService.invoiceGet(id);
	}
	
	/**
	 * 酒店收到发票
	 * @param id
	 * @param invoiceNo
	 * @return
	 */
	@RequestMapping(value = "invoice/received/{id}")
	@ResponseBody
	public JsonVo invoiceReceived(@PathVariable("id") Long id,String invoiceNo) {
		return orderService.invoiceReceived(id,invoiceNo);
	}
	
	/**
	 * 佣金确认转账
	 * @param id
	 * @param memo
	 * @return
	 */
	@RequestMapping(value = "reconciliation/transfer/accounts/{id}")
	@ResponseBody
	public JsonVo transferAccounts(@PathVariable("id") Long id,String memo) {
		return orderService.transferAccounts(id,memo);
	}
	
	/**
	 * 佣金确认到账
	 * @param id
	 * @param memo
	 * @return
	 */
	@RequestMapping(value = "reconciliation/transfer/accounts/confirmed/{id}")
	@ResponseBody
	public JsonVo transferAccountsConfirmed(@PathVariable("id") Long id,String memo) {
		return orderService.transferAccountsConfirmed(id,memo);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView updateOrder(@PathVariable("id") Long id,Model model) {
		//TODO   修改订单信息
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		
		List<HallOrderDetailModel> otherHalls = Lists.newArrayList();
		List<HallOrderDetailModel> halls = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		Double bookPriceCount = 0.00;
		Double bookServicePercent = 0.00;
		
		System.out.println(halls);
		for(HallOrderDetailModel h : halls){
			bookPriceCount += h.getAmount();
			bookServicePercent = h.getCommissionFeeRate();
					
			if("1".equals(h.getIsmain())){
				System.out.println(h.getPlaceName());
				model.addAttribute("main_hotelplace", h);
			}else{
				otherHalls.add(h);
			}
		}
		
		Double roomPrice = 0.00;
		for(RoomOrderDetailModel r : rooms){
			roomPrice += r.getAmount();
		}
		
		Double mealPrice = 0.00;
		for(MealOrderDetailModel m : meals){
			mealPrice += m.getAmount();
		}
		
		
		boolean iscomission = iscomission(order);
		System.out.println("iscomission>>>>>>>>>>>"+iscomission);
		model.addAttribute("iscomission", iscomission);
		model.addAttribute("mealPrice", mealPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("roomPrice", roomPrice);
		model.addAttribute("bookPriceCount", bookPriceCount);
		model.addAttribute("bookServicePercent", bookServicePercent);
		model.addAttribute("order", order);
		
		model.addAttribute("halls", halls);
		
		model.addAttribute("otherHalls", otherHalls);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		
		return new ModelAndView("weixin/order/orderUpdateForm");
	}
	
	@RequestMapping(value = "state/{id}")
	@ResponseBody
	public JsonVo changeState(@PathVariable("id") Long id,Integer tostate,String cancelReason, Double prepay, Double ramount, Double pamount) {
		//TODO   修改状态
		return orderService.changeState(id,tostate,cancelReason,prepay,ramount,pamount);
		
		//return JsonUtils.success("OK");
	}
	
	
	@RequestMapping(value = "hall/schedule/info")
	@ResponseBody
	public JsonVo getHallScheduleInfo(Model model,Long hotelId,Long placeId,String scheduleDate,String scheduleTime) {
		if("ALL".equals(scheduleTime)){
			List<ScheduleModel> scheduleModels = this.hotelScheduleService.getSchedulePageList(placeId, "HALL", scheduleDate);
			if(scheduleModels!=null){
				return JsonUtils.success("OK",scheduleModels);
			}else{
				return JsonUtils.error("该场地尚未排档！");
			}
		}else{
			List<ScheduleModel> scheduleModels = this.hotelScheduleService.getSchedulePageList(placeId, "HALL", scheduleDate);
			if(scheduleModels!=null){
				return JsonUtils.success("OK",scheduleModels);
			}else{
				return JsonUtils.error("该场地尚未排档！");
			}
		}
	}
	
	
	@RequestMapping(value = "room/schedule/info")
	@ResponseBody
	public JsonVo getRoomScheduleInfo(Model model,Long hotelId,Long placeId,String scheduleDate) {
		PlacePrice placePrice = this.placePriceService.findByPlaceTypeAndPlaceIdAndPlaceSchedule("ROOM",placeId, scheduleDate);
		if(placePrice!=null){
			if(placePrice.getOnlinePrice()!=null){
				return JsonUtils.success("OK",placePrice);
			}else{
				return JsonUtils.error("该场地尚未设置线上价格！");
			}
		}else{
			return JsonUtils.error("该场地尚未设置线上价格！");
		}
	}
	
	
	@RequestMapping(value = "offline/save")
	@ResponseBody
	public JsonVo offlineSave(HttpServletRequest request,String chkmealids,String chkhallid,String chkroomid,String activityTitle,String activityDate,String organizer
			,String linkman,String contactNumber,Long hotelId,Double commissionFeeRate,String ismain,String otherdetail,String otherprice,String email
			,String meetingRemark,String houseRemark,String dinnerRemark,String memo,String oprice,String oquantity,Double mealServiceFeeRate,OrderParam orderParam) throws Exception{
		//Thread.sleep(30000L);
		System.out.println("orderParam>>>>"+orderParam.toString());
		System.out.println("chkhallid>>>>"+chkhallid);
		System.out.println("chkroomid>>>>"+chkroomid);
		System.out.println("chkmealid>>>>"+chkmealids);
		System.out.println("otherdetail>>>>"+otherdetail);
		System.out.println("otherprice>>>>"+otherprice);
		Map<String, String[]> params = request.getParameterMap();
		System.out.println(params.toString());
		if(StringUtils.isNotBlank(chkhallid)){
			String [] hallids = chkhallid.split(",");
			for (String hid : hallids) {
				System.out.println("******---------"+hid);
				/*Integer idx = Integer.valueOf(request.getParameter("scheduleidx"+hid));
				System.out.println("******--------- sch index"+idx);
				for (int i = 1; i <= idx; i++) {
					if(idx==1&&StringUtils.isBlank(request.getParameter("scheduleDate_"+hid+"_"+i))){
						return JsonUtils.error("请选择活动场地！");
					}else if(idx>1&&StringUtils.isBlank(request.getParameter("scheduleDate_"+hid+"_"+i))){
						return JsonUtils.error("选中的活动场地档期信息不全！");
					}
				}*/
				System.out.println("******---------"+hid+" sch Price>>>>>>>>>"+request.getParameter("placePrice_"+hid));
				System.out.println("******---------"+hid+" sch scheduleDate>>"+request.getParameter("scheduleDate_"+hid));
				System.out.println("******---------"+hid+" sch scheduleTime>>"+request.getParameter("hallschedule"+hid));
			}
		}else{
			return JsonUtils.error("请选择活动场地！");
		}
		if(StringUtils.isNotBlank(chkroomid)){
			String [] roomids = chkroomid.split(",");
			for (String rid : roomids) {
				System.out.println("******---------"+rid);
				/*Integer idx = Integer.valueOf(request.getParameter("romscheduleidx"+rid));
				System.out.println("******--------- sch romscheduleidx"dx);
				for (int i = 1; i <= idx; i++) {
					if(StringUtils.isBlank(request.getParameter("roomscheduleDate_"+rid))){
						return JsonUtils.error("选中的住房场地档期信息不全！");
					}
				}*/
				System.out.println("******---------"+rid+" room num>>>>>>>>>>>>"+request.getParameter("rom_num_"+rid));
				System.out.println("******---------"+rid+" room Price>>>>>>>>>>"+request.getParameter("roomPrice_"+rid));
				System.out.println("******---------"+rid+" room scheduleDate>>>"+request.getParameter("roomscheduleDate_"+rid));
			}
		}
		if(StringUtils.isNotBlank(chkmealids)){
			String [] mealids = chkmealids.split(",");
			for (String mid : mealids) {
				System.out.println("******---------"+mid);
				/*Integer idx = Integer.valueOf(request.getParameter("mealscheduleidx"+mid));
				System.out.println("******--------- meal index"+idx);
				for (int i = 1; i <= idx; i++) {
					if(StringUtils.isBlank(request.getParameter("mealscheduleDate_"+mid+"_"+i))){
						return JsonUtils.error("选中的用餐信息不全！");
					}
				}*/
				//if(StringUtils.isBlank(cs))
				System.out.println("******---------"+mid+" meal type>>>>>>>>>>>>"+request.getParameter("mealType_"+mid));
				System.out.println("******---------"+mid+" meal scheduleTime>>>>"+request.getParameter("mealscheduleTime_"+mid));
				System.out.println("******---------"+mid+" meal scheduleDate>>>>"+request.getParameter("mealscheduleDate_"+mid));
				System.out.println("******---------"+mid+" meal num>>>>>>>>>>>>>"+request.getParameter("meal_num_"+mid));
				System.out.println("******---------"+mid+" meal price>>>>>>>>>>>>>"+request.getParameter("mealPrice_"+mid));
			}
		}
		//return JsonUtils.success("修改成功");
		return  this.orderService.save(request,chkhallid,chkroomid,chkmealids,activityTitle,activityDate,organizer,linkman,contactNumber
				,email,hotelId,commissionFeeRate,ismain,otherdetail,otherprice, meetingRemark,houseRemark,dinnerRemark,memo,oprice,oquantity,mealServiceFeeRate);
	}
	
	
	@RequestMapping(value = "update/save")
	@ResponseBody
	public JsonVo savePrice(HttpServletRequest request,Long id,String orderNo) {
		System.out.println(request.getParameterMap().toString());
		//return JsonUtils.success("修改成功");
		Json json  = orderService.saveOrderPrice(request,id,orderNo);
		if(json.isSuccess()){
			return JsonUtils.success("修改成功");
		}else{
			return  JsonUtils.error(json.getMsg());
		}
	}
	
	@RequestMapping(value = "sendEmail")
	@ResponseBody
	public JsonVo sendEmail(Model model,HttpServletRequest request,String base64,Long id) throws IOException {
		base64 = base64.substring(22);
		BASE64Decoder decoder = new BASE64Decoder();
		//Base64解码
		byte[] b = decoder.decodeBuffer(base64);
		for (int i = 0; i < b.length; ++i) {
		    if (b[i] < 0) {// 调整异常数据
		        b[i] += 256;
		    }
		}
		String newName = UUID.randomUUID().toString();  
        String rootPath = request.getServletContext().getRealPath("/hui");  
        String newPath = rootPath+"/static/emailFiles/"; 
        String imgPath = newPath + newName +".jpg";
        String pdfPath = newPath + newName +".pdf";
		//生成jpg图片
		OutputStream out;
		out = new FileOutputStream(imgPath);
		out.write(b);
		out.flush();
		out.close();
		
		//jpg转pdf
		try {
			BufferedImage img = ImageIO.read(new File(imgPath));
			FileOutputStream fos = new FileOutputStream(pdfPath);
			Document doc = new Document(null, 0, 0, 0, 0);
			doc.setPageSize(new Rectangle(img.getWidth(), img.getHeight()));
			Image image = Image.getInstance(imgPath);
			PdfWriter.getInstance(doc, fos);
			doc.open();
			doc.add(image);
			doc.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (BadElementException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		
		
		
		Map<String, Object> map = Maps.newHashMap();
		Order order = orderService.getEntity(id);
		if(StringUtils.isNotBlank(order.getEmail())){
			SimpleMailSender.sendEmail(map,imgPath,pdfPath,order);
		}
		
		return JsonUtils.success("success");
	}
	
	@RequestMapping(value = "modify")
	@ResponseBody
	public JsonVo modify(HttpServletRequest request,OrderParam orderParam) {
		System.out.println(">>>>>>>>>>**********************"+orderParam.toString());
		orderParam.getOtherPrice();
		return orderService.saveOrderNewModify(request,orderParam);
	}
	
	@RequestMapping(value = "wxmodify")
	@ResponseBody
	public JsonVo wxModify(HttpServletRequest request,Long id,String orderNo,String ismain,String hallIds,Double hallAmount,Double hallAllAmount,Double commissionFeeRate
			,String roomIds,Double roomAmount,Double roomAllAmount,String mealIds,Double mealAmount,Double mealAllAmount,Double mealServiceFeeRate,String otherdetail,String otherprice,String email
			,String linkman,String contactNumber,String organizer,String activityDate,String activityTitle,String memo,String meetingRemark,String houseRemark
			,String dinnerRemark,String oquantity,String oprice) {

		System.out.println("id>>>>>>>>>>"+id);
		System.out.println("orderNo>>>>>>>>>>"+orderNo);
		System.out.println("ismain>>>>>>>>>>"+ismain);
		System.out.println("hallIds>>>>>>>>>>"+hallIds);
		System.out.println("hallAmount>>>>>>>>>>"+hallAmount);
		System.out.println("hallAllAmount>>>>>>>>>>"+hallAllAmount);
		System.out.println("commissionFeeRate>>>>>>>>>>"+commissionFeeRate);
		
		System.out.println("mealIds>>>>>>>>>>"+mealIds);
		System.out.println("mealAmount>>>>>>>>>>"+mealAmount);
		System.out.println("mealAllAmount>>>>>>>>>>"+mealAllAmount);
		
		System.out.println("roomIds>>>>>>>>>>"+roomIds);
		System.out.println("roomAmount>>>>>>>>>>"+roomAmount);
		System.out.println("roomAllAmount>>>>>>>>>>"+roomAllAmount);
		System.out.println(">>>>>>>>>>**********************");

		
		return orderService.saveOrderModify(request,id,orderNo,ismain,hallIds,hallAmount,hallAllAmount,commissionFeeRate,roomIds,roomAmount,roomAllAmount,mealIds
				,mealAmount,mealAllAmount,mealServiceFeeRate,otherdetail,otherprice,memo,meetingRemark,houseRemark,dinnerRemark,oquantity,oprice);
		
	}
	
	@RequestMapping(value = "offline/check/index")
	public String offlineCheckIdex(Model model) {
		this.groupSetting(model);
		return "weixin/order/offlineCheckIndex";
	}
	@RequestMapping(value ="offline/check/list")
	@ResponseBody
	public DataGrid offlineChecklist(PageBean<Order> pageBean,HttpServletRequest request,String saleId,String settlement_date) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			if(StringUtils.isNotBlank(saleId)){
				searchparas.put("EQ_o.hotel_sale_id", saleId);
			}
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(StringUtils.isNotBlank(saleId)){
				searchparas.put("EQ_o.company_sale_id", saleId);
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}else{
			
		}
		
		searchparas.put("EQ_o.order_type", "OFFLINE");
		//searchparas.put("EQ_o.offline_state", "0");
		pageBean.set_filterParams(searchparas);
		pageBean.setOrder("asc,desc");
		pageBean.setSort("o.offline_state,o.create_date");
		List<Order> page = orderService.getPageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="offline/check/nopass")
	@ResponseBody
	public JsonVo offlineCheckNopass(HttpServletRequest request,Long orderId,String reason) throws UnsupportedEncodingException {
		//reason = new String(reason.getBytes("ISO-8859-1"), "UTF-8");
		return this.orderService.offlineCheck(orderId,reason,"0");
	}
	
	@RequestMapping(value ="offline/check/pass")
	@ResponseBody
	public JsonVo offlineCheckPass(HttpServletRequest request,Long orderId,String reason) {
		return this.orderService.offlineCheck(orderId,reason,"1");
	}
	
	
	@RequestMapping("/remind/commission")
	@ResponseBody
	public JsonVo commissionRemind(HttpServletRequest request){
		return this.orderService.commissionRemind(0);
	}
	
	
	@RequestMapping("/company/follow")
	@ResponseBody
	public JsonVo companyFollow(HttpServletRequest request,Long orderId,String companyFollowMemo){
		return this.orderService.companyFollow(orderId,companyFollowMemo);
	}
	
	/**
	 * 确认报价
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/confirm/quotation")
	@ResponseBody
	public JsonVo confirmQuotation(HttpServletRequest request,Long id){
		return this.orderService.confirmQuotation(id);
	}
	
	
	@RequestMapping(value = "invalid/{id}")
	@ResponseBody
	public JsonVo orderInvalid(@PathVariable("id") Long id) {
		return orderService.orderInvalid(id);
	}
}
