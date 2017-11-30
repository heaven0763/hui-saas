package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.wechat.hui.model.IntegralReconciliationModel;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.hotel.IntegralCommodityDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.IntegralCommodity;
import com.chuangbang.base.service.user.ChatRecordService;

/**
 * 积分商品Service
 * @author heaven
 * @version 2017-01-10
 */
@Component
@Transactional(readOnly = true)
public class IntegralCommodityService extends BaseService<IntegralCommodity,IntegralCommodityDao> {

	@Autowired
	private IntegralCommodityDao integralCommodityDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private ChatRecordService chatRecordService;
	public IntegralCommodity getEntity(Long id) {
		return integralCommodityDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveIntegralCommodity(IntegralCommodity integralCommodity) {
		if(integralCommodity.getId()==null){
			integralCommodity.setState("0");
			integralCommodity.setCheckState("0");
			integralCommodity.setCreateDate(new Date());
			integralCommodity.setCreateUserId(AccountUtils.getCurrentUserId());
			integralCommodity.setCreateUserName(AccountUtils.getCurrentRName());
		}
		integralCommodityDao.save(integralCommodity);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		integralCommodityDao.delete(id);
	}
	@Transactional(readOnly = false)
	public Json pass(Long id) {
		Json json = new Json();
		try{
			IntegralCommodity integralCommodity = this.getEntity(id);
			User user = userDao.findOne(AccountUtils.getCurrentUserId());
			Hotel hotel = this.hotelDao.findOne(integralCommodity.getHotelId());
			if("0".equals(integralCommodity.getCheckState())){//酒店审核通过
				integralCommodity.setCheckState("1");
				integralCommodity.setHotelCheckDate(new Date());
				integralCommodity.setHotelCheckhUserId(user.getId());
				integralCommodity.setHotelCheckhUserName(user.getRname());
				integralCommodity.setHotelCheckhMemo("酒店审核通过");
				this.integralCommodityDao.save(integralCommodity);
				json.setJson(true, "审核通过！");
				
				try{
					String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过酒店审核！";
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					//提醒上级要审核
					User ruser = userDao.findOne(hotel.getReclaimUserId());
					ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过酒店审核，请你赶快审核！";
					chatRecordService.send("SYSTEM", "SYSTEM", ruser.getId()+"", ruser.getRname(), "SYSTEMMSG", "积分商城商品审核通知", ptext, 0L,"HUI", "integralCommodity", integralCommodity.getId()+"", "");
				}catch(Exception e){}
				
			}else if("1".equals(integralCommodity.getCheckState())){//会掌柜初审，审核通过
				integralCommodity.setCheckState("3");
				integralCommodity.setHuiCheckDate(new Date());
				integralCommodity.setHuiCheckUserId(user.getId());
				integralCommodity.setHuiCheckUserName(user.getRname());
				integralCommodity.setHotelCheckhMemo("会掌柜初审");
				this.integralCommodityDao.save(integralCommodity);
				json.setJson(true, "审核通过！");
				
				try{
					//提醒通过审核
					String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过会掌柜审核！";
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHotelCheckhUserId()+"", integralCommodity.getHotelCheckhUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					//提醒上级要审核
					User head = null;
					//ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过会掌柜初审，请你赶快审核！";
					//chatRecordService.send("SYSTEM", "SYSTEM", head.getId()+"", head.getRname(), "SYSTEM", "积分商城商品审核通知", ptext, null, "", "integralCommodity", integralCommodity.getId()+"", "");
				}catch(Exception e){}
			}else if("3".equals(integralCommodity.getCheckState())){//会掌柜复审，审核通过
				integralCommodity.setCheckState("5");
				integralCommodity.setState("1");
				integralCommodity.setCheckDate(new Date());
				integralCommodity.setCheckUserId(user.getId());
				integralCommodity.setCheckUserName(user.getRname());
				integralCommodity.setCheckMemo("会掌柜复审");
				this.integralCommodityDao.save(integralCommodity);
				
				json.setJson(true, "会掌柜复审通过！");
				try{
				//提醒通过审核
				String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过审核，已上架了！";
				chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHotelCheckhUserId()+"", integralCommodity.getHotelCheckhUserName()
						, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
				chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
						, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
				chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHuiCheckUserId(), integralCommodity.getHuiCheckUserName()
						, "SYSTEMMSG", "积分商城商品审核通知", ptext, 0L,"HUI", "integralCommodity", integralCommodity.getId()+"", "");
				
				}catch(Exception e){}
			}else{
				json.setJson(false, "不可审核！");
			}
		}catch(Exception e){
			json.setJson(false, "审核错误！");
		}
		return json;
	}
	
