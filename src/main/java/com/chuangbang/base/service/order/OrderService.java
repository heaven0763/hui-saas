package com.chuangbang.base.service.order;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.chuangbang.app.model.BookingRecordModel;
import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.OrderModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.app.model.RoomOrderDetailModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;
import com.chuangbang.base.dao.hotel.ScheduleBookingDao;
import com.chuangbang.base.dao.order.ComissionCheckRecordDao;
import com.chuangbang.base.dao.order.ComissionRecordDao;
import com.chuangbang.base.dao.order.EvaluateDao;
import com.chuangbang.base.dao.order.OrderDao;
import com.chuangbang.base.dao.order.OrderDetailDao;
import com.chuangbang.base.dao.order.OrderPayedRecordDao;
import com.chuangbang.base.dao.user.PointsAccountDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.order.OrderDetail;
import com.chuangbang.base.entity.order.OrderPayedRecord;
import com.chuangbang.base.entity.order.ScheduleBooking;
import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelMenuService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.PointsAccountService;
import com.chuangbang.base.thread.SendEmailThread;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.framework.util.RandomStringUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.file.pdf.PdfHelper;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.js.vo.CommissionSum;
import com.chuangbang.js.vo.MonthSummary;
import com.chuangbang.plugins.sms.util.CallUtil;
import com.chuangbang.wechat.hui.model.OrderParam;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 订单Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class OrderService extends BaseService<Order,OrderDao> {

	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private ScheduleBookingDao scheduleBookingDao;
	@Autowired
	private HotelScheduleDao hotelScheduleDao;
	@Autowired
	private EvaluateDao evaluateDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private ChatRecordService chatRecordService;	
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private ComissionRecordDao comissionRecordDao;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private PointsAccountService pointsAccountService;
	@Autowired
	private PointsAccountDao pointsAccountDao;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PlacePriceService placePriceService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private ComissionCheckRecordDao comissionCheckRecordDao;
	@Autowired
	private OrderPayedRecordDao orderPayedRecordDao;
	public Order getEntity(Long id) {
		return orderDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveOrder(Order order) {
		orderDao.save(order);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		orderDao.delete(id);
	}
	
	
	/**
	 * API订单保存方法
	 * @param order     订单
	 * @param details	订单详情
	 */
	@Transactional(readOnly = false)
	public Json saveOrder(Order order, List<OrderDetail> details,List<HotelSchedule> schedules) {
		Json json = new Json();
		if(orderDao.findByOrderNoAndSourceAppId(order.getOrderNo(),order.getSourceAppId())!=null){
			json.setJson(false, "订单号已存在，订单重复提交！");
			return json;
		}
		orderDao.save(order);
		for (OrderDetail orderDetail : details) {
			orderDetailDao.save(orderDetail);
		}
		for (HotelSchedule hotelSchedule : schedules) {
			ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), hotelSchedule.getId(), order.getSourceAppId()+""
					, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName(), "0", null, new Date(), "", "1");
			hotelSchedule.setState("1");
			this.hotelScheduleDao.save(hotelSchedule);
			this.scheduleBookingDao.save(scheduleBooking);
		}
		json.setJson(true, "订单提交成功！");
		return json;
	}
	
	
	/**
	 * API订单保存方法
	 * @param order  订单实体
	 * @param sites  场地详情
	 * @param rooms  房间详情
	 * @param meals  用餐详情
	 * @param others 其他详情
	 * @return
	 */
	@Transactional(readOnly = false)
	public Json saveOrder(Order order, String sites,String rooms,String meals,String others) {
		Json json = new Json();
		if(orderDao.findByOrderNoAndSourceAppId(order.getOrderNo(),order.getSourceAppId())!=null){
			json.setJson(false, "订单号已存在，订单重复提交！",null,"10101");
			return json;
		}
		
		if(StringUtils.isNotBlank(sites)){
			JSONArray siteAry = JSONObject.parseArray(sites);
			for (Object object : siteAry) {
				JSONObject obj = JSONObject.parseObject(object+"");
				Long quantity = 0L;
				HallModel hallModel = this.hotelPlaceService.getHall(obj.getLong("placeId"));
				OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", obj.getLong("placeId"), hallModel.getPlaceName(), obj.getString("ismain")
						,obj.getDouble("amount"), quantity,obj.getDouble("commissionFeeRate"), new Date(), "");
				orderDetail = this.orderDetailDao.save(orderDetail);
				String siteSchedules =  obj.getString("siteSchedules");
				JSONArray siteScheduleAry = JSONObject.parseArray(siteSchedules);
				for (Object siteSchedule : siteScheduleAry) {
					JSONObject sobj = JSONObject.parseObject(siteSchedule+"");
					String scheduleTime = sobj.getString("placeSchedule");
					if("ALL".equals(scheduleTime)){
						List<HotelSchedule> hotelSchedules = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDate(order.getHotelId(), hallModel.getId(), sobj.getString("placeDate"));
						for (HotelSchedule hotelSchedule : hotelSchedules) {
							Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
							String hschdlTime = category.getName();
							if("2".equals(hotelSchedule.getState())){
								json.setJson(false, "非常抱歉；"+hotelSchedule.getHotelName()+hotelSchedule.getPlaceName()+"厅"+hotelSchedule.getPlaceDate()+hschdlTime+"档期已被预订，订单不能提交；请重新选择档期！",null,"10106");
								return json;
							}
							Double hallschedulePrice = Double.valueOf(sobj.getDouble("price"))/3;
							if(hschdlTime.equals("中午")){
								hallschedulePrice = 0D;
							}
							ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
									, hotelSchedule.getId(), sobj.getString("placeDate"), hschdlTime, hallschedulePrice,1L,order.getSourceAppId(), order.getOrderSource()
									, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
									, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
							this.scheduleBookingDao.save(scheduleBooking);
							hotelSchedule.setState("1");
							this.hotelScheduleDao.save(hotelSchedule);
						}
						
						quantity+=1;
					}else{
						HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(sobj.getLong("placeScheduleId"));
						if("2".equals(hotelSchedule.getState())){
							json.setJson(false, "非常抱歉；"+hotelSchedule.getHotelName()+hotelSchedule.getPlaceName()+"厅"+hotelSchedule.getPlaceDate()+sobj.getString("placeSchedule")+"档期已被预订，订单不能提交；请重新选择档期！",null,"10106");
							return json;
						}
						quantity+=1;
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
								, sobj.getLong("placeScheduleId"), sobj.getString("placeDate"), sobj.getString("placeSchedule"), sobj.getDouble("price"),1L,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
						hotelSchedule.setState("1");
						if(order.getSettlementStatus().equals("02")){
							scheduleBooking.setState("2");
							hotelSchedule.setState("2");
						}
						this.hotelScheduleDao.save(hotelSchedule);
						this.scheduleBookingDao.save(scheduleBooking);
					}
				}
				orderDetail.setQuantity(quantity);
				this.orderDetailDao.save(orderDetail);
			}
		}
		
		if(StringUtils.isNotBlank(rooms)){
			JSONArray roomAry = JSONObject.parseArray(rooms);
			for (Object object : roomAry) {
				JSONObject obj = JSONObject.parseObject(object+"");
				Long quantity = 0L;
				RoomModel room = this.hotelPlaceService.getRoom( obj.getLong("placeId"));
				OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "02", obj.getLong("placeId"), room.getPlaceName(), ""
						,obj.getDouble("amount"), obj.getLong("quantity"),0.0D, new Date(), "");
				orderDetail = this.orderDetailDao.save(orderDetail);
				String roomSchedules =  obj.getString("roomSchedules");
				JSONArray roomScheduleAry = JSONObject.parseArray(roomSchedules);
				for (Object roomSchedule : roomScheduleAry) {
					JSONObject sobj = JSONObject.parseObject(roomSchedule+"");
					quantity+=sobj.getLong("quantity");
					ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "02", orderDetail.getPlaceId()
							,null, sobj.getString("placeDate"), "", sobj.getDouble("price"),sobj.getLong("quantity"),order.getSourceAppId(), order.getOrderSource()
							, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
							, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),sobj.getString("breakfast"),"",0L);
					this.scheduleBookingDao.save(scheduleBooking);
				}
				orderDetail.setQuantity(quantity);
				this.orderDetailDao.save(orderDetail);
			}
		}
		
		if(StringUtils.isNotBlank(meals)){
			JSONArray mealAry = JSONObject.parseArray(meals);
			for (Object object : mealAry) {
				JSONObject obj = JSONObject.parseObject(object+"");
				Long quantity = 0L;
				HotelMenu hotelMenu = this.hotelMenuService.getEntity(obj.getLong("placeId"));
				OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "03", obj.getLong("placeId"), hotelMenu.getName(), ""
						,obj.getDouble("amount"), obj.getLong("quantity"),0.0D, new Date(), "");
				orderDetail = this.orderDetailDao.save(orderDetail);
				String mealSchedules =  obj.getString("mealSchedules");
				JSONArray mealScheduleAry = JSONObject.parseArray(mealSchedules);
				for (Object mealSchedule : mealScheduleAry) {
					JSONObject sobj = JSONObject.parseObject(mealSchedule+"");
					quantity+=sobj.getLong("quantity");
					ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "03", orderDetail.getPlaceId()
							,null, sobj.getString("placeDate"), sobj.getString("placeSchedule"), sobj.getDouble("price"), sobj.getLong("quantity"),order.getSourceAppId(), order.getOrderSource()
							, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
							, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"",sobj.getString("mealType"),10L);
					this.scheduleBookingDao.save(scheduleBooking);
				}
				orderDetail.setQuantity(quantity);
				this.orderDetailDao.save(orderDetail);
			}
		}
		
		if(StringUtils.isNotBlank(others)){
			//TODO 其他消费 完善
		}
		orderDao.save(order);
		json.setJson(true, "订单提交成功！");
		return json;
	}
	/**
	 * 订单状态改变方法
	 * @param sourceAppId
	 * @param orderNo
	 * @param action
	 * @param reason
	 * @param memo
	 * @param opuid
	 * @return
	 */
	@Transactional(readOnly = false)
	public Json changeOrderStateForApi(Long sourceAppId,String orderNo,String clientId, String action,String day,String reason,String memo,Double prepaid) {
		Json json = new Json();
		Order order = this.orderDao.findByOrderNoAndSourceAppId(orderNo, sourceAppId);
		
		if(order==null){
			json.setJson(false, "订单不存在！", null, "10105");
			return json;
		}
		User sale = this.userService.getEntity(order.getHotelSaleId());
		if("PAY".equals(action)){
			if(order.getState().compareTo("05")<0){
				order.setSettlementStatus("02");
				order.setPayDate(new Date());
				order.setPrepaid(prepaid);
				order.setState("04");
				List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientIdAndType(order.getHotelId(), orderNo, order.getClientId(), "01"); 
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(scheduleBooking.getPlaceScheduleId());
					hotelSchedule.setState("2");
					hotelScheduleDao.save(hotelSchedule);
				}
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("2");//支付订金
					this.scheduleBookingDao.save(scheduleBooking);
				}
				this.orderDao.save(order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已提交订金！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已提交订金！", sale.getMobile());//【会掌柜】
				json.setJson(true, "操作成功！",order);
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=PAYSUCCESS";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("CANCEL".equals(action)){//取消订单
			if(order.getState().compareTo("05")<=0){
				if(order.getSettlementStatus().equals("01")){
					List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
					for (ScheduleBooking scheduleBooking : bookings) {
						scheduleBooking.setState("4");//取消
						this.scheduleBookingDao.save(scheduleBooking);
					}
					order.setCancelDate(new Date());
					order.setCancelMemo(memo);
					order.setCancelReason(reason);
					order.setState("10");
					this.orderDao.save(order);
					json.setJson(true, "操作成功！",order);
					chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已取消！", sale.getMobile());//【会掌柜】
				}else{
					return changeOrderStateForApi(sourceAppId,orderNo,clientId, "REFUNDED",day,reason,memo,null);
				}
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CANCEL";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("REFUNDING".equals(action)){//退款申请
			if(order.getState().compareTo("05")<0){
				order.setState("11");
				order.setRefundDate(new Date());
				order.setRefundMemo(memo);
				order.setRefundReason(reason);
				this.orderDao.save(order);
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已提交退款申请！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				chatRecordService.send("SYSTEM", "SYSTEM", "hotel_finance", "hotel_finance", "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已提交退款申请！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已提交退款申请！", sale.getMobile());//【会掌柜】
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=REFUNDINGSUCCESS";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("REFUNDED".equals(action)){//退款确认
			if(order.getState().compareTo("05")<=0||order.getState().equals("11")){
				List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientIdAndType(order.getHotelId(), orderNo, order.getClientId(), "01"); 
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(scheduleBooking.getPlaceScheduleId());
					hotelSchedule.setState("1");
					hotelScheduleDao.save(hotelSchedule);
				}
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("4");
					this.scheduleBookingDao.save(scheduleBooking);
				}
				order.setRefundDate(new Date());
				order.setRefundMemo(memo);
				order.setRefundReason(reason);
				order.setState("12");
				this.orderDao.save(order);
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已退款成功！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=REFUNDEDSUCCESS";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("WAIT".equals(action)){
			if(order.getState().equals("03")){
				order.setState("01");
				order.setCreateDate(new Date());
				this.orderDao.save(order);
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("1");//支付订金
					this.scheduleBookingDao.save(scheduleBooking);
				}
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已标记为待受理状态，请尽快进行受理操作！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已标记为待受理状态，请尽快进行受理操作！", sale.getMobile());//【会掌柜】
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=WAITSUCCESS";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("FAIL".equals(action)){
			if(order.getState().compareTo("01")>0&&order.getState().compareTo("05")<0){
				order.setState("05");
				order.setCancelDate(new Date());
				order.setCancelMemo("订单失败！");
				order.setCancelReason(reason);
				this.orderDao.save(order);
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已标记失败！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已标记失败！", sale.getMobile());//【会掌柜】
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CLOSESUCCESS";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("QUOTATION".equals(action)){//quotation  确认报价
			if("02".equals(order.getState())){
				order.setState("021");
				order.setConfirmQuotationDate(new Date());
				order.setConfirmQuotationUser(order.getClientId());
				this.orderDao.save(order);
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已确认报价！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已确认报价！", sale.getMobile());//【会掌柜】
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=QUOTATION";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else if("UPDATE".equals(action)){//申请修改报价
			if(order.getState().compareTo("02")>0){
				order.setState("02");
				this.orderDao.save(order);
				json.setJson(true, "操作成功！",order);
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已申请修改报价！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已申请修改报价！", sale.getMobile());//【会掌柜】
			}else{
				json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}else{
			json.setJson(false, "操作类型错误，该订单无法操作！", null, "10106");
		}
		return json;
	}
	@Transactional(readOnly = false)
	public Json orderEvaluate(String orderNo, Evaluate evaluate,Long sourceAppId) {
		Json json = new Json();
		Order order = this.orderDao.findByOrderNoAndSourceAppId(orderNo, sourceAppId);
		if(order.getState().equals("7")){
			evaluateDao.save(evaluate);
			order.setState("8");
			this.orderDao.save(order);
			json.setJson(true, "操作成功！");
		}else{
			json.setJson(false, "该订单前置状态错误，该订单无法操作！", null, "10104");
		}
		return json;
	}

	public Order findByOrderNo(String orderNo,Long sourceAppId) {
		return this.orderDao.findByOrderNoAndSourceAppId(orderNo, sourceAppId);
	}
	
	public Order findByOrderNo(String orderNo) {
		return this.orderDao.findByOrderNo(orderNo);
	}

	public String getStateTxt(Order order, Map<String, Object> res) {
		String txt = "";
		if(res==null){
			res = Maps.newHashMap();
		}
		switch (Integer.valueOf(order.getState())) {
		case 1:
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已提交，等待酒店销售处理！");
			txt = "等待酒店销售处理";
			break;
		case 2://处理中
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "酒店销售已接受！");
			txt = "处理中";
			break;
		case 3://无处理
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "酒店销售无处理！");
			txt = "无处理";
			break;
		case 4://进行中
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已达成！");
			txt = "进行中";
			break;
		case 5://失败
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单无法达成，已失败！");
			txt = "已失败";
			break;
		case 6://订单完成
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已完成！");
			txt = "已完成";
			break;
		case 7://订单已评价
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已评价！");
			txt = "已评价";
			break;
		case 10://取消订单
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已取消！");
			txt = "已取消";
			break;
		case 11://退款，待退款
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单待退款！");
			txt = "待退款";
			break;
		case 12://退款
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已退款！");
			txt = "已退款";
			break;
		case 13://关闭订单
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "订单已关闭！");
			txt = "已关闭";
			break;
		case 21://关闭订单
			res.put("orderNo", order.getOrderNo());
			res.put("state", order.getState());
			res.put("msg", "客户确认报价！");
			txt = "确认报价";
			break;
		default:
			break;
		}
		
		return txt;
		
	}
	public String getStateTxt(String state) {
		String txt = "";
		switch (Integer.valueOf(state)) {
		case 1:
			txt = "待处理";
			break;
		case 2://处理中
			txt = "处理中";
			break;
		case 3://无处理
			txt = "无处理";
			break;
		case 4://进行中
			txt = "进行中";
			break;
		case 5://失败
			txt = "已过期";
			break;
		case 6://订单完成
			txt = "已完成";
			break;
		case 7://订单已评价
			txt = "已评价";
			break;
		case 10://取消订单
			txt = "已取消";
			break;
		case 11://退款，待退款
			txt = "退款中";
			break;
		case 12://退款
			txt = "已退款";
			break;
		case 13://关闭订单
			txt = "已关闭";
			break;
		case 21://关闭订单
			txt = "客户确认";
			break;
		default:
			txt = state;
			break;
		}
		return txt;
	}
	
	public String getSettlementStatusTxt(String state) {
		String txt = "";
		if(StringUtils.isBlank(state)||"null".equals(state)){
			return "";
		}
		switch (Integer.valueOf(state)) {
		case 1:
			txt = "未付款";
			break;
		case 2://已支付订金
			txt = "已付订金";
			break;
		case 3://待结算
			txt = "待结算";
			break;
		case 4://已结算中
			txt = "已结算";
			break;
		case 5://挂帐
			txt = "挂帐";
			break;
		case 6://挂帐
			txt = "已退款";
			break;
		default:
			txt = state;
			break;
		}
		return txt;
	}
	public String getCommissionStatusTxt(String state) {
		String txt = "";
		switch (Integer.valueOf(state)) {
		case 0:
			txt = "未返佣";
			break;
		case 1:
			txt = "待返佣";
			break;
		case 2:
			txt = "已对账";
			break;
		case 3:
			txt = "已开票";
			break;
		case 4:
			txt = "已领票";
			break;
		case 5:
			txt = "已收票";
			break;
		case 6:
			txt = "已付款";
			break;
		case 7:
			txt = "已收款";
			break;
		default:
			txt = "其他";
			break;
		}
		return txt;
	}
	public List<OrderModel> getOrderPageList(PageBean<OrderModel> pageBean) {
		String columstr ="o.id as id, o.order_no as orderNo, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, htlu.rname as hotelSaleName, htlu.mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commission_fee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.email as email, o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, hu.rname as companySaleName, hu.mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo, o.zgdiscount as zgdiscount";
		String fromWhere = " from hui_order o left join hui_user htlu on htlu.id = o.hotel_sale_id left join hui_user hu on hu.id = o.company_sale_id  where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, OrderModel.class,null);
	} 
	
	public List<Order> getPageList(PageBean<Order> pageBean) {
		
		String columstr =DynamicSqlHelper.getMappingColumnStr("o.", Order.class);
		columstr = columstr.replace(",o.hotel_name hotelName", ",h.hotel_name hotelName");
		String fromWhere = " from hui_order o left join hui_hotel h on h.id=o.hotel_id where 1=1 ";
		return cusQueryService.page(pageBean, columstr+fromWhere, Order.class,null);
	} 

	public List<OrderModel> getAllOrder(PageBean<OrderModel> pageBean) {
		String columstr ="o.id as id, o.order_no as orderNo, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, htlu.rname as hotelSaleName, htlu.mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commission_fee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.email as email, o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, hu.rname as companySaleName, hu.mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo, o.zgdiscount as zgdiscount";
		String fromWhere = " from hui_order o left join hui_hotel h on h.id = o.hotel_id "
				+ " left join hui_user htlu on htlu.id = o.hotel_sale_id left join hui_user hu on hu.id = o.company_sale_id  "
				+ " where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, OrderModel.class, null);
	}
	
	
	public List<OrderModel> getCommissionOrder(int day) {
		PageBean<OrderModel> pageBean = new PageBean<>();
		String columstr ="o.id as id, o.order_no as orderNo, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, htlu.rname as hotelSaleName, htlu.mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commission_fee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.email as email, o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, hu.rname as companySaleName, hu.mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo, o.zgdiscount as zgdiscount";
		String fromWhere = " from hui_order o left join hui_hotel h on h.id = o.hotel_id "
				+ " left join hui_user htlu on htlu.id = o.hotel_sale_id left join hui_user hu on hu.id = o.company_sale_id"
				+ " where 1=1 and o.commission_status = '01' and DATEDIFF(now(), o.confirm_date)>="+day;
		return customPageService.getAll(pageBean, columstr, fromWhere, OrderModel.class, null);
	}
	
	public OrderModel getOrder(String orderNo,String clientId) {
		String columstr ="o.id as id, o.order_no as orderNo, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, htlu.rname as hotelSaleName, htlu.mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commission_fee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.email as email, o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, hu.rname as companySaleName, hu.mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo, o.zgdiscount as zgdiscount";
		String fromWhere = " from hui_order o left join hui_user htlu on htlu.id = o.hotel_sale_id left join hui_user hu on hu.id = o.company_sale_id"
				+ " where 1=1 and o.order_no='"+orderNo+"' and o.client_id ='"+clientId+"'";
		return customPageService.getOne(columstr, fromWhere, OrderModel.class);
	}
	public OrderModel getOrder(Long id) {
		String columstr ="o.id as id, o.order_no as orderNo, o.area as area, o.hotel_id as hotelId"
				+ ", o.hotel_name as hotelName, o.hotel_sale_id as hotelSaleId, htlu.rname as hotelSaleName, htlu.mobile as hotelSaleMobile"
				+ ", o.amount as amount, o.zgamount as zgamount, o.prepaid as prepaid, o.final_payment as finalPayment, o.site_amount as siteAmount"
				+ ", o.site_commission_fee as siteCommissionFee, o.room_amount as roomAmount, o.dining_amount as diningAmount, o.client_id as clientId"
				+ ", o.activity_date as activityDate, o.activity_title as activityTitle, o.organizer as organizer, o.linkman as linkman, o.contact_number as contactNumber"
				+ ", o.email as email, o.client_points as clientPoints, o.state as state, o.settlement_status as settlementStatus, o.settlement_date as settlementDate"
				+ ", o.settlement_uid as settlementUid, o.company_sale_id as companySaleId, hu.rname as companySaleName, hu.mobile as companySaleMobile"
				+ ", o.create_date as createDate, o.pay_type as payType, o.pay_date as payDate, o.refund_date as refundDate, o.refund_reason as refundReason"
				+ ", o.refund_memo as refundMemo, o.cancel_date as cancelDate, o.cancel_reason as cancelReason, o.cancel_memo as cancelMemo, o.memo as memo, o.zgdiscount as zgdiscount";
		String fromWhere = " from hui_order o left join hui_user htlu on htlu.id = o.hotel_sale_id left join hui_user hu on hu.id = o.company_sale_id"
				+ " where 1=1 and o.id="+id;
		return customPageService.getOne(columstr, fromWhere, OrderModel.class);
	}
	@Transactional(readOnly=false)
	public JsonVo accept(Long id) {
		Order order = this.getEntity(id);
		if("01".equals(order.getState())||"04".equals(order.getState())){
			order.setState("02");
			this.saveOrder(order);
			try{
				//TODO 发消息给会员顾客
				//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				//"【会掌柜】"+
				/*String content = order.getLinkman()+"您好，您的订单【"+order.getOrderNo()+"】已被酒店销售"+order.getHotelSaleName()+"受理，酒店销售会尽快和您联系的，谢谢！";
				CallUtil.sendmsg(content, order.getContactNumber());*/
				
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
			}catch (Exception e) {
			}
			
			return JsonUtils.success("订单已受理！");
		}else{
			return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
		}
		
		
	}
	
	@Transactional(readOnly=false)
	public Json saveOrderPrice(HttpServletRequest request, Long id, String orderNo) {
		Json json = new Json();
		Order order = this.getEntity(id);
		
		if(!order.getOrderNo().equals(orderNo)){
			json.setJson(false, "订单信息错误！");
			return json;
		}
		if(!order.getState().equals("02")){
			json.setJson(false, "订单状态错误！"+getStateTxt(order, null)+"订单不可修改价格！");
			return json;
		}
		Double commissionFeeRate = Double.valueOf(request.getParameter("commissionFeeRate"));
		Double amount = 0D;  
		Double zgamount = 0D;
		Double siteAmount = 0D;
		Double siteCommissionFee = 0D;
		Double roomAmount = 0D;
		Double diningAmount = 0D;
		
		List<OrderDetail> details = this.orderDetailDao.findByOrderNo(orderNo);
		for (OrderDetail orderDetail : details) {
			List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByorderDetailIdAndType(orderDetail.getId(), orderDetail.getType());
			if("01".equals(orderDetail.getType())){
				Double oamount=0D;
				Long quantity = 0L;
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					quantity+=1;
					oamount +=Double.valueOf(request.getParameter("placePrice"+scheduleBooking.getId())); 
					scheduleBooking.setQuantity(1L);
					scheduleBooking.setPrice(Double.valueOf(request.getParameter("placePrice"+scheduleBooking.getId())));
					this.scheduleBookingDao.save(scheduleBooking);
				}
				orderDetail.setAmount(oamount);
				orderDetail.setQuantity(quantity);
				orderDetail.setCommissionFeeRate(commissionFeeRate);
				this.orderDetailDao.save(orderDetail);
				siteCommissionFee+=oamount*commissionFeeRate/100;
				siteAmount+=oamount;
				amount+=oamount+oamount*commissionFeeRate/100;
				
				continue;
			}else if("02".equals(orderDetail.getType())){
				Double oamount=0D;
				Long quantity = 0L;
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					quantity+=Long.valueOf(request.getParameter("roomQuantity"+scheduleBooking.getId()));
					oamount +=Double.valueOf(request.getParameter("roomPrice"+scheduleBooking.getId()))*Long.valueOf(request.getParameter("roomQuantity"+scheduleBooking.getId()));
					scheduleBooking.setQuantity(Long.valueOf(request.getParameter("roomQuantity"+scheduleBooking.getId())));
					scheduleBooking.setPrice(Double.valueOf(request.getParameter("roomPrice"+scheduleBooking.getId())));
					scheduleBooking.setBreakfast(request.getParameter("roomBreakfast"+scheduleBooking.getId()));
					this.scheduleBookingDao.save(scheduleBooking);
				}
				orderDetail.setAmount(oamount);
				orderDetail.setQuantity(quantity);
				this.orderDetailDao.save(orderDetail);
				roomAmount+=oamount;
				amount+=oamount;
				continue;
			}else if("03".equals(orderDetail.getType())){
				Double oamount=0D;
				Long quantity = 0L;
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					quantity+=Long.valueOf(request.getParameter("mealQuantity"+scheduleBooking.getId()));
					oamount +=Double.valueOf(request.getParameter("mealPrice"+scheduleBooking.getId()))*Long.valueOf(request.getParameter("mealQuantity"+scheduleBooking.getId()));
					scheduleBooking.setQuantity(Long.valueOf(request.getParameter("mealQuantity"+scheduleBooking.getId())));
					scheduleBooking.setPrice(Double.valueOf(request.getParameter("mealPrice"+scheduleBooking.getId())));
					scheduleBooking.setMealnum(Long.valueOf(request.getParameter("mealnum"+scheduleBooking.getId())));
					scheduleBooking.setMealType(request.getParameter("mealType"+scheduleBooking.getId()));
					scheduleBooking.setPlaceSchedule(request.getParameter("mealscheduleTime"+scheduleBooking.getId()));
					this.scheduleBookingDao.save(scheduleBooking);
				}
				orderDetail.setAmount(oamount);
				orderDetail.setQuantity(quantity);
				this.orderDetailDao.save(orderDetail);
				diningAmount+=oamount;
				amount+=oamount;
				continue;
			}
		}
		
		zgamount = amount*order.getZgdiscount()/100;
		
		/*System.out.println("****amount>>>"+amount);
		System.out.println("****roomAmount>>>"+roomAmount);
		System.out.println("****siteAmount>>>"+siteAmount);
		System.out.println("****diningAmount>>>"+diningAmount);
		System.out.println("****siteCommissionFee>>>"+siteCommissionFee);*/
	
		
		order.setAmount(amount);
		order.setZgamount(zgamount);
		order.setSiteAmount(siteAmount);
		order.setRoomAmount(roomAmount);
		order.setDiningAmount(diningAmount);
		order.setSiteCommissionFee(siteCommissionFee);
		this.orderDao.save(order);
		json.setJson(true, "修改成功");
		return json;
	}

	public Map<String, Object> count(Map<String, Object> filterParams) {
		Map<String, Object> res = Maps.newHashMap();
		String nnq = "select sum(case when settlement_status ='04' and (o.state='06' or o.state = '07') then amount else 0 end) settlement";
		nnq += ",sum(case when settlement_status ='03' and (o.state='01' or o.state = '02' or o.state = '04') then amount else 0 end) unsettlement";
		nnq += ",sum(case when settlement_status ='02' and (o.state='01' or o.state = '02' or o.state = '04') then amount else 0 end) deposit";
		nnq += ",sum(case when commission_status >='02' and isinvoice='1' and (o.state='04' or o.state='06' or o.state = '07') then amount else 0 end) invoice";
		nnq += ",sum(case when commission_status >='02' and (o.state='04' or o.state='06' or o.state = '07') then amount else 0 end) comission";
		nnq += ",sum(case when commission_status ='01' and (o.state='04' or o.state='06' or o.state = '07') then amount else 0 end) uncomission";
		nnq += " from hui_order o left join hui_hotel h on o.hotel_id = h.id where 1=1 ";
		if(filterParams.get("reclaim_user_id")!=null&&StringUtils.isNotBlank(filterParams.get("reclaim_user_id").toString())){
			nnq += " and o.company_sale_id = '"+filterParams.get("reclaim_user_id")+"'";
		}
		List<Object> list = this.orderDao.executeNativeQuery(nnq, null);
		if(list!=null&&list.size()>0 && list.get(0)!=null){
			Object [] o = (Object[]) list.get(0);
			Double settlement = o[0]==null?0.0D:Double.valueOf(o[0].toString());
			Double unsettlement = o[1]==null?0.0D:Double.valueOf(o[1].toString());
			Double deposit = o[2]==null?0.0D:Double.valueOf(o[2].toString());
			Double invoice = o[3]==null?0.0D:Double.valueOf(o[3].toString());
			Double comission =o[4]==null?0.0D: Double.valueOf(o[4].toString());
			Double uncomission =o[5]==null?0.0D: Double.valueOf(o[5].toString());
			res.put("settlement", settlement>100000?(settlement/10000)+"万元":settlement+"元");
			res.put("unsettlement",unsettlement>100000?(unsettlement/10000)+"万元":unsettlement+"元");
			res.put("deposit", deposit>100000?(deposit/10000)+"万元":deposit+"元");
			res.put("invoice",invoice>100000?(invoice/10000)+"万元":invoice+"元");
			res.put("comission",comission>100000?(comission/10000)+"万元":comission+"元");
			res.put("uncomission",uncomission>100000?(uncomission/10000)+"万元":uncomission+"元");
		}
		return res;
	}
	public Map<String, Object> countComission(Map<String, Object> filterParams) {
		Map<String, Object> res = Maps.newHashMap();
		String nnq = "select sum(amount) settlement";
		nnq += ",sum( commission_amount) comission";
		nnq += " from hui_order o left join hui_hotel h on o.hotel_id = h.id where 1=1 and o.commission_status='07'";
		if(filterParams.get("reclaim_user_id")!=null&&StringUtils.isNotBlank(filterParams.get("reclaim_user_id").toString())){
			nnq += " and h.reclaim_user_id = '"+filterParams.get("reclaim_user_id")+"'";
		}
		List<Object> list = this.orderDao.executeNativeQuery(nnq, null);
		if(list!=null&&list.size()>0 && list.get(0)!=null){
			Object [] o = (Object[]) list.get(0);
			Double settlement = o[0]==null?0.0D:Double.valueOf(o[0].toString());
			Double comission =o[1]==null?0.0D: Double.valueOf(o[1].toString());
			res.put("settlement", settlement>100000?(settlement/10000)+"万元":settlement+"元");
			res.put("comission",comission>100000?(comission/10000)+"万元":comission+"元");
		}
		return res;
	}
	
	
	@Transactional(readOnly=false)
	public JsonVo invoiceGet(Long id) {
		try {
			Order order = this.getEntity(id);
			order.setReceiveDate(new Date());
			order.setCommissionStatus("04");
			this.orderDao.save(order);
			ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
			comissionRecord.setState("04");
			comissionRecordDao.save(comissionRecord);
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());//hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+
				String ptext = "会掌柜销售"+ AccountUtils.getCurrentRName()+"已领取" + hotel.getHotelName()+"的订单【"+order.getOrderNo()+"】的返佣发票！";
				chatRecordService.log("LOG", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
				ptext+="请留意发票的送达！";
				chatRecordService.send("SYSTEM", "SYSTEM", "hotel_finance", "hotel_finance", "SYSTEMMSG", "订单返佣通知", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
		} catch (Exception e) {
			JsonUtils.error("领取发票确认失败！");
		}
		
		return JsonUtils.success("领取发票成功！");
	}
	
	/**
	 * 线下活动录入
	 * @param request
	 * @param chkhallid
	 * @param chkroomid
	 * @param chkmealids
	 * @param activityTitle
	 * @param activityDate
	 * @param organizer
	 * @param linkman
	 * @param contactNumber
	 * @param hotelId
	 * @param serviceFee
	 * @return
	 */
	@Transactional(readOnly=false)
	public JsonVo save(HttpServletRequest request, String chkhallid, String chkroomid, String chkmealids,
			String activityTitle, String activityDate, String organizer, String linkman, String contactNumber,
			String email, Long hotelId, Double commissionFeeRate,String ismain,String otherdetail,String otherprice
			,String meetingRemark,String houseRemark,String dinnerRemark,String memo,String oprice,String oquantity,Double mealServiceFeeRate) {
		try {
			
			String orderNo = RandomStringUtil.getOrderNo(6);
			String orderType = "OFFLINE";
			
			Double amount = 0D;
			Double zgamount= 0D;
			
			Double prepaid = 0D;
			Double finalPayment= 0D;
			
			Double siteAmount= 0D;
			Double siteCommissionFee= 0D;
			Double roomAmount= 0D;
			Double diningAmount= 0D;
			Double otherAmount = 0D;
			HotelModel hotelModel = this.hotelService.getHotel(hotelId);
			HotelCooperationInfo  hotelCooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotelId);
			if(hotelCooperationInfo==null){
				return JsonUtils.error("很抱歉，该酒店暂时没有填写相关的合作信息，不能下单！");
			}
			SalerModel hotelSale = this.userService.getRamdomSale(hotelId);
			if(hotelSale==null){
				return JsonUtils.error("很抱歉，该酒店暂时没有对应的销售人员，不能下单！");
			}
			Order order = new Order(orderNo, orderType, 1L, "会掌柜", hotelModel.getCityText(), hotelId, hotelModel.getHotelName(), hotelModel.getpName(), hotelCooperationInfo.getCommissionRights()
					, hotelSale.getId(), hotelSale.getRname(), hotelSale.getMobile(), 0d, amount, zgamount, prepaid, finalPayment, siteAmount, siteCommissionFee, roomAmount, diningAmount,otherAmount
					, "", activityDate, activityTitle, organizer, linkman, contactNumber, "01", "00", new Date(), "");
			order.setCompanySaleId(AccountUtils.getCurrentUserId());
			order.setCompanySaleName(AccountUtils.getCurrentRName());
			order.setCompanySaleMobile(AccountUtils.getCurrentUser().getMobile());
			order.setZgdiscount(100D);
			order.setSettlementStatus("01");
			order.setOfflineState("1");
			order.setEmail(email);
			
			order.setMemo(memo);
			//order = this.orderDao.save(order);
			
			if(StringUtils.isNotBlank(chkhallid)){
				order.setMeetingRemark(meetingRemark);
				String [] hallids = chkhallid.split(",");
				
				for (String hid : hallids) {
					HallModel hallModel = this.hotelPlaceService.getHall(Long.valueOf(hid));
					String  main = "0";
					if(ismain.equals(hid)){
						main = "1";
					}
					Double damount = 0.0D;	
					Long quantity = 0L;
				
					
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hallModel.getId(), hallModel.getPlaceName(),main ,damount, quantity,commissionFeeRate, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);

					String hallSchedules[] = request.getParameterValues("hallschedule"+hid);
					String schAmounts[] = request.getParameterValues("placePrice_"+hid);
					String placeDates[] = request.getParameterValues("scheduleDate_"+hid);
					for (int n=0,len=placeDates.length;n<len;n++) {
						String placeDate = placeDates[n];
						Double pamount = Double.valueOf(schAmounts[n]);
						String scheduleTime[] = hallSchedules[n].split("#");
						Double uprice =pamount/scheduleTime.length;
						for (String  schTime : scheduleTime) {
							HotelSchedule hotelSchedule =this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(hotelId, Long.valueOf(hid), placeDate,  schTime);
							Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
							String hschdlTime = category.getName();
							if("2".equals(hotelSchedule.getState())){
								return JsonUtils.error("非常抱歉；"+hotelSchedule.getHotelName()+hotelSchedule.getPlaceName()+"厅"+hotelSchedule.getPlaceDate()+hschdlTime+"档期已被预订，订单不能提交；请重新选择档期！");
							}
							quantity+=1;
							ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
									, hotelSchedule.getId(), placeDate, hschdlTime, uprice,1L,order.getSourceAppId(), order.getOrderSource()
									, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
									, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
							this.scheduleBookingDao.save(scheduleBooking);
							hotelSchedule.setState("1");
							this.hotelScheduleDao.save(hotelSchedule);
						}
						
						damount += pamount;
					}
					siteAmount+=damount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(damount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			if(StringUtils.isNotBlank(chkroomid)){
				order.setHouseRemark(houseRemark);
				String [] roomids = chkroomid.split(",");
				for (String rid : roomids) {
					RoomModel roomModel = this.hotelPlaceService.getRoom(Long.valueOf(rid));
					Long quantity = 0L;
					Double ramount = 0.0D;	
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "02",roomModel.getId(), roomModel.getPlaceName(), "",ramount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					this.orderDetailDao.save(orderDetail);
					
					String roomNums[] =  request.getParameterValues("rom_num_"+rid);
					String roomPrices[] =  request.getParameterValues("roomPrice_"+rid);
					String roomScheduleDates[] = request.getParameterValues("roomscheduleDate_"+rid);
					String roomBreakfasts[] = request.getParameterValues("breakfast_"+rid);
					for (int i = 0,len = roomScheduleDates.length; i < len; i++) {
						
						Long num = Long.valueOf(roomNums[i]);
						Double price = Double.valueOf(roomPrices[i]);
						String roomScheduleDate = roomScheduleDates[i];
						String roomBreakfast = roomBreakfasts[i];
						
						quantity+=num;
						ramount+=price*num;
						
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "02", orderDetail.getPlaceId()
								,null, roomScheduleDate, "", price,num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),roomBreakfast,"",0L);
						this.scheduleBookingDao.save(scheduleBooking);
					}
					roomAmount+=ramount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(ramount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			if(StringUtils.isNotBlank(chkmealids)){
				order.setDinnerRemark(dinnerRemark);
				String [] mealids = chkmealids.split(",");
				for (String mid : mealids) {
					HotelMenu hotelMenu = this.hotelMenuService.getEntity(Long.valueOf(mid));
					Long quantity = 0L;
					Double mamount = 0D;
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "03", hotelMenu.getId(),hotelMenu.getName(), ""
							,mamount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					
					
					String mealNums[] =  request.getParameterValues("meal_num_"+mid);
					String mealPrices[] =  request.getParameterValues("mealPrice_"+mid);
					String mealScheduleDates[] = request.getParameterValues("mealscheduleDate_"+mid);
					String mealScheduleTimes[] = request.getParameterValues("mealscheduleTime_"+mid);
					String mealTypes[] = request.getParameterValues("mealType_"+mid);
					
					for (int i = 0,len = mealScheduleDates.length; i < len; i++) {
						String mealScheduleDate = mealScheduleDates[i];
						String mealScheduleTime = mealScheduleTimes[i];
						String type = mealTypes[i];
						Long num = Long.valueOf(mealNums[i]);
						Double price = Double.valueOf(mealPrices[i]);
						
						quantity+=num;
						mamount+=price*num;
						
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "03", orderDetail.getPlaceId()
								,null, mealScheduleDate, mealScheduleTime
								, price, num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", type,order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"",type,10L);
						this.scheduleBookingDao.save(scheduleBooking);
					}
					diningAmount+=mamount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(mamount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(otherdetail)){
				String [] odetails = otherdetail.split(",");
				String [] oprices = otherprice.split(",");
				String [] ounitprices = oprice.split(",");
				String [] oquantitys = oquantity.split(",");
				for (int i=0;i<odetails.length;i++) {
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "09",null,odetails[i], ""
							,Long.valueOf(oquantitys[i])*Double.valueOf(ounitprices[i]), Long.valueOf(oquantitys[i]),0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					otherAmount+=Long.valueOf(oquantitys[i])*Double.valueOf(ounitprices[i]);
				}
			}
					
			siteCommissionFee = siteAmount*commissionFeeRate/100;
			Double mealServiceFee = diningAmount*mealServiceFeeRate/100;
			amount = siteAmount+roomAmount+diningAmount+mealServiceFee+siteCommissionFee+otherAmount;
			zgamount = amount;
			finalPayment = amount;
			
			order.setAmount(amount);
			order.setZgamount(zgamount);
			
			order.setSiteCommissionFee(siteCommissionFee);
			order.setSiteAmount(siteAmount);
			order.setRoomAmount(roomAmount);
			order.setDiningAmount(diningAmount);
			order.setOtherAmount(otherAmount);
			
			order.setMealServiceFee(mealServiceFee);
			order.setMealServiceFeeRate(mealServiceFeeRate);
			order.setSiteCommissionFeeRate(commissionFeeRate);
			order = this.orderDao.save(order);
			try{
				String title = "订单通知";
				String ptext = "你收到新的订单【"+order.getOrderNo()+"】，请及时处理！";
				chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				String url = Constant.DOMAIN+"/base/order/pdf/detail/"+order.getId();
				String tinyurl = HttpUtils.getC7ggDWZ(url);
				ptext += "点击链接查看详情："+tinyurl;
				CallUtil.sendmsg(ptext, hotelSale.getMobile());
				String tplPath = PdfHelper.getTplPath();
				SendEmailThread emailThread = new SendEmailThread(order.getId(), order.getOrderNo(), hotelSale.getEmail(), tplPath, title);
				emailThread.start();
			}catch(Exception e){}
			
			return JsonUtils.success("提交成功！",order.getId());
			
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
	}
	
	@Transactional(readOnly=false)
	public JsonVo changeState(Long id, Integer tostate,String cancelReason,Double prepay, Double ramount, Double pamount) {
		try{
			switch (tostate) {
			case 0:
				return this.cancel(id,cancelReason,"",ramount);
			case 1:
				return this.accept(id);
			case 2:
				//prepay
				return this.prepay(id,prepay);
			case 3:
				return this.signup(id);
			case 4:
				return this.finshed(id);
			case 5:
				return this.settlemented(id,pamount);
			case 7:
				return this.payed(id,pamount,"PAY");
			default:
				return JsonUtils.error("订单修改状态错误！");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return JsonUtils.error("订单状态修改失败！");
		}
	}
	
	/**
	 * 订单付款
	 * @param id
	 * @param pamount
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo payed(Long id, Double pamount,String type) {
		try {
			Order order = this.getEntity(id);
			if(order.getFinalPayment()!=null&&order.getFinalPayment().compareTo(pamount)>0){
				order.setFinalPayment(order.getFinalPayment()-pamount);
			}else{
				order.setFinalPayment(order.getAmount()-pamount);
			}
			if(order.getSettlementAmount()!=null){
				order.setSettlementAmount(order.getSettlementAmount()+pamount);
			}else{
				order.setSettlementAmount(pamount);
			}
			OrderPayedRecord orderPayedRecord = new OrderPayedRecord(order.getHotelId(), order.getId(), type, order.getAmount(), pamount, order.getFinalPayment()
					, order.getSettlementAmount(), new Date(), AccountUtils.getCurrentUserId(), new Date(), ""); 
			this.orderPayedRecordDao.save(orderPayedRecord);
			return JsonUtils.success("付款成功");
		} catch (Exception e) {
			e.printStackTrace();
			return JsonUtils.error("系统错误");
		}
		
	}

	/**
	 * 已收款。。。
	 * @param id
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo settlemented(Long id, Double pamount) {
		Order order = this.getEntity(id);
		HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(order.getHotelId());
		//if(order.getState().equals("04")){
		String state = order.getState().compareTo("06")>0?order.getState():"06";
		order.setState(state);
		order.setConfirmDate(new Date());
		Double pointrate = cooperationInfo.getPointsRate()==null?0D:cooperationInfo.getPointsRate();
		Double hotelPoint = order.getAmount()*pointrate/100;
		order.setHotelPoints(hotelPoint);
		
		Double clientPoint = order.getAmount()*pointrate/100;
		order.setClientPoints(clientPoint);
		
		PointsAccount pointsAccount = this.pointsAccountService.findByClientTypeAndClientId("HOTEL", order.getHotelId()+"");
		pointsAccount.setBalancePoints(pointsAccount.getBalancePoints()+hotelPoint);
		pointsAccount.setTotalPoints(pointsAccount.getTotalPoints()+hotelPoint);
		pointsAccountDao.save(pointsAccount);
		
		if("00".equals(order.getCommissionStatus())){
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());

				Double housingCommission = 0D;
				Double dinnerCommission= 0D;
				Double mettingRoomCommission= 0D;
				Double ortherCommission= 0D;
				
				Double allCommission= 0D;
				Double commissionAmount= 0D;
				if(cooperationInfo.getCommissionType().equals("1")){//全单返
					allCommission = order.getZgamount()*cooperationInfo.getAllCommission()/100;
					commissionAmount = allCommission;
				}else if(cooperationInfo.getCommissionType().equals("2")){//分项返
					housingCommission = order.getRoomAmount()*cooperationInfo.getHousingCommission()/100;
					dinnerCommission = calculatedRoomCommission(order,cooperationInfo);// order.getDiningAmount()*cooperationInfo.getDinnerCommission()/100;
					mettingRoomCommission = order.getSiteAmount()*cooperationInfo.getMettingRoomCommission()/100;
					commissionAmount = housingCommission+dinnerCommission+mettingRoomCommission+ortherCommission;
				}else{
					return JsonUtils.error("该酒店尚未设置返佣类型！");
				}
				
				ComissionRecord comissionRecord = new ComissionRecord(hotel.getId(), order.getOrderNo(), order.getZgamount(), cooperationInfo.getCommissionType()
						, cooperationInfo.getHousingCommission(), housingCommission, cooperationInfo.getDinnerCommission(), dinnerCommission, cooperationInfo.getMettingRoomCommission()
						, mettingRoomCommission, cooperationInfo.getOrtherCommission(), ortherCommission, cooperationInfo.getAllCommission(), allCommission, commissionAmount
						, "01", new Date(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), "确认返佣");
				this.comissionRecordDao.save(comissionRecord);
				order.setCommissionStatus("01");
				order.setCommissionDate(new Date());
				order.setCommissionAmount(commissionAmount);
				order.setCommissionRate(cooperationInfo.getAllCommission());
				this.orderDao.save(order);
				
				try{
					String ptext = AccountUtils.getCurrentRName()+"在"+DateTimeUtils.getCurrentDate()+"发起了一笔【"+order.getOrderNo()+"】订单的返佣！";
					chatRecordService.log("LOG", "发起返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "发起返佣日志");
					ptext+="请及时审核处理！";
					String batId = RandomStringUtil.getWthdrwNo(8);
					chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "发起返佣",batId);
				}catch(Exception e){
				}
				
			}catch(Exception e){
				//return JsonUtils.error("返佣操作异常！");
			}
		}
		/*}else if(order.getState().equals("06")){
			
		}else{
			return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
		}*/
		
		order.setSettlementStatus("04");
		order.setSettlementDate(new Date());
		order.setSettlementUid(AccountUtils.getCurrentUserId());
		pamount = pamount==null||pamount==0?order.getSettlementAmount():pamount;
		order.setSettlementAmount(pamount);
		order.setFinalPayment(0D);
		this.orderDao.save(order);
		
		OrderPayedRecord orderPayedRecord = new OrderPayedRecord(order.getHotelId(), order.getId(), "SETTLEMENT", order.getAmount(), pamount, order.getFinalPayment()
				, order.getSettlementAmount(), new Date(), AccountUtils.getCurrentUserId(), new Date(), ""); 
		this.orderPayedRecordDao.save(orderPayedRecord);
		try{
			String title = "订单通知";
			String ptext = "酒店销售【"+AccountUtils.getCurrentRName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】已结算 ！订单已完成！";
			//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
			
			chatRecordService.log("LOG", "订单签约", ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "订单签约");
			
			if("1".equals(cooperationInfo.getCommissionRights())){
				List<User> users = this.userService.findByHotelIdAndGroupId(order.getHotelId(), 10L);
				String batId = RandomStringUtil.getWthdrwNo(8);
				for (User user : users) {
					chatRecordService.send("SYSTEM", "SYSTEM", user.getId(),user.getRname(), "SYSTEMMSG", title, "订单【"+order.getOrderNo()+"】已结算;订单已完成！请尽快核实信息并确认返佣!", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "",batId);
					//CallUtil.sendmsg(ptext, user.getMobile());
				}
			}else{
				String batId = RandomStringUtil.getWthdrwNo(8);
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());
				List<User> gusers = this.userService.findByPhtlidAndGroupId(hotel.getPid(), 10L);
				for (User user : gusers) {
					chatRecordService.send("SYSTEM", "SYSTEM", user.getId(),user.getRname(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "",batId);
					//CallUtil.sendmsg(ptext, user.getMobile());
				}
			}
			
			/*String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已结算;订单已完成！欢迎再次惠顾！谢谢！";//"【会掌柜】"+
			CallUtil.sendmsg(content, order.getContactNumber());*/
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
				HttpUtils.doPost(order.getNotifyUrl(),params );
			}
			
		}catch(Exception e){
		}
		return JsonUtils.success("订单已收款修改成功！");
	}

	/**
	 * 订单完成
	 * @param id
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo finshed(Long id) {
		Order order = this.getEntity(id);
		try{
			//if(order.getState().equals("04")){
				String state = order.getState().compareTo("06")>0?order.getState():"06";
				order.setSettlementStatus("03");
				order.setState(state);
				order.setConfirmDate(new Date());
				HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(order.getHotelId());
				Double pointrate = cooperationInfo.getPointsRate()==null?0D:cooperationInfo.getPointsRate();
				Double hotelPoint = order.getAmount()*pointrate/100;
				order.setHotelPoints(hotelPoint);
				
				Double clientPoint = order.getAmount()*pointrate/100;
				order.setClientPoints(clientPoint);
				
				PointsAccount pointsAccount = this.pointsAccountService.findByClientTypeAndClientId("HOTEL", order.getHotelId()+"");
				pointsAccount.setBalancePoints(pointsAccount.getBalancePoints()+hotelPoint);
				pointsAccount.setTotalPoints(pointsAccount.getTotalPoints()+hotelPoint);
				pointsAccountDao.save(pointsAccount);
				if("00".equals(order.getCommissionStatus())){
					try{
						Hotel hotel = this.hotelService.getEntity(order.getHotelId());
							
						Double housingCommission = 0D;
						Double dinnerCommission= 0D;
						Double mettingRoomCommission= 0D;
						Double ortherCommission= 0D;
						
						Double allCommission= 0D;
						Double commissionAmount= 0D;
						if(cooperationInfo.getCommissionType().equals("1")){//全单返
							allCommission = order.getZgamount()*cooperationInfo.getAllCommission()/100;
							commissionAmount = allCommission;
						}else if(cooperationInfo.getCommissionType().equals("2")){//分项返
							housingCommission = order.getRoomAmount()*cooperationInfo.getHousingCommission()/100;
							dinnerCommission = calculatedRoomCommission(order,cooperationInfo);// order.getDiningAmount()*cooperationInfo.getDinnerCommission()/100;
							mettingRoomCommission = order.getSiteAmount()*cooperationInfo.getMettingRoomCommission()/100;
							commissionAmount = housingCommission+dinnerCommission+mettingRoomCommission+ortherCommission;
						}else{
							return JsonUtils.error("该酒店尚未设置返佣类型！");
						}
						
						ComissionRecord comissionRecord = new ComissionRecord(hotel.getId(), order.getOrderNo(), order.getZgamount(), cooperationInfo.getCommissionType()
								, cooperationInfo.getHousingCommission(), housingCommission, cooperationInfo.getDinnerCommission(), dinnerCommission, cooperationInfo.getMettingRoomCommission()
								, mettingRoomCommission, cooperationInfo.getOrtherCommission(), ortherCommission, cooperationInfo.getAllCommission(), allCommission, commissionAmount
								, "01", new Date(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), "确认返佣");
						comissionRecord.setMeetingAmount(order.getSiteAmount());
						comissionRecord.setHouseAmount(order.getRoomAmount());
						comissionRecord.setDinnerAmount(order.getDiningAmount());
						comissionRecord.setOtherAmount(order.getOtherAmount());
						comissionRecord.setIsupdate("0");
						comissionRecord.setComissionRecord(order.getAmount(), order.getSiteAmount(), order.getRoomAmount(), order.getDiningAmount(), order.getOtherAmount()
								, cooperationInfo.getMettingRoomCommission(),  cooperationInfo.getHousingCommission(), cooperationInfo.getDinnerCommission()
								, cooperationInfo.getOrtherCommission(), cooperationInfo.getAllCommission());
						this.comissionRecordDao.save(comissionRecord);
						order.setCommissionStatus("01");
						order.setCommissionDate(new Date());
						order.setCommissionAmount(commissionAmount);
						order.setCommissionRate(cooperationInfo.getAllCommission());
						this.orderDao.save(order);
						
						try{
							String ptext = AccountUtils.getCurrentRName()+"在"+DateTimeUtils.getCurrentDate()+"发起了一笔【"+order.getOrderNo()+"】订单的返佣！";
							chatRecordService.log("LOG", "发起返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "发起返佣日志");
							ptext+="请及时审核处理！";
							chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "发起返佣");
						}catch(Exception e){
						}
						
					}catch(Exception e){
						return JsonUtils.error("返佣操作异常！");
					}
				}
				
				
				this.orderDao.save(order);
				try{
					String title = "订单通知";
					String ptext = "酒店销售【"+AccountUtils.getCurrentRName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】已完成，待结算收款！";
					//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					chatRecordService.log("LOG", "订单签约", ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "订单签约");
					if("1".equals(cooperationInfo.getCommissionRights())){
						ptext = "酒店销售【"+AccountUtils.getCurrentRName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】已完成，请尽快进行返佣操作！";
						chatRecordService.send("SYSTEM", "SYSTEM","hote_finance", "hote_finance", "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
						/*List<User> users = this.userService.findByHotelIdAndGroupId(order.getHotelId(), 10L);
						for (User user : users) {
							CallUtil.sendmsg(ptext, user.getMobile());
						}*/
					}else{
						chatRecordService.send("SYSTEM", "SYSTEM","group_finance", "group_finance", "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
						/*Hotel hotel = this.hotelService.getEntity(order.getHotelId());
						List<User> gusers = this.userService.findByPhtlidAndGroupId(hotel.getPid(), 10L);
						for (User user : gusers) {
							CallUtil.sendmsg(ptext, user.getMobile());
						}*/
					}
					
					/*String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已完成！"+ptext;//"【会掌柜】"+
					CallUtil.sendmsg(content, order.getContactNumber());*/
					if(StringUtils.isNotBlank(order.getNotifyUrl())){
						String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
						HttpUtils.doPost(order.getNotifyUrl(),params );
					}
				}catch(Exception e){
					
				}
				
				return JsonUtils.success("订单确认结束成功！");
			/*}else{
				return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
			}*/
		}catch(Exception e){
			return JsonUtils.error("该订单修改失败！");
		}
		
	}

	/**
	 * 
	 * @param order
	 * @param cooperationInfo
	 * @return
	 */
	private Double calculatedRoomCommission(Order order,HotelCooperationInfo cooperationInfo) {
		Double roomAllCommission = 0D;
		List<RoomOrderDetailModel> rooms = this.orderDetailService.getAllRoomOrderDetailModel(order.getOrderNo());
		for (RoomOrderDetailModel room : rooms) {
			for (BookingRecordModel booking: room.getBookingRecordModels()) {
				PlacePrice placePrice = this.placePriceService.findByPlaceTypeAndPlaceIdAndPlaceSchedule("ROOM", room.getPlaceId(), booking.getPlaceDate());
				Double rcomission = (placePrice.getOnlinePrice()-placePrice.getOfflinePrice())*booking.getQuantity()*(cooperationInfo.getHousingCommission()/100);
				roomAllCommission+=rcomission;
			}
		}
		return roomAllCommission;
	}
	/**
	 * 订单签约
	 * @param id
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo signup(Long id) {
		Order order = this.getEntity(id);
		if("021".equals(order.getState())){
			order.setState("04");
			order.setSignDate(new Date());
			order.setSignUid(AccountUtils.getCurrentUserId());
			order.setSignUname(AccountUtils.getCurrentRName());
			this.orderDao.save(order);
			
			
			List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientIdAndType(order.getHotelId(), order.getOrderNo(), order.getClientId(), "01"); 
			for (ScheduleBooking scheduleBooking : scheduleBookings) {
				HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(scheduleBooking.getPlaceScheduleId());
				hotelSchedule.setState("2");//支付订金 or 已签约
				hotelScheduleDao.save(hotelSchedule);
			}
			List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
			for (ScheduleBooking scheduleBooking : bookings) {
				scheduleBooking.setState("2");//支付订金 or 已签约
				this.scheduleBookingDao.save(scheduleBooking);
			}
			
			try{
				String title = "订单通知";
				String ptext = "酒店销售【"+AccountUtils.getCurrentRName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】已签约！";
				//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				chatRecordService.log("LOG", "订单签约", ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "订单签约");
				/*String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已达成！"+ptext;//"【会掌柜】"+
				CallUtil.sendmsg(content, order.getContactNumber());*/
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
					HttpUtils.doPost(order.getNotifyUrl(),params );
				}
			}catch(Exception e){
			}
			
			return JsonUtils.success("订单签约成功！");
		}else{
			return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
		}
	}

	/**
	 * 
	 * @param id
	 * @param prepay
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo prepay(Long id, Double prepay) {
		//已交定金
		Order order = this.getEntity(id);
		try{
			if(order.getState().compareTo("05")<0&&order.getSettlementStatus().compareTo("02")<=0){
				order.setSettlementStatus("02");
				order.setPayDate(new Date());
				List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientIdAndType(order.getHotelId(), order.getOrderNo(), order.getClientId(), "01"); 
				for (ScheduleBooking scheduleBooking : scheduleBookings) {
					HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(scheduleBooking.getPlaceScheduleId());
					/*if(hotelSchedule.getState().equals("2")){
						throw new Exception("档期已被锁定，不可支付!");
					}*/
					hotelSchedule.setState("2");
					hotelScheduleDao.save(hotelSchedule);
				}
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("2");//支付订金
					this.scheduleBookingDao.save(scheduleBooking);
				}
				order.setState("04");
				order.setPrepaid(prepay);
				Double finalPayment = order.getAmount()-prepay;
				finalPayment = finalPayment<0?0:finalPayment;
				order.setFinalPayment(finalPayment);
				/*order.setState("04");
				order.setSignDate(new Date());
				order.setSignUid(AccountUtils.getCurrentUserId());
				order.setSignUname(AccountUtils.getCurrentRName());*/
				this.orderDao.save(order);
				OrderPayedRecord orderPayedRecord = new OrderPayedRecord(order.getHotelId(), order.getId(), "PREPAY", order.getAmount(), prepay, order.getFinalPayment()
						, order.getSettlementAmount(), new Date(), AccountUtils.getCurrentUserId(), new Date(), ""); 
				this.orderPayedRecordDao.save(orderPayedRecord);
				try{
					//TODO 发消息给会员顾客
					String ptext = "酒店销售【"+AccountUtils.getCurrentRName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】已交订金!";
					//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已提交订金！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					chatRecordService.log("LOG", "取消订单", ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "取消订单");
					
					/*String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已交订金！"+ptext;//"【会掌柜】"+
					CallUtil.sendmsg(content, order.getContactNumber());*/
					if(StringUtils.isNotBlank(order.getNotifyUrl())){
						String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
						HttpUtils.doPost(order.getNotifyUrl(),params );
					}
				}catch (Exception e) {
				}
				return JsonUtils.success("订单订金交付成功！");
			}else{
				return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
			}
		}catch(Exception e){
			return JsonUtils.error(e.getMessage());
		}
	}
	/**
	 * 取消订单
	 * @param id
	 * @param reason
	 * @param memo
	 * @return
	 */
	@Transactional(readOnly=false)
	private JsonVo cancel(Long id,String reason,String memo, Double ramount) {
		Order order = this.getEntity(id);
		if(order.getState().compareTo("05")<=0){
			if(order.getSettlementStatus().equals("01")){
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("4");//取消
					this.scheduleBookingDao.save(scheduleBooking);
				}
				order.setCancelDate(new Date());
				order.setCancelMemo(memo);
				order.setCancelReason(reason);
				order.setState("10");
			}else if(order.getSettlementStatus().equals("02")){
				order.setState("11");
				order.setRefundAmount(ramount);
				order.setRefundDate(new Date());
				order.setRefundMemo(memo);
				order.setRefundReason(reason);
				order.setCancelDate(new Date());
				order.setCancelMemo(memo);
				order.setCancelReason(reason);
			}else{
				return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
			}
			if(!order.getCommissionStatus().equals("00")){
				ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
				comissionRecord.setState("00");
				this.comissionRecordDao.save(comissionRecord);
				order.setCommissionStatus("00");
			}
			this.orderDao.save(order);
			try{
				//TODO 发消息给会员顾客
				//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				/*String ptext = "酒店销售【"+order.getHotelName()+"】在"+DateTimeUtils.getCurrentTimeStamp()+"取消了订单【"+order.getOrderNo()+"】!";
				chatRecordService.log("SYSTEMMSG", "取消订单", ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "取消订单");
				ptext = "很遗憾，由于"+reason+";订单未能达成；"+ptext;//【会掌柜】
				CallUtil.sendmsg(ptext, order.getContactNumber());*/
				
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CANCEL";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
			}catch (Exception e) {
			}
			return JsonUtils.success("订单取消申请已提交！");
		}else{
			return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
		}
		
	}

	@Transactional(readOnly=false)
	public JsonVo bookingSave(HotelModel hotelModel, HallModel hallModel, HotelSchedule hotelSchedule, Category category,
			String linkman, String company, String mobile,String activityTitle,String activityDate) {
		
		try{
			String orderNo = RandomStringUtil.getOrderNo(6);
			String orderType = "ONLINE";
			
			Hotel hotel = this.hotelService.getEntity(hotelModel.getId());
			HotelCooperationInfo  hotelCooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotelModel.getId());
			PlacePrice placePrice = this.placePriceService.findByPlaceIdAndPlaceSchedule(hallModel.getHotelId(), hotelSchedule.getPlaceDate());
			if(placePrice==null || placePrice.getOnlinePrice()==null){
				return JsonUtils.error("档期价格尚未设置！");
			}
			Double amount = placePrice.getOnlinePrice()*1;  
			Double zgamount = amount;
			Double siteAmount = placePrice.getOnlinePrice()*1;
			Double siteCommissionFee = 0D;
			Double roomAmount = 0D;
			Double diningAmount = 0D;
			Double otherAmount = 0D;
			Double prepaid = 0D;
			Double finalPayment = placePrice.getOnlinePrice()*1;
			
			SalerModel conpamySale = this.userService.getSaler(hotel.getReclaimUserId());
			Order order = new Order(orderNo, orderType, 0L, "酒店自有客户", hotelModel.getCityText(), hotelModel.getId(), hotelModel.getHotelName(), hotelModel.getpName(), hotelCooperationInfo.getCommissionRights()
					, AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), AccountUtils.getCurrentUser().getMobile(), 0d, amount, zgamount, prepaid, finalPayment, siteAmount, siteCommissionFee, roomAmount, diningAmount
					,otherAmount, "", activityDate, activityTitle, company, linkman, mobile, "02", "00", new Date(), "酒店自有客户");
			order.setCompanySaleId(conpamySale.getId());
			order.setCompanySaleName(conpamySale.getRname());
			order.setCompanySaleMobile(conpamySale.getMobile());
			order.setZgdiscount(100D);
			order.setSettlementStatus("01");
			order.setOfflineState("1");
			
			order.setMeetingRemark(hotel.getMeetingRemark());
			/*order.setHouseRemark(hotel.getHouseRemark());
			order.setDinnerRemark(hotel.getDinnerRemark());*/
			
			//order = this.orderDao.save(order);
			
			OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hallModel.getId(), hallModel.getPlaceName(),"1" ,siteAmount, 1L,0D, new Date(), "");
			orderDetail = this.orderDetailDao.save(orderDetail);
			
			ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
					, hotelSchedule.getId(),hotelSchedule.getPlaceDate(), category.getName()
					, placePrice.getOnlinePrice(),1L,order.getSourceAppId(), order.getOrderSource()
					, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
					, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
			
			this.scheduleBookingDao.save(scheduleBooking);
			hotelSchedule.setState("1");
			this.hotelScheduleDao.save(hotelSchedule);
			return JsonUtils.success("提交成功！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
		
	}
	@Transactional(readOnly=false)
	public JsonVo adjustmentStatusAgree(String agree, Long id,String reason,String memo) {
		try{
			Order order = this.getEntity(id);
			if(agree.equals("1")){
				if(order.getState().equals("11")){
					List<ScheduleBooking> scheduleBookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientIdAndType(order.getHotelId(), order.getOrderNo(), order.getClientId(), "01"); 
					for (ScheduleBooking scheduleBooking : scheduleBookings) {
						HotelSchedule hotelSchedule = this.hotelScheduleDao.findOne(scheduleBooking.getPlaceScheduleId());
						hotelSchedule.setState("1");
						hotelScheduleDao.save(hotelSchedule);
					}
					List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
					for (ScheduleBooking scheduleBooking : bookings) {
						scheduleBooking.setState("4");
						this.scheduleBookingDao.save(scheduleBooking);
					}
					/*order.setRefundDate(new Date());
					order.setRefundMemo(memo);
					order.setRefundReason(reason);*/
					if(!order.getCommissionStatus().equals("00")){
						ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
						comissionRecord.setState("00");
						this.comissionRecordDao.save(comissionRecord);
						order.setCommissionStatus("00");
					}
					order.setSettlementStatus("06");
					order.setState("10");
					this.orderDao.save(order);

					try{
						//TODO 发消息给会员顾客
						//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
						chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已退款成功！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
						String ptext="编号【"+order.getOrderNo()+"】的订单，已退款成功；资金将会在3到5个工作日内原路返回！";//【会掌柜】
						
						CallUtil.sendmsg(ptext, order.getContactNumber());
						if(StringUtils.isNotBlank(order.getNotifyUrl())){
							String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
							HttpUtils.doPost(order.getNotifyUrl(),params);
						}
					}catch (Exception e) {
					}
					return JsonUtils.success("提交成功！");
				}else{
					return JsonUtils.error("该订单前置状态错误，该订单无法操作！");
				}
			}else{
				
				order.setRefundDate(new Date());
				order.setRefundReason(reason);
				order.setCancelDate(null);
				order.setCancelMemo("");
				order.setCancelReason("");
				if(!order.getCommissionStatus().equals("00")){
					order.setRefundMemo("拒绝取消场地，订单状态转为进行中");
					order.setState("04");
				}else{
					order.setRefundMemo("拒绝取消场地，订单状态转为处理中");
					order.setState("02");
				}
				this.orderDao.save(order);
				try{
					//TODO 发消息给会员顾客
					//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，拒绝取消，订单状态转为处理中;请与客户及时沟通处理！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					String ptext="编号【"+order.getOrderNo()+"】的订单，拒绝取消，订单状态转为处理中;请与酒店销售及时沟通处理！";//【会掌柜】
					
					CallUtil.sendmsg(ptext, order.getContactNumber());
					if(StringUtils.isNotBlank(order.getNotifyUrl())){
						String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
						HttpUtils.doPost(order.getNotifyUrl(),params);
					}
				}catch (Exception e) {
				}
				return JsonUtils.success("提交成功！");
			}
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
	}

	/**
	 * 线下活动审核
	 * @param orderId
	 * @param reason 不通过原因
	 * @param flag 0：不通过；1：通过
	 * @return
	 */
	@Transactional(readOnly=false)
	public JsonVo offlineCheck(Long orderId, String reason, String flag) {
		try{
			Order order = this.getEntity(orderId);
			if("1".equals(flag)){
				order.setOfflineState("1");
				order.setOfflineMemo("");
			}else{
				order.setOfflineState("2");
				order.setOfflineMemo(reason);
			}
			this.orderDao.save(order);
			try{
				//TODO 发消息给会员顾客
				//chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的订单，客户已取消！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				if("1".equals(flag)){
					chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的线下活动订单已通过审核，请及时与客户联系沟通！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
					chatRecordService.send("SYSTEM", "SYSTEM", order.getCompanySaleId(), order.getCompanySaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的线下活动订单已通过审核，请及时通知酒店销售与客户联系沟通！",0L, "HUI", "ORDER", order.getOrderNo(), "");
				}else{
					chatRecordService.send("SYSTEM", "SYSTEM", order.getCompanySaleId(), order.getCompanySaleName(), "SYSTEMMSG","订单通知", "编号"+order.getOrderNo()+"的线下活动订单审核审核不通过，原因为"+reason+"！", 0L, "HUI", "ORDER", order.getOrderNo(), "");
				}
				
			}catch (Exception e) {
			}
			return JsonUtils.success("提交成功！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
	}

	@Transactional(readOnly=false)
	public JsonVo saveOrderModify(HttpServletRequest request, Long id, String orderNo, String ismain
			,String hallIds, Double hallAmount, Double hallAllAmount,Double commissionFeeRate,String roomIds, Double roomAmount, Double roomAllAmount
			,String mealIds,Double mealAmount, Double mealAllAmount,Double mealServiceFeeRate
			,String otherdetail,String otherprice,String memo,String meetingRemark,String houseRemark,String dinnerRemark,String oquantity,String oprice) {
		
		String odtids = this.getOrderDetailId(orderNo);
		String shrids = this.getScheduleRecordId(orderNo);
		System.out.println("odtids>>>>"+odtids);
		System.out.println("shrids>>>>"+shrids);
		
		try{
			Order order = this.getEntity(id);
			order.setMemo(memo);
			if(!order.getOrderNo().equals(orderNo)){
				return JsonUtils.error("订单信息错误！");
			}
			if(!order.getState().equals("01")&&!order.getState().equals("02")&&!order.getState().equals("04")){
				return JsonUtils.error( "订单状态错误！"+getStateTxt(order, null)+"订单不可修改！");
			}
			
			/*this.deleteOrderDetail(order.getOrderNo());
			this.deleteScheduleRecord(order.getOrderNo());*/
			
			Double amount = 0D;  
			Double zgamount = 0D;
			Double siteAmount = 0D;
			Double siteCommissionFee = 0D;
			Double houseAmount = 0D;
			Double diningAmount = 0D;
			Double mealServiceFee = 0D;
			Double otherAmount = 0D;
			
			String bookState = "1";
			if("01".equals(order.getSettlementStatus())){
				
			}else{
				bookState = "2";
			}
			
			if(StringUtils.isNotBlank(hallIds)){
				order.setMeetingRemark(meetingRemark);
				String [] hlids = hallIds.substring(1).split("#");
				for (String hid : hlids) {
					HallModel hallModel = this.hotelPlaceService.getHall(Long.valueOf(hid));
					String  main = "0";
					if(ismain.equals(hid)){
						main = "1";
					}
					Double damount = 0.0D;	
					Long quantity = 0L;
				
					
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hallModel.getId(), hallModel.getPlaceName(),main ,damount, quantity,commissionFeeRate, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					
					
					String [] scheduleDates = request.getParameterValues("scheduleDate_"+hid);
					String [] placePrices = request.getParameterValues("placePrice_"+hid);
					String [] placeScheduleIds = request.getParameterValues("placeScheduleIds_"+hid);
					
					int i=0;
					for (String placeDate : scheduleDates) {
						String placeScheduleId = placeScheduleIds[i];
						String pshids[] = placeScheduleId.split("#");
						Double cprice = Double.valueOf(placePrices[i]);
						for (String pshid : pshids) {
							HotelSchedule hotelSchedule = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(order.getHotelId(), Long.valueOf(hid), placeDate, pshid);
							Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
							String hschdlTime = category.getName();
							Double uprice = cprice/pshids.length;
							quantity+=1;
							damount+=uprice;
							
							ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
									, hotelSchedule.getId(), placeDate, hschdlTime, uprice,1L,order.getSourceAppId(), order.getOrderSource()
									, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
									, "", null, new Date(), bookState, "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
							
							this.scheduleBookingDao.save(scheduleBooking);
							
							if(order.getSettlementStatus().equals("01")){
								hotelSchedule.setState("1");
							}else{
								hotelSchedule.setState("2");
							}
							
							this.hotelScheduleDao.save(hotelSchedule);
						}
						i++;
					}
					
					siteAmount+=damount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(damount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(roomIds)){
				order.setHouseRemark(houseRemark);
				String [] rmids = roomIds.substring(1).split("#");
				for (String rid : rmids) {
					String []breakfasts = request.getParameterValues("breakfast_"+rid);
					String []roomscheduleDates = request.getParameterValues("roomscheduleDate_"+rid);
					String []romNums = request.getParameterValues("rom_num_"+rid);
					String []roomPrices = request.getParameterValues("roomPrice_"+rid);
					
					RoomModel roomModel = this.hotelPlaceService.getRoom(Long.valueOf(rid));
					Long quantity = 0L;
					Double ramount = 0.0D;	
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "02",roomModel.getId(), roomModel.getPlaceName(), "",ramount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					this.orderDetailDao.save(orderDetail);
					
					int i=0;
					for (String rsdate : roomscheduleDates) {
						Long num = Long.valueOf(romNums[i]);
						Double price = Double.valueOf(roomPrices[i]);
						quantity+=num;
						ramount+=price*num;
						
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "02", orderDetail.getPlaceId()
								,null, rsdate, "", price,num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),breakfasts[i],"",0L);
						this.scheduleBookingDao.save(scheduleBooking);
						i++;
					}
					
					houseAmount+=ramount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(ramount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(mealIds)){
				order.setDinnerRemark(dinnerRemark);
				String [] mlIds = mealIds.substring(1).split("#");
				for (String mid : mlIds) {
					
					
					String []mealTypes = request.getParameterValues("mealType_"+mid);
					String []mealscheduleTimes = request.getParameterValues("mealscheduleTime_"+mid);
					String []meal_nums = request.getParameterValues("meal_num_"+mid);
					String []mealscheduleDates = request.getParameterValues("mealscheduleDate_"+mid);
					String []mealPrices = request.getParameterValues("mealPrice_"+mid);
					
					
					HotelMenu hotelMenu = this.hotelMenuService.getEntity(Long.valueOf(mid));
					Long quantity = 0L;
					Double mamount = 0D;
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "03", hotelMenu.getId(),hotelMenu.getName(), ""
							,mamount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					int i = 0;
					for (String msdate : mealscheduleDates) {
						String type = mealTypes[i];
						Long num = Long.valueOf(meal_nums[i]);
						Double price = Double.valueOf(mealPrices[i]);
						quantity+=num;
						mamount+=price*num;
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "03", orderDetail.getPlaceId()
								,null, msdate, mealscheduleTimes[i], price, num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", type,order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"",type,10L);
						this.scheduleBookingDao.save(scheduleBooking);
						
						i++;
					}
					diningAmount+=mamount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(mamount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			
			if(StringUtils.isNotBlank(otherdetail)){
				String [] odetails = otherdetail.split(",");
				String [] oquantitys = oquantity.split(",");
				String [] ounitprices = oprice.split(",");
				for (int i=0;i<odetails.length;i++) {
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "09",null,odetails[i], ""
							,Long.valueOf(oquantitys[i])*Double.valueOf(ounitprices[i]), Long.valueOf(oquantitys[i]),0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					otherAmount+=Long.valueOf(oquantitys[i])*Double.valueOf(ounitprices[i]);
				}
			}
					
					
			
			
			siteCommissionFee = siteAmount*commissionFeeRate/100;
			mealServiceFee = diningAmount*mealServiceFeeRate/100;
			
			amount = siteAmount+siteCommissionFee+houseAmount+diningAmount+mealServiceFee+otherAmount;
			zgamount = amount;
			Double finalPayment = amount-order.getPrepaid();
			
			
			/*System.out.println("otherAmount>>>>"+otherAmount);
			System.out.println("siteAmount>>>>"+siteAmount);
			System.out.println("roomAmount>>>>"+roomAmount);
			System.out.println("diningAmount>>"+diningAmount);
			System.out.println("siteCommissionFee>>>"+siteCommissionFee);
			System.out.println("amount>>>"+amount);
			System.out.println("zgamount>>>"+zgamount);
			System.out.println("finalPayment>>>"+finalPayment);*/
			
			order.setAmount(amount);
			order.setZgamount(zgamount);
			order.setOtherAmount(otherAmount);
			order.setSiteCommissionFee(siteCommissionFee);
			order.setSiteAmount(siteAmount);
			order.setRoomAmount(roomAmount);
			order.setDiningAmount(diningAmount);
			order.setFinalPayment(finalPayment);
			
			order.setMealServiceFee(mealServiceFee);
			order.setMealServiceFeeRate(mealServiceFeeRate);
			order.setSiteCommissionFeeRate(commissionFeeRate);
			this.orderDao.save(order);
			
			try{
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
				
				
				String title = "订单通知";
				String ptext = "您的订单已修改，请及时处理！";
				chatRecordService.send("SYSTEM", "SYSTEM", order.getClientId(), order.getLinkman(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				
				String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已被销售"+order.getHotelSaleName()+"于"+DateTimeUtils.getCurrentTimeStamp()+"修改；请知悉！";//"【会掌柜】"+
				String url = Constant.DOMAIN+"/base/order/pdf/detail/"+order.getId();
				String tinyurl = HttpUtils.getC7ggDWZ(url);
				content += "点击链接前去确认："+tinyurl;
				CallUtil.sendmsg(content, order.getContactNumber());
				
				String tplPath = PdfHelper.getTplPath();
				SendEmailThread emailThread = new SendEmailThread(order.getId(), order.getOrderNo(), order.getEmail(), tplPath, title);
				emailThread.start();
			}catch(Exception e){
			}
		
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
		
		this.batchDeleteScheduleRecord(shrids);
		this.batchDeleteOrderDetail(odtids);
		return JsonUtils.success("提交成功！");
	}

	@Transactional(readOnly=false)
	private void deleteScheduleRecord(String orderNo) {
		String hql =" delete from ScheduleBooking s where s.orderNo='"+orderNo+"'";
		this.scheduleBookingDao.querydelete(hql);
	}
	@Transactional(readOnly=false)
	private void deleteOrderDetail(String orderNo) {
		String hql =" delete from OrderDetail d where d.orderNo='"+orderNo+"'";
		this.orderDetailDao.querydelete(hql);
	}
	
	
	@Transactional(readOnly=false)
	private void batchDeleteScheduleRecord(String ids) {
		String odtids[] = ids.split(",");
		Long[] otids = new Long[odtids.length];
		for (int i = 0; i < odtids.length; i++) {
			otids[i] = Long.valueOf(odtids[i]);
		}
		this.scheduleBookingDao.batchDelete(otids);
	}
	@Transactional(readOnly=false)
	private void batchDeleteOrderDetail(String ids) {
		String odtids[] = ids.split(",");
		Long[] otids = new Long[odtids.length];
		for (int i = 0; i < odtids.length; i++) {
			otids[i] = Long.valueOf(odtids[i]);
		}
		this.orderDetailDao.batchDelete(otids);
	}
	private String getScheduleRecordId(String orderNo) {
		String hql =" select group_concat(s.id) as ids from hui_schedule_booking s where s.order_no='"+orderNo+"'";
		List<Object> res = this.scheduleBookingDao.executeNativeQuery(hql, null);
		if(res!=null&&res.size()>0){
			return res.get(0)==null?"":res.get(0).toString();
		}
		return "";
	}
	
	private String getOrderDetailId(String orderNo) {
		String hql =" select group_concat(s.id) as ids from hui_order_detail s where s.order_no='"+orderNo+"'";
		List<Object> res = this.orderDetailDao.executeNativeQuery(hql, null);
		if(res!=null&&res.size()>0){
			return res.get(0)==null?"":res.get(0).toString();
		}
		return "";
	}
	

	
	
	@Transactional(readOnly=false)
	public JsonVo invoiceReceived(Long id, String invoiceNo) {
		try {
			Order order = this.getEntity(id);
			if(!invoiceNo.equals(order.getInvoiceNo())){
				return JsonUtils.error("发票号码错误！");
			}
			order.setCommissionStatus("05");
			this.orderDao.save(order);
			ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
			comissionRecord.setState("05");
			comissionRecordDao.save(comissionRecord);
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());//hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+
				String ptext = "酒店"+ hotel.getHotelName()+"财务已领取订单【"+order.getOrderNo()+"】的返佣发票！";
				chatRecordService.log("", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext+"请留意转账情况！", 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
		} catch (Exception e) {
			return JsonUtils.error("领取发票确认失败！");
		}
		
		return JsonUtils.success("领取发票成功！");
	}
	
	@Transactional(readOnly=false)
	public JsonVo transferAccountsConfirmed(Long id, String memo) {
		try {
			Order order = this.getEntity(id);
			order.setCommissionStatus("07");
			this.orderDao.save(order);
			ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
			comissionRecord.setState("07");
			comissionRecord.setMemo(StringUtils.isNotBlank(comissionRecord.getMemo())?comissionRecord.getMemo()+";"+memo:memo);
			comissionRecordDao.save(comissionRecord);
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());//hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+
				String ptext = "会掌柜财务在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】佣金已到帐；本订单返佣流程已结束！";
				chatRecordService.log("", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				chatRecordService.send("SYSTEM", "SYSTEM", "hotel_finance", "hotel_finance", "SYSTEMMSG", "订单返佣通知", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
		} catch (Exception e) {
			return JsonUtils.error("转账确认失败！");
		}
		
		return JsonUtils.success("转账确认成功！");
	}
	
	@Transactional(readOnly=false)
	public JsonVo transferAccounts(Long id, String transferRemark) {
		try {
			Order order = this.getEntity(id);
			order.setCommissionStatus("06");
			this.orderDao.save(order);
			ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
			comissionRecord.setState("06");
			comissionRecord.setTransferRemark(transferRemark);
			comissionRecord.setTransferDate(new Date());
			comissionRecordDao.save(comissionRecord);
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());//hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+
				String ptext = "酒店"+ hotel.getHotelName()+"财务在"+DateTimeUtils.getCurrentTimeStamp()+"标记订单【"+order.getOrderNo()+"】佣金已转帐！";
				chatRecordService.log("", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext+"请留意转账情况！", 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
		} catch (Exception e) {
			return JsonUtils.error("转账确认失败！");
		}
		
		return JsonUtils.success("转账确认成功！");
	}

	public JsonVo commissionRemind(int day) {
		String sql ="SELECT count(*) FROM hui_order o left join hui_hotel h on o.hotel_id = h.id"
				+ " where o.state = '06' and o.commission_status = '01' and DATEDIFF(now(), o.confirm_date)>=?";
		
		if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
			sql +=" and h.pid="+ AccountUtils.getCurrentUser().getPhtlid();
		}else{
			sql +=" and h.id="+ AccountUtils.getCurrentUserHotelId();
		}
		List<Object> params = Lists.newArrayList();
		params.add(day);
		List<Object> res = this.orderDao.executeNativeQuery(sql, params);
		if(res!=null&&res.size()>0){
			Integer count = res.get(0)==null?0:Integer.valueOf(res.get(0).toString());
			return JsonUtils.success("ok", count);
		}
		return JsonUtils.success("ok", 0);
	}
	
	@Transactional(readOnly=false)
	public JsonVo companyFollow(Long orderId, String companyFollowMemo) {
		Order order = this.getEntity(orderId);
		order.setCompanyFollowSaleId(AccountUtils.getCurrentUserId());
		order.setCompanyFollowSaleName(AccountUtils.getCurrentRName());
		order.setCompanyFollowTime(new Date());
		order.setCompanyFollowMemo(companyFollowMemo);
		this.orderDao.save(order);
		if(StringUtils.isNotBlank(order.getNotifyUrl())){
			String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE";
			HttpUtils.doPost(order.getNotifyUrl(),params);
		}
		return JsonUtils.success("客服反馈成功！");
	}
	
	@Transactional(readOnly=false)
	public JsonVo saveOrderNewModify(HttpServletRequest request, OrderParam orderParam) {
		String odtids = this.getOrderDetailId(orderParam.getOrderNo());
		String shrids = this.getScheduleRecordId(orderParam.getOrderNo());
		System.out.println("odtids>>>>"+odtids);
		System.out.println("shrids>>>>"+shrids);
		
		try{
			Order order = this.getEntity(orderParam.getId());
			order.setEmail(orderParam.getEmail());
			order.setLinkman(orderParam.getLinkman());
			order.setContactNumber(orderParam.getContactNumber());
			order.setOrganizer(orderParam.getOrganizer());
			order.setActivityDate(orderParam.getActivityDate());
			order.setActivityTitle(orderParam.getActivityTitle());
			order.setMemo(orderParam.getMemo());
			
			if(!order.getOrderNo().equals(orderParam.getOrderNo())){
				return JsonUtils.error("订单信息错误！");
			}
			if(!order.getState().equals("01")&&!order.getState().equals("02")&&!order.getState().equals("04")){
				return JsonUtils.error( "订单状态错误！"+getStateTxt(order, null)+"订单不可修改！");
			}
			
			Double amount = 0D;  
			Double zgamount = 0D;
			Double siteAmount = 0D;
			Double siteCommissionFee = 0D;
			Double houseAmount = 0D;
			Double diningAmount = 0D;
			Double otherAmount = 0D;
			
			String bookState = "1";
			if("01".equals(order.getSettlementStatus())){
				
			}else{
				bookState = "2";
			}
			
			if(StringUtils.isNotBlank(orderParam.getHallIds())){
				order.setMeetingRemark(orderParam.getMeetingRemark());
				String [] hlids = orderParam.getHallIds().substring(1).split("#");
				for (String hid : hlids) {
					HallModel hallModel = this.hotelPlaceService.getHall(Long.valueOf(hid));
					String  main = "0";
					if(orderParam.getIsmain().equals(hid)){
						main = "1";
					}
					Double damount = 0.0D;	
					Long quantity = 0L;
				
					
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hallModel.getId(), hallModel.getPlaceName(),main ,damount, quantity,orderParam.getCommissionFeeRate(), new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					
					
					String [] scheduleDates = request.getParameterValues("scheduleDate_"+hid);
					String [] scheduleTimes = request.getParameterValues("scheduleTime_"+hid);
					String [] placePrices = request.getParameterValues("placePrice_"+hid);
					
					if(null == scheduleDates || scheduleDates.length<=0){
					}else{
						int i=0;
						for (String placeDate : scheduleDates) {
							String scheduleTime = scheduleTimes[i];
							if("ALL".equals(scheduleTime)){
								List<HotelSchedule> hotelSchedules = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDate(order.getHotelId(), Long.valueOf(hid), placeDate);
								for (HotelSchedule hotelSchedule : hotelSchedules) {
									Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
									String hschdlTime = category.getName();
									Double hallschedulePrice = Double.valueOf(placePrices[i])/3;
									if(hschdlTime.equals("中午")){
										hallschedulePrice = 0D;
									}
									ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
											, hotelSchedule.getId(), placeDate, hschdlTime, hallschedulePrice,1L,order.getSourceAppId(), order.getOrderSource()
											, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
											, "", null, new Date(), bookState, "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
									this.scheduleBookingDao.save(scheduleBooking);
									if(order.getSettlementStatus().equals("01")){
										hotelSchedule.setState("1");
									}else{
										hotelSchedule.setState("2");
									}
									this.hotelScheduleDao.save(hotelSchedule);
								}
								
								quantity+=1;
								damount+=Double.valueOf(placePrices[i]);
							}else{
								String pschs[] = scheduleTime.split("#");
								Double cprice = Double.valueOf(placePrices[i]);
								for (String placeSchedule : pschs) {
									HotelSchedule hotelSchedule = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(order.getHotelId(), Long.valueOf(hid), placeDate, placeSchedule);
									Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
									String hschdlTime = category.getName();
									Double uprice = cprice/pschs.length;
									quantity+=1;
									damount+=uprice;
									
									ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
											, hotelSchedule.getId(), placeDate, hschdlTime, uprice,1L,order.getSourceAppId(), order.getOrderSource()
											, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
											, "", null, new Date(), bookState, "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
									
									this.scheduleBookingDao.save(scheduleBooking);
									
									if(order.getSettlementStatus().equals("01")){
										hotelSchedule.setState("1");
									}else{
										hotelSchedule.setState("2");
									}
									
									this.hotelScheduleDao.save(hotelSchedule);
								}
								
							}
							
							i++;
						}
					}
					
					
					siteAmount+=damount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(damount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(orderParam.getRoomIds())){
				order.setHouseRemark(orderParam.getHouseRemark());
				System.out.println("orderParam.getRoomIds()>>>>>>>>>"+orderParam.getRoomIds());
				String roomIds = orderParam.getRoomIds().replace("undefined", "").substring(1);
				System.out.println("roomIds>>>>>>>>>"+roomIds);
				String [] rmids = roomIds.split("#");
				for (String rid : rmids) {
					System.out.println("rid>>>>>>>>>"+rid);
					String []breakfasts = request.getParameterValues("breakfast_"+rid);
					String []roomscheduleDates = request.getParameterValues("roomscheduleDate_"+rid);
					String []romNums = request.getParameterValues("rom_num_"+rid);
					String []roomPrices = request.getParameterValues("roomPrice_"+rid);
					
					System.out.println("breakfast>>>>>>>>>"+breakfasts.length);
					System.out.println("roomscheduleDate>>>>>>>>>"+roomscheduleDates.length);
					System.out.println("roomPrice>>>>>>>>>"+roomPrices.length);
					System.out.println("romNum>>>>>>>>>"+romNums.length);
					
					RoomModel roomModel = this.hotelPlaceService.getRoom(Long.valueOf(rid));
					Long quantity = 0L;
					Double ramount = 0.0D;	
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "02",roomModel.getId(), roomModel.getPlaceName(), "",ramount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					this.orderDetailDao.save(orderDetail);
					
					int i=0;
					for (String rsdate : roomscheduleDates) {
						Long num = Long.valueOf(romNums[i]);
						Double price = Double.valueOf(roomPrices[i]);
						quantity+=num;
						ramount+=price*num;
						
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "02", orderDetail.getPlaceId()
								,null, rsdate, "", price,num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"1","",0L);
						this.scheduleBookingDao.save(scheduleBooking);
						i++;
					}
					
					houseAmount+=ramount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(ramount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(orderParam.getMealIds())){
				order.setDinnerRemark(orderParam.getDinnerRemark());
				String mealIds = orderParam.getMealIds().replace("undefined", "").substring(1);
				System.out.println("mealIds>>>>>>>>>"+mealIds);
				String [] mlIds = mealIds.split("#");
				for (String mid : mlIds) {
					
					String []mealTypes = request.getParameterValues("mealType_"+mid);
					String []mealscheduleTimes = request.getParameterValues("mealscheduleTime_"+mid);
					String []meal_nums = request.getParameterValues("meal_num_"+mid);
					String []mealscheduleDates = request.getParameterValues("mealscheduleDate_"+mid);
					String []mealPrices = request.getParameterValues("mealPrice_"+mid);
					
					HotelMenu hotelMenu = this.hotelMenuService.getEntity(Long.valueOf(mid));
					Long quantity = 0L;
					Double mamount = 0D;
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "03", hotelMenu.getId(),hotelMenu.getName(), ""
							,mamount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					int i = 0;
					for (String msdate : mealscheduleDates) {
						String type = mealTypes[i];
						Long num = Long.valueOf(meal_nums[i]);
						Double price = Double.valueOf(mealPrices[i]);
						quantity+=num;
						mamount+=price*num;
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "03", orderDetail.getPlaceId()
								,null, msdate, mealscheduleTimes[i], price, num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", type,order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"",type,10L);
						this.scheduleBookingDao.save(scheduleBooking);
						
						i++;
					}
					diningAmount+=mamount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(mamount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			
			if(StringUtils.isNotBlank(orderParam.getOtherdetail())){
				String [] odetails = orderParam.getOtherDetail();
				Long [] oquantity = orderParam.getOQuantity();
				Double [] ounitprices = orderParam.getOUnitPrice();
				for (int i=0;i<odetails.length;i++) {
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "09",null,odetails[i], ""
							,oquantity[i]*ounitprices[i], oquantity[i],0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					otherAmount+=oquantity[i]*ounitprices[i];
				}
			}
					
			
			Double mealServiceFee = diningAmount*orderParam.getMealServiceFeeRate()/100;
			siteCommissionFee = siteAmount*orderParam.getCommissionFeeRate()/100;
			amount = siteAmount+siteCommissionFee+houseAmount+diningAmount+mealServiceFee+otherAmount;
			zgamount = amount;
			Double finalPayment = amount-order.getPrepaid();
			
			order.setAmount(amount);
			order.setZgamount(zgamount);
			order.setOtherAmount(otherAmount);
			order.setSiteCommissionFee(siteCommissionFee);
			order.setSiteAmount(siteAmount);
			order.setRoomAmount(houseAmount);
			order.setDiningAmount(diningAmount);
			order.setFinalPayment(finalPayment);
			
			order.setMealServiceFee(mealServiceFee);
			order.setMealServiceFeeRate(orderParam.getMealServiceFeeRate());
			order.setSiteCommissionFeeRate(orderParam.getCommissionFeeRate());
			
			this.orderDao.save(order);
			
			try{
				
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE&id=1";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
				
				String title = "订单通知";
				String ptext = "您的订单已修改，请及时处理！";
				chatRecordService.send("SYSTEM", "SYSTEM", order.getClientId(), order.getLinkman(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				
				String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已被销售"+order.getHotelSaleName()+"于"+DateTimeUtils.getCurrentTimeStamp()+"修改；请知悉！";//"【会掌柜】"+
				String url = Constant.DOMAIN+"/base/order/pdf/detail/"+order.getId();
				String tinyurl = HttpUtils.getC7ggDWZ(url);
				content += "点击链接前去确认："+tinyurl;
				CallUtil.sendmsg(content, order.getContactNumber());
				
				System.err.println("**********************************************************************************************");
				String tplPath = PdfHelper.getTplPath();
				SendEmailThread emailThread = new SendEmailThread(order.getId(), order.getOrderNo(), order.getEmail(), tplPath, title);
				emailThread.start();
				System.err.println("**********************************************************************************************");
			}catch(Exception e){
				e.printStackTrace();
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
		this.batchDeleteScheduleRecord(shrids);
		this.batchDeleteOrderDetail(odtids);
		return JsonUtils.success("提交成功！");
	}

	@Transactional(readOnly=false)
	public JsonVo saveOrderNewModify(HttpServletRequest request, Long id, String orderNo, String ismain, String hallIds,
			Double hallAmount, Double hallAllAmount, Double commissionFeeRate, String roomIds, Double roomAmount,
			Double roomAllAmount, String mealIds, Double mealAmount, Double mealAllAmount, String otherdetail,
			String otherprice,String email,String linkman,String contactNumber,String organizer,String activityDate,String activityTitle,String memo) {
		try{
			Order order = this.getEntity(id);
			order.setEmail(email);
			order.setLinkman(linkman);
			order.setContactNumber(contactNumber);
			order.setOrganizer(organizer);
			order.setActivityDate(activityDate);
			order.setActivityTitle(activityTitle);
			order.setMemo(memo);
			if(!order.getOrderNo().equals(orderNo)){
				return JsonUtils.error("订单信息错误！");
			}
			if(!order.getState().equals("01")&&!order.getState().equals("02")&&!order.getState().equals("04")){
				return JsonUtils.error( "订单状态错误！"+getStateTxt(order, null)+"订单不可修改！");
			}
			
			this.deleteOrderDetail(order.getOrderNo());
			this.deleteScheduleRecord(order.getOrderNo());
			
			Double amount = 0D;  
			Double zgamount = 0D;
			Double siteAmount = 0D;
			Double siteCommissionFee = 0D;
			Double houseAmount = 0D;
			Double diningAmount = 0D;
			
			Double otherAmount = 0D;
			
			String bookState = "1";
			if("01".equals(order.getSettlementStatus())){
				
			}else{
				bookState = "2";
			}
			
			if(StringUtils.isNotBlank(hallIds)){
				String [] hlids = hallIds.substring(1).split("#");
				for (String hid : hlids) {
					HallModel hallModel = this.hotelPlaceService.getHall(Long.valueOf(hid));
					String  main = "0";
					if(ismain.equals(hid)){
						main = "1";
					}
					Double damount = 0.0D;	
					Long quantity = 0L;
				
					
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hallModel.getId(), hallModel.getPlaceName(),main ,damount, quantity,commissionFeeRate, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					
					
					String [] hallScheduleIds = request.getParameterValues("hallScheduleId_"+hid);
					String [] scheduleDates = request.getParameterValues("scheduleDate_"+hid);
					String [] scheduleTimes = request.getParameterValues("scheduleTime_"+hid);
					String [] placePrices = request.getParameterValues("placePrice_"+hid);
					
					/*System.out.println("hallScheduleIds>>>>"+hallScheduleIds.length);
					System.out.println("scheduleDates>>>>>>>>>"+scheduleDates.length);
					System.out.println("scheduleTimes>>>>>>>>>"+scheduleTimes.length);
					System.out.println("placePrices>>>>>>>>>"+placePrices.length);*/
					if(null == scheduleDates || scheduleDates.length<=0){
					}else{
						int i=0;
						for (String placeDate : scheduleDates) {
							String scheduleTime = scheduleTimes[i];
							if("ALL".equals(scheduleTime)){
								List<HotelSchedule> hotelSchedules = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDate(order.getHotelId(), Long.valueOf(hid), placeDate);
								for (HotelSchedule hotelSchedule : hotelSchedules) {
									Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
									String hschdlTime = category.getName();
									Double hallschedulePrice = Double.valueOf(placePrices[i])/3;
									if(hschdlTime.equals("中午")){
										hallschedulePrice = 0D;
									}
									ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
											, hotelSchedule.getId(), placeDate, hschdlTime, hallschedulePrice,1L,order.getSourceAppId(), order.getOrderSource()
											, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
											, "", null, new Date(), bookState, "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
									this.scheduleBookingDao.save(scheduleBooking);
									if(order.getSettlementStatus().equals("01")){
										hotelSchedule.setState("1");
									}else{
										hotelSchedule.setState("2");
									}
									this.hotelScheduleDao.save(hotelSchedule);
								}
								
								quantity+=1;
								damount+=Double.valueOf(placePrices[i]);
							}else{
								String pschs[] = scheduleTime.split("#");
								Double cprice = Double.valueOf(placePrices[i]);
								for (String placeSchedule : pschs) {
									HotelSchedule hotelSchedule = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(order.getHotelId(), Long.valueOf(hid), placeDate, placeSchedule);
									Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
									String hschdlTime = category.getName();
									Double uprice = cprice/pschs.length;
									quantity+=1;
									damount+=uprice;
									
									ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
											, hotelSchedule.getId(), placeDate, hschdlTime, uprice,1L,order.getSourceAppId(), order.getOrderSource()
											, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
											, "", null, new Date(), bookState, "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
									
									this.scheduleBookingDao.save(scheduleBooking);
									
									if(order.getSettlementStatus().equals("01")){
										hotelSchedule.setState("1");
									}else{
										hotelSchedule.setState("2");
									}
									
									this.hotelScheduleDao.save(hotelSchedule);
								}
								
							}
							
							i++;
						}
					}
					
					
					siteAmount+=damount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(damount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(roomIds)){
				String [] rmids = roomIds.substring(1).split("#");
				for (String rid : rmids) {
					String []breakfasts = request.getParameterValues("breakfast_"+rid);
					String []roomscheduleDates = request.getParameterValues("roomscheduleDate_"+rid);
					String []romNums = request.getParameterValues("rom_num_"+rid);
					String []roomPrices = request.getParameterValues("roomPrice_"+rid);
					
					System.out.println("breakfast>>>>>>>>>"+breakfasts.length);
					System.out.println("roomscheduleDate>>>>>>>>>"+roomscheduleDates.length);
					System.out.println("roomPrice>>>>>>>>>"+roomPrices.length);
					System.out.println("romNum>>>>>>>>>"+romNums.length);
					
					RoomModel roomModel = this.hotelPlaceService.getRoom(Long.valueOf(rid));
					Long quantity = 0L;
					Double ramount = 0.0D;	
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "02",roomModel.getId(), roomModel.getPlaceName(), "",ramount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					this.orderDetailDao.save(orderDetail);
					
					int i=0;
					for (String rsdate : roomscheduleDates) {
						Long num = Long.valueOf(romNums[i]);
						Double price = Double.valueOf(roomPrices[i]);
						quantity+=num;
						ramount+=price*num;
						
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "02", orderDetail.getPlaceId()
								,null, rsdate, "", price,num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"1","",0L);
						this.scheduleBookingDao.save(scheduleBooking);
						i++;
					}
					
					houseAmount+=ramount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(ramount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			if(StringUtils.isNotBlank(mealIds)){
				String [] mlIds = mealIds.substring(1).split("#");
				for (String mid : mlIds) {
					
					
					String []mealTypes = request.getParameterValues("mealType_"+mid);
					String []mealscheduleTimes = request.getParameterValues("mealscheduleTime_"+mid);
					String []meal_nums = request.getParameterValues("meal_num_"+mid);
					String []mealscheduleDates = request.getParameterValues("mealscheduleDate_"+mid);
					String []mealPrices = request.getParameterValues("mealPrice_"+mid);
					
					HotelMenu hotelMenu = this.hotelMenuService.getEntity(Long.valueOf(mid));
					Long quantity = 0L;
					Double mamount = 0D;
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "03", hotelMenu.getId(),hotelMenu.getName(), ""
							,mamount, quantity,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					int i = 0;
					for (String msdate : mealscheduleDates) {
						String type = mealTypes[i];
						Long num = Long.valueOf(meal_nums[i]);
						Double price = Double.valueOf(mealPrices[i]);
						quantity+=num;
						mamount+=price*num;
						ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "03", orderDetail.getPlaceId()
								,null, msdate, mealscheduleTimes[i], price, num,order.getSourceAppId(), order.getOrderSource()
								, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
								, "", null, new Date(), "1", type,order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"",type,10L);
						this.scheduleBookingDao.save(scheduleBooking);
						
						i++;
					}
					diningAmount+=mamount;
					orderDetail.setQuantity(quantity);
					orderDetail.setAmount(mamount);
					this.orderDetailDao.save(orderDetail);
				}
			}
			
			
			if(StringUtils.isNotBlank(otherdetail)){
				String [] odetails = otherdetail.split(",");
				String [] oprices = otherprice.split(",");
				for (int i=0;i<odetails.length;i++) {
					OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "09",null,odetails[i], ""
							,Double.valueOf(oprices[i]), 1L,0.0D, new Date(), "");
					orderDetail = this.orderDetailDao.save(orderDetail);
					otherAmount+=orderDetail.getAmount();
				}
			}
					
			
			
			siteCommissionFee = siteAmount*commissionFeeRate/100;
			amount = siteAmount+houseAmount+diningAmount+siteCommissionFee+otherAmount;
			zgamount = amount;
			Double finalPayment = amount-order.getPrepaid();
			
			/*System.out.println("otherAmount>>>>"+otherAmount);
			System.out.println("siteAmount>>>>"+siteAmount);
			System.out.println("roomAmount>>>>"+roomAmount);
			System.out.println("diningAmount>>"+diningAmount);
			System.out.println("siteCommissionFee>>>"+siteCommissionFee);
			System.out.println("amount>>>"+amount);
			System.out.println("zgamount>>>"+zgamount);
			System.out.println("finalPayment>>>"+finalPayment);*/
			
			order.setAmount(amount);
			order.setZgamount(zgamount);
			order.setOtherAmount(otherAmount);
			order.setSiteCommissionFee(siteCommissionFee);
			order.setSiteAmount(siteAmount);
			order.setRoomAmount(roomAmount);
			order.setDiningAmount(diningAmount);
			order.setFinalPayment(finalPayment);
			
			this.orderDao.save(order);
			
			try{
				String title = "订单通知";
				String ptext = "您的订单已修改，请及时处理！";
				chatRecordService.send("SYSTEM", "SYSTEM", order.getClientId(), order.getLinkman(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
				String content = order.getHotelName()+"订单【"+order.getOrderNo()+"】已被销售"+order.getHotelSaleName()+"于"+DateTimeUtils.getCurrentTimeStamp()+"修改；请知悉！";//"【会掌柜】"+
				//CallUtil.sendmsg(content, order.getContactNumber());
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=UPDATE&id=1";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
			}catch(Exception e){
			}
			
			return JsonUtils.success("提交成功！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
	}

	@Transactional(readOnly=false)
	public JsonVo bookingSave(HotelModel hotel, HallModel hall, String linkman, String company, String mobile,
			String activityTitle, String email, String placeDate, String scheduleTime, String scheduleTimeTxt) {
		String orderNo = RandomStringUtil.getOrderNo(6);
		String orderType = "ONLINE";
		try{
			Hotel mhotel = this.hotelService.getEntity(hotel.getId());
			HotelCooperationInfo  hotelCooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
			PlacePrice placePrice = this.placePriceService.findByPlaceIdAndPlaceSchedule(hall.getId(), placeDate);
			if(placePrice==null || placePrice.getOnlinePrice()==null){
				return JsonUtils.error("档期价格尚未设置！");
			}
			Double amount = placePrice.getOnlinePrice()*1;  
			Double zgamount = amount;
			Double siteAmount = placePrice.getOnlinePrice()*1;
			Double siteCommissionFee = 0D;
			Double roomAmount = 0D;
			Double diningAmount = 0D;
			Double otherAmount = 0D;
			Double prepaid = 0D;
			Double finalPayment = placePrice.getOnlinePrice()*1;
			
			SalerModel conpamySale = this.userService.getSaler(mhotel.getReclaimUserId());
			Order order = new Order(orderNo, orderType, 0L, "酒店自有客户", hotel.getCityText(), hotel.getId(), hotel.getHotelName(), hotel.getpName(), hotelCooperationInfo.getCommissionRights()
					, AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), AccountUtils.getCurrentUser().getMobile(), 0d, amount, zgamount, prepaid, finalPayment, siteAmount, siteCommissionFee, roomAmount, diningAmount
					,otherAmount, "", placeDate, activityTitle, company, linkman, mobile, "02", "00", new Date(), "酒店自有客户");
			order.setCompanySaleId(conpamySale.getId());
			order.setCompanySaleName(conpamySale.getRname());
			order.setCompanySaleMobile(conpamySale.getMobile());
			order.setZgdiscount(100D);
			order.setSettlementStatus("01");
			order.setOfflineState("1");
			order.setEmail(email);
			
			order.setMeetingRemark(mhotel.getMeetingRemark());
			//order.setHouseRemark(mhotel.getHouseRemark());
			//order.setDinnerRemark(mhotel.getDinnerRemark());
			//order = this.orderDao.save(order);
			
			OrderDetail orderDetail = new OrderDetail(order.getOrderNo(), "01", hall.getId(), hall.getPlaceName(),"1" ,siteAmount, 1L,0D, new Date(), "");
			orderDetail = this.orderDetailDao.save(orderDetail);
			String pschs[] = scheduleTime.split("#");
			Double cprice = 0D;
			Long quantity = 0L;
			if(pschs.length>=3){
				cprice = placePrice.getOnlinePrice()*3;
			}else{
				cprice = placePrice.getOnlinePrice()*pschs.length;
			}
			for (String placeSchedule : pschs) {
				HotelSchedule hotelSchedule = this.hotelScheduleDao.findByHotelIdAndPlaceIdAndPlaceDateAndPlaceSchedule(order.getHotelId(), hall.getId(), placeDate, placeSchedule);
				Category category = this.categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule()));
				String hschdlTime = category.getName();
				Double uprice = cprice/pschs.length;
				quantity+=1;
				
				ScheduleBooking scheduleBooking = new ScheduleBooking(order.getHotelId(), order.getOrderNo(), orderDetail.getId(),  "01", orderDetail.getPlaceId()
						, hotelSchedule.getId(), placeDate, hschdlTime, uprice,1L,order.getSourceAppId(), order.getOrderSource()
						, order.getClientId(), order.getOrganizer(), order.getLinkman(), order.getContactNumber(), order.getHotelSaleId(), order.getHotelSaleName()
						, "", null, new Date(), "1", "",order.getHotelSaleId(),order.getHotelSaleName(),order.getHotelSaleMobile(),"","",0L);
				
				this.scheduleBookingDao.save(scheduleBooking);
				
				if(order.getSettlementStatus().equals("01")){
					hotelSchedule.setState("1");
				}else{
					hotelSchedule.setState("2");
				}
				
				this.hotelScheduleDao.save(hotelSchedule);
			}
			orderDetail.setQuantity(quantity);
			orderDetail.setAmount(cprice);
			this.orderDetailDao.save(orderDetail);
			siteAmount = cprice;
			amount = cprice;
			zgamount = amount;
			finalPayment = zgamount;
			
			order.setAmount(amount);
			order.setZgamount(zgamount);
			order.setOtherAmount(otherAmount);
			order.setSiteCommissionFee(siteCommissionFee);
			order.setSiteAmount(siteAmount);
			order.setRoomAmount(roomAmount);
			order.setDiningAmount(diningAmount);
			order.setFinalPayment(finalPayment);
			
			this.orderDao.save(order);
			
			return JsonUtils.success("提交成功！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("提交失败！");
		}
	}

	//每月酒店订单数、订单总额汇总
	public List<MonthSummary> getSummaryInfo(String startTime, String endTime) {
		// TODO Auto-generated method stub
		String hotelIds = null;
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				hotelIds = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
			}else{
				hotelIds = AccountUtils.getCurrentUserHotelId();
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
		}
		String columStr = " hotel_name as hotelName, SUM(amount) as totalMoney, COUNT(*) as totalOrder";
		String fromWhere = " from hui_order WHERE create_date BETWEEN '"+startTime+"' AND '"+endTime+"' AND (state = 6 or state = 2 or state = 4)";
		if(StringUtils.isNotEmpty(hotelIds)){
			fromWhere += " and hotel_id in ("+hotelIds+")";
		}
		fromWhere += " GROUP BY hotel_id";
		PageBean<MonthSummary> pageBean = new PageBean<MonthSummary>();
		return customPageService.getAll(pageBean, columStr, fromWhere, MonthSummary.class);
	}

	public List<CommissionSum> getCommissionSumInfo(Long hotelId,String startTime, String endTime) {
		// TODO Auto-generated method stub
		Long hotelpid = null;
		String hotelIds = null;
		String csaleIds = null;
		String hsaleIds = null;
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("company_sales")){
				csaleIds = AccountUtils.getCurrentUserId();
			}else if(SecurityUtils.getSubject().hasRole("company_operate")){
				
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				hotelpid = AccountUtils.getCurrentUser().getPhtlid();//this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
			}else{
				hotelIds = AccountUtils.getCurrentUserHotelId();
			}
			
			if(SecurityUtils.getSubject().hasRole("hotel_sales")){
				hsaleIds = AccountUtils.getCurrentUserId();
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
		}
		String columStr = " h.hotel_name as hotelName, SUM(c.amount) as totalOrderMoney, SUM(c.commission_amount) as totalCommissionAmount, COUNT(*) as totalCommissionOrder";
		String fromWhere = " FROM hui_comission_record AS c left join hui_order o on o.order_no = c.order_no left join hui_hotel h on h.id = c.hotel_id where 1=1";
		if(StringUtils.isNotBlank(startTime)){
			startTime = startTime + " 00:00:00";
			fromWhere += " and o.activity_date >='"+startTime+"'";
		}
		if(StringUtils.isNotBlank(endTime)){
			endTime =  endTime + " 23:59:59";
			fromWhere += " and o.activity_date <='"+endTime+"'";
		}
		if(hotelId!=null){
			fromWhere += " and c.hotel_id ="+hotelId;
		}else{
			if(StringUtils.isNotEmpty(hotelIds)){
				fromWhere += " and c.hotel_id ="+hotelIds;
			}
		}
		if(hotelpid!=null){
			fromWhere += " and h.pid ="+hotelpid;
		}
		if(StringUtils.isNotBlank(csaleIds)){
			fromWhere += " and o.company_sale_id ='"+csaleIds+"'";
		}
		if(StringUtils.isNotBlank(hsaleIds)){
			fromWhere += " and o.hotel_sale_id ='"+hsaleIds+"'";
		}
		fromWhere += " GROUP BY c.hotel_id";
		System.out.println("select "+columStr+" "+fromWhere);
		//List<Object> list = this.
		PageBean<CommissionSum> pageBean = new PageBean<CommissionSum>();
		pageBean.setSort("c.id");
		return customPageService.getAll(pageBean, columStr, fromWhere, CommissionSum.class,null);
	}

	@Transactional(readOnly=false)
	public JsonVo confirmQuotation(Long id) {
		try{
			Order order = this.getEntity(id);
			if("02".equals(order.getState())){
				order.setState("021");
				order.setConfirmQuotationDate(new Date());
				order.setConfirmQuotationUser(AccountUtils.getCurrentUserId());
				this.orderDao.save(order);
				return JsonUtils.success("确认报价成功！");
			}else{
				return JsonUtils.error("只有处理中的订单方可确认报价！");
			}
		}catch(Exception e){
			return JsonUtils.error("系统错误！");
		}
	}

	@Transactional(readOnly=false)
	public JsonVo orderInvalid(Long id) {
		Order order = this.getEntity(id);
		
		if(order.getState().compareTo("01")>0&&order.getState().compareTo("05")<0){
			User sale = this.userService.getEntity(order.getHotelSaleId());
			
			if(!order.getCommissionStatus().equals("00")){
				ComissionRecord comissionRecord = comissionRecordDao.findByOrderNo(order.getOrderNo());
				comissionCheckRecordDao.querydelete("delete from ComissionCheckRecord c where c.recordId = "+comissionRecord.getId());
				comissionRecordDao.delete(comissionRecord);
			}
			
			order.setCancelDate(new Date());
			order.setCancelMemo("订单无效！");
			order.setCancelReason("订单无效！");
			order.setCommissionStatus("00");
			if(order.getSettlementStatus().compareTo("02")>=0){
				order.setState("11");
				order.setRefundAmount(order.getPrepaid());
				order.setRefundDate(new Date());
				order.setRefundMemo("订单无效！");
				order.setRefundReason("订单无效！");
			}else{
				order.setState("05");
			}
			this.orderDao.save(order);
			chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG","订单通知", "编号【"+order.getOrderNo()+"】的订单，客户已标记失败！", order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
			CallUtil.sendmsg("编号【"+order.getOrderNo()+"】的订单，客户已标记失败！", sale.getMobile());//【会掌柜】
			
		}else{
			return  JsonUtils.error("该订单前置状态错误，该订单无法操作！");
		}
		if(StringUtils.isNotBlank(order.getNotifyUrl())){
			String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CLOSESUCCESS";
			HttpUtils.doPost(order.getNotifyUrl(),params);
		}
		
		return JsonUtils.success("操作成功！");
	}

	@Transactional(readOnly=false)
	public JsonVo orderSaleChangeSave(Long orderId, String saleId) {
		Order order = this.getEntity(orderId);
		order.setOriginalHotelSale(order.getHotelSaleId());
		order.setHotelSaleId(saleId);
		this.orderDao.save(order);
		return JsonUtils.success("修改成功！");
	}
}
