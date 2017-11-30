package com.chuangbang.js.web.account;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Department;
import com.chuangbang.js.service.account.DepartmentService;

@Controller
@RequestMapping(value = "/account/department")
public class DepartmentController extends BaseController {

	@Autowired
	private DepartmentService departmentService;

	@RequestMapping(value = "create")
	public String createForm(Model model) {
		model.addAttribute("formActionName", "添加");
		return "account/departmentForm";
	}

	@RequestMapping(value = "save")
	public ModelAndView save(Department department,RedirectAttributes redirectAttributes) {
		if(!departmentService.validateUniqueFiled(department, "unitcode")){
			return ajaxDoneError("对不起，已经存在相同部门编号的部门，请不要重复添加！");
		}
		departmentService.saveDepartment(department);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}

	@RequestMapping(value = "tiqu/{id}")
	public String tiquForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("department", departmentService.getDepartment(id));
		return "account/departmentList";
	}

	@RequestMapping(value ="index")
	public String index(Model model) {
		return "account/departmentList";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(String superUnit,PageBean<Department> pageBean,HttpServletRequest request, Model model) {
		pageBean.set_filterParams(this.getSearchParams(request));
		Page<Department> p = departmentService.getEntities(pageBean);
		return getDataGrid(pageBean, p.getContent());
	}

	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id,RedirectAttributes redirectAttributes) {
		departmentService.deleteDepartment(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	
	@RequestMapping(value = "batchDelete")
	public ModelAndView batchDelete(HttpServletResponse response,HttpServletRequest request) throws Exception{
		String id = request.getParameter("ids");
		String[] idstr = id.split(",");
		Long[] ids = new Long[idstr.length];
		for (int i = 0; i < idstr.length; i++) {
			ids[i] = Long.valueOf(idstr[i]);
			System.out.println("编号："+ids[i]);
		}
		departmentService.batchDelete(ids);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView updateForm(@PathVariable("id") Long id, Model model) {
		Department department = departmentService.getDepartment(id);
		/*if(AdminLevel.DISTRICT.equals(AdminLevel.getAdminLevel(department.getUnitcode()))){
			return ajaxErrorAndClose("对不起，不能修改区级别的单位！");
		}*/
		model.addAttribute("department", department);
		return new ModelAndView("account/departmentForm");
	}
}
