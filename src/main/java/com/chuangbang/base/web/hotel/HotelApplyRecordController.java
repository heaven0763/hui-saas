package com.chuangbang.base.web.hotel;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.app.model.ApplyHotelRecordModel;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelApplyRecord;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelApplyRecordService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.UserService;

/**
 * 申请加入酒店记录Controller
 * @author xtp
 * @version 2017-08-09
 */
@Controller
@RequestMapping(value = "/base/hotel/record")
public class HotelApplyRecordController extends BaseController{
	
	@Autowired
	HotelApplyRecordService hotelApplyRecordService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private UserService userService;
	@Autowired
	private  MenuService menuService;
	@RequestMapping(value ="hotelJoinList")
	public String hotelJoinList(HttpServletRequest request) {
		return "hotel/hotelJoinList";
	}
	
	@RequestMapping(value ="applyCheckList")
	public String applyCheckList(HttpServletRequest request,Model model) {
		List<Menu> menus = this.menuService.getSysAuthRootMenus(90L);
		model.addAttribute("menus",menus);
		return "hotel/applyCheckList";
	}
	
	@RequestMapping(value ="hotelJoinRecord")
	public String hotelJoinRecord(HttpServletRequest request) {
		return "hotel/hotelJoinRecord";
	}
	
	@RequestMapping(value = "saveRecord")
	public ModelAndView createRecord(Model model,HotelApplyRecord record,String userId,Long hotelId,String type) {
	//	System.out.println(record);
		userId = AccountUtils.getCurrentUserId();
		int num = hotelApplyRecordService.isExist(userId,hotelId,type);
		System.out.println(num+"num");
		if(num != 1){
			record.setUserId(userId);
			if(hotelId==null){
				record.setHotelID((long) 0);//会掌柜
			}else{
				record.setHotelID(hotelId);
			}
			record.setType(type);
			record.setState("0");
			record.setApplyDate(new Date());
			hotelApplyRecordService.saveRecord(record);
			return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
		}
		return  ajaxDoneSuccess("已存在！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="recordList")
	@ResponseBody
	public DataGrid recordList(PageBean<ApplyHotelRecordModel> pageBean,HttpServletRequest request) {
		Map<String, Object> filterParams = this.getSearchParams(request);
		pageBean.set_filterParams(filterParams);
		List<ApplyHotelRecordModel> page = hotelApplyRecordService.getRecordPageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="checkList")
	@ResponseBody
	public DataGrid checkList(PageBean<User> pageBean,HttpServletRequest request) {
		String hotelIds = null;
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_r.hotel_id", 0);
			filterParams.put("EQ_r.type", "HUI");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_r.hotel_id", AccountUtils.getCurrentUserhotelPId());
				filterParams.put("EQ_r.type", "GROUP");
			}else{
				filterParams.put("EQ_r.hotel_id", AccountUtils.getCurrentUserHotelId());
				filterParams.put("EQ_r.type", "HOTEL");
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			filterParams.put("OR_EQ;r.hotel_id",hotelIds);
			filterParams.put("EQ_r.type", "HUI");
		}
		
		pageBean.set_filterParams(filterParams);
		List<User> page = hotelApplyRecordService.getCheckPageList(pageBean,hotelIds);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "cancle")
	public ModelAndView cancle(Model model,Long id) {
		hotelApplyRecordService.cancel(id);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value = "checkApply")
	public ModelAndView checkApply(Long recordId,int state,Long groupId) {
		HotelApplyRecord record = hotelApplyRecordService.getEntity(recordId);
		Json json = hotelApplyRecordService.check(record,state,groupId);
		if(json.isSuccess()){
			return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
		}else{
			return  ajaxDoneError("操作失败！");
		}
	}
	
	
	@RequestMapping(value ="checkForm/{recordId}")
	public String hotelJoinCheckForm(Model model,HttpServletRequest request,@PathVariable("recordId") Long recordId) {
		HotelApplyRecord record = hotelApplyRecordService.getEntity(recordId);
		User user = this.userService.getEntity(record.getUserId());
		model.addAttribute("user",user);
		model.addAttribute("record", record);
		return "hotel/hotelJoinCheckForm";
	}
}
