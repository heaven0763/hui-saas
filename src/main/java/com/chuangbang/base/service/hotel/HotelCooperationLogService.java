package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelCooperationLog;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.dao.hotel.HotelCooperationInfoDao;
import com.chuangbang.base.dao.hotel.HotelCooperationLogDao;

/**
 * 场地返佣比例修改记录Service
 * @author heaven
 * @version 2017-03-14
 */
@Component
@Transactional(readOnly = true)
public class HotelCooperationLogService extends BaseService<HotelCooperationLog,HotelCooperationLogDao> {

	@Autowired
	private HotelCooperationLogDao hotelCooperationLogDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelCooperationInfoDao hotelCooperationInfoDao;
	public HotelCooperationLog getEntity(Long id) {
		return hotelCooperationLogDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelCooperationLog(HotelCooperationLog hotelCooperationLog) {
		hotelCooperationLogDao.save(hotelCooperationLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelCooperationLogDao.delete(id);
	}
	
	@Transactional(readOnly = false)
	public JsonVo saveHotelCooperationLog(HotelCooperationInfo cooperationInfo, Long hotelId,
			Double afallCommissionRate, Double afmettingRoomCommissionRate, Double afhousingCommissionRate,
			Double afdinnerCommissionRate, Double afortherCommissionRate, Double afpointsRate,String applyReason) {
		try{
			boolean flag= true;
			if(!cooperationInfo.getHousingCommission().equals(afhousingCommissionRate)){
				flag = false;
			}
			if(!cooperationInfo.getDinnerCommission().equals(afdinnerCommissionRate)){
				flag = false;
			}
			if(!cooperationInfo.getMettingRoomCommission().equals(afmettingRoomCommissionRate)){
				flag = false;
			}
			if(!cooperationInfo.getOrtherCommission().equals(afortherCommissionRate)){
				flag = false;
			}
			if(null!=cooperationInfo.getAllCommission()&&!cooperationInfo.getAllCommission().equals(afallCommissionRate)){
				flag = false;
			} 
			/*if(!cooperationInfo.getPointsRate().equals(afpointsRate)){
				flag = false;
			}
			 */			
			if(flag){
				JsonUtils.error("比例无改变，无需提交！");
			}
			
			HotelCooperationLog hotelCooperationLog = new HotelCooperationLog(hotelId, cooperationInfo.getId(), cooperationInfo.getCommissionType(), cooperationInfo.getIsPoints()
					, cooperationInfo.getHousingCommission(), cooperationInfo.getDinnerCommission(), cooperationInfo.getMettingRoomCommission()
					, cooperationInfo.getOrtherCommission(), cooperationInfo.getAllCommission(), cooperationInfo.getPointsRate()
					, afhousingCommissionRate, afdinnerCommissionRate, afmettingRoomCommissionRate, afortherCommissionRate, afallCommissionRate, afpointsRate, "0"
					, applyReason, new Date(), AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), "场地返佣比例调整申请");
			
			hotelCooperationLog = this.hotelCooperationLogDao.save(hotelCooperationLog);
			
			try{
				//提醒消息
				String ptext = AccountUtils.getCurrentRName()+"提交了"+cooperationInfo.getHotelName()+"的场地返佣比例调整申请！";
				chatRecordService.send("SYSTEM", "SYSTEM","company_finance", "company_finance", "SYSTEMMSG", "场地返佣比例调整申请通知", ptext, 0L, "HUI", "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
				chatRecordService.log("LOG", "场地返佣比例调整申请", ptext, hotelId,  cooperationInfo.getHotelName(), "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
			}catch(Exception e){}
			return JsonUtils.success("场地返佣比例调整申请提交成功！");
		}catch(Exception e){
			e.printStackTrace();
			return JsonUtils.error("场地返佣比例调整申请提交失败！");
		}
	}

	public List<HotelCooperationLog> getHotelCooperationLogPageList(PageBean<HotelCooperationLog> pageBean) {
		String columstr = "c.id as id, c.hotel_id as hotelId, c.cp_id as cpId, c.type as type, c.points_rate_type as pointsRateType, c.bfhousing_commission_rate as bfhousingCommissionRate"
				+ ", c.bfdinner_commission_rate as bfdinnerCommissionRate, c.bfmetting_room_commission_rate as bfmettingRoomCommissionRate, c.bforther_commission_rate as bfortherCommissionRate"
				+ ", c.bfall_commission_rate as bfallCommissionRate, c.bfpoints_rate as bfpointsRate, c.afhousing_commission_rate as afhousingCommissionRate, c.afdinner_commission_rate as afdinnerCommissionRate"
				+ ", c.afmetting_room_commission_rate as afmettingRoomCommissionRate, c.aforther_commission_rate as afortherCommissionRate, c.afall_commission_rate as afallCommissionRate"
				+ ", c.afpoints_rate as afpointsRate, c.state as state, c.check_date as checkDate, c.check_memo as checkMemo, c.check_user_id as checkUserId, c.check_user_name as checkUserName"
				+ ", c.apply_reason as applyReason, c.apply_date as applyDate, c.apply_user_id as applyUserId, c.apply_user_name as applyUserName, c.memo as memo, star.name as star, h.hotel_name as hotelName";
		String fromWhere = " from hui_hotel_cooperation_log c left join hui_hotel h on h.id=c.hotel_id  left join hui_category star on star.id=h.hotel_star"
				+ " where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, HotelCooperationLog.class,null);
	}
	public HotelCooperationLog getHotelCooperationLog(Long id) {
		String columstr = "c.id as id, c.hotel_id as hotelId, c.cp_id as cpId, c.type as type, c.points_rate_type as pointsRateType, c.bfhousing_commission_rate as bfhousingCommissionRate"
				+ ", c.bfdinner_commission_rate as bfdinnerCommissionRate, c.bfmetting_room_commission_rate as bfmettingRoomCommissionRate, c.bforther_commission_rate as bfortherCommissionRate"
				+ ", c.bfall_commission_rate as bfallCommissionRate, c.bfpoints_rate as bfpointsRate, c.afhousing_commission_rate as afhousingCommissionRate, c.afdinner_commission_rate as afdinnerCommissionRate"
				+ ", c.afmetting_room_commission_rate as afmettingRoomCommissionRate, c.aforther_commission_rate as afortherCommissionRate, c.afall_commission_rate as afallCommissionRate"
				+ ", c.afpoints_rate as afpointsRate, c.state as state, c.check_date as checkDate, c.check_memo as checkMemo, c.check_user_id as checkUserId, c.check_user_name as checkUserName"
				+ ", c.apply_reason as applyReason, c.apply_date as applyDate, c.apply_user_id as applyUserId, c.apply_user_name as applyUserName, c.memo as memo, star.name as star, h.hotel_name as hotelName";
		String fromWhere = " from hui_hotel_cooperation_log c left join hui_hotel h on h.id=c.hotel_id  left join hui_category star on star.id=h.hotel_star"
				+ " where 1=1 and c.id="+id;
		return customPageService.getOne( columstr, fromWhere, HotelCooperationLog.class,null);
	}
	@Transactional(readOnly = false)
	public JsonVo pass(Long id) {
		try{
			HotelCooperationLog hotelCooperationLog = this.getEntity(id);
			if("0".equals(hotelCooperationLog.getState())){
				
				HotelCooperationInfo hotelCooperationInfo = this.hotelCooperationInfoDao.findOne(hotelCooperationLog.getCpId());
				hotelCooperationInfo.setAllCommission(hotelCooperationLog.getAfallCommissionRate());
				hotelCooperationInfo.setMettingRoomCommission(hotelCooperationLog.getAfmettingRoomCommissionRate());
				hotelCooperationInfo.setHousingCommission(hotelCooperationLog.getAfhousingCommissionRate());
				hotelCooperationInfo.setDinnerCommission(hotelCooperationLog.getAfdinnerCommissionRate());
				hotelCooperationInfo.setOrtherCommission(hotelCooperationLog.getAfortherCommissionRate());
				hotelCooperationInfo.setPointsRate(hotelCooperationLog.getAfpointsRate());
				this.hotelCooperationInfoDao.save(hotelCooperationInfo);
				hotelCooperationLog.setState("1");
				this.hotelCooperationLogDao.save(hotelCooperationLog);
				
				try{
					//提醒消息
					String ptext = AccountUtils.getCurrentRName()+"审核通过了"+hotelCooperationInfo.getHotelName()+"的场地返佣比例调整申请！";
					
					chatRecordService.send("SYSTEM", "SYSTEM",hotelCooperationLog.getApplyUserId(), hotelCooperationLog.getApplyUserName()
							, "SYSTEMMSG", "场地返佣比例调整申请通知", ptext, 0L,"HUI", "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
					
					chatRecordService.log("LOG", "场地返佣比例调整申请", ptext,  0L,"HUI", "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
				}catch(Exception e){}
				return JsonUtils.success("审核成功！");
			}else{
				return JsonUtils.error("调整信息有误！");
			}
		}catch(Exception e){
			return JsonUtils.error("审核失败！");
		}
	}
	
	@Transactional(readOnly = false)
	public JsonVo noPass(Long id) {
		HotelCooperationLog hotelCooperationLog = this.getEntity(id);
		if("0".equals(hotelCooperationLog.getState())){
			hotelCooperationLog.setState("2");
			this.hotelCooperationLogDao.save(hotelCooperationLog);
			HotelCooperationInfo hotelCooperationInfo = this.hotelCooperationInfoDao.findOne(hotelCooperationLog.getCpId());
			try{
				//提醒消息
				String ptext = AccountUtils.getCurrentRName()+"审核了"+hotelCooperationInfo.getHotelName()+"的场地返佣比例调整申请，结果不通过！";
				
				chatRecordService.send("SYSTEM", "SYSTEM",hotelCooperationLog.getApplyUserId(), hotelCooperationLog.getApplyUserName()
						, "SYSTEMMSG", "场地返佣比例调整申请通知", ptext, 0L,"HUI", "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
				
				chatRecordService.log("LOG", "场地返佣比例调整申请", ptext,0L,"HUI", "HotelCooperationLog", hotelCooperationLog.getId()+"", "");
			}catch(Exception e){}
			return JsonUtils.error("操作成功！");
		}else{
			return JsonUtils.error("调整信息有误！");
		}
	}
	
}
