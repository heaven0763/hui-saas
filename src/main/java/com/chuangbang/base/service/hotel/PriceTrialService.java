package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.hotel.CategoryDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;
import com.chuangbang.base.dao.hotel.PlacePriceDao;
import com.chuangbang.base.dao.hotel.PriceAdjustDao;
import com.chuangbang.base.dao.hotel.PriceTrialDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.base.enums.GroupType;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.thread.SamePriceThread;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.page.PageBean;

/**
 * 场地价格调整Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class PriceTrialService extends BaseService<PriceTrial,PriceTrialDao> {

	@Autowired
	private PriceTrialDao priceTrialDao;
	
	@Autowired
	private PriceAdjustDao priceAdjustDao;
	
	@Autowired
	private PlacePriceDao placePriceDao;
	
	@Autowired
	private HotelPlaceDao hotelPlaceDao;
	
	@Autowired
	private CustomPageService customPageService;
	
	@Autowired
	private ChatRecordService chatRecordService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private HotelScheduleDao hotelScheduleDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	public PriceTrial getEntity(Long id) {
		return priceTrialDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void savePriceTrial(PriceTrial priceTrial) {
		priceTrialDao.save(priceTrial);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		priceTrialDao.delete(id);
	}
	
	
	public List<PriceTrial> getPriceTrialPageList(PageBean<PriceTrial> pageBean) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.create_date as createDate, pa.memo as memo, pa.trial_date as trialDate"
				+ ", pa.trial_user_id as trialUserId, pa.trial_user_name as trialUserName, pa.trial_reason as trialReason, pa.trial_state as trialState, pa.final_date as finalDate"
				+ ", pa.final_user_id as finalUserId, pa.final_user_name as finalUserName, pa.final_reason as finalReason, pa.final_state as finalState, r.region_name as area"
				+ ", pa.adjust_sdate as adjustSdate, pa.adjust_edate as adjustEdate, pa.price_type as priceType";
		String fromWhere = " from hui_price_trial pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " left join hui_region r on r.id=h.city"
				+ " where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, PriceTrial.class,null);
	} 
	
	public List<PriceTrial> getAllPriceTrial(PageBean<PriceTrial> pageBean) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.create_date as createDate, pa.memo as memo, pa.trial_date as trialDate"
				+ ", pa.trial_user_id as trialUserId, pa.trial_user_name as trialUserName, pa.trial_reason as trialReason, pa.trial_state as trialState, pa.final_date as finalDate"
				+ ", pa.final_user_id as finalUserId, pa.final_user_name as finalUserName, pa.final_reason as finalReason, pa.final_state as finalState, r.region_name as area"
				+ ", pa.adjust_sdate as adjustSdate, pa.adjust_edate as adjustEdate, pa.price_type as priceType";
		String fromWhere = " from hui_price_trial pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " left join hui_region r on r.id=h.city"
				+ " left join hui_region r on r.id=h.city"
				+ " where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, PriceTrial.class, null);
	}
	
	public PriceTrial getPriceTrial(Long id) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.create_date as createDate, pa.memo as memo, pa.trial_date as trialDate"
				+ ", pa.trial_user_id as trialUserId, pa.trial_user_name as trialUserName, pa.trial_reason as trialReason, pa.trial_state as trialState, pa.final_date as finalDate"
				+ ", pa.final_user_id as finalUserId, pa.final_user_name as finalUserName, pa.final_reason as finalReason, pa.final_state as finalState, r.region_name as area"
				+ ", pa.adjust_sdate as adjustSdate, pa.adjust_edate as adjustEdate, pa.price_type as priceType";
		String fromWhere = " from hui_price_trial pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " left join hui_region r on r.id=h.city"
				+ " where 1=1 and pa.id="+id;
		return customPageService.getOne(columstr, fromWhere, PriceTrial.class);
	}
	
	@Transactional(readOnly = false)
	public Json passCheck(Long id,String checkType) {
		Json json = new Json();
		PriceTrial priceTrial = this.getEntity(id);
		
		Hotel hotel = hotelService.getEntity(priceTrial.getHotelId());
		if("TRIAL".equals(checkType)){
			if(priceTrial.getState().equals("1")&&priceTrial.getTrialState().equals("1")){
				//AccountUtils.getCurrentUserType().equals("HOTEL")&&
				json.setJson(false, "已通过初审申请不能重复审核！");
				return json;
			}
			priceTrial.setTrialDate(new Date());
			priceTrial.setTrialReason("");
			priceTrial.setTrialState("1");
			priceTrial.setTrialUserId(AccountUtils.getCurrentUserId());
			priceTrial.setTrialUserName(AccountUtils.getCurrentRName());
			priceTrial.setState("1");
			priceTrialDao.save(priceTrial);
			
			String toUserID = hotel.getReclaimUserId();
			String toUserName = hotel.getReclaimUserName();
			String ptext = "会掌柜销售"+AccountUtils.getCurrentRName()+ "审核了酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请!";
			
			chatRecordService.send("SYSTEM", "SYSTEM", GroupType.company_administrator.name(), GroupType.company_administrator.name(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, 0L, "HUI", "PRICETRIAL", priceTrial.getId()+"", "");
			
			toUserID = priceTrial.getApplyUserId();
			toUserName = priceTrial.getApplyUserName();
			ptext = "您好，您提交的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，初审通过了!";
			chatRecordService.send("SYSTEM", "SYSTEM", toUserID, toUserName, "SYSTEMMSG", "酒店场地价格调整申请", ptext,hotel.getId(), hotel.getHotelName(), "PRICETRIAL", priceTrial.getId()+"", "");
			json.setJson(true, "审核成功！");
		}else if("FINAL".equals(checkType)){
			if(priceTrial.getState().equals("2")&&priceTrial.getFinalState().equals("1")){
				//AccountUtils.getCurrentUserType().equals("HOTEL")&&
				json.setJson(false, "已通过审核申请不能重复审核！");
				return json;
			}
			priceTrial.setFinalDate(new Date());
			priceTrial.setFinalReason("");
			priceTrial.setFinalState("1");
			priceTrial.setFinalUserId(AccountUtils.getCurrentUserId());
			priceTrial.setFinalUserName(AccountUtils.getCurrentRName());
			priceTrial.setState("2");
			priceTrialDao.save(priceTrial);
			
			/*List<PriceAdjust> priceAdjusts = this.priceAdjustDao.findByAuditId(priceTrial.getId());
			for (PriceAdjust priceAdjust : priceAdjusts) {
				PlacePrice placePrice = this.placePriceDao.findByPlaceIdAndPlaceSchedule(priceAdjust.getPlaceId(), priceAdjust.getAdjustSdate());
				HotelPlace hotelPlace = this.hotelPlaceDao.findOne(priceAdjust.getPlaceId());
				if(placePrice==null){
					 placePrice = new PlacePrice(priceTrial.getHotelId(), priceTrial.getHotelName(), hotelPlace.getPlaceType(), priceTrial.getPlaceId(), priceTrial.getPlaceName()
								, priceAdjust.getAdjustSdate(), priceAdjust.getOnlinePriceAfter(), priceAdjust.getOfflinePriceAfter(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
				}else{
					placePrice.setBeforeOfflinePrice(placePrice.getBeforeOfflinePrice());
					placePrice.setOfflinePrice(priceAdjust.getOfflinePriceAfter());
					
					placePrice.setBeforeOnlinePrice(placePrice.getBeforeOnlinePrice());
					placePrice.setOnlinePrice(priceAdjust.getOnlinePriceAfter());
					
					placePrice.setUpdateDate(new Date());
				}
				placePriceDao.save(placePrice);
				this.saveSchedule(priceTrial, priceAdjust);
			}*/
			
			SamePriceThread priceThread = new SamePriceThread(priceTrial);
			priceThread.start();
			json.setJson(true, "审核成功,价格同步需要时间，请稍后再查询！");
			String ptext = "您好，您提交的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，终审通过了，价格同步需要时间，请稍后再查询!";
			chatRecordService.send("SYSTEM", "SYSTEM", priceTrial.getApplyUserId(), priceTrial.getApplyUserName(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, hotel.getId(), hotel.getHotelName(), "PRICETRIAL", priceTrial.getId()+"", "");
			ptext = "您好，您初审的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，终审通过了，价格同步需要时间，请稍后再查询!";
			chatRecordService.send("SYSTEM", "SYSTEM", priceTrial.getTrialUserId(), priceTrial.getTrialUserName(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, hotel.getId(), hotel.getHotelName(), "PRICETRIAL", priceTrial.getId()+"", "");
		}
		
		return json;
	}

	@Transactional(readOnly = false)
	public Json noPassCheck(Long id,String checkType,String reason) {
		Json json = new Json();
		PriceTrial priceTrial = this.getEntity(id);
		Hotel hotel = hotelService.getEntity(priceTrial.getHotelId());
		if("TRIAL".equals(checkType)){
			
			priceTrial.setTrialDate(new Date());
			priceTrial.setTrialReason(reason);
			priceTrial.setTrialState("2");
			priceTrial.setTrialUserId(AccountUtils.getCurrentUserId());
			priceTrial.setTrialUserName(AccountUtils.getCurrentRName());
			priceTrial.setState("3");
			priceTrialDao.save(priceTrial);
			
			String toUserID = priceTrial.getApplyUserId();
			String toUserName = priceTrial.getApplyUserName();
			String ptext = "很抱歉，您提交的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，审核不通过!";
			chatRecordService.send("SYSTEM", "SYSTEM", priceTrial.getApplyUserId(),priceTrial.getApplyUserName(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, 0L, "HUI", "PRICETRIAL", priceTrial.getId()+"", "");
			
		}else if("FINAL".equals(checkType)){
			
			priceTrial.setFinalDate(new Date());
			priceTrial.setFinalReason(reason);
			priceTrial.setFinalState("2");
			priceTrial.setFinalUserId(AccountUtils.getCurrentUserId());
			priceTrial.setFinalUserName(AccountUtils.getCurrentRName());
			priceTrial.setState("4");
			priceTrialDao.save(priceTrial);
			
			String ptext = "很抱歉，您提交的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，终审不通过；如需修改，请重新提交!";
			chatRecordService.send("SYSTEM", "SYSTEM", priceTrial.getApplyUserId(), priceTrial.getApplyUserName(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, hotel.getId(), hotel.getHotelName(), "PRICETRIAL", priceTrial.getId()+"", "");
			ptext = "很抱歉，您初审的酒店场地"+priceTrial.getPlaceName()+priceTrial.getAdjustSdate()+"~"+priceTrial.getAdjustEdate()+(priceTrial.getPriceType().equals("on")?"线上价格":"线下价格")+"调整申请，终审不通过!";
			chatRecordService.send("SYSTEM", "SYSTEM", priceTrial.getTrialUserId(), priceTrial.getTrialUserName(), "SYSTEMMSG", "酒店场地价格调整申请", ptext, hotel.getId(), hotel.getHotelName(), "PRICETRIAL", priceTrial.getId()+"", "");
		
		}
		json.setJson(true, "操作成功！");
		return json;
	}
	
	@Transactional(readOnly = false)
	private void saveSchedule(PriceTrial priceTrial,PriceAdjust priceAdjust){
		HotelPlace hotelPlace = this.hotelPlaceDao.findOne(priceTrial.getPlaceId());
		List<Category> categories = this.categoryDao.findByKind("SCHEDULETIME");
		for (Category category : categories) {
			HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(priceTrial.getPlaceId(),priceAdjust.getAdjustSdate(),category.getId()+"");
			if(schedule==null){
				schedule = new HotelSchedule(priceTrial.getHotelId(), priceTrial.getHotelName(), hotelPlace.getPlaceType(), priceTrial.getPlaceId(), priceTrial.getPlaceName(), category.getId()+"", priceAdjust.getAdjustSdate(), "0", AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
				this.hotelScheduleDao.save(schedule);
			}
		}
	}
}
