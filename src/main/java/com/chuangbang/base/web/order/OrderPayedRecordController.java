package com.chuangbang.base.web.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.web.BaseController;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.base.entity.order.OrderPayedRecord;
import com.chuangbang.base.service.order.OrderPayedRecordService;

/**
 * 订单付款记录Controller
 * @author heaven
 * @version 2017-10-26
 */
@Controller
@RequestMapping(value = "base/order/payed/record")
public class OrderPayedRecordController extends BaseController {

	@Autowired
	private OrderPayedRecordService orderPayedRecordService;
	
	@ModelAttribute("orderPayedRecord")
	public OrderPayedRecord getOrderPayedRecord(@RequestParam(value = "id", required = false) Long id) {
		if(id!=null) {
			return orderPayedRecordService.getEntity(id);
		}
		return new OrderPayedRecord();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "order/orderPayedRecordList";
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "order/orderPayedRecordForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(OrderPayedRecord orderPayedRecord) {
		orderPayedRecordService.saveOrderPayedRecord(orderPayedRecord);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<OrderPayedRecord> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<OrderPayedRecord> page = orderPayedRecordService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		OrderPayedRecord orderPayedRecord = orderPayedRecordService.getEntity(id);
		model.addAttribute("orderPayedRecord", orderPayedRecord);
		return new ModelAndView("order/orderPayedRecordForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		orderPayedRecordService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
