package com.chuangbang.base.service.hotel;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.HotelSelModel;
import com.chuangbang.app.model.RecommendedHotel;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.hotel.SiteServiceDao;
import com.chuangbang.base.dao.hotel.SupportingServicesDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelApplyRecord;
import com.chuangbang.base.entity.hotel.SiteService;
import com.chuangbang.base.entity.hotel.SupportingServices;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.plugins.baidu.yun.map.model.BaiduMapResult;
import com.chuangbang.plugins.baidu.yun.util.BaiduMapUtil;
import com.google.common.collect.Lists;

/**
 * 酒店Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class HotelService extends BaseService<Hotel,HotelDao> {

	@Autowired
	private HotelDao hotelDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private SiteServiceDao siteServiceDao;
	@Autowired
	private SupportingServicesDao supportingServicesDao;
	@Autowired
	private CusQueryService cusQueryService;
	public List<HotelModel> getHotelPageList(PageBean<HotelModel> pageBean,Double longitude,Double latitude) {
		String columstr = "h.id as id, h.pid as pid, hg.name as pName, h.hotel_name as hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.original_img as originalImg"
				+ ", h.thumb_img as thumbImg, h.style as style, h.traffic_signs as trafficSigns, h.landmarks as landmarks, h.qq as qq, h.website as website, h.line as line"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.keyword as keyword, h.description as description, h.search as search, h.introduction as introduction, h.decoration_time as decorationTime, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.mobile as mobile, h.fax as fax, h.email as email, h.tag as tag, h.state as state, h.certifi_time as certifiTime, h.verify as verify, h.is_hot as isHot"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.create_date as createDate, h.memo as memo, h.reclaim_user_name as reclaimUserName"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '06') dealNum, h.trade_kicker as tradeKicker, h.tbmeal_amount as tbmealAmount, h.buffet_amount as buffetAmount"
				+ ", p.region_name as provinceText, c.region_name as cityText, d.region_name as districtText, s.district as tradeAreaText, ht.name as hotelTypeText, star.name as hotelStarText"
				+ ", h.meeting_remark as meetingRemark, h.house_remark as houseRemark, h.dinner_remark as dinnerRemark"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as roomPrice"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as hallPrice";
				/*+ ", (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=67) qsbednum"
				+ ", (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=68) dualbednum"*/
				if(null!=longitude&&null!=latitude){
					columstr+= ", getDistance(h.longitude,h.latitude,"+longitude+","+latitude+") as distance";
				}
			
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star"
				+ "	left join hui_hotel_group hg on hg.id= h.pid"
				+ " where 1=1 and h.state = 1";
		//fromWhere += " GROUP BY h.id";
		if(pageBean.get_filterParams().get("EQ_style")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_style")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_style")+"',h.style) >= 1";
			pageBean.get_filterParams().remove("EQ_style");
		}
		if(pageBean.get_filterParams().get("EQ_purpose")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_purpose")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_purpose")+"',h.purpose) >= 1";
			pageBean.get_filterParams().remove("EQ_purpose");
		}
		if(pageBean.get_filterParams().get("LTE_qsbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_qsbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=67)>="+pageBean.get_filterParams().get("LTE_qsbednum");
			pageBean.get_filterParams().remove("LTE_qsbednum");
		}
		if(pageBean.get_filterParams().get("LTE_dualbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_dualbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=68)>="+pageBean.get_filterParams().get("LTE_dualbednum");
			pageBean.get_filterParams().remove("LTE_dualbednum");
		}
		return customPageService.page(pageBean, columstr, fromWhere, HotelModel.class,null);
	} 
	
	public List<Map<String,Object>> getHotelPageListForApi(PageBean<Map<String, Object>> pageBean,Double longitude,Double latitude) {
		String columstr = "h.id as id, h.hotel_name as hotelName, h.hotel_type as hotelType, h.thumb_img as thumbImg"
				+ ", star.name as hotelStarText, h.address as address, h.decoration_time as decorationTime"
				+ ", (SELECT max(CAST(hall_area AS DECIMAL)) FROM hzg_saas.hui_hotel_place p WHERE p.hotel_id = h.id and p.place_type = 'HALL') as hallMaxArea"
				+ ", (SELECT max(people_num) FROM hzg_saas.hui_hotel_place p WHERE p.hotel_id = h.id and p.place_type = 'HALL') as maxPeopleNum"
				+ ", (select count(*) from hui_hotel_place o where o.hotel_id = h.id and o.place_type = 'HALL') as hallNum"
				+ ", (select count(*) from hui_hotel_place o where o.hotel_id = h.id and o.place_type = 'ROOM') as roomNum"
				/*//+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.hotel_star as hotelStar, h.keyword as keyword, h.description as description, h.search as search, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.create_date as createDate, h.reclaim_user_name as reclaimUserName"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '06') dealNum, h.trade_kicker as tradeKicker, h.tbmeal_amount as tbmealAmount, h.buffet_amount as buffetAmount"
				+ ", p.region_name as provinceText, c.region_name as cityText, d.region_name as districtText, s.district as tradeAreaText, ht.name as hotelTypeText"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as roomPrice"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as hallPrice"*/;
				if(null!=longitude&&null!=latitude){
					columstr+= ", getDistance(h.longitude,h.latitude,"+longitude+","+latitude+") as distance";
				}
			
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star"
				+ "	left join hui_hotel_group hg on hg.id= h.pid"
				+ " where 1=1 and h.state = 1";
		//fromWhere += " GROUP BY h.id";
		if(pageBean.get_filterParams().get("EQ_style")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_style")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_style")+"',h.style) >= 1";
			pageBean.get_filterParams().remove("EQ_style");
		}
		if(pageBean.get_filterParams().get("EQ_purpose")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_purpose")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_purpose")+"',h.purpose) >= 1";
			pageBean.get_filterParams().remove("EQ_purpose");
		}
		if(pageBean.get_filterParams().get("LTE_qsbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_qsbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=67)>="+pageBean.get_filterParams().get("LTE_qsbednum");
			pageBean.get_filterParams().remove("LTE_qsbednum");
		}
		if(pageBean.get_filterParams().get("LTE_dualbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_dualbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=68)>="+pageBean.get_filterParams().get("LTE_dualbednum");
			pageBean.get_filterParams().remove("LTE_dualbednum");
		}
		return customPageService.queryAsPageList(pageBean, columstr, fromWhere);
	} 
	
	
	public List<HotelModel> getSimpleHotelPageList(PageBean<HotelModel> pageBean,Double longitude,Double latitude) {
		String columstr = "h.id as id, h.pid as pid, hg.name as pName, h.hotel_name as hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.thumb_img as thumbImg"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.decoration_time as decorationTime, h.hall_num as hallNum, h.update_date as updateDate"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.state as state, h.create_date as createDate, h.memo as memo, h.reclaim_user_name as reclaimUserName"
				+ ", p.region_name as provinceText, c.region_name as cityText, d.region_name as districtText, s.district as tradeAreaText, ht.name as hotelTypeText, star.name as hotelStarText";
				if(null!=longitude&&null!=latitude){
					columstr+= ", getDistance(h.longitude,h.latitude,"+longitude+","+latitude+") as distance";
				}
			
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star"
				+ "	left join hui_hotel_group hg on hg.id= h.pid"
				+ " where 1=1 and h.state = 1";
		//fromWhere += " GROUP BY h.id";
		if(pageBean.get_filterParams().get("EQ_style")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_style")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_style")+"',h.style) >= 1";
			pageBean.get_filterParams().remove("EQ_style");
		}
		if(pageBean.get_filterParams().get("EQ_purpose")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("EQ_purpose")+"")){
			fromWhere+=" and getStrMatch('"+pageBean.get_filterParams().get("EQ_purpose")+"',h.purpose) >= 1";
			pageBean.get_filterParams().remove("EQ_purpose");
		}
		if(pageBean.get_filterParams().get("LTE_qsbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_qsbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=67)>="+pageBean.get_filterParams().get("LTE_qsbednum");
			pageBean.get_filterParams().remove("LTE_qsbednum");
		}
		if(pageBean.get_filterParams().get("LTE_dualbednum")!=null&&StringUtils.isNotBlank(pageBean.get_filterParams().get("LTE_dualbednum")+"")){
			fromWhere+=" and (select count(*) from hui_hotel_place p where p.hotel_id = h.id and p.place_type = 'ROOM' and p.room_type=68)>="+pageBean.get_filterParams().get("LTE_dualbednum");
			pageBean.get_filterParams().remove("LTE_dualbednum");
		}
		return customPageService.page(pageBean, columstr, fromWhere, HotelModel.class,null);
	} 
	
	public List<HotelSelModel> getSelHotelPageList(PageBean<HotelSelModel> pageBean,Double longitude,Double latitude) {
		String columstr = " h.id as id, h.pid as pid, h.pname as pName, h.hotel_name as hotelName, h.reclaim_user_id as reclaimUserId, h.reclaim_user_name as reclaimUserName";
		String fromWhere = " from hui_hotel h where 1=1 and h.state = 1";
		return customPageService.page(pageBean, columstr, fromWhere, HotelSelModel.class,null);
	} 
	
	public List<HotelSelModel> getSelHotelPageList(PageBean<HotelSelModel> pageBean) {
		String columstr = " h.id as id, h.pid as pid, h.pname as pName, h.hotel_name as hotelName, h.reclaim_user_id as reclaimUserId, h.reclaim_user_name as reclaimUserName";
		String fromWhere = " from hui_hotel h where 1=1 and h.state = 1";
		return customPageService.page(pageBean, columstr, fromWhere, HotelSelModel.class,null);
	} 
	public List<HotelSelModel> getAllHotelForSel(PageBean<HotelSelModel> pageBean) {
		String columstr = "h.id as id, h.pid as pid, h.pname as pName, h.hotel_name as hotelName, h.reclaim_user_id as reclaimUserId, h.reclaim_user_name as reclaimUserName";
		String fromWhere = " from hui_hotel h where 1=1 and h.state = 1";
		return customPageService.getAll(pageBean, columstr, fromWhere, HotelSelModel.class, null);
	}
	public List<HotelModel> getApplyHotelPageList(PageBean<HotelModel> pageBean,int referer,String hotelName) {
		String userId = AccountUtils.getCurrentUserId();
		String columstr = "h.id as id, h.pid as pid, h.pname as pName, h.hotel_name as hotelName, h.description as description, r.id as recordId, r.user_id as userId"
				+ ", (select count(*) from hui_apply_record where h.id = hotel_id and state = 0 and user_id ='"+userId+"') as applyState"   //==1   申请状态
				+ ", (select count(*) from hui_apply_record where h.id = hotel_id and state = 1 and user_id ='"+userId+"') as joinState";   //==1  已加入
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star left join hui_apply_record r on h.id = r.hotel_id"
				+ " where 1=1 and h.state = 1";
		if(StringUtils.isNotBlank(hotelName)){
			fromWhere +=  " and h.hotel_name LIKE '%"+hotelName+"%'";
		}
		fromWhere += " GROUP BY h.id";
		if(referer==1){
			//微信端进来
			pageBean.setOrder("asc");
		}
	
		return customPageService.hotelList(pageBean, columstr, fromWhere, HotelModel.class,null);
	} 
	
	
	public List<Map<String, Object>> getPageTeams(PageBean<Map<String, Object>> pageBean) {
		String userId = AccountUtils.getCurrentUserId();
		String sql =" t.id as id, t.name as name, t.type as type, t.times as times, t.desction as desction, r.id as recordId, r.user_id as userId"
		+ ", (select count(*) from hui_apply_record where t.id = hotel_id and t.type=type and state = 0 and user_id ='"+userId+"') as applyState"   //==1   申请状态
		+ ", (select count(*) from hui_apply_record where t.id = hotel_id and t.type=type and state = 1 and user_id ='"+userId+"') as joinState";   //==1  已加入
		String fromWhere =	" FROM hzg_saas.hui_team_view t left join hui_apply_record r on t.id = r.hotel_id and t.type=r.type AND r.state = 0 where 1=1";
		pageBean.setOrder("desc");
		pageBean.setSort("t.times");
		List<Map<String, Object>> res = customPageService.pageAsMap(pageBean, sql,fromWhere, null);
		return res;
	}

	
	public List<HotelModel> getMHotelPageList(PageBean<HotelModel> pageBean) {
		String columstr = "h.id as id, h.pid as pid, hg.name as pName, h.hotel_name as hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.original_img as originalImg"
				+ ", h.thumb_img as thumbImg, h.style as style, h.traffic_signs as trafficSigns, h.landmarks as landmarks, h.qq as qq, h.website as website, h.line as line"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.keyword as keyword, h.description as description, h.search as search, h.introduction as introduction, h.decoration_time as decorationTime, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.mobile as mobile, h.fax as fax, h.email as email, h.tag as tag, h.state as state, h.certifi_time as certifiTime, h.verify as verify, h.is_hot as isHot"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.reclaim_user_id as reclaimUserId, h.reclaim_user_name as reclaimUserName"
				+ ", h.create_user_id as createUserId, h.create_user_name as createUserName, h.create_date as createDate, h.memo as memo"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '06') dealNum, h.trade_kicker as tradeKicker, h.tbmeal_amount as tbmealAmount, h.buffet_amount as buffetAmount"
				+ ", h.meeting_remark as meetingRemark, h.house_remark as houseRemark, h.dinner_remark as dinnerRemark";
		String fromWhere = " from hui_hotel h where 1=1 "
				+ "	left join hui_hotel_group hg on hg.id= h.pid";
		return customPageService.page(pageBean, columstr, fromWhere, HotelModel.class,null);
	} 

	public List<HotelModel> getAllHotel(PageBean<HotelModel> pageBean) {
		String columstr = "h.id as id, h.pid as pid, hg.name as pName, h.hotel_name as hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.original_img as originalImg"
				+ ", h.thumb_img as thumbImg, h.style as style, h.traffic_signs as trafficSigns, h.landmarks as landmarks, h.qq as qq, h.website as website, h.line as line"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.keyword as keyword, h.description as description, h.search as search, h.introduction as introduction, h.decoration_time as decorationTime, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.mobile as mobile, h.fax as fax, h.email as email, h.tag as tag, h.state as state, h.certifi_time as certifiTime, h.verify as verify, h.is_hot as isHot"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.create_date as createDate, h.memo as memo"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '06') dealNum, h.trade_kicker as tradeKicker, h.tbmeal_amount as tbmealAmount, h.buffet_amount as buffetAmount"
				+ ", p.region_name as provinceText, c.region_name as cityText, d.region_name as districtText, s.district as tradeAreaText, ht.name as hotelTypeText, star.name as hotelStarText"
				+ ", h.meeting_remark as meetingRemark, h.house_remark as houseRemark, h.dinner_remark as dinnerRemark"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as roomPrice"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as hallPrice";
				
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star"
				+ "	left join hui_hotel_group hg on hg.id= h.pid"
				+ " where 1=1 and h.state = 1";
		return customPageService.getAll(pageBean, columstr, fromWhere, HotelModel.class, null);
	}

	public HotelModel getHotel(Long id) {
		String columstr = "h.id as id, h.pid as pid, hg.name as pName, h.hotel_name as hotelName, h.hotel_type as hotelType, h.hotel_star as hotelStar, h.original_img as originalImg"
				+ ", h.thumb_img as thumbImg, h.style as style, h.traffic_signs as trafficSigns, h.landmarks as landmarks, h.qq as qq, h.website as website, h.line as line"
				+ ", h.province as province, h.city as city, h.district as district, h.trade_area as tradeArea, h.address as address, h.longitude as longitude, h.latitude as latitude"
				+ ", h.keyword as keyword, h.description as description, h.search as search, h.introduction as introduction, h.decoration_time as decorationTime, h.hall_num as hallNum"
				+ ", h.room_num as roomNum, h.largest_venue as largestVenue, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum"
				+ ", h.special_service as specialService, h.recommended_index as recommendedIndex, h.review_index as reviewIndex, h.contact as contact, h.telephone as telephone"
				+ ", h.mobile as mobile, h.fax as fax, h.email as email, h.tag as tag, h.state as state, h.certifi_time as certifiTime, h.verify as verify, h.is_hot as isHot"
				+ ", h.is_tui as isTui, h.isbest as isbest, h.browse as browse, h.sort_order as sortOrder, h.create_date as createDate, h.memo as memo"
				+ ", (select count(*) from hui_order o where o.hotel_id = h.id and o.state = '06') dealNum, h.trade_kicker as tradeKicker, h.tbmeal_amount as tbmealAmount, h.buffet_amount as buffetAmount"
				+ ", p.region_name as provinceText, c.region_name as cityText, d.region_name as districtText, s.district as tradeAreaText, ht.name as hotelTypeText, star.name as hotelStarText"
				+ ", h.meeting_remark as meetingRemark, h.house_remark as houseRemark, h.dinner_remark as dinnerRemark"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'ROOM' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as roomPrice"
				+ ", (SELECT ifnull(min(online_price),0) price FROM hui_place_price where place_type = 'HALL' AND place_schedule = '"+DateTimeUtils.getCurrentDate()+"' AND hotel_id = h.id) as hallPrice";
				
		String fromWhere = " from hui_hotel h left join hui_region p on p.id=h.province left join hui_region c on c.id=h.city left join hui_region d on d.id=h.district"
				+ " left join hui_district s on s.id=h.trade_area left join hui_category ht on ht.id=h.hotel_type left join hui_category star on star.id=h.hotel_star"
				+ "	left join hui_hotel_group hg on hg.id= h.pid"
				+ " where 1=1 and h.state = 1 and h.id="+id;
		return customPageService.getOne(columstr, fromWhere, HotelModel.class);
	}
	
	public Hotel getEntity(Long id) {
		return hotelDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveHotel(Hotel hotel) {
		hotelDao.save(hotel);
	}
	
	@Transactional(readOnly = false)
	public void saveHotel(Hotel hotel,String supportings,String roomservices) {
		if(hotel.getId()==null){
			hotel.setState("1");
			hotel.setCreateDate(new Date());
			hotel.setCreateUserId(AccountUtils.getCurrentUserId());
			hotel.setCreateUserName(AccountUtils.getCurrentRName());
			hotel.setCompanyId(AccountUtils.getCurrentUserCompanyId());
		}
		hotel.setUpdateDate(new Date());
		if(StringUtils.isNotBlank(hotel.getAddress())){
			BaiduMapResult baiduMapResult;
			try {
				baiduMapResult = BaiduMapUtil.getGeocoding(hotel.getAddress().trim());
				hotel.setLatitude(Double.valueOf(baiduMapResult.getLocation().getLat()));
				hotel.setLongitude(Double.valueOf(baiduMapResult.getLocation().getLng()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		hotel = hotelDao.save(hotel);
		if(StringUtils.isNotBlank(supportings)){
			deleteByHotelId(hotel.getId(),"HOTELSUPORTING");
			String sprtIds[] =supportings.split(",");
			for (String id : sprtIds) {
				SiteService site = this.siteServiceDao.findBySiteIdAndSiteTypeAndServiceIdAndKind(hotel.getId(),"HOTEL",Long.valueOf(id),"HOTELSUPORTING");
				if(site==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(id));
					site = new SiteService(hotel.getId(), "HOTEL", hotel.getId(), "HOTELSUPORTING", Long.valueOf(id), services.getName(), services.getLogo());
					this.siteServiceDao.save(site);
				}
			}
		}
		if(StringUtils.isNotBlank(roomservices)){
			deleteByHotelId(hotel.getId(),"ROOMSERVICE");
			String sprtIds[] =roomservices.split(",");
			for (String id : sprtIds) {
				SiteService site = this.siteServiceDao.findBySiteIdAndSiteTypeAndServiceIdAndKind(hotel.getId(),"HOTEL",Long.valueOf(id),"ROOMSERVICE");
				if(site==null){
					SupportingServices services = this.supportingServicesDao.findOne(Long.valueOf(id));
					site = new SiteService(hotel.getId(), "HOTEL", hotel.getId(), "ROOMSERVICE", Long.valueOf(id), services.getName(), services.getLogo());
					this.siteServiceDao.save(site);
				}
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		hotelDao.delete(id);
	}
	@Transactional(readOnly = false)
	public void deleteByHotelId(Long id,String kind) {
		String nnq =  "delete from hui_site_service where site_id=? and site_type='HOTEL' and kind=?";
		List<Object> params = Lists.newArrayList();
		params.add(id);
		params.add(kind);
		hotelDao.executeNativeSQL(nnq, params);
	}

	public String findHotelIdsByPId(Long pId) {
		String ids="";
		String nnq =  "select id from hui_hotel where pid=?";
		List<Object> params = Lists.newArrayList();
		params.add(pId);
		List<Object> res = this.hotelDao.executeNativeQuery(nnq, params);
		if(res!=null&&res.size()>0){
			for (Object object : res) {
				if(StringUtils.isNotBlank(ids)){
					ids += ","+object.toString();
				}else{
					ids = object.toString();
				}
			}
		}
		return ids;
	}

	public String findHotelIdsByCompanyId(Long companyId) {
		String ids="";
		String nnq =  "select id from hui_hotel where company_id=?";
		List<Object> params = Lists.newArrayList();
		params.add(companyId);
		List<Object> res = this.hotelDao.executeNativeQuery(nnq, params);
		if(res!=null&&res.size()>0){
			for (Object object : res) {
				if(StringUtils.isNotBlank(ids)){
					ids += ","+object.toString();
				}else{
					ids = object.toString();
				}
			}
		}
		return ids;
	}
	public String findHotelIdsByReclaimUserId(String userId) {
		String ids="";
		String nnq =  "select id from hui_hotel where reclaim_user_id=?";
		List<Object> params = Lists.newArrayList();
		params.add(userId);
		List<Object> res = this.hotelDao.executeNativeQuery(nnq, params);
		if(res!=null&&res.size()>0){
			for (Object object : res) {
				if(StringUtils.isNotBlank(ids)){
					ids += ","+object.toString();
				}else{
					ids = object.toString();
				}
			}
		}
		return ids;
	}

	public HotelApplyRecord getHuiRecord() {
		// TODO Auto-generated method stub
		//state>0  申请中
		//applyState>0 已加入
		String columStr = "count(*) as state, (select count(*) from hui_apply_record where hotel_id = 0 and state = '1') as temp";
		String fromWhere = " from hui_apply_record where hotel_id = 0 and state = '0' and user_id = '"+AccountUtils.getCurrentUserId()+"'";
		return customPageService.getOne(columStr, fromWhere, HotelApplyRecord.class);
	}

	@Transactional(readOnly=false)
	public JsonVo authorUserHotelSave(User user, String hotelIds,String unhotelIds) {
		try{
			if(StringUtils.isNotBlank(hotelIds)){
				String [] mhotelIds =hotelIds.split(",");
				for (String hid : mhotelIds) {
					Hotel hotel = this.getEntity(Long.valueOf(hid));
					System.out.println(">>>>>>>>>>>>yes>>>>>>>>>>>"+hotel.getHotelName());
					hotel.setReclaimUserId(user.getId());
					hotel.setReclaimUserName(user.getRname());
					this.hotelDao.save(hotel);
				}
			}
			
			if(StringUtils.isNotBlank(unhotelIds)){
				String [] mhotelIds =unhotelIds.split(",");
				for (String hid : mhotelIds) {
					Hotel hotel = this.getEntity(Long.valueOf(hid));
					System.out.println(">>>>>>>>>>>>yes>>>>>>>>>>>"+hotel.getHotelName());
					if(StringUtils.isNotBlank(hotel.getReclaimUserId())&&!user.getId().equals(hotel.getReclaimUserId())){
						
					}else{
						hotel.setReclaimUserId(null);
						hotel.setReclaimUserName(null);
						this.hotelDao.save(hotel);
					}
				}
			}
		
		/*
			if(StringUtils.isBlank(hotelIds)){
				List<Hotel> hotels = this.hotelDao.findByReclaimUserId(user.getId());
				if(hotels!=null&&hotels.size()>0){
					for (Hotel hotel : hotels) {
						hotel.setReclaimUserId("");
						hotel.setReclaimUserName("");
						this.hotelDao.save(hotel);
					}
				}
			}else{
				String nhotelIds = hotelIds.replaceAll(",", "#")+"#";
				List<Hotel> hotels = this.hotelDao.findByReclaimUserId(user.getId());
				if(hotels!=null&&hotels.size()>0){
					for (Hotel hotel : hotels) {
						if(!nhotelIds.contains(hotel.getId()+"#")){
							System.out.println(">>>>>>>>>no>>>>>>>>>>>>>>"+hotel.getHotelName());
							hotel.setReclaimUserId("");
							hotel.setReclaimUserName("");
							this.hotelDao.save(hotel);
						}
					}
				}
				String mhotelIds[] = hotelIds.split(",");
				for (String hid : mhotelIds) {
					Hotel hotel = this.getEntity(Long.valueOf(hid));
					System.out.println(">>>>>>>>>>>>yes>>>>>>>>>>>"+hotel.getHotelName());
					hotel.setReclaimUserId(user.getId());
					hotel.setReclaimUserName(user.getRname());
					this.hotelDao.save(hotel);
				}
			}*/
			return JsonUtils.success("分配成功！");
		}catch(Exception e){
			return JsonUtils.error("系统错误！");
		}
	}

	public List<RecommendedHotel> getPageRecommendedHotel(PageBean<RecommendedHotel> pageBean) {
		String columstr = "h.id as id, h.hotel_name as hotelName, h.original_img as originalImg, h.thumb_img as thumbImg, h.decoration_time as decorationTime"
				+ ", h.hall_num as hallNum, h.room_num as roomNum, h.average_price as averagePrice, h.hall_max_area as hallMaxArea, h.max_people_num as maxPeopleNum";
		String fromWhere = " from hui_hotel h where 1=1 and h.state = 1";
		return customPageService.page(pageBean, columstr, fromWhere, RecommendedHotel.class,null);
	}

	public List<Hotel> findByReclaimUserId(String reclaimUserId) {
		return this.hotelDao.findByReclaimUserId(reclaimUserId);
	}
}
