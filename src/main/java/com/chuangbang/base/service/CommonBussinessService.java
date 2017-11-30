package com.chuangbang.base.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.OrderModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.dao.hotel.CategoryDao;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.hotel.HotelDynamicDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;
import com.chuangbang.base.dao.hotel.ScheduleBookingDao;
import com.chuangbang.base.dao.order.ComissionRecordDao;
import com.chuangbang.base.dao.order.OrderDao;
import com.chuangbang.base.dao.user.ChatRecordDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.order.ScheduleBooking;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.ScheduleBookingService;
import com.chuangbang.base.service.order.ComissionRecordService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.framework.util.RandomStringUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.plugins.sms.util.CallUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Component
@Transactional(readOnly = true)
public class CommonBussinessService {
	
	@Autowired
	private ScheduleBookingService scheduleBookingService;
	@Autowired
	private ScheduleBookingDao scheduleBookingDao;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private ChatRecordDao chatRecordDao;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private ComissionRecordDao comissionRecordDao;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private ComissionRecordService comissionRecordService;
	@Autowired
	private HotelDynamicDao hotelDynamicDao;
	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private HotelPlaceDao hotelPlaceDao;
	@Autowired
	private HotelScheduleDao hotelScheduleDao;
	
	@Autowired
	private CategoryDao categoryDao;
	@Transactional(readOnly = false)
	public void queryAndCancelUnDealOrder() {
		String crtDay = DateTimeUtils.getCurrentDate();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("LTE_placeDate", crtDay);
		filterParams.put("EQ_state", "1");
		List<ScheduleBooking> bookings = this.scheduleBookingService.getEntities(filterParams);
		for (ScheduleBooking scheduleBooking : bookings) {
			Order order = this.orderDao.findByOrderNo(scheduleBooking.getOrderNo());
			if(order!=null&&"01".equals(order.getSettlementStatus())){
				if("01".equals(order.getState())||"02".equals(order.getState())||"04".equals(order.getState())){
					order.setCancelDate(new Date());
					order.setCancelMemo("过期无效订单处理");
					order.setCancelReason("过期无效订单处理");
					order.setState("10");
					scheduleBooking.setState("4");
					scheduleBookingDao.save(scheduleBooking);
					this.orderDao.save(order);
					if(StringUtils.isNotBlank(order.getNotifyUrl())){
						String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CANCEL";
						HttpUtils.doPost(order.getNotifyUrl(),params);
					}
				}
			}else{
				
			}
		}
	}

