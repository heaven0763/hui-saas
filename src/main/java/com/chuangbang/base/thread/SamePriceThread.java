package com.chuangbang.base.thread;

import java.util.Date;
import java.util.List;

import com.chuangbang.base.dao.hotel.CategoryDao;
import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.dao.hotel.HotelScheduleDao;
import com.chuangbang.base.dao.hotel.PlacePriceDao;
import com.chuangbang.base.dao.hotel.PriceAdjustDao;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.spring.SpringUtils;

public class SamePriceThread extends Thread{
	private PriceTrial priceTrial;
	private PriceAdjustDao priceAdjustDao = (PriceAdjustDao) SpringUtils.getBean("priceAdjustDao");
	private PlacePriceDao placePriceDao = (PlacePriceDao) SpringUtils.getBean("placePriceDao");
	private HotelPlaceDao hotelPlaceDao =  (HotelPlaceDao) SpringUtils.getBean("hotelPlaceDao");
	
	private CategoryDao categoryDao =  (CategoryDao) SpringUtils.getBean("categoryDao");
	private HotelScheduleDao hotelScheduleDao =  (HotelScheduleDao) SpringUtils.getBean("hotelScheduleDao");
	@Override
	public void run(){
		System.out.println("SamePriceThread>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>run"+DateTimeUtils.getCurrentTimeStamp());
		List<PriceAdjust> priceAdjusts = priceAdjustDao.findByAuditId(priceTrial.getId());
		for (PriceAdjust priceAdjust : priceAdjusts) {
			PlacePrice placePrice = placePriceDao.findByPlaceIdAndPlaceSchedule(priceAdjust.getPlaceId(), priceAdjust.getAdjustSdate());
			HotelPlace hotelPlace = hotelPlaceDao.findOne(priceAdjust.getPlaceId());
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
			if("HALL".equals(hotelPlace.getPlaceType())){
				List<Category> categories = categoryDao.findByKind("SCHEDULETIME");
				for (Category category : categories) {
					HotelSchedule schedule =this.hotelScheduleDao.findByPlaceIdAndPlaceDateAndPlaceSchedule(priceTrial.getPlaceId(),priceAdjust.getAdjustSdate(),category.getId()+"");
					if(schedule==null){
						schedule = new HotelSchedule(priceTrial.getHotelId(), priceTrial.getHotelName(), hotelPlace.getPlaceType(), priceTrial.getPlaceId(), priceTrial.getPlaceName(), category.getId()+"", priceAdjust.getAdjustSdate(), "0", AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), new Date(), "");
						this.hotelScheduleDao.save(schedule);
					}
				}
			}
		}
		System.out.println("SamePriceThread>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>end"+DateTimeUtils.getCurrentTimeStamp());
	}
	
	
	public SamePriceThread() {
		super();
	}


	public SamePriceThread(PriceTrial priceTrial) {
		super();
		this.priceTrial = priceTrial;
	}
	
	public PriceTrial getPriceTrial() {
		return priceTrial;
	}
	public void setPriceTrial(PriceTrial priceTrial) {
		this.priceTrial = priceTrial;
	}
	
	
}
