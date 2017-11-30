package com.chuangbang.base.web.hotel;

import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelCooperationLog;
import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelCooperationLogService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
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
@RequestMapping(value = "base/hotel/cooperationinfo")
public class HotelCooperationInfoController extends BaseController {

	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private RegionService regionService;
	@Autowired
	private HotelCooperationLogService hotelCooperationLogService;
	@Autowired
	private UserService userService;
	
	
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
		return "hotel/hotelCooperationInfoList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		this.groupSetting(model);
		return "hotel/hotelCooperationInfoForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelCooperationInfo hotelCooperationInfo) {
		HotelCooperationInfo exithotelcptinfo = this.hotelCooperationInfoService.findByHotelId(hotelCooperationInfo.getHotelId());
		if(hotelCooperationInfo.getId()==null&&exithotelcptinfo!=null){
			return ajaxDoneError("该酒店的合作信息已存在，请勿重复添加！");
		}
		if(hotelCooperationInfo.getId()==null){
			hotelCooperationInfo.setCreateUserId(AccountUtils.getCurrentUserId());
			hotelCooperationInfo.setCreateUserName(AccountUtils.getCurrentRName());
			hotelCooperationInfo.setCreateDate(new Date());
		}
		Hotel hotel = this.hotelService.getEntity(hotelCooperationInfo.getHotelId());
		Region region = regionService.getEntity(Long.valueOf(hotel.getCity()+""));
		hotelCooperationInfo.setHotelName(hotel.getHotelName());
		hotelCooperationInfo.setHoteType(hotel.getHotelType());
		hotelCooperationInfo.setHotelNature(hotel.getHotelNature());
		hotelCooperationInfo.setArea(region.getRegionName());
		hotelCooperationInfo.setReclaimUserName(hotel.getReclaimUserName());
		hotelCooperationInfo.setReclaimUserId(hotel.getReclaimUserId());
		hotelCooperationInfoService.saveHotelCooperationInfo(hotelCooperationInfo);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelCooperationInfo> pageBean,HttpServletRequest request,String sdate,String fdate,String citypartner) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		if(StringUtils.isNotBlank(citypartner)){
			searchparas.put("EQ_cp.city", citypartner);
		}
		if(StringUtils.isNotBlank(sdate)){
			searchparas.put("GTE_c.agreementedate", sdate);
		}
		if(StringUtils.isNotBlank(fdate)){
			searchparas.put("LTE_c.agreementedate", fdate);
		}
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchparas.put("EQ_h.company_id", AccountUtils.getCurrentUser().getCompanyId());
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_c.hotel_id", AccountUtils.getCurrentUser().getHotelId());
		}
		
		List<HotelCooperationInfo> page = hotelCooperationInfoService.getHotelCooperationInfoPageList(pageBean);
		for (HotelCooperationInfo hotelCooperationInfo : page) {
			//hotelCooperationInfo.setCommissionBelong("1".equals(hotelCooperationInfo.getCommissionBelong())?"酒店":"集团");
			//hotelCooperationInfo.setCommissionRights("1".equals(hotelCooperationInfo.getCommissionRights())?"酒店":"集团");
			//hotelCooperationInfo.setHoteType(categoryService.getEntity(Long.valueOf(hotelCooperationInfo.getHoteType())).getName());
			if(StringUtils.isNotBlank(hotelCooperationInfo.getAgreementSDate())){
				hotelCooperationInfo.setAgreementSDate(DateTimeUtils.toZHDay(DateTimeUtils.string2Date(hotelCooperationInfo.getAgreementSDate(), "yyyy-MM-dd")));
			}
			if(StringUtils.isNotBlank(hotelCooperationInfo.getAgreementEDate())){
				hotelCooperationInfo.setAgreementEDate(DateTimeUtils.toZHDay(DateTimeUtils.string2Date(hotelCooperationInfo.getAgreementEDate(), "yyyy-MM-dd")));
			}
		}
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		HotelCooperationInfo hotelCooperationInfo = hotelCooperationInfoService.getEntity(id);
		model.addAttribute("hotelCooperationInfo", hotelCooperationInfo);
		return new ModelAndView("hotel/hotelCooperationInfoForm");
	}
	
	@RequestMapping(value = "update/rate/{id}")
	public ModelAndView rate(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		HotelCooperationInfo hotelCooperationInfo = hotelCooperationInfoService.getEntity(id);
		HotelModel hotelModel = this.hotelService.getHotel(hotelCooperationInfo.getHotelId());
		model.addAttribute("hotelCooperationInfo", hotelCooperationInfo);
		model.addAttribute("hotel", hotelModel);
		return new ModelAndView("hotel/hotelCooperationRateForm");
	}
	
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model) {
		this.groupSetting(model);
		HotelCooperationInfo hotelCooperationInfo = hotelCooperationInfoService.getEntity(id);
		model.addAttribute("hotelCooperationInfo", hotelCooperationInfo);
		return new ModelAndView("hotel/hotelCooperationInfoDetail");
	}
	
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelCooperationInfoService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	@RequestMapping(value = "site/rebate/check/index")
	public String siteRebateCheckIndex(Model model) {
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
		
		return "hotel/hotelCooperationLogList";
	}
	
	@RequestMapping(value ="site/rebate/check/list")
	@ResponseBody
	public DataGrid siteRebateCheckList(PageBean<HotelCooperationLog> pageBean,HttpServletRequest request,String sdate,String fdate) {
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
		pageBean.setOrder("asc,desc");
		pageBean.setSort("c.state,c.apply_date"); 
		List<HotelCooperationLog> page = hotelCooperationLogService.getHotelCooperationLogPageList(pageBean);
		return getDataGrid(pageBean, page);//, 
	}
}
