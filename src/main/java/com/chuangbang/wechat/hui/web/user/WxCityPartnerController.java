package com.chuangbang.wechat.hui.web.user;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.chuangbang.app.model.CompanyModel;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.OrderModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.excel.ExcelModel;
import com.chuangbang.framework.util.excel.ExcelModel.CellStyle;
import com.chuangbang.framework.util.excel.ExcelUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Department;
import com.chuangbang.js.service.account.DepartmentService;
import com.chuangbang.js.service.account.UserService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value = "/weixin/city/partner")
public class WxCityPartnerController extends BaseController{
	
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private ExcelUtils excelUtils;
	@Autowired
	private UserService userService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		this.groupSetting(model);
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_districtCode", 0);
		List<Department> departments = this.departmentService.getEntities(filterParams, new Sort(Direction.ASC, "id"));
		model.addAttribute("departments", departments);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/cityPartnerIndex";
		}else{
			return "user/cityPartnerList";
		}
	}

	@RequestMapping("/list")
	@ResponseBody
	public JsonVo findAll(HttpServletRequest request,PageBean<CompanyModel> pageBean){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_c.auth_type", "PARTNER");
		pageBean.set_filterParams(filterParams);
		List<CompanyModel> page = this.companyService.getPageList(pageBean);
		for (CompanyModel companyModel : page) {
			companyModel.setHotelQuantity(this.companyService.countHotel(companyModel.getId()));
			companyModel.setAllAmount(this.companyService.allAmount(companyModel.getId(),DateTimeUtils.toDay( companyModel.getSeffectiveDate()),DateTimeUtils.getCurrentDate()+"23:59:59.889"));
			companyModel.setAnnualAmount(this.companyService.yearAmount(companyModel.getId(), DateTimeUtils.getCurtYear(new Date())));
		}
		return JsonUtils.success("",getDataGrid(pageBean,page))  ;
	}
	
	@RequestMapping("/pc/list")
	@ResponseBody
	public DataGrid findFAll(HttpServletRequest request,PageBean<CompanyModel> pageBean){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_c.auth_type", "PARTNER");
		pageBean.set_filterParams(filterParams);
		List<CompanyModel> page = this.companyService.getPageList(pageBean);
		for (CompanyModel companyModel : page) {
			companyModel.setHotelQuantity(this.companyService.countHotel(companyModel.getId()));
			companyModel.setAllAmount(this.companyService.allAmount(companyModel.getId(),DateTimeUtils.toDay( companyModel.getSeffectiveDate()),DateTimeUtils.getCurrentDate()+"23:59:59.889"));
			companyModel.setAnnualAmount(this.companyService.yearAmount(companyModel.getId(), DateTimeUtils.getCurtYear(new Date())));
		}
		return getDataGrid(pageBean,page)  ;
	}
	
	@RequestMapping(value = "export/hotel")
	public void export(HttpServletRequest request,HttpServletResponse response,Long cmpyId,PageBean<HotelModel> pageBean) throws Exception{
		CompanyModel company = this.companyService.getOne(cmpyId);
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_h.company_id", cmpyId);
		pageBean.set_filterParams(filterParams);
		List<HotelModel> hotels = this.hotelService.getAllHotel(pageBean);
		List<ExcelModel> excelModels = Lists.newArrayList();
		excelModels.add(new ExcelModel("编号", "id", CellStyle.NUMBER));
		excelModels.add(new ExcelModel("酒店名称","hotelName", CellStyle.STR));
		excelModels.add(new ExcelModel("酒店类型","hotelTypeText", CellStyle.STR));
		excelModels.add(new ExcelModel("酒店星级","hotelStarText", CellStyle.STR));
		excelModels.add(new ExcelModel("省","provinceText", CellStyle.STR));
		excelModels.add(new ExcelModel("市","cityText", CellStyle.STR));
		
		excelModels.add(new ExcelModel("地区","districtText", CellStyle.STR));
		excelModels.add(new ExcelModel("详细地址","address", CellStyle.STR));
		excelModels.add(new ExcelModel("商圈","tradeAreaText", CellStyle.STR));
		excelModels.add(new ExcelModel("大厅数量","hallNum", CellStyle.NUMBER));
		
		excelModels.add(new ExcelModel("客房数量","roomNum", CellStyle.NUMBER));
		excelModels.add(new ExcelModel("联系人","contact", CellStyle.STR));
		excelModels.add(new ExcelModel("联系电话","telephone", CellStyle.STR));
		excelModels.add(new ExcelModel("传真","fax", CellStyle.STR));
		excelModels.add(new ExcelModel("邮箱","email", CellStyle.STR));
		
		String title = "合伙人【"+company.getRname()+"】开拓酒店";
		Workbook workbook =excelUtils.exportCommonExcel(hotels, title, excelModels);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String ymd = sdf.format(new Date());  
		String fileName = title+ymd+".xls";
		response.setContentType("application/vnd.ms-excel");
		Servlets.setFileDownloadHeader(response,fileName);
		workbook.write(response.getOutputStream());
		response.getOutputStream().flush();
	}
	
	@RequestMapping(value = "export/order")
	public void export(HttpServletRequest request,HttpServletResponse response,Long cmpyId,Long idx,PageBean<OrderModel> pageBean) throws Exception{
		CompanyModel company = this.companyService.getOne(cmpyId);
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_h.company_id", cmpyId);
		filterParams.put("EQ_o.settlement_status", "01");
		/*if(idx==0){
			filterParams.put("GTE_o.settlement_date", DateTimeUtils.toDay(company.getSeffectiveDate()));
			filterParams.put("LTE_o.settlement_date", DateTimeUtils.getCurrentDate()+"23:59:59.889");
		}else{
			filterParams.put("GTE_o.settlement_date", DateTimeUtils.getCurtYear(new Date())+"-01-01 00:00:00.000");
			filterParams.put("LTE_o.settlement_date", DateTimeUtils.getCurtYear(new Date())+"-12-31 23:59:59.889");
		}*/
		
		pageBean.set_filterParams(filterParams);
		List<OrderModel> hotels = this.orderService.getAllOrder(pageBean);
		List<ExcelModel> excelModels = Lists.newArrayList();
		excelModels.add(new ExcelModel("订单编号", "orderNo", CellStyle.STR));
		excelModels.add(new ExcelModel("地区","area", CellStyle.STR));
		excelModels.add(new ExcelModel("酒店名称","hotelName", CellStyle.STR));
		
		excelModels.add(new ExcelModel("酒店销售姓名","hotelSaleName", CellStyle.STR));
		excelModels.add(new ExcelModel("酒店销售联系电话 ","hotelSaleMobile", CellStyle.STR));
		excelModels.add(new ExcelModel("总金额","amount", CellStyle.STR));
		excelModels.add(new ExcelModel("活动时间","activityDate", CellStyle.STR));
		excelModels.add(new ExcelModel("活动名称","activityTitle", CellStyle.STR));
		excelModels.add(new ExcelModel("主办单位","organizer", CellStyle.STR));
		excelModels.add(new ExcelModel("联系人","linkman", CellStyle.STR));
		excelModels.add(new ExcelModel("联系电话","contactNumber", CellStyle.STR));
		excelModels.add(new ExcelModel("结算日期","settlementDate", CellStyle.STR));
		
		
		String title = "合伙人【"+company.getRname()+"】开拓酒店业务订单";
		Workbook workbook =excelUtils.exportCommonExcel(hotels, title, excelModels);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String ymd = sdf.format(new Date());  
		String fileName = title+ymd+".xls";
		response.setContentType("application/vnd.ms-excel");
		Servlets.setFileDownloadHeader(response,fileName);
		workbook.write(response.getOutputStream());
		response.getOutputStream().flush();
	}
	
	
	@RequestMapping(value = "export/staff")
	public void exportStaff(HttpServletRequest request,HttpServletResponse response,Long cmpyId,PageBean<SalerModel> pageBean) throws Exception{
		CompanyModel company = this.companyService.getOne(cmpyId);
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_u.company_id", cmpyId);
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("u.group_id,u.create_date");
		pageBean.setOrder("asc,asc");
		List<SalerModel> hotels = this.userService.getAllSaler(pageBean);
		List<ExcelModel> excelModels = Lists.newArrayList();
		excelModels.add(new ExcelModel("员工账号", "username", CellStyle.STR));
		excelModels.add(new ExcelModel("员工姓名","rname", CellStyle.STR));
		excelModels.add(new ExcelModel("员工手机","mobile", CellStyle.STR));
		
		excelModels.add(new ExcelModel("员工邮箱","email", CellStyle.STR));
		excelModels.add(new ExcelModel("员工职务 ","position", CellStyle.STR));
		excelModels.add(new ExcelModel("注册日期","createDate", CellStyle.STR));
		
		
		String title = "合伙人【"+company.getRname()+"】管辖人员表";
		Workbook workbook =excelUtils.exportCommonExcel(hotels, title, excelModels);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String ymd = sdf.format(new Date());  
		String fileName = title+ymd+".xls";
		response.setContentType("application/vnd.ms-excel");
		Servlets.setFileDownloadHeader(response,fileName);
		workbook.write(response.getOutputStream());
		response.getOutputStream().flush();
	}

	@RequestMapping("/detail/{id}")
	public String detail(HttpServletRequest request,Model model,@PathVariable("id") Long id){
		this.groupSetting(model);
		ChatRecord chatRecord = this.chatRecordService.getEntity(id);
		chatRecord.setState("0");
		this.chatRecordService.saveChatRecord(chatRecord);
		model.addAttribute("msg", chatRecord);
		return "weixin/hui/messageDetail";
	}
	
	
	@RequestMapping("/create")
	public String detail(HttpServletRequest request,Model model){
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/cityPartnerForm";
		}else{
			return "user/cityPartnerForm";
		}
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public JsonVo sava(HttpServletRequest request,String rname,String username ,String mobile,String email,String password
			,String cfpassword,String companyName,Integer province,Integer city){
		this.userService.savePartner(rname,username,mobile,email,password,cfpassword,companyName,province,city);
		return JsonUtils.success("OK")  ;
	}
}
