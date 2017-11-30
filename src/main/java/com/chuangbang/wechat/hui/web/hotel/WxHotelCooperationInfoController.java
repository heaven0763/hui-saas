package com.chuangbang.wechat.hui.web.hotel;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelCooperationLog;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelCooperationLogService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.service.account.UserService;
import com.google.common.collect.Maps;

/**
 * 场地合作信息Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotel/cooperationinfo")
public class WxHotelCooperationInfoController extends BaseController {

	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private UserService userService;
	@Autowired
	private HotelCooperationLogService hotelCooperationLogService;
	
	@ModelAttribute("hotelCooperationInfo")
	public HotelCooperationInfo getHotelCooperationInfo(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelCooperationInfoService.getEntity(id);
		}
		return new HotelCooperationInfo();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HUI");
			filterParams.put("EQ_u.group_id", "3");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HOTEL");
			filterParams.put("EQ_u.group_id", "9");
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_u.company_id", AccountUtils.getCurrentUser().getCompanyId());
			filterParams.put("EQ_u.group_id", "3");
		}else{
			
		}
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		return "weixin/hotel/hotelCooperationInfoIndex";
	}
	
	
	@RequestMapping(value ="list")
	@ResponseBody
	public JsonVo list(PageBean<HotelCooperationInfo> pageBean,HttpServletRequest request,String sdate,String fdate,String citypartner) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if(StringUtils.isNotBlank(citypartner)){
			searchparas.put("EQ_cp.city", citypartner);
		}
		if(StringUtils.isNotBlank(fdate)){
			searchparas.put("GTE_c.agreementedate", fdate);
		}
		if(StringUtils.isNotBlank(sdate)){
			searchparas.put("LTE_c.agreementedate", sdate);
		}
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		List<HotelCooperationInfo> page = hotelCooperationInfoService.getHotelCooperationInfoPageList(pageBean);
		for (HotelCooperationInfo hotelCooperationInfo : page) {
			//hotelCooperationInfo.setCommissionBelong("1".equals(hotelCooperationInfo.getCommissionBelong())?"酒店":"集团");
			//hotelCooperationInfo.setCommissionRights("1".equals(hotelCooperationInfo.getCommissionRights())?"酒店":"集团");
			//hotelCooperationInfo.setHoteType(categoryService.getEntity(Long.valueOf(hotelCooperationInfo.getHoteType())).getName());
			if(StringUtils.isNotBlank(hotelCooperationInfo.getAgreementSDate()))
				hotelCooperationInfo.setAgreementSDate(DateTimeUtils.toZHDay(DateTimeUtils.string2Date(hotelCooperationInfo.getAgreementSDate(), "yyyy-MM-dd")));
			if(StringUtils.isNotBlank(hotelCooperationInfo.getAgreementEDate()))
				hotelCooperationInfo.setAgreementEDate(DateTimeUtils.toZHDay(DateTimeUtils.string2Date(hotelCooperationInfo.getAgreementEDate(), "yyyy-MM-dd")));
		}
		return JsonUtils.success("ok", getDataGrid(pageBean, page));
	}
	
	@RequestMapping(value ="detail/{id}")
	@ResponseBody
	public JsonVo detail(@PathVariable("id") Long id,HttpServletRequest request) {
		HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.getEntity(id);
		return JsonUtils.success("ok",cooperationInfo);//, getDataGrid(pageBean, page)
	}
	
	@RequestMapping(value ="save")
	@ResponseBody
	public JsonVo save(HttpServletRequest request,Long cpId,Long hotelId,Double afallCommissionRate,Double afmettingRoomCommissionRate
			,Double afhousingCommissionRate,Double afdinnerCommissionRate,Double afortherCommissionRate,Double afpointsRate,String applyReason) throws UnsupportedEncodingException {
		HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.getEntity(cpId);
		applyReason = new String(applyReason.getBytes("iso-8859-1"),"UTF-8");
		return hotelCooperationLogService.saveHotelCooperationLog(cooperationInfo,hotelId,afallCommissionRate,afmettingRoomCommissionRate
				,afhousingCommissionRate,afdinnerCommissionRate,afortherCommissionRate,afpointsRate,applyReason);
		//return JsonUtils.success("ok");//, getDataGrid(pageBean, page)
	}
	
	@RequestMapping(value = "site/rebate/check/index")
	public String siteRebateCheckIndex(Model model) {
		PageBean<SalerModel> pageBean = new PageBean<>();
		Map<String, Object> filterParams = Maps.newHashMap();
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HUI");
			filterParams.put("EQ_u.group_id", "3");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_u.user_type", "HOTEL");
			filterParams.put("EQ_u.group_id", "9");
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			filterParams.put("EQ_u.company_id", AccountUtils.getCurrentUser().getCompanyId());
			filterParams.put("EQ_u.group_id", "3");
		}else{
			
		}
		pageBean.set_filterParams(filterParams);
		List<SalerModel> sales = userService.getAllSaler(pageBean);
		model.addAttribute("sales", sales);
		
		//List<E>
		return "weixin/hotel/siteRebateCheckIndex";
	}
	
	
	@RequestMapping(value ="site/rebate/check/list")
	@ResponseBody
	public JsonVo siteRebateCheckList(PageBean<HotelCooperationLog> pageBean,HttpServletRequest request,String sdate,String fdate) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if(StringUtils.isNotBlank(fdate)){
			searchparas.put("GTE_c.apply_date", fdate);
		}
		if(StringUtils.isNotBlank(sdate)){
			searchparas.put("LTE_c.apply_date", sdate);
		}
		if(StringUtils.isNotBlank(searchparas.get("EQ_c.state")+"")&&"1".equals(searchparas.get("EQ_c.state")+"")){
			searchparas.put("EQ_c.state","");
			searchparas.put("NE_c.state","0");
		}
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}
		pageBean.set_filterParams(searchparas);
		List<HotelCooperationLog> page = hotelCooperationLogService.getHotelCooperationLogPageList(pageBean);
		return JsonUtils.success("ok",getDataGrid(pageBean, page));//, 
	}
	
	
	@RequestMapping(value ="site/rebate/check/pass/{id}")
	@ResponseBody
	public JsonVo siteRebateCheckPass(@PathVariable("id") Long id,HttpServletRequest request) {
		return hotelCooperationLogService.pass(id);
		//return JsonUtils.success("ok");//, getDataGrid(pageBean, page)
	}
	
	@RequestMapping(value ="site/rebate/check/nopass/{id}")
	@ResponseBody
	public JsonVo siteRebateCheckNoPass(@PathVariable("id") Long id,HttpServletRequest request) {
		return hotelCooperationLogService.noPass(id);
		//return JsonUtils.success("ok");//, getDataGrid(pageBean, page)
	}
	
}
