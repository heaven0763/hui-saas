package com.chuangbang.base.service.hotel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.dao.hotel.PriceAdjustDao;

/**
 * 场地价格调整Service
 * @author mabelxiao
 * @version 2016-11-15
 */
@Component
@Transactional(readOnly = true)
public class PriceAdjustService extends BaseService<PriceAdjust,PriceAdjustDao> {

	@Autowired
	private PriceAdjustDao priceAdjustDao;
	
	@Autowired
	private CustomPageService customPageService;
	
	public PriceAdjust getEntity(Long id) {
		return priceAdjustDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void savePriceAdjust(PriceAdjust priceAdjust) {
		priceAdjustDao.save(priceAdjust);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		priceAdjustDao.delete(id);
	}
	
	
	public List<PriceAdjust> getPriceAdjustPageList(PageBean<PriceAdjust> pageBean) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.adjust_sdate as adjustSdate"
				+ ", pa.adjust_edate as adjustEdate, pa.online_price_before as onlinePriceBefore, pa.online_price_after as onlinePriceAfter, pa.online_price_rate as onlinePriceRate"
				+ ", pa.offline_price_before as offlinePriceBefore, pa.offline_price_after as offlinePriceAfter, pa.offline_price_rate as offlinePriceRate, pa.price_before_rate as priceBeforeRate"
				+ ", pa.price_after_rate as priceAfterRate, pa.adjust_rate as adjustRate, pa.create_date as createDate, pa.memo as memo";
		String fromWhere = " from hui_price_adjust pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " where 1=1 ";
		return customPageService.page(pageBean, columstr, fromWhere, PriceAdjust.class,null);
	} 
	
	public List<PriceAdjust> getAllPriceAdjust(PageBean<PriceAdjust> pageBean) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.adjust_sdate as adjustSdate"
				+ ", pa.adjust_edate as adjustEdate, pa.online_price_before as onlinePriceBefore, pa.online_price_after as onlinePriceAfter, pa.online_price_rate as onlinePriceRate"
				+ ", pa.offline_price_before as offlinePriceBefore, pa.offline_price_after as offlinePriceAfter, pa.offline_price_rate as offlinePriceRate, pa.price_before_rate as priceBeforeRate"
				+ ", pa.price_after_rate as priceAfterRate, pa.adjust_rate as adjustRate, pa.create_date as createDate, pa.memo as memo";
		String fromWhere = " from hui_price_adjust pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " where 1=1 ";
		return customPageService.getAll(pageBean, columstr, fromWhere, PriceAdjust.class, null);
	}
	
	public PriceAdjust getPriceAdjust(Long id) {
		String columstr = "pa.id as id, pa.hotel_id as hotelId, pa.hotel_name as hotelName, pa.place_id as placeId, pa.place_name as placeName, pa.state as state"
				+ ", pa.apply_user_id as applyUserId, pa.apply_user_name as applyUserName, pa.apply_date as applyDate, pa.adjust_sdate as adjustSdate"
				+ ", pa.adjust_edate as adjustEdate, pa.online_price_before as onlinePriceBefore, pa.online_price_after as onlinePriceAfter, pa.online_price_rate as onlinePriceRate"
				+ ", pa.offline_price_before as offlinePriceBefore, pa.offline_price_after as offlinePriceAfter, pa.offline_price_rate as offlinePriceRate, pa.price_before_rate as priceBeforeRate"
				+ ", pa.price_after_rate as priceAfterRate, pa.adjust_rate as adjustRate, pa.create_date as createDate, pa.memo as memo";
		String fromWhere = " from hui_price_adjust pa left join hui_hotel h on h.id = pa.hotel_id "
				+ " where 1=1 and pa.id="+id;
		return customPageService.getOne(columstr, fromWhere, PriceAdjust.class);
	}

	public List<PriceAdjust> findByAuditId(Long auditId) {
		return priceAdjustDao.findByAuditId(auditId);
	}
	
}
