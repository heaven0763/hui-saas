package com.chuangbang.base.web.hotel;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.base.entity.hotel.IntegralCommodity;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.IntegralCommodityService;

/**
 * 积分商品Controller
 * @author heaven
 * @version 2017-01-10
 */
@Controller
@RequestMapping(value = "base/hotel/integral/commodity")
public class IntegralCommodityController extends BaseController {

	@Autowired
	private IntegralCommodityService integralCommodityService;
	@Autowired
	private HotelService hotelService;
	
	@ModelAttribute("integralCommodity")
	public IntegralCommodity getIntegralCommodity(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
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
		return "hotel/integralCommodityList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/integralCommodityForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("integralCommodity")IntegralCommodity integralCommodity) {
		integralCommodityService.saveIntegralCommodity(integralCommodity);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<IntegralCommodity> pageBean,HttpServletRequest request, String checkState) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if(StringUtils.isNotBlank(checkState)){
			if("1".equals(checkState)){
				searchparas.put("GTE_checkState", "1");
				searchparas.put("LTE_checkState", "4");
			}else{
				searchparas.put("EQ_checkState", checkState);
			}
		}
		if(AccountUtils.getCurrentUserType().equals("HOTEL")){
			if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				searchparas.put("OR_EQ;hotelId",hotelIds);
			}else{
				searchparas.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}
		}else if(AccountUtils.getCurrentUserType().equals("HUI")){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			searchparas.put("OR_EQ;hotelId",hotelIds);
		}else{
		}
		pageBean.set_filterParams(searchparas);
		Page<IntegralCommodity> page = integralCommodityService.getEntities(pageBean);
		for (IntegralCommodity integralCommodity : page.getContent()) {
			HotelModel hotel = this.hotelService.getHotel(integralCommodity.getHotelId());
			if(hotel!=null){
				integralCommodity.setHotelName(hotel.getHotelName());
			}
		}
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		IntegralCommodity integralCommodity = integralCommodityService.getEntity(id);
		model.addAttribute("integralCommodity", integralCommodity);
		return new ModelAndView("hotel/integralCommodityForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		integralCommodityService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
