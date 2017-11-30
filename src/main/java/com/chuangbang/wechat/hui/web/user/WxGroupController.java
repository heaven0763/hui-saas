package com.chuangbang.wechat.hui.web.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.PermissionService;
import com.chuangbang.js.service.account.UserService;


@Controller
@RequestMapping(value = "/weixin/group")
public class WxGroupController extends BaseController {
	
	@Autowired
	private UserService accountManager;
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private MenuService menuService;

	@RequestMapping("/findall")
	@ResponseBody
	public JsonVo findall(){
		List<Group> groups = groupService.getAllEntities();
		
		return JsonUtils.success("",groups);
	}
	
	

}
