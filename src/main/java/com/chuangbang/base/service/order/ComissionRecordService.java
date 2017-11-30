package com.chuangbang.base.service.order;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.app.model.BookingRecordModel;
import com.chuangbang.app.model.RoomOrderDetailModel;
import com.chuangbang.base.dao.order.ComissionCheckRecordDao;
import com.chuangbang.base.dao.order.ComissionRecordDao;
import com.chuangbang.base.dao.order.OrderDao;

/**
 * 返佣记录Service
 * @author heaven
 * @version 2017-03-08
 */
@Component
@Transactional(readOnly = true)
public class ComissionRecordService extends BaseService<ComissionRecord,ComissionRecordDao> {

	@Autowired
	private ComissionRecordDao comissionRecordDao;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private PlacePriceService placePriceService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ComissionCheckRecordDao comissionCheckRecordDao;
	public ComissionRecord getEntity(Long id) {
		return comissionRecordDao.findOne(id);
	}
	
	public ComissionRecord findByOrderNo(String orderNo) {
		return comissionRecordDao.findByOrderNo(orderNo);
	}
	@Transactional(readOnly = false)
	public void saveComissionRecord(ComissionRecord comissionRecord) {
		comissionRecordDao.save(comissionRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		comissionRecordDao.delete(id);
	}
	
	/**
	 * 发起返佣
	 * @param order
	 * @return
	 */
	@Transactional(readOnly = false)
	public JsonVo comission(Order order) {
		Json json = new Json();
		try{
			Hotel hotel = this.hotelService.getEntity(order.getHotelId());
			HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
			if(iscomission(order,json,hotel,cooperationInfo)){
				
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
				comissionRecord.setIsupdate("0");
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
				
				/*try{
					String ptext = hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+"确认了一笔【"+order.getOrderNo()+"】订单的返佣！";
					chatRecordService.log("LOG", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
					ptext+="请及时审核处理！";
					chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
				}catch(Exception e){
				}*/
				
				try{
					String ptext = AccountUtils.getCurrentRName()+"在"+DateTimeUtils.getCurrentDate()+"发起了一笔【"+order.getOrderNo()+"】订单的返佣！";
					chatRecordService.log("LOG", "发起返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "发起返佣日志");
					ptext+="请及时审核处理！";
					chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "发起返佣");
				}catch(Exception e){
				}
				
				return JsonUtils.error("发起返佣操作成功，等待审核！");
			}else{
				return JsonUtils.error(json.getMsg());
			}
		}catch(Exception e){
			return JsonUtils.error("返佣操作异常！");
		}
	}
	
	public Double calculatedRoomCommission(Order order,HotelCooperationInfo cooperationInfo) {
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
	
	public Double calculatedRoomCommission(Long quantity,Double cmsnHouseAmount,Double cmsnHouseRate,Double onlinePrice,Double offlinePrice) {
		Double roomAllCommission = 0D;
		if(cmsnHouseAmount==null){
			roomAllCommission = (onlinePrice-offlinePrice)*quantity*(cmsnHouseRate/100);
		}else{
			roomAllCommission = cmsnHouseAmount*(cmsnHouseRate/100);
		}
		return roomAllCommission;
	}

	/**
	 * 返佣状态判断
	 * @param order
	 * @param json
	 * @param hotel
	 * @param cooperationInfo
	 * @return
	 */
	private boolean iscomission(Order order,Json json,Hotel hotel,HotelCooperationInfo cooperationInfo) {
		boolean iscomission = false;
		if((order.getState().equals("06")||order.getState().equals("07"))&&order.getCommissionStatus().equals("01")){
			if("1".equals(hotel.getHotelNature())&&AccountUtils.getCurrentUserHotelId().equals(hotel.getId()+"")
					&&AccountUtils.getCurrentUser().getGroupId().equals(10L)){
				iscomission = true;
			}else if("2".equals(hotel.getHotelNature())){
				if(cooperationInfo.getCommissionRights().equals("1")){
					if(AccountUtils.getCurrentUserHotelId().equals(hotel.getId()+"")
							&&AccountUtils.getCurrentUser().getGroupId().equals(10L)){
						iscomission = true;
					}else{
						json.setJson(false, "您没有返佣权限！");
					}
				}else if(cooperationInfo.getCommissionRights().equals("2")){
					if(AccountUtils.getCurrentUser().getCompanyId().equals(hotel.getPid())
							&&AccountUtils.getCurrentUser().getGroupId().equals(7L)){
						iscomission = true;
					}else{
						json.setJson(false, "您没有返佣权限！");
					}
				}else{
					json.setJson(false, "该订单信息异常！");
				}
			}else{
				json.setJson(false, "该订单信息异常！");
			}
		}else{
			json.setJson(false, "该订单不可进行返佣操作！");
		}
		return iscomission;
	}

	/**
	 * 审核开票
	 * @param order
	 * @return
	 */
	@Transactional(readOnly = false)
	public JsonVo invoiceSave(Order order,String invoiceNo,String invoiceUname,String invoiceDate) {
		try{
			if(!SecurityUtils.getSubject().hasRole("company_finance")){
				return JsonUtils.error("您没有操作权限！");
			}
			if(null==order||!order.getCommissionStatus().equals("02")){
				return JsonUtils.error("订单对应返佣信息错误！");
			}
			if(!order.getState().equals("021")&&!order.getState().equals("04")&&!order.getState().equals("06")&&!order.getState().equals("07")){
				return JsonUtils.error("订单对应返佣信息错误！");
			}
			ComissionRecord comissionRecord = this.comissionRecordDao.findByOrderNo(order.getOrderNo());
			if(comissionRecord==null){
				return JsonUtils.error("订单对应返佣信息错误！");
			}
			comissionRecord.setState("03");
			comissionRecord.setInvoiceDate(DateTimeUtils.string2Date(invoiceDate, DateTimeUtils.PATTERN_TO_DAY) );
			comissionRecord.setInvoiceUname(invoiceUname);
			comissionRecord.setInvoiceNo(invoiceNo);
			comissionRecord.setInvoiceOpUserId(AccountUtils.getCurrentUserId());
			comissionRecord.setInvoiceOpUserName(AccountUtils.getCurrentRName());
			this.comissionRecordDao.save(comissionRecord);
			order.setCommissionStatus("03");
			order.setInvoiceDate(comissionRecord.getInvoiceDate());
			order.setInvoiceNo(invoiceNo);
			order.setInvoiceUname(invoiceUname);
			order.setIsinvoice("1");
			this.orderDao.save(order);
			
			try{
				Hotel hotel = this.hotelService.getEntity(order.getHotelId());//hotel.getHotelName()+"在"+DateTimeUtils.getCurrentDate()+
				String ptext = hotel.getHotelName()+"的订单【"+order.getOrderNo()+"】的返佣发票已开出！";
				chatRecordService.log("LOG", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				chatRecordService.send("SYSTEM", "SYSTEM", "hotel_finance", "hotel_finance", "SYSTEMMSG", "订单返佣通知", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣");
				ptext+="请及时前往财务部领取！";
				chatRecordService.send("SYSTEM", "SYSTEM", hotel.getReclaimUserId(), hotel.getReclaimUserName(), "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
			
			return JsonUtils.success("填写开票信息成功！");
		}catch(Exception e){
			return JsonUtils.error("系统错误！");
		}
		
	}

	@Transactional(readOnly=false)
	public JsonVo batchCommission() {
		try{
			Map<String, Object> filterParams = Maps.newHashMap();
			filterParams.put("OR_EQ;state", "021,04,06,07");
			filterParams.put("EQ_commissionStatus", "00");
			filterParams.put("EQ_sourceAppId", "1");
			filterParams.put("LT_activityDate", DateTimeUtils.getCurrentDate());
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
					allCommission = order.getAmount()*cooperationInfo.getAllCommission()/100;
					commissionAmount = allCommission;
				}else if(cooperationInfo.getCommissionType().equals("2")){//分项返
					housingCommission = order.getRoomAmount()*cooperationInfo.getHousingCommission()/100;
					dinnerCommission = calculatedRoomCommission(order,cooperationInfo);// order.getDiningAmount()*cooperationInfo.getDinnerCommission()/100;
					mettingRoomCommission = order.getSiteAmount()*cooperationInfo.getMettingRoomCommission()/100;
					ortherCommission = order.getOtherAmount()*cooperationInfo.getOrtherCommission()/100;
					commissionAmount = housingCommission+dinnerCommission+mettingRoomCommission+ortherCommission;
				}else{
					return JsonUtils.error("该酒店尚未设置返佣类型！");
				}
				
				ComissionRecord comissionRecord = new ComissionRecord(hotel.getId(), order.getOrderNo(), order.getAmount(), cooperationInfo.getCommissionType()
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
			e.printStackTrace();
			return JsonUtils.error("系统错误！");
		}
		
		
	}

	
	/**
	 * 确认返佣
	 * @param order
	 * @return
	 */
	@Transactional(readOnly=false)
	public JsonVo cfmcomission(Order order) {
		try{
			ComissionRecord comissionRecord = this.findByOrderNo(order.getOrderNo());
			order.setCommissionStatus("02");
			comissionRecord.setState("02");
			this.comissionRecordDao.save(comissionRecord);
			this.orderDao.save(order);
			Hotel hotel = this.hotelService.getEntity(order.getHotelId());
			try{
				String ptext = hotel.getHotelName()+"财务"+AccountUtils.getCurrentRName()+"在"+DateTimeUtils.getCurrentDate()+"确认了一笔【"+order.getOrderNo()+"】订单的返佣！";
				chatRecordService.log("LOG", "确认返佣", ptext, hotel.getId(), hotel.getHotelName(), "comissionRecord", comissionRecord.getId()+"", "确认返佣日志");
				ptext+="请及时审核处理！";
				chatRecordService.send("SYSTEM", "SYSTEM", "company_finance", "company_finance", "SYSTEMMSG", "订单返佣通知", ptext, 0L, "HUI", "comissionRecord", comissionRecord.getId()+"", "确认返佣");
			}catch(Exception e){
			}
			return JsonUtils.success("确认返佣成功！");
		}catch(Exception e){
			return JsonUtils.error("系统错误！");
		}
	}
	
	@Transactional(readOnly=false)
	public JsonVo saveComissionRecord(String cmsn_type, Long cmsn_id, Double cmsn_amount, Double meeting_amount,
			Double house_amount, Double dinner_amount, Double other_amount,Long quantity) {
		try{
			ComissionRecord comissionRecord = this.getEntity(cmsn_id);
			if("01".equals(comissionRecord.getState())){
				//HotelCooperationInfo hotelCooperationInfo = this.hotelCooperationInfoService.findByHotelId(comissionRecord.getHotelId());
				/*if("1".equals(comissionRecord.getType())){
					comissionRecord.setAllCommission(cmsn_amount*comissionRecord.getAllCommissionRate()/100);
					comissionRecord.setCommissionAmount(cmsn_amount*comissionRecord.getAllCommissionRate()/100);
					comissionRecord.setAmount(cmsn_amount);
				}else{
					
					Double housingCommission = house_amount*comissionRecord.getHousingCommissionRate()/100;//calculatedRoomCommission(quantity,house_amount,comissionRecord.getHousingCommissionRate(),null,null);// order.getRoomAmount()*cooperationInfo.getHousingCommission()/100;
					Double dinnerCommission =  dinner_amount*comissionRecord.getDinnerCommissionRate()/100;
					Double mettingRoomCommission = meeting_amount*comissionRecord.getMettingRoomCommissionRate()/100;
					Double ortherCommission = other_amount*comissionRecord.getOrtherCommissionRate()/100;
					Double commissionAmount = housingCommission+dinnerCommission+mettingRoomCommission+ortherCommission;
					System.out.println("house_amount>>>>>"+house_amount);
					System.out.println("housingCommission>>>>>"+comissionRecord.getHousingCommissionRate());
					comissionRecord.setMeetingAmount(meeting_amount);
					comissionRecord.setHouseAmount(house_amount);
					comissionRecord.setDinnerAmount(dinner_amount);
					comissionRecord.setOtherAmount(other_amount);
					
					comissionRecord.setAmount(meeting_amount+house_amount+dinner_amount+other_amount);
					
					comissionRecord.setMettingRoomCommission(mettingRoomCommission);
					comissionRecord.setHousingCommission(housingCommission);
					comissionRecord.setDinnerCommission(dinnerCommission);
					comissionRecord.setOrtherCommission(ortherCommission);
					comissionRecord.setCommissionAmount(commissionAmount);
				}*/
				ComissionCheckRecord comissionCheckRecord = null;
				System.out.println(comissionRecord.getType());
				if("1".equals(comissionRecord.getType())){
					 comissionCheckRecord = new ComissionCheckRecord(comissionRecord.getId(), cmsn_amount, comissionRecord.getAmount(), comissionRecord.getType(), comissionRecord.getAllCommissionRate()
							, cmsn_amount*comissionRecord.getAllCommissionRate()/100, cmsn_amount*comissionRecord.getAllCommissionRate()/100, "0", null, new Date(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName());
				}else{
					System.out.println(comissionRecord.getType());
					Double housingCommission = house_amount*comissionRecord.getHousingCommissionRate()/100;//calculatedRoomCommission(quantity,house_amount,comissionRecord.getHousingCommissionRate(),null,null);// order.getRoomAmount()*cooperationInfo.getHousingCommission()/100;
					Double dinnerCommission =  dinner_amount*comissionRecord.getDinnerCommissionRate()/100;
					Double mettingRoomCommission = meeting_amount*comissionRecord.getMettingRoomCommissionRate()/100;
					Double ortherCommission = other_amount*comissionRecord.getOrtherCommissionRate()/100;
					Double commissionAmount = housingCommission+dinnerCommission+mettingRoomCommission+ortherCommission;
					Double amount = meeting_amount+house_amount+dinner_amount+other_amount;
					comissionCheckRecord = new ComissionCheckRecord(comissionRecord.getId(), meeting_amount, house_amount, dinner_amount, other_amount
							, comissionRecord.getMeetingAmount(), comissionRecord.getHouseAmount(), comissionRecord.getDinnerAmount(), comissionRecord.getOtherAmount()
							, comissionRecord.getType(), comissionRecord.getHousingCommissionRate(), housingCommission, comissionRecord.getDinnerCommissionRate(), dinnerCommission
							, comissionRecord.getMettingRoomCommissionRate(), mettingRoomCommission, comissionRecord.getOrtherCommissionRate(), ortherCommission, commissionAmount
							, "0", null, new Date(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName());
					comissionCheckRecord.setAmount(amount);
				}
				System.out.println(comissionCheckRecord);
				this.comissionCheckRecordDao.save(comissionCheckRecord);
				comissionRecord.setUpdateDate(new Date());
				comissionRecord.setUpdateUserId(AccountUtils.getCurrentUserId());
				comissionRecord.setUpdateUserName(AccountUtils.getCurrentRName());
				comissionRecord.setIsupdate("1");
				comissionRecord.setUpdateId(comissionCheckRecord.getId());
				this.comissionRecordDao.save(comissionRecord);
				Order order = this.orderDao.findByOrderNo(comissionRecord.getOrderNo());
				order.setIscommissionupdate("1");
				this.orderDao.save(order);
				return JsonUtils.success("修改成功,等待审核！");
			}else{
				return JsonUtils.error("财务已确认金额或未返佣，不可修改！");
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("系统错误！");
		}
	}
	
	@Transactional(readOnly=false)
	public JsonVo commissionUpdateUnpass(Long orderId, Long cmsnId, Long cmsnchkId) {
		try{
			ComissionRecord comissionRecord = this.getEntity(cmsnId);
			comissionRecord.setIsupdate("0");
			comissionRecord.setUpdateId(null);
			this.comissionRecordDao.save(comissionRecord);
			ComissionCheckRecord comissionCheckRecord = this.comissionCheckRecordDao.findOne(cmsnchkId);
			comissionCheckRecord.setState("-1");
			this.comissionCheckRecordDao.save(comissionCheckRecord);
			Order order = this.orderDao.findByOrderNo(comissionRecord.getOrderNo());
			order.setIscommissionupdate("0");
			this.orderDao.save(order);
			return JsonUtils.success("审核操作完成！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("系统错误！");
		}
	}
	
	@Transactional(readOnly=false)
	public JsonVo commissionCfm(Long orderId, Long cmsnId) {
		try{
			ComissionRecord comissionRecord = this.getEntity(cmsnId);
			comissionRecord.setIsupdate("9");
			this.comissionRecordDao.save(comissionRecord);
			Order order = this.orderDao.findByOrderNo(comissionRecord.getOrderNo());
			order.setIscommissionupdate("9");
			this.orderDao.save(order);
			return JsonUtils.success("审核操作完成！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("系统错误！");
		}
	}
	
	@Transactional(readOnly=false)
	public JsonVo commissionUpdatePass(Long orderId, Long cmsnId, Long cmsnchkId) {
		try{
			ComissionCheckRecord comissionCheckRecord = this.comissionCheckRecordDao.findOne(cmsnchkId);
			comissionCheckRecord.setState("1");
			this.comissionCheckRecordDao.save(comissionCheckRecord);
			
			ComissionRecord comissionRecord = this.getEntity(cmsnId);
			comissionRecord.setIsupdate("0");
			if("1".equals(comissionRecord.getType())){
				comissionRecord.setAllCommission(comissionCheckRecord.getAllCommission());
				comissionRecord.setCommissionAmount(comissionCheckRecord.getCommissionAmount());
				comissionRecord.setAmount(comissionCheckRecord.getAmount());
			}else{
				comissionRecord.setMeetingAmount(comissionCheckRecord.getMeetingAmount());
				comissionRecord.setHouseAmount(comissionCheckRecord.getHouseAmount());
				comissionRecord.setDinnerAmount(comissionCheckRecord.getDinnerAmount());
				comissionRecord.setOtherAmount(comissionCheckRecord.getOtherAmount());
				
				comissionRecord.setAmount(comissionCheckRecord.getAmount());
				
				comissionRecord.setMettingRoomCommission(comissionCheckRecord.getMettingRoomCommission());
				comissionRecord.setHousingCommission(comissionCheckRecord.getHousingCommission());
				comissionRecord.setDinnerCommission(comissionCheckRecord.getDinnerCommission());
				comissionRecord.setOrtherCommission(comissionCheckRecord.getOrtherCommission());
				comissionRecord.setCommissionAmount(comissionCheckRecord.getCommissionAmount());
			}
			comissionRecord.setUpdateDate(new Date());
			this.comissionRecordDao.save(comissionRecord);
			Order order = this.orderDao.findByOrderNo(comissionRecord.getOrderNo());
			order.setIscommissionupdate("0");
			this.orderDao.save(order);
			return JsonUtils.success("审核操作完成！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("系统错误！");
		}
	}
}
