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
import com.chuangbang.base.entity.order.ComissionRecord;
import com.chuangbang.base.service.order.ComissionRecordService;

/**
 * 返佣记录Controller
 * @author heaven
 * @version 2017-03-08
 */
@Controller
@RequestMapping(value = "base/order/comissionrecord")
public class ComissionRecordController extends BaseController {

	@Autowired
	private ComissionRecordService comissionRecordService;
	
	@ModelAttribute("comissionRecord")
	public ComissionRecord getComissionRecord(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return comissionRecordService.getEntity(id);
		}
		return new ComissionRecord();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "order/comissionRecordForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "order/comissionRecordForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(ComissionRecord comissionRecord) {
		comissionRecordService.saveComissionRecord(comissionRecord);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ComissionRecord> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<ComissionRecord> page = comissionRecordService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		ComissionRecord comissionRecord = comissionRecordService.getEntity(id);
		model.addAttribute("comissionRecord", comissionRecord);
		return new ModelAndView("order/comissionRecordForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		comissionRecordService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
