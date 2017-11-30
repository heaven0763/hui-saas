package com.chuangbang.js.web.account;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.PermissionService;
import com.chuangbang.js.service.account.UserService;


@Controller
@RequestMapping(value = "/account/group/")
public class GroupDetailController {

	@Autowired
	private UserService accountManager;

	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private MenuListEditor menuListEditor;
	
	@Autowired
	private PermissionListEditor permissionListEditor;
	
	@InitBinder
	public void initBinder(WebDataBinder b) {
		b.registerCustomEditor(List.class, "menuList", menuListEditor);
		b.registerCustomEditor(List.class, "permissionEntityList", permissionListEditor);
	}
	
	@RequestMapping(value = "update/{id}")
	public String updateForm(@PathVariable("id") Long id,Model model) {
		Group group = accountManager.getGroup(id);
		/*boolean disabled = false;
		String[] arr = {"administrator","districtBureau","financialDept","districtAudit","townAudit","villageAudit"};
		for (int i = 0; i < arr.length; i++) {
			if (arr[i].equals(group.getGroupId())) {
				disabled = true;
				break;
			}
		}
		model.addAttribute("allPermissions", permissionService.getAllPermission());
		model.addAttribute("allMenus", menuService.getAllMenu());
		model.addAttribute("id", id);
		model.addAttribute("disabled", disabled);*/
		
		model.addAttribute("group", group);
		return "account/groupForm";
	}
	
	@RequestMapping(value="updateTemp/{id}")
	public String updateTemp(Model model){
		model.addAttribute("allPermissions", permissionService.getAllPermission());
		model.addAttribute("allMenus", menuService.getAllMenu());
		model.addAttribute("formActionName", "修改");
		return "account/tempGroupForm";
	}

	@ModelAttribute("group")
	public Group getGroup(@PathVariable("id") Long id) {
		return accountManager.getGroup(id);
	}
}
