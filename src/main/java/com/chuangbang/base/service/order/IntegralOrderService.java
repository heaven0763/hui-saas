package com.chuangbang.base.service.order;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.dao.order.IntegralOrderDao;
import com.chuangbang.base.dao.order.IntegralOrderDetailDao;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.IntegralCommodity;
import com.chuangbang.base.entity.order.IntegralOrder;
import com.chuangbang.base.entity.order.IntegralOrderDetail;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.IntegralCommodityService;
import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.RandomStringUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.wechat.hui.model.IntegralReconciliationModel;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Component("integralOrderService")
@Transactional(readOnly=true)
public class IntegralOrderService extends BaseService<IntegralOrder, IntegralOrderDao>{
	
	@Autowired
	private IntegralOrderDao integralOrderDao;
	@Autowired
	private IntegralOrderDetailDao integralOrderDetailDao;
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private IntegralCommodityService integralCommodityService;
	@Autowired
	private HotelService hotelService;

	
	public IntegralOrder getEntity(Long id) {
		return integralOrderDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveIntegralOrder(IntegralOrder IntegralOrder) {
		integralOrderDao.save(IntegralOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		integralOrderDao.delete(id);
	}
	
	public List<IntegralReconciliationModel> getCommentPageList(PageBean<IntegralReconciliationModel> pageBean) {
		StringBuilder sbd = new StringBuilder();
		sbd.append("SELECT i.id id,i.item_id itemId,i.item_name itemName,i.points points,i.zgamount zgamount,i.jdamount jdamount,o.order_no orderNo");
		sbd.append(",o.create_date createDate,o.client_id clientId,o.client_name clientName,o.client_mobile clientMobile,o.area area,o.settlement_status settlementStatus");
		sbd.append(" FROM hzg_saas.hui_integral_order_detail i left join hui_integral_order o on o.order_no = i.order_no where 1=1 ");
	
		return  cusQueryService.page(pageBean, sbd.toString(), IntegralReconciliationModel.class,null);
	} 
	
	@Transactional(readOnly = false)
	public void batchSaveTestData(){
		IntegralCommodity integralCommodity = this.integralCommodityService.getEntity(1L);
		Hotel hotel = this.hotelService.getEntity(integralCommodity.getHotelId());
		for (int i = 0; i < 20; i++) {
			String orderNo = RandomStringUtil.getOrderNo(5);
			IntegralOrder integralOrder = new IntegralOrder(orderNo, "IntegralOrder", 1L, "会掌柜", "广州", integralCommodity.getHotelId(), hotel.getHotelName()
					, integralCommodity.getIntegral()*1.0, integralCommodity.getZgprice(), integralCommodity.getPrice(), "5455352", "王小峰"
					, "15874747878", new Date(), "01");
			integralOrder.setSettlementStatus("0");
			this.integralOrderDao.save(integralOrder);
			IntegralOrderDetail integralOrderDetail = new IntegralOrderDetail(orderNo, integralCommodity.getId(), integralCommodity.getName(), integralCommodity.getZgprice(), integralCommodity.getPrice(), integralCommodity.getIntegral()*1.0, 1L, "0", new Date(), "");
			this.integralOrderDetailDao.save(integralOrderDetail);
		}
	}

	public IntegralOrder findByOrderNo(String orderNo) {
		return this.integralOrderDao.findByOrderNo(orderNo);
	}

	@Transactional(readOnly = false)
	public JsonVo settlement(String orderNo, Long itemId) {
		try{
			IntegralOrder integralOrder = this.findByOrderNo(orderNo);
			IntegralOrderDetail integralOrderDetail =integralOrderDetailDao.findOne(itemId);
			if("HOTEL".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("0")){
				if(SecurityUtils.getSubject().hasRole("group_finance")||SecurityUtils.getSubject().hasRole("hotel_finance")){
					integralOrder.setSettlementStatus("1");
					integralOrder.setHotelSettlementDate(new Date());
					integralOrder.setHotelSettlementUid(AccountUtils.getCurrentUserId());
					this.integralOrderDao.save(integralOrder);
					integralOrderDetail.setState("1");
					this.integralOrderDetailDao.save(integralOrderDetail);
					return JsonUtils.success("确认成功！");
				}else{
					return JsonUtils.error("没有对账权限！");
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("1")){
				if(SecurityUtils.getSubject().hasRole("company_finance")){
					integralOrder.setSettlementStatus("2");
					integralOrder.setSettlementDate(new Date());
					integralOrder.setSettlementUid(AccountUtils.getCurrentUserId());
					this.integralOrderDao.save(integralOrder);
					integralOrderDetail.setState("2");
					this.integralOrderDetailDao.save(integralOrderDetail);
					return JsonUtils.success("确认成功！");
				}else{
					return JsonUtils.error("没有对账权限！");
				}
				
			}else{
				return JsonUtils.error("没有对账权限或对账信息有误！");
			}
		}catch(Exception e){
			return JsonUtils.error("对账信息错误！");
		}
		
		
	}

	public Map<String, Object> countUnSettlementAmount(String type,String itemId) {
		Map<String, Object> res = Maps.newHashMap();
		List<Object> params = Lists.newArrayList();
		String nnq = "select sum(zgamount) zgamount,sum(jdamount) jdamount from hui_integral_order  where settlement_status <> '2' ";
		if("GROUP".equals(type)){
			itemId.replace(",", "','");
			nnq += " and hotel_id in ('"+itemId+"')";
		}else if("HOTEL".equals(type)){
			nnq += " and hotel_id = ? ";
			params.add(itemId);
		}else{
			
		}
		
		List<Object> list = this.integralOrderDao.executeNativeQuery(nnq, params);
		if(list!=null&&list.size()>0){
			if(list.get(0)!=null){
				Object []o = (Object[]) list.get(0);
				res.put("zgamount", o[0]);
				res.put("jdamount", o[1]);
			}
		}
		return res;
	}
	
	@Transactional(readOnly = false)
	public JsonVo batchSettlement() {
		Map<String, Object> filterParams = Maps.newHashMap();
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("group_finance")){
				String hotelIds = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("OR_EQ;hotelId",hotelIds);
			}else if(SecurityUtils.getSubject().hasRole("hotel_finance")){
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}else{
				return JsonUtils.error("没有对账权限！");
			}
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(!SecurityUtils.getSubject().hasRole("company_finance")){
				return JsonUtils.error("没有对账权限！");
			}
		}else{
			return JsonUtils.error("没有对账权限！");
		}
		
		List<IntegralOrder> integralOrders = this.getEntities(filterParams);
		for (IntegralOrder integralOrder : integralOrders) {
			if("HOTEL".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("0")){
				integralOrder.setSettlementStatus("1");
				integralOrder.setHotelSettlementDate(new Date());
				integralOrder.setHotelSettlementUid(AccountUtils.getCurrentUserId());
				this.integralOrderDao.save(integralOrder);
				List<IntegralOrderDetail> integralOrderDetails = this.integralOrderDetailDao.findByOrderNo(integralOrder.getOrderNo());
				for (IntegralOrderDetail integralOrderDetail : integralOrderDetails) {
					integralOrderDetail.setState("1");
					this.integralOrderDetailDao.save(integralOrderDetail);
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("1")){
				integralOrder.setSettlementStatus("2");
				integralOrder.setSettlementDate(new Date());
				integralOrder.setSettlementUid(AccountUtils.getCurrentUserId());
				this.integralOrderDao.save(integralOrder);
				List<IntegralOrderDetail> integralOrderDetails = this.integralOrderDetailDao.findByOrderNo(integralOrder.getOrderNo());
				for (IntegralOrderDetail integralOrderDetail : integralOrderDetails) {
					integralOrderDetail.setState("1");
					this.integralOrderDetailDao.save(integralOrderDetail);
				}
			}else{
				//return JsonUtils.error("没有对账权限或对账信息有误！");
			}
		}
		
		return JsonUtils.success("确认成功！");
	}
	
	@Transactional(readOnly = false)
	public JsonVo batchSettlement(String orderNos) {
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("group_finance")){
			}else if(SecurityUtils.getSubject().hasRole("hotel_finance")){
			}else{
				return JsonUtils.error("没有对账权限！");
			}
		}else if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(!SecurityUtils.getSubject().hasRole("company_finance")){
				return JsonUtils.error("没有对账权限！");
			}
		}else{
			return JsonUtils.error("没有对账权限！");
		}
		String []oNos = orderNos.split(",");
		for (String orderNo : oNos) {
			IntegralOrder integralOrder = this.findByOrderNo(orderNo);
			if("HOTEL".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("0")){
				integralOrder.setSettlementStatus("1");
				integralOrder.setHotelSettlementDate(new Date());
				integralOrder.setHotelSettlementUid(AccountUtils.getCurrentUserId());
				this.integralOrderDao.save(integralOrder);
				List<IntegralOrderDetail> integralOrderDetails = this.integralOrderDetailDao.findByOrderNo(integralOrder.getOrderNo());
				for (IntegralOrderDetail integralOrderDetail : integralOrderDetails) {
					integralOrderDetail.setState("1");
					this.integralOrderDetailDao.save(integralOrderDetail);
				}
			}else if("HUI".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("1")){
				integralOrder.setSettlementStatus("2");
				integralOrder.setSettlementDate(new Date());
				integralOrder.setSettlementUid(AccountUtils.getCurrentUserId());
				this.integralOrderDao.save(integralOrder);
				List<IntegralOrderDetail> integralOrderDetails = this.integralOrderDetailDao.findByOrderNo(integralOrder.getOrderNo());
				for (IntegralOrderDetail integralOrderDetail : integralOrderDetails) {
					integralOrderDetail.setState("1");
					this.integralOrderDetailDao.save(integralOrderDetail);
				}
			}else{
				//return JsonUtils.error("没有对账权限或对账信息有误！");
			}
		}
		return JsonUtils.success("确认成功！");
	}
 }
