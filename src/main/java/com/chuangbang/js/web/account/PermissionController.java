package com.chuangbang.js.web.account;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.PermissionService;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value = "/account/permission")
public class PermissionController extends BaseController{
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private MenuService menuService;

	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		Map<String, String> names = Maps.newHashMap();
		names.put("user", "用户");
		names.put("group", "角色");
		names.put("menu", "菜单");
		names.put("permission", "权限");
		names.put("schedulebooking", "档期预定");
		names.put("cooperationinfo", "合作信息");
		names.put("evaluate", "评价");
		names.put("order", "订单");
		names.put("price", "价格");
		names.put("company", "企业");
		names.put("hotel", "酒店");
		names.put("hall", "大厅");
		names.put("room", "客房");
		names.put("set", "套餐");
		names.put("hmenu", "酒店菜单");
		names.put("schedule", "档期");
		names.put("img", "图库");
		names.put("dynamic", "酒店动态");
		names.put("message", "留言");
		names.put("region", "地区");
		names.put("district", "商圈");
		names.put("category", "类型");
		names.put("supporting", "配套服务");
		names.put("sitestype", "场地风格");
		names.put("application", "应用");
		names.put("api", "接口");
		names.put("errorcode", "错误代码");
		names.put("integralcommodity", "积分商城商品");
		names.put("audit", "审核记录");
		names.put("chatrecord", "消息记录");
		names.put("pointsaccount", "积分账户");
		List<Menu> list = this.menuService.getAllMenu();
		String title="";
		/*for (Menu menu : list) {
			String str = "";
			if(!menu.getUrl().equals("#")){
				str = menu.getUrl().substring(0, menu.getUrl().indexOf("/index"));
				str = str.substring(str.lastIndexOf("/")+1);
				System.out.println( menu.getId()+">>>>>>>>>>"+str);
				if(!title.contains(str)){
					Permission add = new Permission(str+":add",names.get(str)+"添加", "", null, menu.getId());
					Permission query = new Permission(str+":query", names.get(str)+"查询", "", null, menu.getId());
					Permission update = new Permission(str+":update", names.get(str)+"修改", "", null, menu.getId());
					Permission delete = new Permission(str+":delete", names.get(str)+"删除", "", null, menu.getId());
					Permission view = new Permission(str+":view", names.get(str)+"查看", "", null, menu.getId());
					
					this.permissionService.savePermission(add);
					this.permissionService.savePermission(query);
					this.permissionService.savePermission(update);
					this.permissionService.savePermission(delete);
					this.permissionService.savePermission(view);
					
				}
				if(StringUtils.isNotBlank(title)){
					title+=","+str;
				}else{
					title+=str;
				}
				
			}else{
				Permission add = new Permission(":add", "添加", "", null, menu.getId());
				Permission query = new Permission(":query", "查询", "", null, menu.getId());
				Permission update = new Permission(":update", "修改", "", null, menu.getId());
				Permission delete = new Permission(":delete", "删除", "", null, menu.getId());
				Permission view = new Permission(":view", "查看", "", null, menu.getId());
				
				this.permissionService.savePermission(add);
				this.permissionService.savePermission(query);
				this.permissionService.savePermission(update);
				this.permissionService.savePermission(delete);
				this.permissionService.savePermission(view);
			}
			
			
		}*/
		return "account/permissionList";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Menu menu,Model model,PageBean<Permission> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		pageBean.set_filterParams(searchParams);
		Page<Permission> p = permissionService.getEntities(pageBean);
		for (Permission permission : p) {
			if(permission.getMenuId()!=null){
				Menu mnu = this.menuService.getMenu(permission.getMenuId());
				permission.setMenuName(mnu==null?"":mnu.getName());
			}
		}
		return getDataGrid(pageBean, p.getContent());
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "account/permissionForm";
	}
	
	@RequestMapping(value = "update/{id}")
	public String updateForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("permission", permissionService.getPermission(id));
		return "account/permissionForm";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Json add(Long id, Long parentId,String displayname,String permission,String memo) {
		Json json = new Json();
		System.out.println(id);
		Permission prmission = new Permission(permission, displayname, memo, parentId);
		if(null!=id){
			prmission.setId(id);
		}
		try{
			permissionService.saveEntity(prmission);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}

	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Json delete(@PathVariable("id")Long id) {
		Json json = new Json();
		try{
			permissionService.deleteEntity(id);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}
	
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Json batchDelete(String ids) throws InterruptedException {
		System.out.println("编号："+ids);
		String[] idstr = ids.split(",");
		Long[] idint = new Long[idstr.length];
		for (int i = 0; i < idstr.length; i++) {
			idint[i] = Long.valueOf(idstr[i]);
			System.out.println("编号："+idint[i]);
		}
		Json json = new Json();
		try{
			permissionService.batchDelete(idint);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}
}