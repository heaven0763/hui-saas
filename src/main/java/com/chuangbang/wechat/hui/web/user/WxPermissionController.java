package com.chuangbang.wechat.hui.web.user;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.service.account.PermissionService;

@Controller
@RequestMapping(value = "/weixin/permission")
public class WxPermissionController extends BaseController{
	@Autowired
	private PermissionService permissionService;

	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		return "account/permissionList";
	}

	@RequestMapping("/findAll")
	@ResponseBody
	public JsonVo findAll(HttpServletRequest request,Model model){
		return JsonUtils.success("",permissionService.getAllEntities())  ;
	}
	
}