package com.chuangbang.base.web.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.chuangbang.base.entity.order.Receipt;
import com.chuangbang.base.service.order.ReceiptService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 水单资料Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/order/receipt")
public class ReceiptController extends BaseController {

	@Autowired
	private ReceiptService receiptService;
	
	@ModelAttribute("receipt")
	public Receipt getReceipt(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return receiptService.getEntity(id);
		}
		return new Receipt();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "order/receiptForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "order/receiptForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Receipt receipt) {
		receiptService.saveReceipt(receipt);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Receipt> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Receipt> page = receiptService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Receipt receipt = receiptService.getEntity(id);
		model.addAttribute("receipt", receipt);
		return new ModelAndView("order/receiptForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		receiptService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
