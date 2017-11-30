package com.chuangbang.base.web.order;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
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
import org.springside.modules.mapper.JsonMapper;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.app.model.ComissionRecordModel;
import com.chuangbang.app.model.HallOrderDetailModel;
import com.chuangbang.app.model.MealOrderDetailModel;
import com.chuangbang.app.model.RoomOrderDetailModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.dao.order.ComissionCheckRecordDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.order.OrderDetail;
import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.SiteImgService;
import com.chuangbang.base.service.order.ComissionRecordService;
import com.chuangbang.base.service.order.OrderDetailService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.PointsAccountService;
import com.chuangbang.base.thread.SendEmailThread;
import com.chuangbang.framework.entity.dictionary.Dictionary;
import com.chuangbang.framework.service.dictionary.DictionaryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.file.pdf.PdfHelper;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.js.vo.CommissionSum;
import com.chuangbang.js.vo.MonthSummary;
import com.chuangbang.log.service.operation.UserOperationService;
import com.chuangbang.wechat.hui.model.UserOperationModel;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 订单Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/order")
public class OrderController extends BaseController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserOperationService userOperationService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private PointsAccountService pointsAccountService;
	@Autowired
	private ComissionRecordService comissionRecordService;
	@Autowired
	private ComissionCheckRecordDao comissionCheckRecordDao;
	/*@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private HotelScheduleService hotelScheduleService;*/
	@Autowired
	private SiteImgService siteImgService;
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
		
		return "order/orderList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,String OFFTAG) {
		this.groupSetting(model);
		model.addAttribute("OFFTAG", OFFTAG);
		return "order/orderForm";
	}

	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("order")Order order) {
		orderService.saveOrder(order);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}

	@RequestMapping(value = "saveprice")
	public ModelAndView savePrice(HttpServletRequest request,Long id,String orderNo) {
		Json json  = orderService.saveOrderPrice(request,id,orderNo);
		if(json.isSuccess()){
			return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
		}else{
			return  ajaxDoneError(json.getMsg());
		}
	}

	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Order> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if(AccountUtils.getRoles("hotel_sales")){
			searchparas.put("EQ_hotelSaleId", AccountUtils.getCurrentUserId());
		}
		
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			searchparas.put("OR_EQ;hotelId",hotelIds);
		}
		
		pageBean.set_filterParams(searchparas);
		pageBean.setOrder("desc");
		Page<Order> page = orderService.getEntities(pageBean);
		for (Order order : page.getContent()) {
			order.setSettlementStatusTxt(this.orderService.getSettlementStatusTxt(order.getSettlementStatus()));
			order.setStateTxt(this.orderService.getStateTxt(order.getState()));
			order.setCommissionStatusTxt(this.orderService.getCommissionStatusTxt(order.getCommissionStatus()));
		}
		return getDataGrid(pageBean, page.getContent());
	}

	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,String OFFTAG) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		List<HallOrderDetailModel> sites = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		model.addAttribute("hotelsale", userService.getSaler(order.getHotelSaleId()));
		model.addAttribute("companysale", userService.getSaler(order.getCompanySaleId()));
		model.addAttribute("order", order);
		model.addAttribute("sites", sites);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		Map<String, Object> res = Maps.newHashMap();
		model.addAttribute("stateTxt", orderService.getStateTxt(order, res));
		model.addAttribute("res", res);
		model.addAttribute("OFFTAG", OFFTAG);
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		//=OFFLINE
		return new ModelAndView("order/orderForm");
	}
	
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model,String OFFTAG,String issend) {
		this.groupSetting(model);
		Order order = orderService.getEntity(id);
		List<HallOrderDetailModel> sites = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		PageBean<UserOperationModel>  pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_l.operate_table", "Order");
		filterParams.put("EQ_l.operate_id", order.getId());
		pageBean.set_filterParams(filterParams);
		List<UserOperationModel> logs = userOperationService.findByOperateLog(pageBean);
		System.out.println(">>>>>>>>>>>logs "+logs.size());
		for (UserOperationModel userOperation : logs) {
			if("INSERT".equals(userOperation.getOperateType())){
				userOperation.setOperateContent("客户提交订单");
			}else if("UPDATE".equals(userOperation.getOperateType())){
				System.out.println(">>>>>>>>>>>logs "+userOperation.getNewData());
				JSONObject newObj = JSONObject.parseObject(userOperation.getNewData());
				Iterator<String> iterator = newObj.keySet().iterator();
				Map<String, Object> newmap = Maps.newHashMap();
				while (iterator.hasNext()) {
					String key = iterator.next();
					newmap.put(key, newObj.get(key));
				}
				List<Map<String, Object>> res = Lists.newArrayList();
				System.out.println(">>>>>>>>>>>logs "+userOperation.getOldData());
				JSONObject oldObj = JSONObject.parseObject(userOperation.getOldData());
				if(oldObj!=null){
					Iterator<String> it = oldObj.keySet().iterator();
					while (it.hasNext()) {
						String key = it.next();
						Map<String, Object> map = getKeyValue(key,oldObj.get(key),newmap.get(key));
						if(map!=null){
							res.add(map);
						}
					}
				}
				userOperation.setChangeDatas(res);
			}
		}
		System.out.println(new JsonMapper().toJson(logs));
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		model.addAttribute("hotel", hotel);
		model.addAttribute("order", order);
		model.addAttribute("sites", sites);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		model.addAttribute("logs", logs);
		model.addAttribute("OFFTAG", OFFTAG);
		model.addAttribute("stateTxt", orderService.getStateTxt(order, null));
		return new ModelAndView("order/orderDetail");
	}
	@RequestMapping(value = "/pdf/create/{id}")
	public ModelAndView pdfCreate(@PathVariable("id") Long id,HttpServletRequest request,HttpServletResponse response){
		  try {
				Order order = orderService.getEntity(id);
				String tplPath = PdfHelper.getTplPath();
				System.out.println("/pdf/create/>>>>>>tplPath>>>>>"+tplPath);
				SendEmailThread sendEmailThread = new SendEmailThread(order.getId(), order.getOrderNo(), order.getEmail(), tplPath, "订单详情");
				sendEmailThread.start();
			} catch (Exception e) {
				e.printStackTrace();
			}
		return ajaxDoneSuccess("生成成功！");
	}
	@RequestMapping(value = "/pdf/detail/{id}")
	public ModelAndView pdfDetail(@PathVariable("id") Long id, Model model,String OFFTAG,String issend,HttpServletRequest request) {
		//this.groupSetting(model);
		Order order = orderService.getEntity(id);
		System.out.println(order);
		System.out.println(">>>>"+order.getOrderNo());
		List<HallOrderDetailModel> sites = this.orderDetailService.getAllHallOrderDetail(order.getOrderNo());
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		List<MealOrderDetailModel> meals = this.orderDetailService.getAllMealOrderDetailModel(order.getOrderNo());
		List<OrderDetail> otherDetails = this.orderDetailService.getAllOtherDetails(order.getOrderNo());
		model.addAttribute("otherDetails", otherDetails);
		PageBean<UserOperationModel>  pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_l.operate_table", "Order");
		filterParams.put("EQ_l.operate_id", order.getId());
		pageBean.set_filterParams(filterParams);
		List<UserOperationModel> logs = userOperationService.findByOperateLog(pageBean);
		for (UserOperationModel userOperation : logs) {
			if("INSERT".equals(userOperation.getOperateType())){
				userOperation.setOperateContent("客户提交订单");
			}else if("UPDATE".equals(userOperation.getOperateType())){
				JSONObject newObj = JSONObject.parseObject(userOperation.getNewData());
				Iterator<String> iterator = newObj.keySet().iterator();
				Map<String, Object> newmap = Maps.newHashMap();
				while (iterator.hasNext()) {
					String key = iterator.next();
					newmap.put(key, newObj.get(key));
				}
				List<Map<String, Object>> res = Lists.newArrayList();
				JSONObject oldObj = JSONObject.parseObject(userOperation.getOldData());
				if(oldObj!=null){
					Iterator<String> it = oldObj.keySet().iterator();
					while (it.hasNext()) {
						String key = it.next();
						Map<String, Object> map = getKeyValue(key,oldObj.get(key),newmap.get(key));
						res.add(map);
					}
				}
				userOperation.setChangeDatas(res);
			}
		}
		Hotel hotel = this.hotelService.getEntity(order.getHotelId());
		List<SiteImg> hotelImgs = siteImgService.findBySiteIdAndSiteTypeAndNum(hotel.getId(), "HOTEL",4);
		List<Map<String, Object>> hallImgs = Lists.newArrayList();
		for (HallOrderDetailModel hall : sites) {
			hall.setIsmain(hall.getIsmain().equals("1")?"主会场":"分会场");
			hall.setPillars((hall.getPillar()!=null&&hall.getPillar()>0)?"立柱":"无柱");
			List<SiteImg> himgs = siteImgService.findBySiteIdAndSiteTypeAndNum(hall.getPlaceId(), "HALL",2);
			Map<String, Object> hmap =  Maps.newHashMap();
			hmap.put("name", hall.getPlaceName());
			hmap.put("imgs", himgs);
			hallImgs.add(hmap);
		}
		List<Map<String, Object>> roomImgs = Lists.newArrayList();
		for (RoomOrderDetailModel room : rooms) {
			List<SiteImg> rimgs = siteImgService.findBySiteIdAndSiteTypeAndNum(room.getPlaceId(), "ROOM",2);
			Map<String, Object> rmap =  Maps.newHashMap();
			rmap.put("name", room.getPlaceName());
			rmap.put("imgs", rimgs);
			roomImgs.add(rmap);
		}
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		if("2".equals(hotel.getHotelNature())){
			HotelGroup hotelGroup = this.hotelGroupService.getEntity(hotel.getPid());
			model.addAttribute("hotelGroup", hotelGroup);
		}
		model.addAttribute("hotel", hotel);
		model.addAttribute("hotelImgs",hotelImgs);
		model.addAttribute("hallImgs",hallImgs);
		model.addAttribute("roomImgs",roomImgs);
		
		model.addAttribute("order", order);
		model.addAttribute("sites", sites);
		model.addAttribute("rooms", rooms);
		model.addAttribute("meals", meals);
		model.addAttribute("logs", logs);
		model.addAttribute("OFFTAG", OFFTAG);
		model.addAttribute("stateTxt", orderService.getStateTxt(order, null));
		model.addAttribute("issend", issend);
		
		return new ModelAndView("order/orderPdfDetail");
	}

	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		orderService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}


	@RequestMapping(value = "accept/{id}")
	public ModelAndView accept(@PathVariable("id") Long id) {
		orderService.accept(id);
		return ajaxDoneSuccess("操作成功！");
	}


	private  Map<String, Object> getKeyValue(String key,Object ovalue,Object nvalue){
		Map<String, Object> map = Maps.newHashMap();
		if("hotelSaleName".equals(key)){
			map.put("title", "酒店销售姓名");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("hotelSaleMobile".equals(key)){
			map.put("title", "酒店销售电话");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("hotelPoints".equals(key)){
			map.put("title", "酒店获得积分");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("amount".equals(key)){
			map.put("title", "活动总计费用");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}  
		else if("zgdiscount".equals(key)){
			map.put("title", "掌柜折扣");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("zgamount".equals(key)){
			map.put("title", "掌柜预算金额");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("prepaid".equals(key)){
			map.put("title", "预付金额");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("finalPayment".equals(key)){
			map.put("title", "尾款");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("siteAmount".equals(key)){
			map.put("title", "活动场地费用");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("siteCommissionFee".equals(key)){
			map.put("title", "场地服务费用");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("roomAmount".equals(key)){
			map.put("title", "住房场地费用");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("diningAmount".equals(key)){
			map.put("title", "用餐选择费用");
			map.put("type", "price");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("clientId".equals(key)){
			//map.put("title", "客户编号");
		}   
		else if("activityDate".equals(key)){
			map.put("title", "活动日期");
		}  
		else if("activityTitle".equals(key)){
			map.put("title", "活动名称");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}  
		else if("organizer".equals(key)){
			map.put("title", "活动主办单位");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("linkman".equals(key)){
			map.put("title", "联系人");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("contactNumber".equals(key)){
			map.put("title", "联系电话");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("clientPoints".equals(key)){
			map.put("title", "客户获取积分");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("companyFollowSaleName".equals(key)){
			map.put("title", "公司客服姓名");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("companyFollowTime".equals(key)){
			map.put("title", "公司客服介入时间");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("companyFollowMemo".equals(key)){
			map.put("title", "公司客服介入反馈");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("state".equals(key)){
			map.put("title", "订单状态");
			map.put("nvalue",this.orderService.getStateTxt(nvalue+""));
			map.put("ovalue",this.orderService.getStateTxt(ovalue+""));
		}   
		else if("settlementStatus".equals(key)){
			map.put("title", "结算状态");
			map.put("nvalue",this.orderService.getSettlementStatusTxt(nvalue+""));
			map.put("ovalue",this.orderService.getSettlementStatusTxt(ovalue+""));
		}else if("settlementDate".equals(key)){
			map.put("title", "结算时间");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("commissionStatus".equals(key)){
			map.put("title", "返佣状态");
			map.put("nvalue",this.orderService.getCommissionStatusTxt(nvalue+""));
			map.put("ovalue",this.orderService.getCommissionStatusTxt(ovalue+""));
		}   
		else if("commissionDate".equals(key)){
			map.put("title", " 返佣时间");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("commissionRate".equals(key)){
			map.put("title", "提佣比例");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("commissionAmount".equals(key)){
			map.put("title", "提佣金额");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("signDate".equals(key)){
			map.put("title", "签约时间");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}
		else if("isupload".equals(key)){
			map.put("title", "签约业务员姓名");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}
		else if("isinvoice".equals(key)){
			map.put("title", "是否已开票");
			map.put("nvalue","1".equals(nvalue)?"已开票":"未开票");
			map.put("ovalue",ovalue);
		}   
		else if("invoiceUname".equals(key)){
			map.put("title", "开票人");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("invoiceNo".equals(key)){
			map.put("title", "开具发票号码");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("invoiceDate".equals(key)){
			map.put("title", "开具日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("receiveDate".equals(key)){
			map.put("title", "领取日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("companySaleName".equals(key)){
			map.put("title", "公司销售姓名");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("companySaleMobile".equals(key)){
			map.put("title", "公司销售电话");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("createDate".equals(key)){
			map.put("title", "创建日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("payType".equals(key)){
			map.put("title", "支付类型");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("payDate".equals(key)){
			map.put("title", "支付日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("refundDate".equals(key)){
			map.put("title", "退款日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}   
		else if("refundReason".equals(key)){
			map.put("title", "退款原因");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("cancelDate".equals(key)){
			map.put("title", "取消日期");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		} 
		else if("cancelReason".equals(key)){
			map.put("title", "取消原因");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("offlineState".equals(key)){
			map.put("title", "线下活动审核状态");
			map.put("nvalue",StringUtils.isNotBlank(nvalue.toString())?(nvalue.toString().equals("0")?"未审核":(nvalue.toString().equals("1")?"审核通过":"审核不通过")):"");
			map.put("ovalue",StringUtils.isNotBlank(ovalue.toString())?(ovalue.toString().equals("0")?"未审核":(ovalue.toString().equals("1")?"审核通过":"审核不通过")):"");
		}else if("offlineMemo".equals(key)){
			map.put("title", "线下活动审核备注");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("otherAmount".equals(key)){
			map.put("title", "其他费用");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("email".equals(key)){
			map.put("title", "电子邮箱");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("refundAmount".equals(key)){
			map.put("title", "退款金额");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("settlementAmount".equals(key)){
			map.put("title", "结算金额");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("settlementAmount".equals(key)){
			map.put("mealServiceFee", "用餐加收服务费");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("siteCommissionFeeRate".equals(key)){
			map.put("title", "场地加收服务费率");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("mealServiceFeeRate".equals(key)){
			map.put("title", "用餐加收服务费率");
			map.put("nvalue",nvalue);
			map.put("ovalue",ovalue);
		}else if("originalHotelSale".equals(key)){
			map.put("title", "原销售人员");
			
			map.put("nvalue",nvalue!=null&&StringUtils.isNotBlank(nvalue.toString())?this.userService.getEntity(nvalue.toString()).getRname():"");
			map.put("ovalue",ovalue!=null&&StringUtils.isNotBlank(ovalue.toString())?this.userService.getEntity(ovalue.toString()).getRname():"");
		}else if("hotelSaleId".equals(key)){
			map.put("title", "现销售人员");
			map.put("nvalue",nvalue!=null&&StringUtils.isNotBlank(nvalue.toString())?this.userService.getEntity(nvalue.toString()).getRname():"");
			map.put("ovalue",ovalue!=null&&StringUtils.isNotBlank(ovalue.toString())?this.userService.getEntity(ovalue.toString()).getRname():"");
		}else{
			return null;
		}
		return map;
	}
	
	
	@RequestMapping(value = "offline/check/index")
	public String offlineCheckIdex(Model model) {
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
			filterParams.put("EQ_u.group_id", "3");
			filterParams.put("EQ_u.company_id", AccountUtils.getCurrentUserCompanyId());
		}else{
			
		}
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		return "order/offLineOrderList";
	}
	
	
	
	@RequestMapping(value = "reconciliation/index")
	public String reconciliationIndex(Model model){
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
			}
			Map<String, Object> res = orderService.count(filterParams);
			model.addAttribute("res",res);
		}
		return "order/reconciliationList";
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
		if(!order.getCommissionStatus().equals("00")){
			ComissionRecord comissionRecord = comissionRecordService.findByOrderNo(order.getOrderNo());
			if("1".equals(comissionRecord.getIsupdate())&&null!=comissionRecord.getUpdateId()){
				ComissionCheckRecord comissionCheckRecord = comissionCheckRecordDao.findOne(comissionRecord.getUpdateId());
				ComissionRecordModel comissionRecordModel = new ComissionRecordModel(comissionCheckRecord);
				model.addAttribute("comissionCheckRecord", comissionCheckRecord);
				model.addAttribute("comissionRecordModel", comissionRecordModel);
			}else{
				ComissionRecordModel comissionRecordModel = new ComissionRecordModel(comissionRecord);
				model.addAttribute("comissionRecordModel", comissionRecordModel);
			}
			
			model.addAttribute("comissionRecord", comissionRecord);
		}
		boolean iscomission = iscomission(order);
		model.addAttribute("iscomission", iscomission);
		HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		
		model.addAttribute("cooperationInfo", cooperationInfo);
		model.addAttribute("isgetinvoice", isgetinvoice);
		model.addAttribute("order", order);
		model.addAttribute("hotel", hotel);
		model.addAttribute("account", account);
		return new ModelAndView("order/reconciliationDetail");
	}
	@RequestMapping(value = "reconciliation/origindetail/{id}")
	public ModelAndView reconciliationOriginDetail(@PathVariable("id") Long id,Model model) {
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
		if(!order.getCommissionStatus().equals("00")){
			ComissionRecord comissionRecord = comissionRecordService.findByOrderNo(order.getOrderNo());
			model.addAttribute("comissionRecord", comissionRecord);
		}
		boolean iscomission = iscomission(order);
		model.addAttribute("iscomission", iscomission);
		HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
		
		SalerModel hotelSale = this.userService.getSaler(order.getHotelSaleId());
		SalerModel huiSale = this.userService.getSaler(order.getCompanySaleId());
		model.addAttribute("hotelSale", hotelSale);
		model.addAttribute("huiSale", huiSale);
		
		model.addAttribute("cooperationInfo", cooperationInfo);
		model.addAttribute("isgetinvoice", isgetinvoice);
		model.addAttribute("order", order);
		model.addAttribute("hotel", hotel);
		model.addAttribute("account", account);
		return new ModelAndView("order/reconciliationOriginDetail");
	}
	
	private boolean iscomission(Order order) {
		boolean iscomission = false;
		if("01".equals(order.getCommissionStatus())&&"HOTEL".equals(AccountUtils.getCurrentUserType())){
			Hotel hotel = this.hotelService.getEntity(order.getHotelId());
			if("1".equals(hotel.getHotelNature())&&AccountUtils.getCurrentUserHotelId().equals(order.getHotelId()+"")
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
	
	@RequestMapping(value = "/monthSummary")
	public String monthSummary(Model model) {
		return "account/monthSummary";
	}
	
	@RequestMapping(value = "/monthSummary/list")
	@ResponseBody
	public DataGrid monthSummaryList(Model model,PageBean<MonthSummary> pageBean,String startTime,String endTime) {
		startTime = startTime + " 00:00:00";
		endTime =  endTime + " 23:59:59";
		List<MonthSummary> page = orderService.getSummaryInfo(startTime,endTime);
		return getDataGrid(pageBean,page);
	}
	
	/**
	 * 佣金汇总统计页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/commissionSum")
	public String commissionSum(Model model) {
		return "account/commissionSum";
	}
	
	/**
	 * 佣金汇总统计
	 */
	@RequestMapping(value = "/commissionSum/list")
	@ResponseBody
	public DataGrid commissionSumList(Model model,PageBean<CommissionSum> pageBean,Long hotelId,String startTime,String endTime) {
		List<CommissionSum> page = orderService.getCommissionSumInfo(hotelId,startTime,endTime);
		return getDataGrid(pageBean,page);
	}
	
	/**
	 * 不通过佣金修改
	 * @param orderId
	 * @param cmsnId
	 * @param cmsnchkId
	 * @return
	 */
	@RequestMapping(value = "/commission/cmsn/update/unpass")
	@ResponseBody
	public JsonVo commissionUpdateUnpass(Long orderId,Long cmsnId,Long cmsnchkId) {
		return this.comissionRecordService.commissionUpdateUnpass(orderId,cmsnId,cmsnchkId);
	}
	
	/**
	 * 通过佣金修改
	 * @param orderId
	 * @param cmsnId
	 * @param cmsnchkId
	 * @return
	 */
	@RequestMapping(value = "/commission/cmsn/update/pass")
	@ResponseBody
	public JsonVo commissionUpdatePass(Long orderId,Long cmsnId,Long cmsnchkId) {
		return this.comissionRecordService.commissionUpdatePass(orderId,cmsnId,cmsnchkId);
	}
	
	/**
	 * 佣金修改确认
	 * @param orderId
	 * @param cmsnId
	 * @return
	 */
	@RequestMapping(value = "/commission/cmsn/cfm")
	@ResponseBody
	public JsonVo commissionCfm(Long orderId,Long cmsnId) {
		return this.comissionRecordService.commissionCfm(orderId,cmsnId);
	}
	
	
	/**
	 * 更改跟进销售
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/salerChangeForm/{orderId}")
	public String salerChangeForm(@PathVariable("orderId") Long orderId,Model model) {
		Order order = this.orderService.getEntity(orderId);
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
		filterParams.put("NE_u.id",order.getHotelSaleId());
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		
		User osale = this.userService.getEntity(order.getHotelSaleId());
		model.addAttribute("sales", sales);
		model.addAttribute("order", order);
		model.addAttribute("osale", osale);
		return "order/salerChangeForm";
	}
	
	
	/**
	 * 更改跟进销售
	 * @param orderId
	 * @param cmsnId
	 * @return
	 */
	@RequestMapping(value = "/orderSaleChangeSave")
	public ModelAndView  orderSaleChangeSave(Long orderId,String saleId) {
		JsonVo jsonVo = this.orderService.orderSaleChangeSave(orderId,saleId);
		if(jsonVo.getStatusCode().equals("200")){
			return ajaxDoneSuccess("更新成功！");
		}else{
			return ajaxDoneError("更新失败！");
		}
	}
}
