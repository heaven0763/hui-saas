package com.chuangbang.wechat.hui.web.hotel;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
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

import com.chuangbang.base.entity.hotel.IntegralCommodity;
import com.chuangbang.base.entity.order.IntegralOrder;
import com.chuangbang.base.entity.order.IntegralOrderDetail;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.IntegralCommodityService;
import com.chuangbang.base.service.order.IntegralOrderDetailService;
import com.chuangbang.base.service.order.IntegralOrderService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.wechat.hui.model.IntegralReconciliationModel;

/**
 * 场地合作信息Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotel/integral")
public class WxHotelIntegralMallController extends BaseController {

	@Autowired
	private HotelService hotelService;
	@Autowired
	private IntegralCommodityService integralCommodityService;
	@Autowired
	private IntegralOrderService integralOrderService;
	@Autowired
	private IntegralOrderDetailService  integralOrderDetailService;
	
	@ModelAttribute("integralCommodity")
	public IntegralCommodity getIntegralCommodity(@RequestParam(value = "id", required = false) Long id) {
		if (id != null) {
			return integralCommodityService.getEntity(id);
		}
		return new IntegralCommodity();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		this.groupSetting(model);
		model.addAttribute("mtype", AccountUtils.getCurrentUserType());
		model.addAttribute("mposition", AccountUtils.getCurrentUser().getPosition());
		model.addAttribute("mgid", AccountUtils.getCurrentUser().getGroupId());
		return "weixin/hotel/hotelIntegralMallIndex";
	}
	@RequestMapping(value = "create")
	public String create(Model model) {
		return "weixin/hotel/hotelIntegralMallForm";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public JsonVo list(PageBean<IntegralCommodity> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			searchparas.put("OR_EQ;hotelId",hotelIds);
		}
		pageBean.set_filterParams(searchparas);
		Page<IntegralCommodity> page = integralCommodityService.getEntities(pageBean);
		return JsonUtils.success("ok", getDataGrid(pageBean, page.getContent()));
	}
	
	//
	
	@RequestMapping(value = "save")
	@ResponseBody
	public ModelAndView save(@Valid @ModelAttribute("integralCommodity")IntegralCommodity integralCommodity,String base64Img) {
		if(integralCommodity.getId()==null){
			integralCommodity.setState("0");
			integralCommodity.setCheckState("0");
			integralCommodity.setCreateDate(new Date());
			integralCommodity.setHotelId(1L);//Long.valueOf(AccountUtils.getCurrentUserHotelId())
			integralCommodity.setCreateUserId(AccountUtils.getCurrentUserId());
			integralCommodity.setCreateUserName(AccountUtils.getCurrentRName());
		}
		if(StringUtils.isNotBlank(base64Img)){
			String newPhotoPath = FileUtils.generateImage(base64Img, "integralmall/" + new Date().getTime() + ".jpg");
			if(StringUtils.isNotBlank(newPhotoPath)){
				integralCommodity.setImg(newPhotoPath);
			}
		}
		integralCommodityService.saveIntegralCommodity(integralCommodity);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	
	@RequestMapping(value = "pass/{id}")
	@ResponseBody
	public ModelAndView pass(@PathVariable("id") Long id) {
		integralCommodityService.pass(id);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value = "nopass/{id}")
	@ResponseBody
	public ModelAndView nopass(@PathVariable("id") Long id) {
		integralCommodityService.nopass(id);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	
	@RequestMapping(value = "reconciliation/index")
	public String reconciliationIndex(Model model,HttpServletRequest request) {
		/*model.addAttribute("mtype", AccountUtils.getCurrentUserType());
		model.addAttribute("mposition", AccountUtils.getCurrentUser().getPosition());
		model.addAttribute("mgid", AccountUtils.getCurrentUser().getGroupId());*/
		//integralOrderService.batchSaveTestData();
		this.groupSetting(model);
		Map<String, Object> res = null;
		String type = "";
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("group_finance")){
				String hotelIds = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				res = integralOrderService.countUnSettlementAmount("GROUP",hotelIds);
			}else if(SecurityUtils.getSubject().hasRole("hotel_finance")){
				res = integralOrderService.countUnSettlementAmount("HOTEL",AccountUtils.getCurrentUserHotelId());
			}else{
				//searchparas.put("ISN_o.hotel_id", 1);
			}
			
			type="HOTEL";
		}else{
			res = integralOrderService.countUnSettlementAmount("HUI","");
			type="HUI";
		}
		model.addAttribute("res", res);
		model.addAttribute("type", type);
		
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/integralReconciliationIndex";
		}else{
			return "order/integralReconciliationList";
		}
		
	}
	
	

	@RequestMapping(value ="reconciliation/list")
	@ResponseBody
	public JsonVo reconciliationList(PageBean<IntegralReconciliationModel> pageBean,HttpServletRequest request,String settlement_status) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("group_finance")){
				String hotelIds = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				searchparas.put("OR_EQ;o.hotel_id",hotelIds);
			}else if(SecurityUtils.getSubject().hasRole("hotel_finance")){
				searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			}else{
				searchparas.put("ISN_o.hotel_id", 1);
			}
		}
		
		if("1".equals(settlement_status)){
			searchparas.put("EQ_o.settlement_status", 2);
		}else if("0".equals(settlement_status)){
			searchparas.put("NE_o.settlement_status", 2);
		}
		pageBean.set_filterParams(searchparas);
		List<IntegralReconciliationModel> page = integralOrderService.getCommentPageList(pageBean);
		return JsonUtils.success("ok", getDataGrid(pageBean, page));
	}
	
	@RequestMapping(value ="reconciliation/pc/list")
	@ResponseBody
	public DataGrid reconciliationPcList(PageBean<IntegralReconciliationModel> pageBean,HttpServletRequest request,String settlement_status) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(SecurityUtils.getSubject().hasRole("group_finance")){
				String hotelIds = this.hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				searchparas.put("OR_EQ;o.hotel_id",hotelIds);
			}else if(SecurityUtils.getSubject().hasRole("hotel_finance")){
				searchparas.put("EQ_o.hotel_id", AccountUtils.getCurrentUserHotelId());
			}else{
				searchparas.put("ISN_o.hotel_id", 1);
			}
		}
		
		if("1".equals(settlement_status)){
			searchparas.put("EQ_o.settlement_status", 2);
		}else if("0".equals(settlement_status)){
			searchparas.put("NE_o.settlement_status", 2);
		}
		pageBean.set_filterParams(searchparas);
		List<IntegralReconciliationModel> page = integralOrderService.getCommentPageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="reconciliation/detail/{id}")
	public String reconciliationList(@PathVariable("id") Long id,HttpServletRequest request,Model model) {
		IntegralOrderDetail integralOrderDetail = this.integralOrderDetailService.getEntity(id);
		IntegralOrder integralOrder = this.integralOrderService.findByOrderNo(integralOrderDetail.getOrderNo());
		IntegralCommodity integralCommodity = integralCommodityService.getEntity(integralOrderDetail.getItemId());
		model.addAttribute("integralOrder", integralOrder);
		model.addAttribute("integralOrderDetail", integralOrderDetail);
		model.addAttribute("integralCommodity", integralCommodity);
		
		boolean issettlement = false;
		String type = "";
		if("HOTEL".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("0")){
			if(SecurityUtils.getSubject().hasRole("group_finance")||SecurityUtils.getSubject().hasRole("hotel_finance")){
				issettlement = true;
			}
			type="HOTEL";
		}else if("HUI".equals(AccountUtils.getCurrentUserType())&&integralOrder.getSettlementStatus().equals("1")){
			if(SecurityUtils.getSubject().hasRole("company_finance")){
				issettlement = true;
			}
			type="HUI";
		}
		
		model.addAttribute("issettlement", issettlement);
		model.addAttribute("type", type);
		
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/order/integralReconciliationDetail";
		}else{
			return "order/integralReconciliationDetail";
		}
	}
	
	@RequestMapping(value ="reconciliation/settlement")
	@ResponseBody
	public JsonVo settlement(HttpServletRequest request,String orderNo,Long itemId) {
		return integralOrderService.settlement(orderNo,itemId);
	}
	
	@RequestMapping(value ="reconciliation/batchsettlement")
	@ResponseBody
	public JsonVo batchSettlement(HttpServletRequest request,String orderNos) {
		if(StringUtils.isBlank(orderNos)){
			return integralOrderService.batchSettlement();
		}else{
			return integralOrderService.batchSettlement(orderNos);
		}
		
	}
}
