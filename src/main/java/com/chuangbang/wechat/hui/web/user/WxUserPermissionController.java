package com.chuangbang.wechat.hui.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.PermissionService;
import com.chuangbang.wechat.hui.model.GroupModel;
import com.google.common.collect.Lists;

@Controller
@RequestMapping(value = "/weixin/user/permission")
public class WxUserPermissionController extends BaseController{

	@Autowired
	private UserPermissionService userPermissionService;
		
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	
	@RequestMapping("/findByUserId/{userid}")
	@ResponseBody
	public JsonVo findByUserId(HttpServletRequest request,Model model,@PathVariable("userid")String userid){
		System.out.println("userid>>>>"+userid);
		return JsonUtils.success("",userPermissionService.findByUserId(userid,"1"))  ;
	}
	
	@RequestMapping("/findTmpByUserId/{userid}")
	@ResponseBody
	public JsonVo findTmpByUserId(HttpServletRequest request,Model model,@PathVariable("userid")String userid){
		System.out.println("userid>>>>"+userid);
		return JsonUtils.success("",userPermissionService.findByUserId(userid,"0"))  ;
	}
	
	@RequestMapping("/findByGroupId")
	@ResponseBody
	public JsonVo findByUserId(HttpServletRequest request,Model model,Long groupId){
		System.out.println("groupId>>>>"+groupId);
		Group group  = groupService.getEntity(groupId);
		return JsonUtils.success("",group.getPermissionEntityList())  ;
	}
	
	@RequestMapping("/groupPms/list")
	@ResponseBody
	public JsonVo findAllGroupPms(PageBean pageBean,HttpServletRequest request,Model model){
		Map<String, Object> searchparas = this.getSearchParams(request);
		
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			
			
			Group group = this.groupService.getEntity(Long.valueOf(searchparas.get("NE_id").toString()));
			if(group!=null&&group.getGroupId().startsWith("hotel")){
				searchparas.put("EQ_pid", 12);
				searchparas.put("LLIKE_groupId","hotel");
			}else if(group!=null&&group.getGroupId().startsWith("group")){
				searchparas.put("EQ_pid", 12);
				searchparas.put("LLIKE_groupId","group");
			}else{	
				searchparas.put("EQ_pid", 11);
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_pid", 12);
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
				searchparas.put("LLIKE_groupId","hotel");
			}
		}else if("partner".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_pid", 14);
		}else if("application".equals(AccountUtils.getCurrentUserType())){
			searchparas.put("EQ_pid", 15);
		}else{
			searchparas.put("EQ_pid", 13);
		}
		List<Group> groups = groupService.getEntities(searchparas);
		List<GroupModel> groupModels = Lists.newArrayList();
		for(Group group : groups){
			//groupModel.setPermissions(permissionService.findByGroupId(groupModel.getId()));
			GroupModel groupModel = new GroupModel();
			BeanUtils.copyProperties(group, groupModel);
			groupModel.setPermissions(group.getPermissionEntityList());
			groupModels.add(groupModel);
		}
		
		return JsonUtils.success("",groupModels);
	}
	
	
	@RequestMapping("/savePermission")
	@ResponseBody
	public JsonVo savePermission(String user_id,String permission_ids){
		userPermissionService.updatePermission(user_id, permission_ids);
		return JsonUtils.success("ok");
	}

}
