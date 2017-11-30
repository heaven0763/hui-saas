package com.chuangbang.wechat.hui.web.order;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.base.service.order.EvaluateService;
import com.chuangbang.framework.entity.dictionary.Dictionary;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.dictionary.DictionaryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Lists;

/**
 * 评价表Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "weixin/order/evaluate")
public class WxEvaluateController extends BaseController {

	@Autowired
	private EvaluateService evaluateService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	@Autowired
	private DictionaryService dictionaryService;
	
	@ModelAttribute("evaluate")
	public Evaluate getEvaluate(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return evaluateService.getEntity(id);
		}
		return new Evaluate();
	}
	
	@RequestMapping(value = "index/{evaluatetype}")
	public String index(Model model,@PathVariable("evaluatetype")String evaluateType) {
		
		List<Dictionary> usertypeDicts = dictionaryService.findByKind("USERTYPE");	//评论人群
		
		model.addAttribute("evaluatetype", evaluateType);
		model.addAttribute("usertypeDicts",usertypeDicts);
		return "weixin/order/evaluateIndex";
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
	public JsonVo list(PageBean<Evaluate> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		List<Object> params = Lists.newArrayList();
		
		String sql = evaluateService.buildQuerySql(pageBean, request);
		
		List<Evaluate> evaluates = cusQueryService.page(pageBean, sql, Evaluate.class,params);
		
		return JsonUtils.success("",getDataGrid(pageBean, evaluates))  ;
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
		return new ModelAndView("weixin/order/evaluateDetail");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		evaluateService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	
	@RequestMapping(value = "reply/save")
	@ResponseBody
	public JsonVo replySave(Long id,String replyContent) throws UnsupportedEncodingException {
		replyContent = new String(replyContent.getBytes("iso-8859-1"), "UTF-8");
		return  evaluateService.replySave(id,replyContent);
	}
	
}
