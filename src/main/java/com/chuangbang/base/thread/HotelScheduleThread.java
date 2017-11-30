package com.chuangbang.base.thread;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.chuangbang.base.dao.hotel.CategoryDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.spring.SpringUtils;
import com.google.common.collect.Lists;

public class HotelScheduleThread extends Thread{
	private Long placeId;
	private Integer days;
	private String type;
	private Long hotelId;
	
	private CategoryDao categoryDao =  (CategoryDao) SpringUtils.getBean("categoryDao");
	private HotelPlaceDao hotelPlaceDao =  (HotelPlaceDao) SpringUtils.getBean("hotelPlaceDao");
	private HotelScheduleDao hotelScheduleDao =  (HotelScheduleDao) SpringUtils.getBean("hotelScheduleDao");
	
	
	@Override
	public void run(){
		Date date = new Date();
		System.out.println("HotelScheduleThread>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>run"+DateTimeUtils.getCurrentTimeStamp());
		List<Category> categories = this.categoryDao.findByKind("SCHEDULETIME");
		if(StringUtils.isNotBlank(type)){
			if("HOTEL".equals(type)){
				List<HotelPlace> places = this.hotelPlaceDao.findByHotelIdAndPlaceType(hotelId,"HALL");
				for (HotelPlace hotelPlace : places) {
					saveschedule(hotelPlace,categories);
				}
			}else if("HALL".equals(type)){
				HotelPlace hotelPlace = this.hotelPlaceDao.findOne(placeId);
				saveschedule(hotelPlace,categories);
			}
		}else{
			HotelPlace hotelPlace = this.hotelPlaceDao.findOne(placeId);
			saveschedule(hotelPlace,categories);
		}
		
		System.out.println("HotelScheduleThread>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>end"+DateTimeUtils.getCurrentTimeStamp());
		System.out.println("耗时>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>end"+(new Date().getTime()-date.getTime())*1.0/1000+"s");
	}
	
	private void saveschedule(HotelPlace hotelPlace,List<Category> categories){
		String placeDate = getMaxPlaceDate(hotelPlace.getId());
		System.out.println("placeDate>>>>>>>>"+placeDate);
		Date pdate = DateUtils.parseDate(placeDate);
		String inserts = "insert into hui_hotel_schedule (create_date, create_user_id, create_user_name, hotel_id, hotel_name,memo, place_date, place_id, place_name, place_schedule, place_type, state) values";
		String values = "";
		for(int i=1;i<=days;i++){
			Date date = DateUtils.addDays(pdate, i);
			for (Category category : categories) {
				String sdate = DateTimeUtils.toDay(date);
				HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(hotelPlace.getId(),sdate,category.getId()+"");
				if(schedule==null){
					schedule = new HotelSchedule(hotelPlace.getHotelId(), "", hotelPlace.getPlaceType(), hotelPlace.getId(), hotelPlace.getPlaceName(), category.getId()+"", sdate, "0", "SYSTEM", "SYSTEM", new Date(), "");
					//this.hotelScheduleDao.save(schedule);
					values+="('"+DateTimeUtils.getCurrentTimeStamp()+"', 'SYSTEM', 'SYSTEM', "+hotelPlace.getHotelId()+", '', '', '"+sdate+"', "+hotelPlace.getId()+", '"+hotelPlace.getPlaceName()+"', '"+category.getId()+"', 'HALL', '0'),";
				}
			}
		}
		this.hotelScheduleDao.executeNativeSQL(inserts+values.substring(0,values.length()-1));
		/*insert into hui_hotel_schedule (create_date, create_user_id, create_user_name, hotel_id, hotel_name, 
				memo, place_date, place_id, place_name, place_schedule, place_type, state) values ('11/20/2017 
						11:53:03.031', 'SYSTEM', 'SYSTEM', 1610, '', '', '2018-10-28', 509, '5号馆/6号馆', '87', 'HALL', 
						'0')  {executed in 10 msec}
		*/
	}

	public HotelScheduleThread() {
		super();
	}
	public HotelScheduleThread(Long placeId,Integer days) {
		super();
		this.placeId = placeId;
		this.days = days;
	}

	public Long getPlaceId() {
		return placeId;
	}
	public void setPlaceId(Long placeId) {
		this.placeId = placeId;
	}
	
	public Integer getDays() {
		return days;
	}


	public void setDays(Integer days) {
		this.days = days;
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


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public Long getHotelId() {
		return hotelId;
	}
	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}


	public HotelScheduleThread(Long placeId, Integer days, String type, Long hotelId) {
		super();
		this.placeId = placeId;
		this.days = days;
		this.type = type;
		this.hotelId = hotelId;
	}

	public HotelScheduleThread( Integer days, String type, Long hotelId) {
		super();
		this.days = days;
		this.type = type;
		this.hotelId = hotelId;
	}



	
	
}
