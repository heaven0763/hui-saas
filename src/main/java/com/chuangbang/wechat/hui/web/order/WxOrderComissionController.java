package com.chuangbang.wechat.hui.web.order;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.service.order.ComissionRecordService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.framework.util.json.JsonVo;

@Controller
@RequestMapping(value = "weixin/order/comission")
public class WxOrderComissionController {
	
	@Autowired
	private ComissionRecordService comissionRecordService;
	@Autowired
	private OrderService orderService;
	
	/**
	 * 确认返佣
	 * @param request
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value = "create")
	@ResponseBody
	public JsonVo createForm(HttpServletRequest request,Long orderId) {
		Order order = this.orderService.getEntity(orderId);
		return comissionRecordService.cfmcomission(order);
		//return JsonUtils.success("ok");
	}
	
	/**
	 * 确认返佣
	 * @param request
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value = "update")
	@ResponseBody
	public JsonVo createForm(HttpServletRequest request,String cmsn_type, Long cmsn_id,Double cmsn_amount
			,Double meeting_amount,Double house_amount,Double dinner_amount,Double other_amount,Long quantity) {
		return comissionRecordService.saveComissionRecord(cmsn_type, cmsn_id,cmsn_amount,meeting_amount,house_amount,dinner_amount,other_amount,quantity);
		//return JsonUtils.success("ok");
	}
	/**
	 * 确认返佣
	 * @param request
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value = "batch")
	@ResponseBody
	public JsonVo batchCommission(HttpServletRequest request) {
		return comissionRecordService.batchCommission();
	}
	/**
	 * 审核开票
	 * @param request
	 * @param orderId
	 * @return
	 */
	@RequestMapping(value = "invoice/save")
	@ResponseBody
	public JsonVo invoiceSave(HttpServletRequest request,Long orderId ,String invoiceNo,String invoiceUname,String invoiceDate) {
		Order order = this.orderService.getEntity(orderId);
		return comissionRecordService.invoiceSave(order,invoiceNo,invoiceUname,invoiceDate);
		//return JsonUtils.success("ok");
	}
	
}
