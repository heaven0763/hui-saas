package com.chuangbang.base.service.hotel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.hotel.HotelCooperationInfoDao;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;

/**
 * 场地合作信息Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class HotelCooperationInfoService extends BaseService<HotelCooperationInfo,HotelCooperationInfoDao> {

	@Autowired
	private HotelCooperationInfoDao hotelCooperationInfoDao;
	@Autowired
	private CustomPageService customPageService;
	
	public HotelCooperationInfo getEntity(Long id) {
		return hotelCooperationInfoDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelCooperationInfo(HotelCooperationInfo hotelCooperationInfo) {
		hotelCooperationInfoDao.save(hotelCooperationInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelCooperationInfoDao.delete(id);
	}

	public HotelCooperationInfo findByHotelId(Long hotelId) {
		return hotelCooperationInfoDao.findByHotelId(hotelId);
	}
	
	public List<HotelCooperationInfo> getHotelCooperationInfoPageList(PageBean<HotelCooperationInfo> pageBean) {
		String columstr = "c.id as id, c.all_commission as allCommission, c.commission_belong as commissionBelong, c.commission_rights as commissionRights"
				+", c.commission_type as commissionType, c.create_date as createDate, c.create_user_id as createUserId, c.create_user_name as createUserName"
				+", c.dinner_commission as dinnerCommission, ht.name as hoteType, c.hotel_id as hotelId, c.hotel_name as hotelName, c.hotel_nature as hotelNature"
				+", c.housing_commission as housingCommission, c.is_points as isPoints, c.link_mobile as linkMobile, c.link_phone as linkPhone, c.linkman as linkman"
				+", c.memo as memo, c.metting_room_commission as mettingRoomCommission, c.orther_commission as ortherCommission, c.points_rate as pointsRate, c.reclaim_user_id as reclaimUserId"
				+", c.reclaim_user_name as reclaimUserName, u.mobile as reclaimUserMobile, c.agreementedate as agreementEDate, c.agreementsdate as agreementSDate, c.area as area";
		String fromWhere = " from hui_hotel_cooperation_info c left join hui_hotel h on h.id = c.hotel_id left join hui_user u on u.id=c.reclaim_user_id"
				+ " left join hui_category ht on ht.id=c.hote_type left join hui_company cp on  cp.id = h.pid and cp.auth_type='PARTNER'"
				+ " where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, HotelCooperationInfo.class,null);
	} 
	
	public List<HotelCooperationInfo> getAllHotelCooperationInfo(PageBean<HotelCooperationInfo> pageBean) {
		String columstr = "c.id as id, c.all_commission as allCommission, c.commission_belong as commissionBelong, c.commission_rights as commissionRights"
				+", c.commission_type as commissionType, c.create_date as createDate, c.create_user_id as createUserId, c.create_user_name as createUserName"
				+", c.dinner_commission as dinnerCommission, ht.name as hoteType, c.hotel_id as hotelId, c.hotel_name as hotelName, c.hotel_nature as hotelNature"
				+", c.housing_commission as housingCommission, c.is_points as isPoints, c.link_mobile as linkMobile, c.link_phone as linkPhone, c.linkman as linkman"
				+", c.memo as memo, c.metting_room_commission as mettingRoomCommission, c.orther_commission as ortherCommission, c.points_rate as pointsRate, c.reclaim_user_id as reclaimUserId"
				+", c.reclaim_user_name as reclaimUserName, u.mobile as reclaimUserMobile, c.agreementedate as agreementEDate, c.agreementsdate as agreementSDate, c.area as area";
		String fromWhere = " from hui_hotel_cooperation_info c left join hui_hotel h on h.id = c.hotel_id left join hui_user u on u.id=c.reclaim_user_id"
				+ " left join hui_category ht on ht.id=c.hote_type left join hui_company cp on  cp.id = h.pid and cp.auth_type='PARTNER'"
				+ " where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, HotelCooperationInfo.class, null);
	}
	
	public HotelCooperationInfo getHotelCooperationInfo(Long id) {
		String columstr = "c.id as id, c.all_commission as allCommission, c.commission_belong as commissionBelong, c.commission_rights as commissionRights"
				+", c.commission_type as commissionType, c.create_date as createDate, c.create_user_id as createUserId, c.create_user_name as createUserName"
				+", c.dinner_commission as dinnerCommission, ht.name as hoteType, c.hotel_id as hotelId, c.hotel_name as hotelName, c.hotel_nature as hotelNature"
				+", c.housing_commission as housingCommission, c.is_points as isPoints, c.link_mobile as linkMobile, c.link_phone as linkPhone, c.linkman as linkman"
				+", c.memo as memo, c.metting_room_commission as mettingRoomCommission, c.orther_commission as ortherCommission, c.points_rate as pointsRate, c.reclaim_user_id as reclaimUserId"
				+", c.reclaim_user_name as reclaimUserName, u.mobile as reclaimUserMobile, c.agreementedate as agreementEDate, c.agreementsdate as agreementSDate, c.area as area";
		String fromWhere = " from hui_hotel_cooperation_info c left join hui_hotel h on h.id = c.hotel_id left join hui_user u on u.id=c.reclaim_user_id"
				+ " left join hui_category ht on ht.id=c.hote_type left join hui_company cp on  cp.id = h.pid and cp.auth_type='PARTNER'"
				+ " where 1=1 and c.id="+id;
		return customPageService.getOne(columstr, fromWhere, HotelCooperationInfo.class);
	}
}
