package com.chuangbang.js.web.account;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Tree;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.PermissionService;
import com.chuangbang.js.service.account.UserService;


@Controller
@RequestMapping(value = "/account/group")
public class GroupController extends BaseController {
	
	@Autowired
	private UserService accountManager;
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private MenuService menuService;
	
	
	@Autowired
	private MenuListEditor menuListEditor;
	
	@Autowired
	private PermissionListEditor permissionListEditor;
	
	@Autowired
	private GroupListEditor groupListEditor;
	
	@InitBinder
	public void initBinder(WebDataBinder b) {
		b.registerCustomEditor(List.class, "menuList", menuListEditor);
		b.registerCustomEditor(List.class, "permissionEntityList", permissionListEditor);
		b.registerCustomEditor(List.class, "groupList", groupListEditor);
	}

	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		return "account/groupList";
	}
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Group group,Model model,PageBean<Group> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		pageBean.set_filterParams(searchParams);
		Page<Group> p = groupService.getEntities(pageBean);
		return getDataGrid(pageBean, p.getContent());
	}
	@RequestMapping(value ="comboxlist")
	@ResponseBody
	public List<Group> comboxlist(HttpServletRequest request,Group shops,Model model,PageBean<Group> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		pageBean.set_filterParams(searchParams);
		List<Group> groups=groupService.getEntities(searchParams);
		return groups;
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		model.addAttribute("group", new Group());
		model.addAttribute("id", 0);
		return "account/groupForm";
	}
	@RequestMapping(value = "menus/{id}")
	@ResponseBody
	public List<Tree>  getAllMenu(@PathVariable("id") Long id){
		List<Tree> tree = menuService.tree(id);
		return  tree;
	}
	
	
	@RequestMapping(value = "permission/{id}")
	public String permissionForm(@PathVariable("id") Long id,Model model){
		Group group = accountManager.getGroup(id);
		model.addAttribute("group", group);
		return "account/groupPermission";
	}
	
	/*@RequestMapping(value = "prmsnsave")
	public ModelAndView prmsnsave(Long id,String menusid,String permissionsid) {
		
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}*/
	
	@RequestMapping(value = "permissionTree")
	@ResponseBody
	public List<Tree> permissionTree(Long groupId){
		List<Tree> tree = permissionService.tree(groupId);
		return  tree;
	}
	
	@RequestMapping(value = "menupmstree")
	@ResponseBody
	public List<Tree> menuPmsTree(Long groupId){
		List<Tree> tree = permissionService.treeMenuPms(groupId);
		return  tree;
	}
	@RequestMapping(value = "save")
	public ModelAndView save(Group group, RedirectAttributes redirectAttributes) {
		System.out.println(group.toString());
		if(group.getId() == null && groupService.findByGroupId(group.getGroupId())!= null){
			return ajaxDoneError("该角色代码已存在，请不要重复添加！");
		}
		System.out.println(">>>>>"+group.getMenuIds());
		accountManager.saveGroup(group);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		Group group = accountManager.getGroup(id);
		if(group.getGroupId().equals("administrator")){
			return ajaxDoneError("不能删除该用户组");
		}
		accountManager.deleteGroup(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping(value = "createTemp")
	public String createTempForm(Model model){
		model.addAttribute("group", new Group());
		model.addAttribute("allPermissions", permissionService.getAllPermission());
		model.addAttribute("allMenus", menuService.getAllMenu());
		model.addAttribute("formActionName", "添加");
		return "account/tempGroupForm";
	}

}
