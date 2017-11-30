package com.chuangbang.base.service.hotel;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.base.dao.hotel.HotelHallPeopleNumDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.SiteServiceDao;
import com.chuangbang.base.dao.hotel.SupportingServicesDao;
import com.chuangbang.base.entity.hotel.HotelHallPeopleNum;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.SiteService;
import com.chuangbang.base.entity.hotel.SupportingServices;
import com.chuangbang.base.thread.HotelScheduleThread;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 大厅/客房表Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class HotelPlaceService extends BaseService<HotelPlace,HotelPlaceDao> {

	@Autowired
	private HotelPlaceDao hotelPlaceDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private SiteServiceDao siteServiceDao;
	@Autowired
	private SupportingServicesDao supportingServicesDao;
	@Autowired
	private HotelHallPeopleNumDao hallPeopleNumDao;
	
	public HotelPlace getEntity(Long id) {
		return hotelPlaceDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelPlace(HotelPlace hotelPlace) {
		hotelPlaceDao.save(hotelPlace);
		
		
	}
	
	@Transactional(readOnly = false)
	public void saveHotelPlace(HttpServletRequest request,HotelPlace hotelPlace,String supportings,String halldisplays,Integer pillarNum) {
		if(hotelPlace.getId()==null){
			hotelPlace.setState("1");
			hotelPlace.setCreateDate(new Date());
			hotelPlace.setCreateUserId(AccountUtils.getCurrentUserId());
			hotelPlace.setCreateUserName(AccountUtils.getCurrentRName());
			
		}
		if(hotelPlace.getPillar().equals(0)){
			hotelPlace.setPillar(pillarNum+"");
		}
		hotelPlace = hotelPlaceDao.save(hotelPlace);
		
		if(StringUtils.isNotBlank(supportings)){
			deleteSiteServiceByHotelId(hotelPlace.getId(),"HALL","HALLSUPPORT");
			String sprtIds[] =supportings.split(",");
			for (int i=0;i<sprtIds.length;i++) {
				String supportingsVal = request.getParameter("supportingsVal"+sprtIds[i]); //s[] = supportingsVal.split(",");
				SiteService site = this.siteServiceDao.findBySiteIdAndSiteTypeAndServiceIdAndKind(hotelPlace.getId(),"HALL",Long.valueOf(sprtIds[i]),"HALLSUPPORT");
				if(site==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(sprtIds[i]));
					site = new SiteService(hotelPlace.getHotelId(), "HALL", hotelPlace.getId(), "HALLSUPPORT", Long.valueOf(sprtIds[i]), services.getName(), services.getLogo());
					site.setSpval(supportingsVal);
					this.siteServiceDao.save(site);
				}else{
					site.setSpval(supportingsVal);
					this.siteServiceDao.save(site);
				}
			}
		}
		if(StringUtils.isNotBlank(halldisplays)){
			deleteHotelHallPeopleNumByHotelId(hotelPlace.getId());
			String dpids[] =halldisplays.split(",");
			//String hallPleNum[] = hallPeopleNums.split(",");
			for (int i=0;i<dpids.length;i++) {
				String personNum = request.getParameter("personNum"+dpids[i]); 
				HotelHallPeopleNum hallPeopleNum = this.hallPeopleNumDao.findByHallIdAndDisplayId(hotelPlace.getId(),Long.valueOf(dpids[i]));
				if(hallPeopleNum==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(dpids[i]));
					hallPeopleNum = new HotelHallPeopleNum(hotelPlace.getId(), Long.valueOf(dpids[i]), services.getLogo(), services.getName(), Long.valueOf(personNum));
					this.hallPeopleNumDao.save(hallPeopleNum);
				}else{
					hallPeopleNum.setPeopleNum(Long.valueOf(personNum));
					this.hallPeopleNumDao.save(hallPeopleNum);
				}
			}
		}
		
		
		HotelScheduleThread hotelScheduleThread = new HotelScheduleThread(hotelPlace.getId(), 365);
		hotelScheduleThread.start();
		
	}
	
	@Transactional(readOnly = false)
	public void deleteSiteServiceByHotelId(Long id,String type,String kind) {
		String nnq =  "delete from hui_site_service where site_id=? and site_type=? and kind=?";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		params.add(type);
		params.add(kind);
		hotelPlaceDao.executeNativeSQL(nnq, params);
	}
	
	@Transactional(readOnly = false)
	public void deleteHotelHallPeopleNumByHotelId(Long id){
		String nnq =  "delete from hui_hotel_hall_people_num where hall_id=?";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		hotelPlaceDao.executeNativeSQL(nnq, params);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelPlaceDao.delete(id);
	}

	public List<Object> getPlaceBySize(Integer rows) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public List<HallModel> getHotelHallPageList(Long hotelId,Integer rows,String sorts,String descs) {
		PageBean<HallModel> pageBean = new PageBean<>();
		//, h.introduction as introduction, h.description as description, h.memo as memo
		String columstr ="h.id as id, h.hotel_id as hotelId, hotel.hotel_name as hotelName, h.place_type as placeType, h.place_name as placeName, h.recommended_index as recommendedIndex"
				+ ", h.original_img as originalImg, h.thumb_img as thumbImg, h.zgui_price as zguiPrice, h.hotel_price as hotelPrice, h.isauth as isauth, h.auth_date as authDate, h.isrecommend as isrecommend"
				+ ", h.isbest as isbest, h.hall_area as hallArea, h.length as length, h.width as width, h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.decoration_time as decorationTime"
				+ ", h.electric_power as electricPower, h.sort_order as sortOrder, h.state as state, h.create_date as createDate, h.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place h left join hui_hotel hotel on hotel.id = h.hotel_id where 1=1 and h.state = '1' and h.place_type='HALL' and h.hotel_id="+hotelId;
		pageBean.setRows(rows);
		pageBean.setSort(sorts);
		pageBean.setOrder(descs);
		return customPageService.page(pageBean, columstr, fromWhere, HallModel.class,null);
	} 
	public List<Map<String,Object>> getHotelHallPageListForApi(Long hotelId,Integer rows,String sorts,String descs) {
		PageBean<HallModel> pageBean = new PageBean<>();
		String columstr ="h.id as id, h.place_name as placeName, h.thumb_img as thumbImg"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = h.id) as hotelPrice"
				+ ", h.hall_area as hallArea, h.people_num as peopleNum, h.decoration_time as decorationTime";
		String fromWhere = " from hui_hotel_place h left join hui_hotel hotel on hotel.id = h.hotel_id where 1=1 and h.state = '1' and h.place_type='HALL' and h.hotel_id="+hotelId;
		pageBean.setRows(rows);
		pageBean.setSort(sorts);
		pageBean.setOrder(descs);
		return customPageService.queryAsPageList(pageBean, columstr, fromWhere);
	} 
	
	public List<HallModel> getHallPageList(PageBean<HallModel> pageBean) {
		//, h.zgui_price as zguiPrice, h.hotel_price as hotelPrice, h.description as description, h.introduction as introduction
		String columstr ="h.id as id, h.hotel_id as hotelId, hotel.hotel_name as hotelName, h.place_type as placeType, h.place_name as placeName, h.recommended_index as recommendedIndex"
				+ ", h.original_img as originalImg, h.thumb_img as thumbImg, h.isauth as isauth, h.auth_date as authDate, h.isrecommend as isrecommend"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = h.id) as hotelPrice"
				+ ", h.isbest as isbest, h.hall_area as hallArea, h.length as length, h.width as width, h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.decoration_time as decorationTime"
				+ ", h.electric_power as electricPower, h.sort_order as sortOrder, h.state as state, h.create_date as createDate, h.memo as memo, h.trade_kicker as tradeKicker";
		
		String fromWhere = " from hui_hotel_place h left join hui_hotel hotel on hotel.id = h.hotel_id where 1=1 and h.state = '1' and h.place_type='HALL'";
		return customPageService.page(pageBean, columstr, fromWhere, HallModel.class,null);
	} 

	public List<HallModel> getAllHall(PageBean<HallModel> pageBean) {
		String columstr ="h.id as id, h.hotel_id as hotelId, hotel.hotel_name as hotelName, h.place_type as placeType, h.place_name as placeName, h.recommended_index as recommendedIndex"
				+ ", h.original_img as originalImg, h.thumb_img as thumbImg, h.isauth as isauth, h.auth_date as authDate, h.isrecommend as isrecommend"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = h.id) as hotelPrice"
				+ ", h.isbest as isbest, h.hall_area as hallArea, h.length as length, h.width as width, h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.decoration_time as decorationTime"
				+ ", h.electric_power as electricPower, h.sort_order as sortOrder, h.state as state, h.create_date as createDate, h.memo as memo, h.trade_kicker as tradeKicker";
		
		String fromWhere = " from hui_hotel_place h left join hui_hotel hotel on hotel.id = h.hotel_id where 1=1 and h.state = '1' and h.place_type='HALL'";
		return customPageService.getAll(pageBean, columstr, fromWhere, HallModel.class, null);
	}
	
	public List<HallModel> getAllHall(Long hotelId) {
		PageBean<HallModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_h.hotel_id", hotelId);
		pageBean.set_filterParams(filterParams);
		return this.getAllHall(pageBean);
		
	}
	
	public HallModel getHall(Long id) {
		String columstr = "h.id as id, h.hotel_id as hotelId, hotel.hotel_name as hotelName, h.place_type as placeType, h.place_name as placeName, h.recommended_index as recommendedIndex, h.description as description"
				+ ", h.original_img as originalImg, h.thumb_img as thumbImg, h.zgui_price as zguiPrice, h.hotel_price as hotelPrice, h.isauth as isauth, h.auth_date as authDate, h.isrecommend as isrecommend"
				+ ", h.isbest as isbest, h.hall_area as hallArea, h.length as length, h.width as width, h.height as height, h.floor as floor, h.pillar as pillar, h.people_num as peopleNum, h.decoration_time as decorationTime"
				+ ", h.electric_power as electricPower, h.introduction as introduction, h.sort_order as sortOrder, h.state as state, h.create_date as createDate, h.memo as memo, h.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place h left join hui_hotel hotel on hotel.id = h.hotel_id where 1=1 and h.state = '1' and h.id="+id;
		return customPageService.getOne(columstr, fromWhere, HallModel.class);
	}
	
	@Transactional(readOnly = false)
	public void saveHotelRoom(HotelPlace hotelPlace, String techs, String facilities) {
		if(hotelPlace.getId()==null){
			hotelPlace.setState("1");
			hotelPlace.setCreateDate(new Date());
			hotelPlace.setCreateUserId(AccountUtils.getCurrentUserId());
			hotelPlace.setCreateUserName(AccountUtils.getCurrentRName());
		}
		
		hotelPlace = hotelPlaceDao.save(hotelPlace);
		
		if(StringUtils.isNotBlank(facilities)){
			deleteSiteServiceByHotelId(hotelPlace.getId(),"ROOM","FACILITIES");
			String sprtIds[] =facilities.split(",");
			for (String id : sprtIds) {
				SiteService site = this.siteServiceDao.findBySiteIdAndSiteTypeAndServiceIdAndKind(hotelPlace.getId(),"ROOM",Long.valueOf(id),"FACILITIES");
				if(site==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(id));
					site = new SiteService(hotelPlace.getHotelId(), "ROOM", hotelPlace.getId(), "FACILITIES", Long.valueOf(id), services.getName(), services.getLogo());
					this.siteServiceDao.save(site);
				}
			}
		}
		
		if(StringUtils.isNotBlank(techs)){
			deleteSiteServiceByHotelId(hotelPlace.getId(),"ROOM","MEDIA&TECH");
			String sprtIds[] =techs.split(",");
			for (String id : sprtIds) {
				SiteService site = this.siteServiceDao.findBySiteIdAndSiteTypeAndServiceIdAndKind(hotelPlace.getId(),"ROOM",Long.valueOf(id),"MEDIA&TECH");
				if(site==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(id));
					site = new SiteService(hotelPlace.getHotelId(), "ROOM", hotelPlace.getId(), "MEDIA&TECH", Long.valueOf(id), services.getName(), services.getLogo());
					this.siteServiceDao.save(site);
				}
			}
		}
	}
	
	public List<RoomModel> getHotelRoomPageList(Long hotelId,Integer rows) {
		PageBean<RoomModel> pageBean = new PageBean<>();
		//, r.description as description, r.zgui_price as zguiPrice, r.hotel_price as hotelPrice, r.introduction as introduction
		String columstr ="r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.original_img as originalImg, r.thumb_img as thumbImg, r.isauth as isauth"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = r.id) as hotelPrice"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime, r.room_num as roomNum"
				+ ", r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.free_water as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.sort_order as sortOrder, r.state as state, r.create_date as createDate, r.memo as memo, r.breakfast as breakfast, r.network as network, c.name as roomType, r.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place r left join hui_hotel hotel on hotel.id = r.hotel_id left join hui_category c on c.id = r.room_type "
				+ " where 1=1 and r.state = '1' and r.place_type='ROOM' and r.hotel_id="+hotelId;
		pageBean.setRows(rows);
		return customPageService.page(pageBean, columstr, fromWhere, RoomModel.class,null);
	} 
	
	public List<RoomModel> getRoomPageList(PageBean<RoomModel> pageBean) {
		String columstr ="r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.original_img as originalImg, r.thumb_img as thumbImg, r.isauth as isauth"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = r.id) as hotelPrice"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime, r.room_num as roomNum"
				+ ", r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.free_water as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.sort_order as sortOrder, r.state as state, r.create_date as createDate, r.memo as memo, r.breakfast as breakfast, r.network as network, c.name as roomType, r.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place r left join hui_hotel hotel on hotel.id = r.hotel_id left join hui_category c on c.id = r.room_type "
				+ "where 1=1 and r.state = '1' and r.place_type='ROOM' ";
		return customPageService.page(pageBean, columstr, fromWhere, RoomModel.class,null);
	} 

	public List<RoomModel> getAllRoom(PageBean<RoomModel> pageBean) {
		String columstr ="r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.original_img as originalImg, r.thumb_img as thumbImg, r.isauth as isauth"
				+ ", (SELECT ifnull(online_price,0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND place_id = r.id) as hotelPrice"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime, r.room_num as roomNum"
				+ ", r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.free_water as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.sort_order as sortOrder, r.state as state, r.create_date as createDate, r.memo as memo, r.breakfast as breakfast, r.network as network, c.name as roomType, r.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place r left join hui_hotel hotel on hotel.id = r.hotel_id  left join hui_category c on c.id = r.room_type "
				+ "where 1=1 and r.state = '1' and r.place_type='ROOM' ";
		return customPageService.getAll(pageBean, columstr, fromWhere, RoomModel.class, null);
	}
	
	public RoomModel getRoom(Long id) {
		String columstr ="r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.description as description, r.original_img as originalImg, r.thumb_img as thumbImg, r.zgui_price as zguiPrice, r.hotel_price as hotelPrice, r.isauth as isauth"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime, r.room_num as roomNum"
				+ ", r.introduction as introduction, r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.free_water as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.sort_order as sortOrder, r.state as state, r.create_date as createDate, r.memo as memo, r.breakfast as breakfast, r.network as network, c.name as roomType, r.trade_kicker as tradeKicker";
		String fromWhere = " from hui_hotel_place r left join hui_hotel hotel on hotel.id = r.hotel_id  left join hui_category c on c.id = r.room_type "
				+ " where 1=1 and r.state = '1' and r.id="+id;
		return customPageService.getOne(columstr, fromWhere, RoomModel.class);
	}
	
	public RoomModel getRoom(Long id,String date) {
		String columstr ="r.id as id, r.hotel_id as hotelId, hotel.hotel_name as hotelName, r.place_type as placeType, r.place_name as placeName, r.recommended_index as recommendedIndex"
				+ ", r.description as description, r.original_img as originalImg, r.thumb_img as thumbImg, r.zgui_price as zguiPrice, p.online_price as hotelPrice, r.isauth as isauth"
				+ ", r.auth_date as authDate, r.isrecommend as isrecommend, r.isbest as isbest, r.hall_area as hallArea, r.floor as floor, r.decoration_time as decorationTime"
				+ ", r.introduction as introduction, r.room_service as roomService, r.bed_size as bedSize, r.bed_num as bedNum, r.check_in_num as checkInNum, r.hotwater as hotwater"
				+ ", r.bathroom as bathroom, r.towel as towel, r.free_water as freeWater, r.free_supplies as freeSupplies, r.free_supplies_num as freeSuppliesNum, r.window as window"
				+ ", r.memo as memo, r.breakfast as breakfast, r.network as network, c.name as roomType, r.trade_kicker as tradeKicker, r.room_num as roomNum";
		String fromWhere = " from hui_hotel_place r left join hui_hotel hotel on hotel.id = r.hotel_id  left join hui_category c on c.id = r.room_type "
				+ " left join hui_place_price p on p.place_type = 'ROOM' and p.place_schedule = '"+date+"' and p.place_id = r.id"
				+ " where 1=1 and r.state = '1' and r.id="+id;
		return customPageService.getOne(columstr, fromWhere, RoomModel.class);
	}
}