	@Transactional(readOnly = false)
	public void cancelUnDealOrder() {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_state", "01");
		filterParams.put("EQ_orderType", "ONLINE");
		filterParams.put("NE_clientId", "");
		filterParams.put("NE_sourceAppId", "0");
		List<Order> orders = this.orderService.getEntities(filterParams);
		long crt = new Date().getTime();
		String batchId = RandomStringUtil.getWthdrwNo(8);
		for (Order order : orders) {
			if((crt-order.getCreateDate().getTime())>30*60*1000){
				order.setState("03");
				order.setMemo("30分钟无处理订单!");
				this.orderDao.save(order);
				
				List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
				for (ScheduleBooking scheduleBooking : bookings) {
					scheduleBooking.setState("4");
					scheduleBookingDao.save(scheduleBooking);
				}
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=CANCEL";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
				String content = "很遗憾您的订单【"+order.getOrderNo()+"】超过30分钟无人处理，已被标记为无处理订单；你可以上网站上处理订单;继续等待或结束订单！";//【会掌柜】
				CallUtil.sendmsg(content, order.getContactNumber());
				ChatRecord chatRecord = new ChatRecord("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", "订单无处理通知", "订单【"+order.getOrderNo()+"】超过30分钟无处理；已被标记为无处理！", new Date(), "1", order.getHotelId(), order.getHotelName(), "ORDER", order.getId()+"", "",batchId);
				chatRecordDao.save(chatRecord);
				User sale = this.userDao.findOne( order.getHotelSaleId());
				CallUtil.sendmsg("订单【"+order.getOrderNo()+"】超过30分钟无处理；已被标记为无处理！", sale.getMobile());//【会掌柜】
				
				if(StringUtils.isNotBlank(order.getNotifyUrl())){
					String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=ACCEPT";
					HttpUtils.doPost(order.getNotifyUrl(),params);
				}
			}else if((crt-order.getCreateDate().getTime())<30*60*1000&&(crt-order.getCreateDate().getTime())>20*60*1000){
				if(order.getCompanyFollowTime()==null){
					ChatRecord chatRecord = new ChatRecord("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", "订单无处理通知", "订单【"+order.getOrderNo()+"】下单已超过20分钟；请及时处理！", new Date(), "1", order.getHotelId(), order.getHotelName(), "ORDER", order.getId()+"", "",batchId);
					chatRecordDao.save(chatRecord);
					User sale = this.userDao.findOne( order.getHotelSaleId());
					CallUtil.sendmsg("订单【"+order.getOrderNo()+"】下单已超过20分钟；请及时处理！", sale.getMobile());//【会掌柜】
					Hotel hotel = this.hotelService.getEntity(order.getHotelId());
					SalerModel companySale = userService.getSaler(hotel.getReclaimUserId());
					order.setCompanyFollowTime(new Date());
					order.setCompanyFollowSaleId(companySale.getId());
					order.setCompanyFollowSaleName(companySale.getRname());
					ChatRecord chatRecord2 = new ChatRecord("SYSTEM", "SYSTEM", companySale.getId(), companySale.getRname(), "SYSTEMMSG", "订单处理通知", "订单【"+order.getOrderNo()+"】下单已超过20分钟,酒店销售尚未进行处理；请及时联系酒店销售处理！", new Date(), "1", order.getHotelId(), order.getHotelName(), "ORDER", order.getId()+"", "",batchId);
					chatRecordDao.save(chatRecord2);
					CallUtil.sendmsg("订单【"+order.getOrderNo()+"】下单已超过20分钟,酒店销售尚未进行处理；请及时联系酒店销售处理！", companySale.getMobile());//【会掌柜】
				}
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void queryAndRemindUnCommissionOrder() {
		List<OrderModel> orders = orderService.getCommissionOrder(5);
		String batchId = RandomStringUtil.getWthdrwNo(8);
		for (OrderModel orderModel : orders) {
			ChatRecord chatRecord = chatRecordService.findByToUserIDAndMsgTypeAndItemTypeAndItemIdAndTitle("hotel_finance","SYSTEMMSG","ORDER",orderModel.getId()+"", "返佣提醒");
			if(chatRecord==null){
				chatRecord = new ChatRecord("SYSTEM", "SYSTEM", "hotel_finance", "hotel_finance", "SYSTEMMSG", "返佣提醒", "订单【"+orderModel.getOrderNo()+"】可以进行返佣操作；请及时处理！", new Date(), "1", orderModel.getHotelId(), orderModel.getHotelName(), "ORDER", orderModel.getId()+"", "",batchId);
				chatRecordDao.save(chatRecord);
			}
		}
		
	}
	@Transactional(readOnly = false)
	public JsonVo queryAndCommissionOrder() {
		try{
			Map<String, Object> filterParams = Maps.newHashMap();
			filterParams.put("OR_EQ;state", "021,04,06,07");
			filterParams.put("EQ_commissionStatus", "00");
			filterParams.put("EQ_sourceAppId", "1");
			filterParams.put("GTE_activityDate", DateTimeUtils.getFirstDayOfLastMonth());
			filterParams.put("LT_activityDate", DateTimeUtils.getFirstDayOfMonth());
			List<Order> orders = orderService.getEntities(filterParams);
			int n= 0;
			for (Order order : orders) {
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());
				HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
					
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
					dinnerCommission = comissionRecordService.calculatedRoomCommission(order,cooperationInfo);// order.getDiningAmount()*cooperationInfo.getDinnerCommission()/100;
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
				order.setIscommissionupdate("0");
				this.orderDao.save(order);
				
				try{
					String ptext = AccountUtils.getCurrentRName()+"在"+DateTimeUtils.getCurrentDate()+"发起了一笔【"+order.getOrderNo()+"】订单的返佣！";
					chatRecordService.log("LOG", "发起返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "发起返佣日志");
					ptext+="请及时审核处理！";
					chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "发起返佣");
				}catch(Exception e){
				}
				n++;
			}
			if(n==0){
				return JsonUtils.success("目前无订单需返佣！");
			}else{
				return JsonUtils.success("发起"+n+"单返佣成功！");
			}
		}catch(Exception e){
			return JsonUtils.error("系统错误！");
		}
	}
	
	/**
	 * 订单过期
	 */
	@Transactional(readOnly = false)
	public void queryAndCancelTimeOutOrder() {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("OR_EQ;state", "02,021,04");
		filterParams.put("EQ_commissionStatus", "00");
		filterParams.put("EQ_sourceAppId", "1");
		filterParams.put("LT_activityDate", DateTimeUtils.getCurrentDate());
		List<Order> orders = orderService.getEntities(filterParams);
		for (Order order : orders) {
			order.setState("05");
			order.setMemo(order.getMemo()+"\\n活动日期过期，无处理订单!");
			this.orderDao.save(order);
			
			List<ScheduleBooking> bookings = this.scheduleBookingDao.findByHotelIdAndOrderNoAndClientId(order.getHotelId(),order.getOrderNo(),order.getClientId());
			for (ScheduleBooking scheduleBooking : bookings) {
				scheduleBooking.setState("4");
				scheduleBookingDao.save(scheduleBooking);
			}
			if(StringUtils.isNotBlank(order.getNotifyUrl())){
				String params = "type=ORDER&orderNo="+order.getOrderNo()+"&action=TIMEOUT";
				HttpUtils.doPost(order.getNotifyUrl(),params);
			}
		}
	}

	public Long itemCount(String item) {
		Long num = 0L;

		if("order".equals(item)){
			String nnq = "select count(*) from hui_order where 1=1";
			List<Object> params = Lists.newArrayList();
			nnq += " and offline_state=?";
			params.add(1);
			
			//and o.offline_state = '1'
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
					String hotelids = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
					hotelids = hotelids.replace(",", "','");
					nnq += " and hotel_id in('"+hotelids+"')";
				}else{
					nnq += " and hotel_id=?";
					params.add(AccountUtils.getCurrentUserHotelId());
					if(AccountUtils.isRole("hotel_sales")){
						nnq += " and hotel_sale_id=?";
						params.add(AccountUtils.getCurrentUserId());
					}else if(AccountUtils.isRole("hotel_finance")){
						nnq += " and (state = '04' or state = '06' or state = '07' or state = '11')";
					}else{
						
					}
					
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				/*nnq += " and source_app_id=?";
				params.add(1);*/
				if(AccountUtils.isRole("company_sales")){
					nnq += " and company_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}else{
					
				}
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				String hotelids = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}
			
			List<Object> res = this.orderDao.executeNativeQuery(nnq, params);
			if(null!=res&&res.size()>0){
				num = res.get(0)==null?0L:Long.valueOf(res.get(0)+"");
			}
		}else if("user".equals(item)){
			String nnq = "select count(*) from hui_user u left join hui_group g on g.id = u.group_id  where 1=1";
			List<Object> params = Lists.newArrayList();
			
			
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				nnq += " and u.state=?";
				params.add(1);
				nnq += " and u.user_type=?";
				params.add("HOTEL");
				if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
					nnq += " and u.phtlid =?";
					params.add(AccountUtils.getCurrentUser().getPhtlid());
					nnq += " and g.group_id like 'group%'";
					
				}else{
					nnq += " and g.group_id like 'hotel%'";
					nnq += " and u.hotel_id=?";
					params.add(AccountUtils.getCurrentUserHotelId());
					
					/*if(AccountUtils.isRole("hotel_sales")){
					}else{
						
					}*/
				}
				
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				/*nnq += " and create_user_id=?";
				params.add(AccountUtils.getCurrentUserId());*/
				nnq += " and (u.user_type=? or u.user_type=?)";
				params.add("HUI");
				params.add("PARTNER");
				
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				nnq += " and u.user_type=?";
				params.add("PARTNER");
				nnq += " and u.company_id =?";
				params.add(AccountUtils.getCurrentUser().getCompanyId());
			}
			
			List<Object> res = this.userDao.executeNativeQuery(nnq, params);
			if(null!=res&&res.size()>0){
				num = res.get(0)==null?0L:Long.valueOf(res.get(0)+"");
			}
		}else if("dongtai".equals(item)){
			String nnq = "select count(*) from hui_hotel_dynamic where 1=1";
			List<Object> params = Lists.newArrayList();
			/*nnq += " and iscase=?";
			params.add(1);*/
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
					String hotelids = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
					hotelids = hotelids.replace(",", "','");
					nnq += " and hotel_id in('"+hotelids+"')";
				}else{
					nnq += " and hotel_id=?";
					params.add(AccountUtils.getCurrentUserHotelId());
					
					/*if(AccountUtils.isRole("hotel_sales")){
					}else{
						
					}*/
				}
				
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				/*nnq += " and create_user_id=?";
				params.add(AccountUtils.getCurrentUserId());*/
				
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				String hotelids = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}
			List<Object> res = this.hotelDynamicDao.executeNativeQuery(nnq, params);
			if(null!=res&&res.size()>0){
				num = res.get(0)==null?0L:Long.valueOf(res.get(0)+"");
			}
		}else if("site".equals(item)){
			String nnq = "select count(*) from hui_hotel where 1=1";
			List<Object> params = Lists.newArrayList();
			
			nnq += " and state=?";
			params.add(1);
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
					nnq += " and pid =?";
					params.add(AccountUtils.getCurrentUser().getPhtlid());
					
				}else{
					nnq += " and id=?";
					params.add(AccountUtils.getCurrentUserHotelId());
					
					/*if(AccountUtils.isRole("hotel_sales")){
					}else{
						
					}*/
				}
				
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.isRole("company_sales")){
					nnq += " and reclaim_user_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}
				/*nnq += " and create_user_id=?";
				params.add(AccountUtils.getCurrentUserId());*/
				
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				nnq += " and company_id =?";
				params.add(AccountUtils.getCurrentUser().getCompanyId());
			}
			
			List<Object> res = this.hotelDao.executeNativeQuery(nnq, params);
			if(null!=res&&res.size()>0){
				num = res.get(0)==null?0L:Long.valueOf(res.get(0)+"");
			}
		}
		return num;
	}

	@Transactional(readOnly=false)
	public void queryAndAddHotelSchedule(int days) {
		List<HotelPlace> hotelPlaces = this.hotelPlaceDao.findByPlaceType("HALL");
		String crtDate = DateTimeUtils.getCurrentDate();
		if(hotelPlaces!=null&&hotelPlaces.size()>0){
			List<Category> categories = this.categoryDao.findByKind("SCHEDULETIME");
			for (HotelPlace hotelPlace : hotelPlaces) {
				String placeDate = getMaxPlaceDate(hotelPlace.getId());
				System.out.println("placeDate>>>>>>>>"+placeDate);
				Date pdate = DateUtils.parseDate(placeDate);
				for(int i=1;i<=days;i++){
					Date date = DateUtils.addDays(pdate, i);
					for (Category category : categories) {
						String sdate = DateTimeUtils.toDay(date);
						HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(hotelPlace.getId(),sdate,category.getId()+"");
						if(schedule==null){
							schedule = new HotelSchedule(hotelPlace.getHotelId(), "", hotelPlace.getPlaceType(), hotelPlace.getId(), hotelPlace.getPlaceName(), category.getId()+"", sdate, "0", "SYSTEM", "SYSTEM", new Date(), "");
							this.hotelScheduleDao.save(schedule);
						}
					}
				}
			}
		}
	}

	private String getMaxPlaceDate(Long id) {
		String nnq="select max(place_date) from hui_hotel_schedule where place_id=? group by place_id";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		List<Object> res = this.hotelScheduleDao.executeNativeQuery(nnq, params);
		if(res!=null&&res.size()>0){
			System.out.println(res.get(0)+"");
			return res.get(0)==null||StringUtils.isBlank(res.get(0).toString())?DateTimeUtils.getCurrentDate():res.get(0).toString();
		}
		return DateTimeUtils.getCurrentDate();
	}

	public Long itemTipsCount(String item, String crttype) {
		
		String nnq = "select count(*) from {table} where 1=1";
		List<Object> params = Lists.newArrayList();
		if("prc".equals(item)){
			nnq = nnq.replace("{table}", "hui_price_trial");
			
			if("GROUP".equals(AccountUtils.getCurrentUserType())){
			}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.isRole("company_sales")){
					nnq += " and state=0";
				}else if(AccountUtils.isRole("company_administrator")){
					nnq += " and state=1";
				}else if(AccountUtils.isRole("administrator")){
					nnq += " and (state=0 or state=1)";
				}
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				nnq = "select count(*) from hui_price_trial p left join hui_hotel h on h.id = p.hotel_id where 1=1 and h.company_id="+AccountUtils.getCurrentUserCompanyId();
			}
		}else if("rte".equals(item)){
			nnq = nnq.replace("{table}", "hui_hotel_cooperation_log");
			
			if("GROUP".equals(AccountUtils.getCurrentUserType())){
			}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.isRole("company_administrator")){
					nnq += " and state=0";
				}else if(AccountUtils.isRole("administrator")){
					nnq += " and state=0";
				}
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				nnq = "select count(*) from hui_hotel_cooperation_log p left join hui_hotel h on h.id = p.hotel_id where 1=1 and h.company_id="+AccountUtils.getCurrentUserCompanyId();
			}
		}else if("cms".equals(item)){
			nnq = nnq.replace("{table}", "hui_order");
			nnq += " and (state='021' or state='04' or state='06' or state='07')";
			nnq += " and source_app_id<>0";
			nnq += " and activity_date<='"+DateTimeUtils.getCurrentDate()+"'";
			nnq += " and activity_date>='"+DateTimeUtils.getFirstDayOfMonth()+"'";
			nnq += " and offline_state=1";
			if("GROUP".equals(AccountUtils.getCurrentUserType())){
				String hotelids = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				
				nnq += " and hotel_id=?";
				params.add(AccountUtils.getCurrentUserHotelId());
				if(AccountUtils.isRole("hotel_sales")){
					nnq += " and hotel_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}else if(AccountUtils.isRole("hotel_administrator")){
					/*nnq += " and hotel_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());*/
				}else{
					nnq += " and hotel_sale_id=-1";
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				/*nnq += " and source_app_id=?";
				params.add(1);*/
				if(AccountUtils.isRole("company_sales")){
					nnq += " and company_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}else{
					
				}
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				String hotelids = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}
			
		}else if("ord".equals(item)){
			nnq = nnq.replace("{table}", "hui_order");
			nnq += " and offline_state=1";
			nnq += " and (state<='021' or state='04')";
			//and o.offline_state = '1'
			if("GROUP".equals(AccountUtils.getCurrentUserType())){
				String hotelids = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				
				nnq += " and hotel_id=?";
				params.add(AccountUtils.getCurrentUserHotelId());
				if(AccountUtils.isRole("hotel_sales")){
					nnq += " and hotel_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}else if(AccountUtils.isRole("hotel_administrator")){
					/*nnq += " and hotel_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());*/
				}else{
					nnq += " and hotel_sale_id=-1";
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())){
				/*nnq += " and source_app_id=?";
				params.add(1);*/
				if(AccountUtils.isRole("company_sales")){
					nnq += " and company_sale_id=?";
					params.add(AccountUtils.getCurrentUserId());
				}else{
					
				}
			}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
				String hotelids = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
				hotelids = hotelids.replace(",", "','");
				nnq += " and hotel_id in('"+hotelids+"')";
			}
			
		}else if("usr".equals(item)){
			nnq = nnq.replace("{table}", "hui_apply_record");
			if("HUI".equals(crttype)){
				nnq += " and hotel_id=0 and state = 0 and type ='HUI'";
			}else if("HOTEL".equals(crttype)){
				nnq += " and hotel_id=? and state = 0 and type ='HOTEL'";
				params.add(AccountUtils.getCurrentUserHotelId());
			}else if("GROUP".equals(crttype)){
				nnq += " and hotel_id=? and state = 0 and type ='GROUP'";
				params.add(AccountUtils.getCurrentUserhotelPId());
			}else{
				nnq += " and hotel_id=0 and state = 0 and type ='PARTNER'";
			}
		}else if("ste".equals(item)){
			nnq = nnq.replace("{table}", "");
		}else if("ivt".equals(item)){
			nnq = nnq.replace("{table}", "");
		}
		System.out.println(">>>>>>>>>>>>>>"+nnq);
		Long num = 0L;
		List<Object> res = this.hotelDao.executeNativeQuery(nnq, params);
		if(null!=res&&res.size()>0){
			num = res.get(0)==null?0L:Long.valueOf(res.get(0)+"");
		}	
		return num;
	}
}
