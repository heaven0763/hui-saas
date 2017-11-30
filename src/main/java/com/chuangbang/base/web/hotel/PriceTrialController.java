package com.chuangbang.base.web.hotel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.base.service.hotel.PriceAdjustService;
import com.chuangbang.base.service.hotel.PriceTrialService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地价格调整Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/hotel/price/trial")
public class PriceTrialController extends BaseController {

	@Autowired
	private PriceTrialService priceTrialService;
	@Autowired
	private PriceAdjustService priceAdjustService;
	@ModelAttribute("priceTrial")
	public PriceTrial getPriceTrial(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return priceTrialService.getEntity(id);
		}
		return new PriceTrial();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		return "hotel/priceTrialList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		this.groupSetting(model);
		return "hotel/priceTrialForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("priceTrial")PriceTrial priceTrial) {
		priceTrialService.savePriceTrial(priceTrial);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PriceTrial> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		//Page<PriceTrial> page = priceTrialService.getEntities(pageBean);
		pageBean.setSort("pa.state,pa.apply_date");
		pageBean.setOrder("asc,desc");
		List<PriceTrial> list = this.priceTrialService.getPriceTrialPageList(pageBean);
		return getDataGrid(pageBean,list);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		PriceTrial priceTrial = priceTrialService.getEntity(id);
		model.addAttribute("priceTrial", priceTrial);
		return new ModelAndView("hotel/priceTrialForm");
	}
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model) {
		Map<String, Boolean> groups = groupSetting(model);
		PriceTrial priceTrial = this.priceTrialService.getEntity(id);
		String checktype = "";
		if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("0")&&priceTrial.getTrialDate()==null&&(groups.get("iscompanysales")||groups.get("isadministrator"))){
			checktype = "TRIAL";//会掌柜销售初审 "HOTEL".equals(AccountUtils.getCurrentUserType())&&
		}else if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("1")
				&&priceTrial.getTrialDate()!=null&&priceTrial.getTrialState().equals("1")&&priceTrial.getFinalDate()==null&&(groups.get("iscompanyadministrator")||groups.get("isadministrator"))){
			checktype = "FINAL";//会掌柜复审 "HUI".equals(AccountUtils.getCurrentUserType())&&
		}else{
			checktype = "NONE";
		}
		List<PriceAdjust> priceAdjusts = this.priceAdjustService.findByAuditId(id);
		model.addAttribute("priceTrial", priceTrial);
		model.addAttribute("priceAdjusts", priceAdjusts);
		model.addAttribute("checktype", checktype);
		model.addAttribute("priceTrial", priceTrial);
		return new ModelAndView("hotel/priceTrialDetail");
	}
	
	@RequestMapping(value = "check/{id}")
	public ModelAndView check(@PathVariable("id") Long id, Model model) {
		Map<String, Boolean> groups = groupSetting(model);
		PriceTrial priceTrial = this.priceTrialService.getEntity(id);
		String checktype = "";
		if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("0")&&priceTrial.getTrialDate()==null&&(groups.get("iscompanysales")||groups.get("isadministrator"))){
			checktype = "TRIAL";//会掌柜销售初审 "HOTEL".equals(AccountUtils.getCurrentUserType())&&
		}else if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("1")
				&&priceTrial.getTrialDate()!=null&&priceTrial.getTrialState().equals("1")&&priceTrial.getFinalDate()==null&&(groups.get("iscompanyadministrator")||groups.get("isadministrator"))){
			checktype = "FINAL";//会掌柜复审 "HUI".equals(AccountUtils.getCurrentUserType())&&
		}else{
			checktype = "NONE";
		}
		List<PriceAdjust> priceAdjusts = this.priceAdjustService.findByAuditId(id);
		model.addAttribute("priceTrial", priceTrial);
		model.addAttribute("priceAdjusts", JSONObject.toJSON(priceAdjusts));
		model.addAttribute("checktype", checktype);
		model.addAttribute("priceTrial", priceTrial);
		
		model.addAttribute("date_year_month", priceAdjusts.get(0).getAdjustSdate().substring(0, 7));
		List<String> s = DateTimeUtils.getMonthBetween(priceTrial.getAdjustSdate(),priceTrial.getAdjustEdate());
		String year_months="";
		for (String string : s) {
			year_months += string+",";
		}
		year_months = year_months.substring(0, year_months.length()-1);
		model.addAttribute("year_months", year_months);
		return new ModelAndView("hotel/priceTrialIndex");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		priceTrialService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
