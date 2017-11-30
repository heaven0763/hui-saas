package com.chuangbang.wechat.hui.web.user;

import java.util.Date;
import java.util.List;
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

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.user.PointsAccount;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.PointsAccountService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Maps;

/**
 * 积分账户Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "weixin/user/points")
public class WxPointsAccountController extends BaseController {

	@Autowired
	private PointsAccountService pointsAccountService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	
	@ModelAttribute("pointsAccount")
	public PointsAccount getPointsAccount(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return pointsAccountService.getEntity(id);
		}
		return new PointsAccount();
	}
	
	@RequestMapping(value = "hotel/index")
	public String hotelPointsIndex(Model model) {
		/*List<Hotel> hotels = this.hotelService.getAllEntities();
		for (Hotel hotel : hotels) {
			HotelCooperationInfo cooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotel.getId());
			Double stan = 100/cooperationInfo.getPointsRate();
			String pointStandard = stan+"元折算一分";
			PointsAccount pointsAccount = new PointsAccount("HOTEL", hotel.getId()+"", hotel.getHotelName(), hotel.getCity()+"", 0d, 0d, 0d, 0d, pointStandard, cooperationInfo.getPointsRate(), new Date(), "");
			this.pointsAccountService.savePointsAccount(pointsAccount);
		}*/
		
		Map<String, Object> res = Maps.newHashMap();
		res = pointsAccountService.count("HOTEL");
		model.addAttribute("res", res);
		return "weixin/user/hotelPointsIndex";
	}
	
	@RequestMapping(value = "user/index")
	public String custmrPointsIndex(Model model) {
		Map<String, Object> res = Maps.newHashMap();
		res = pointsAccountService.count("CLIENT");
		model.addAttribute("res", res);
		return "weixin/user/custmrPointsIndex";
	}
	
	
	@RequestMapping(value ="list")
	@ResponseBody
	public JsonVo list(PageBean<PointsAccount> pageBean,HttpServletRequest request) {
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
		
		return JsonUtils.success("ok", getDataGrid(pageBean, page.getContent()));
	}
	
	
}
