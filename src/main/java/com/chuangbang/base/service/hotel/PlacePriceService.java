package com.chuangbang.base.service.hotel;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.base.dao.hotel.PlacePriceDao;
import com.chuangbang.base.dao.hotel.PriceAdjustDao;
import com.chuangbang.base.dao.hotel.PriceTrialDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.google.common.collect.Maps;

/**
 * 场地价格Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class PlacePriceService extends BaseService<PlacePrice,PlacePriceDao> {

	@Autowired
	private PlacePriceDao placePriceDao;
	@Autowired
	private PriceAdjustDao priceAdjustDao;
	@Autowired
	private PriceTrialDao priceTrialDao;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private UserService userService;
	@Autowired
	private PriceTrialService priceTrialService;
	
	public PlacePrice getEntity(Long id) {
		return placePriceDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void savePlacePrice(PlacePrice placePrice) {
		if(placePrice.getId()==null){
			placePrice.setCreateDate(new Date());
			placePrice.setCreateUserId(AccountUtils.getCurrentUserId());
			placePrice.setCreateUserName(AccountUtils.getCurrentRName());
		}
		placePriceDao.save(placePrice);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		placePriceDao.delete(id);
	}

	public PlacePrice findByPlaceIdAndPlaceSchedule(Long placeId, String placeSchedule) {
		// TODO Auto-generated method stub
		return placePriceDao.findByPlaceIdAndPlaceSchedule(placeId,placeSchedule);
	}
	
	public void batchSaveSchedule(String strtDate,int days,List<HallModel> hallModels){
		for (HallModel hallModel : hallModels) {
			for (int i = 0; i < days; i++) {
				String startDate = DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(strtDate),i), "yyyy-MM-dd");
				PlacePrice price = this.placePriceDao.findByPlaceIdAndPlaceSchedule(hallModel.getId(),startDate);
				if(null==price){
					price = new PlacePrice(hallModel.getHotelId(), hallModel.getHotelName(), "HALL", hallModel.getId(), hallModel.getPlaceName(), startDate, 12800D, 10800D, AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
					this.placePriceDao.save(price);
				}
			}
		}
	}
	
	public void batchSaveRoomSchedule(String strtDate,int days,List<RoomModel> roomModels){
		for (RoomModel roomModel : roomModels) {
			for (int i = 0; i < days; i++) {
				String startDate = DateUtils.formatDate(DateUtils.addDays(DateUtils.parseDate(strtDate),i), "yyyy-MM-dd");
				PlacePrice price = this.placePriceDao.findByPlaceIdAndPlaceSchedule(roomModel.getId(),startDate);
				if(null==price){
					price = new PlacePrice(roomModel.getHotelId(),roomModel.getHotelName(), "ROOM", roomModel.getId(), roomModel.getPlaceName(), startDate, 1280D, 1080D, AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
					this.placePriceDao.save(price);
				}
			}
		}
	}

	public List<PriceTrial> findByPlaceIdAndPlaceTypeAndAdjustSdateAndAdjustEdateAndState(Long placeId,String priceType,String adjustSdate,String adjustEdate,String state){
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("GTE_adjustSdate", adjustSdate);
		filterParams.put("LTE_adjustEdate", adjustEdate);
		filterParams.put("EQ_placeId", placeId);
		filterParams.put("EQ_priceType", priceType);
		filterParams.put("EQ_state", state);
		List<PriceTrial> priceTrials = this.priceTrialService.getEntities(filterParams);
		return priceTrials;
	}
	@Transactional(readOnly = false)
	public List<PlacePrice> batchSavePrice(Map<String, Object> searchparas,Double adjust_price,String price_type
			,Double sun,Double mon,Double tue,Double wed,Double thu,Double fri,Double sat) {
		List<PlacePrice> placePrices = this.getEntities(searchparas);
		HotelPlace hotelPlace = this.hotelPlaceService.getEntity(Long.valueOf(searchparas.get("EQ_placeId").toString()));
		Hotel hotel = this.hotelService.getEntity(hotelPlace.getHotelId());
		List<PriceTrial> priceTrials = findByPlaceIdAndPlaceTypeAndAdjustSdateAndAdjustEdateAndState(hotelPlace.getId(),price_type,searchparas.get("GTE_placeSchedule").toString(),searchparas.get("LTE_placeSchedule").toString(),"0");
		if(priceTrials!=null&&priceTrials.size()>0){
			for (PriceTrial priceTrial : priceTrials) {
				this.priceTrialDao.delete(priceTrial);
			}
		}
		PriceTrial priceTrial = new PriceTrial(hotel.getId(), hotel.getHotelName(), hotelPlace.getId(), hotelPlace.getPlaceName(), "0", AccountUtils.getCurrentUserId()
				, AccountUtils.getCurrentRName(), new Date(), new Date(),"");
		priceTrial.setAdjustSdate(searchparas.get("GTE_placeSchedule").toString());
		priceTrial.setAdjustEdate(searchparas.get("LTE_placeSchedule").toString());
		priceTrial.setPriceType(price_type);
		priceTrial = this.priceTrialDao.save(priceTrial);
	
		Date gdata = DateTimeUtils.string2Date(searchparas.get("GTE_placeSchedule").toString(), "yyyy-MM-dd");
		Date ldata = DateTimeUtils.string2Date(searchparas.get("LTE_placeSchedule").toString(), "yyyy-MM-dd");
		long n = (ldata.getTime()-gdata.getTime())/(24*60*60*1000);
		
		for(int i =0;i<=n;i++){
			Date pdate = DateUtils.addDays(gdata, i);
			Double adjustPrice = getAdjustPrice(pdate,sun,mon,tue,wed,thu,fri,sat);
			Double offPrice = "off".equals(price_type)?adjustPrice:0D;
			Double onPrice = "off".equals(price_type)?0D:adjustPrice;
			
			PlacePrice placePrice = this.findByPlaceIdAndPlaceSchedule(hotelPlace.getId(), DateTimeUtils.toDay(pdate));
			Double onlinePriceRate = 0D;
			Double offlinePriceRate = 0D;
			Double priceBeforeRate = 0D;
			Double priceAfterRate = 0D;
			Double adjustRate = 0D;
			Double onlineBfrPrice = 0D;
			Double offlineBfrPrice = 0D;
			if(null==placePrice){
				
			}else{
				if("on".equals(price_type)){
					onlinePriceRate = (onPrice-placePrice.getOnlinePrice())/placePrice.getOnlinePrice();
					onlineBfrPrice = placePrice.getOnlinePrice();
				}else{
					offlinePriceRate = (offPrice-placePrice.getOfflinePrice())/placePrice.getOfflinePrice();
					offlineBfrPrice = placePrice.getOfflinePrice();
				}
				
				
			}
			PriceAdjust priceAdjust = new PriceAdjust(hotel.getId(), hotel.getHotelName(), hotelPlace.getId(), hotelPlace.getPlaceName(), "0", AccountUtils.getCurrentUserId()
					, AccountUtils.getCurrentRName(), new Date(), DateTimeUtils.toDay(pdate), DateTimeUtils.toDay(pdate)
					, onlineBfrPrice, onPrice, onlinePriceRate, offlineBfrPrice, offPrice, offlinePriceRate, priceBeforeRate, priceAfterRate, adjustRate, new Date(), "价格新增");
			priceAdjust.setAuditId(priceTrial.getId());
			priceAdjustDao.save(priceAdjust);
			
			/*PlacePrice placePrice = new PlacePrice(hotel.getId(), hotel.getHotelName(), hotelPlace.getPlaceType(), hotelPlace.getId(), hotelPlace.getPlaceName()
					, DateTimeUtils.toDay(DateUtils.addDays(gdata, i)), onPrice, offPrice, AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
			this.savePlacePrice(placePrice);*/
		}
		placePrices = this.getEntities(searchparas);
		
		try{
			User head = this.userService.getEntity(hotel.getReclaimUserId());
			String ptext = "酒店管理员"+AccountUtils.getCurrentRName()+ "提交了酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请!";
			chatRecordService.send("SYSTEM", "SYSTEM", hotel.getReclaimUserId(), head.getRname(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, 0L,"HUI", "PRICETRIAL", priceTrial.getId()+"", "");
		}catch(Exception e){
		}
		return placePrices;
	}

	private Double getAdjustPrice(Date pdate, Double sun, Double mon, Double tue, Double wed, Double thu, Double fri,
			Double sat) {
		Calendar c = Calendar.getInstance();
		c.setTime(pdate);
		int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
		switch (dayOfWeek) {
		case 1:
			return sun;
		case 2:
			return mon;
		case 3:
			return tue;
		case 4:
			return wed;
		case 5:
			return thu;
		case 6:
			return fri;
		case 7:
			return sat;
		}
		return 0.0;
	}

	public PlacePrice findByPlaceTypeAndPlaceIdAndPlaceSchedule(String placeType,Long placeId, String scheduleDate) {
		
		return this.placePriceDao.findByPlaceTypeAndPlaceIdAndPlaceSchedule(placeType,placeId, scheduleDate) ;
	}
}
