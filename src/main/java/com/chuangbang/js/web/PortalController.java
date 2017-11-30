package com.chuangbang.js.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.service.CommonBussinessService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Controller
@RequestMapping("/portal")
public class PortalController extends BaseController {
	@Autowired
	private CommonBussinessService commonBussinessService; 
	@RequestMapping("/index")
	public String pindex(HttpServletRequest request,Model model){
		this.groupSetting(model);
		Group group = AccountUtils.getCurrentUser().getGroup();
		List<Menu> menus =group.getMenuList();
		List<Menu> commonmenus = Lists.newArrayList();
		for (Menu menu : menus) {
			System.out.println(menu.getName());	
			if("1".equals(menu.getIscommon())){
				commonmenus.add(menu);
			}
		}
		model.addAttribute("commonmenus", commonmenus);
		return "index";
	}
	
	@RequestMapping("/sumitem")
	@ResponseBody
	public JsonVo sumItem(HttpServletRequest request,String sumitem){
		List<Map<String, Object>> res = Lists.newArrayList();
		if(StringUtils.isNotBlank(sumitem)&&sumitem.length()>1){
			sumitem = sumitem.substring(1, sumitem.length()-1);
			String sumitems[]=sumitem.split("#");
			for (String item : sumitems) {
				Long num = commonBussinessService.itemCount(item);
				Map<String, Object> m = Maps.newHashMap();
				m.put("item", item);
				m.put("num", num);
				res.add(m);
			}
		}
		return JsonUtils.success("ok", res);
	}
	
	@RequestMapping("/tipitem")
	@ResponseBody
	public JsonVo tipitem(HttpServletRequest request,String tipitem){
		List<Map<String, Object>> res = Lists.newArrayList();
		if(StringUtils.isNotBlank(tipitem)&&tipitem.length()>1){
			tipitem = tipitem.substring(1, tipitem.length()-1);
			String tipitems[]=tipitem.split("#");
			String crttype = AccountUtils.getHotelUserType();
			for (String item : tipitems) {
				Long num = commonBussinessService.itemTipsCount(item,crttype);
				Map<String, Object> m = Maps.newHashMap();
				m.put("item", item);
				m.put("num", num);
				res.add(m);
			}
		}
		return JsonUtils.success("ok", res);
	}
}
