package com.chuangbang.base.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.chuangbang.base.entity.user.UserPermissionChange;
import com.chuangbang.base.service.user.UserPermissionChangeService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 权限调整记录Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/uesr/permissionchange")
public class UserPermissionChangeController extends BaseController {

	@Autowired
	private UserPermissionChangeService userPermissionChangeService;
	
	@ModelAttribute("userPermissionChange")
	public UserPermissionChange getUserPermissionChange(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return userPermissionChangeService.getEntity(id);
		}
		return new UserPermissionChange();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "user/userPermissionChangeForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/userPermissionChangeForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(UserPermissionChange userPermissionChange) {
		userPermissionChangeService.saveUserPermissionChange(userPermissionChange);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<UserPermissionChange> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<UserPermissionChange> page = userPermissionChangeService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		UserPermissionChange userPermissionChange = userPermissionChangeService.getEntity(id);
		model.addAttribute("userPermissionChange", userPermissionChange);
		return new ModelAndView("user/userPermissionChangeForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		userPermissionChangeService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
