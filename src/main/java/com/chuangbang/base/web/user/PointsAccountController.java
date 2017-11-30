package com.chuangbang.base.web.user;

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

import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.PointsAccountService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 积分账户Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/user/points")
public class PointsAccountController extends BaseController {

	@Autowired
	private PointsAccountService pointsAccountService;
	@Autowired
	private HotelService hotelService;
	@ModelAttribute("pointsAccount")
	public PointsAccount getPointsAccount(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return pointsAccountService.getEntity(id);
		}
		return new PointsAccount();
	}
	
	@RequestMapping(value = "index/{type}")
	public String index(@PathVariable("type") String type,Model model) {
		if("hotel".equals(type)){
			model.addAttribute("title", "酒店积分");
			model.addAttribute("fname", "酒店");
			model.addAttribute("type", "HOTEL");
		}else{
			model.addAttribute("title", "个人客户积分");
			model.addAttribute("fname", "客户");
			model.addAttribute("type", "CLIENT");
		}
		return "user/pointsAccountList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/pointsAccountForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(PointsAccount pointsAccount) {
		pointsAccountService.savePointsAccount(pointsAccount);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PointsAccount> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			if("HOTEL".equals(searchparas.get("EQ_clientType"))){
				String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
				hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
				searchparas.put("OR_EQ;clientId",hotelIds);
			}
		}
		pageBean.set_filterParams(searchparas);
		Page<PointsAccount> page = pointsAccountService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		PointsAccount pointsAccount = pointsAccountService.getEntity(id);
		model.addAttribute("pointsAccount", pointsAccount);
		return new ModelAndView("user/pointsAccountForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		pointsAccountService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
