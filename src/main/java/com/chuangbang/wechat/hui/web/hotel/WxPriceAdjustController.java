package com.chuangbang.wechat.hui.web.hotel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.entity.hotel.PriceTrial;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PriceAdjustService;
import com.chuangbang.base.service.hotel.PriceTrialService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地价格Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotel/price/adjust")
public class WxPriceAdjustController extends BaseController {

	@Autowired
	private PriceAdjustService priceAdjustService;
	@Autowired
	private PriceTrialService priceTrialService;
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		return "weixin/hotel/priceAdjustIndex";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public JsonVo list(PageBean<PriceTrial> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id",AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		System.out.println(">>>>"+AccountUtils.isRole("company_administrator"));
		if(AccountUtils.isRole("company_administrator")){
			pageBean.setSort("pa.state#1@0@2@3@4,pa.apply_date");
			pageBean.setOrder("FIND_IN_SET,desc");
		}else{
			pageBean.setSort("pa.state,pa.apply_date");
			pageBean.setOrder("asc,desc");
		}
		List<PriceTrial> list = this.priceTrialService.getPriceTrialPageList(pageBean);
		return JsonUtils.success("ok", getDataGrid(pageBean, list));
	}
	
	@RequestMapping(value ="detail/{id}")
	public String detail(@PathVariable("id") Long id, Model model,Integer idx) {
		Map<String, Boolean> groups = groupSetting(model);
		PriceTrial priceTrial = this.priceTrialService.getEntity(id);
		String checktype = "";
		System.out.println(">>>>"+AccountUtils.getCurrentUserType()+">>>>>"+priceTrial.getState());
		if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("0")&&priceTrial.getTrialDate()==null&&groups.get("iscompanysales")){
			checktype = "TRIAL";//会掌柜销售初审 "HOTEL".equals(AccountUtils.getCurrentUserType())&&
		}else if("HUI".equals(AccountUtils.getCurrentUserType())&&priceTrial.getState().equals("1")
				&&priceTrial.getTrialDate()!=null&&priceTrial.getTrialState().equals("1")&&priceTrial.getFinalDate()==null&&groups.get("iscompanyadministrator")){
			checktype = "FINAL";//会掌柜复审 "HUI".equals(AccountUtils.getCurrentUserType())&&
		}else{
			checktype = "NONE";
		}
		List<PriceAdjust> priceAdjusts = this.priceAdjustService.findByAuditId(id);
		model.addAttribute("priceTrial", priceTrial);
		model.addAttribute("priceAdjusts", priceAdjusts);
		model.addAttribute("checktype", checktype);
		model.addAttribute("idx", idx);
		return "weixin/hotel/priceAdjustDetail";
	}
	
	
	@RequestMapping(value ="getone")
	@ResponseBody
	public JsonVo getOne(PageBean<PriceTrial> pageBean,HttpServletRequest request,Integer idx) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.setRows(1);
		pageBean.setPage(idx);
		pageBean.set_filterParams(searchparas);
		pageBean.setOrder("desc");
		pageBean.setSort("pa.apply_date");
		List<PriceTrial> list = this.priceTrialService.getPriceTrialPageList(pageBean);
		if(list!=null&&list.size()>0){
			PriceTrial priceTrial = list.get(0);//this.priceTrialService.getEntity(id);
			return JsonUtils.success("ok", priceTrial);
		}else{
			return JsonUtils.error("已是最后一个了！");
		}
	}
	
	@RequestMapping(value ="passcheck/{id}")
	@ResponseBody
	public JsonVo passCheck(@PathVariable("id") Long id,String checkType, Model model) {
		Json json = priceTrialService.passCheck(id,checkType);
		if(json.isSuccess()){
			return JsonUtils.success(json.getMsg());
		}else{
			return JsonUtils.error("操作失败！");
		}
	}
	
	@RequestMapping(value ="nopasscheck/{id}")
	@ResponseBody
	public JsonVo noPassCheck(@PathVariable("id") Long id,String checkType,String reason, Model model) {
		Json json = priceTrialService.noPassCheck(id, checkType,reason);
		if(json.isSuccess()){
			return JsonUtils.success("操作成功！");
		}else{
			return JsonUtils.error("操作失败！");
		}
	}
	
}
