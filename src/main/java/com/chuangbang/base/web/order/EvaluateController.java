package com.chuangbang.base.web.order;

import java.util.List;
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

import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.order.EvaluateService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Lists;

/**
 * 评价表Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/order/evaluate")
public class EvaluateController extends BaseController {

	@Autowired
	private EvaluateService evaluateService;
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("evaluate")
	public Evaluate getEvaluate(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return evaluateService.getEntity(id);
		}
		return new Evaluate();
	}
	
	@RequestMapping(value = "index/{type}")
	public String index(@PathVariable("type") String type,Model model) {
		if("SITE".equals(type)){
			model.addAttribute("title", "场地评论");
			model.addAttribute("fname", "场地");
			
		}else if("SALE".equals(type)){
			model.addAttribute("title", "销售人员评论");
			model.addAttribute("fname", "销售人员");
		}else if("PLATFORM".equals(type)){
			model.addAttribute("title", "会掌柜平台评论");
			model.addAttribute("fname", "会掌柜平台");
		}
		model.addAttribute("evaluateType", type);
		return "order/evaluateList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "order/evaluateForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Evaluate evaluate) {
		evaluateService.saveEvaluate(evaluate);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Evaluate> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		List<Object> params = Lists.newArrayList();
		
		String sql = evaluateService.buildQuerySql(pageBean, request);
		
		List<Evaluate> evaluates = cusQueryService.page(pageBean, sql, Evaluate.class,params);
		return getDataGrid(pageBean, evaluates);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Evaluate evaluate = evaluateService.getEntity(id);
		model.addAttribute("evaluate", evaluate);
		return new ModelAndView("order/evaluateForm");
	}
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model) {
		Evaluate evaluate = evaluateService.getEntity(id);
		model.addAttribute("evaluate", evaluate);
		return new ModelAndView("order/evaluateDetail");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		evaluateService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