	@Transactional(readOnly = false)
	public Json nopass(Long id) {
		Json json = new Json();
		try{
			IntegralCommodity integralCommodity = this.getEntity(id);
			User user = userDao.findOne(AccountUtils.getCurrentUserId());
			Hotel hotel = this.hotelDao.findOne(integralCommodity.getHotelId());
			if("0".equals(integralCommodity.getCheckState())){//酒店审核通过
				integralCommodity.setCheckState("6");
				integralCommodity.setHotelCheckDate(new Date());
				integralCommodity.setHotelCheckhUserId(user.getId());
				integralCommodity.setHotelCheckhUserName(user.getRname());
				integralCommodity.setHotelCheckhMemo("酒店审核");
				this.integralCommodityDao.save(integralCommodity);
				json.setJson(true, "审核不通过！");
				
				try{
					String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"酒店审核不通过！";
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					//提醒上级要审核
					User ruser = userDao.findOne(hotel.getReclaimUserId());
					chatRecordService.send("SYSTEM", "SYSTEM", ruser.getId()+"", ruser.getRname(), "SYSTEMMSG", "积分商城商品审核通知", ptext, 0L,"HUI", "integralCommodity", integralCommodity.getId()+"", "");
				}catch(Exception e){}
				
			}else if("1".equals(integralCommodity.getCheckState())){//会掌柜初审，审核通过
				integralCommodity.setCheckState("6");
				integralCommodity.setHuiCheckDate(new Date());
				integralCommodity.setHuiCheckUserId(user.getId());
				integralCommodity.setHuiCheckUserName(user.getRname());
				integralCommodity.setHotelCheckhMemo("会掌柜初审");
				this.integralCommodityDao.save(integralCommodity);
				json.setJson(true, "审核不通过！");
				
				try{
					//提醒通过审核
					String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"会掌柜审核不通过！";
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHotelCheckhUserId()+"", integralCommodity.getHotelCheckhUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					//提醒上级要审核
					User head = null;
					//ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"已通过会掌柜初审，请你赶快审核！";
					//chatRecordService.send("SYSTEM", "SYSTEM", head.getId()+"", head.getRname(), "SYSTEM", "积分商城商品审核通知", ptext, null, "", "integralCommodity", integralCommodity.getId()+"", "");
				}catch(Exception e){}
			}else if("3".equals(integralCommodity.getCheckState())){//会掌柜复审，审核通过
				integralCommodity.setCheckState("6");
				integralCommodity.setCheckDate(new Date());
				integralCommodity.setCheckUserId(user.getId());
				integralCommodity.setCheckUserName(user.getRname());
				integralCommodity.setCheckMemo("会掌柜复审");
				this.integralCommodityDao.save(integralCommodity);
				
				json.setJson(true, "会掌柜复审通过！");
				try{
				//提醒通过审核
					String ptext = hotel.getHotelName()+"的积分商城商品"+integralCommodity.getName()+"会掌柜复审不通过！";
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHotelCheckhUserId()+"", integralCommodity.getHotelCheckhUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getCreateUserId(), integralCommodity.getCreateUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, hotel.getId(), hotel.getHotelName(), "integralCommodity", integralCommodity.getId()+"", "");
					chatRecordService.send("SYSTEM", "SYSTEM", integralCommodity.getHuiCheckUserId(), integralCommodity.getHuiCheckUserName()
							, "SYSTEMMSG", "积分商城商品审核通知", ptext, 0L,"HUI", "integralCommodity", integralCommodity.getId()+"", "");
				}catch(Exception e){}
			}else{
				json.setJson(false, "不可审核！");
			}
		}catch(Exception e){
			json.setJson(false, "审核错误！");
		}
		return json;
		
	}

/*	public List<IntegralReconciliationModel> getIntegralReconciliationModels(PageBean<IntegralReconciliationModel> pageBean) {
		
		
		return null;
	}*/
	
}
