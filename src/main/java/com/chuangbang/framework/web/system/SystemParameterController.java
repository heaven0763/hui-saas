package com.chuangbang.framework.web.system;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chuangbang.framework.entity.system.SystemParameter;
import com.chuangbang.framework.service.system.SystemParameterService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

@Controller
@RequestMapping(value = "/system/systemparameter")
public class SystemParameterController extends BaseController {
	@Autowired
	private SystemParameterService systemparameterService;

	@RequestMapping("/index")
	public String index(Model model) {
		return "system/systemparameterList";
	}

	@RequestMapping(value = { "list"})
	@ResponseBody
	public DataGrid list(Model model,HttpServletRequest request,PageBean<SystemParameter> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		pageBean.set_filterParams(searchParams);
		Page<SystemParameter> p = systemparameterService.getEntities(pageBean);
		return getDataGrid(pageBean,p.getContent());
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "system/systemparameterForm";
	}

	@RequestMapping(value = "save")
	@ResponseBody
	public ModelAndView save(SystemParameter systemparameter,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		SystemParameter codeSystemParamter = systemparameterService.getByCode(systemparameter.getCode());
		if(systemparameter.getId() == null && codeSystemParamter != null){
			return ajaxDoneError("该参数代码已存在，请不要重复添加！");
		}else if(systemparameter.getId() != null){
			SystemParameter oldSystemParamter = systemparameterService.getEntity(systemparameter.getId());
			if(!oldSystemParamter.getCode().equals(systemparameter.getCode()) && codeSystemParamter != null){
				return ajaxDoneError("该参数代码已存在，请不要重复添加！");
			}
		}
		systemparameterService.saveSystemParameter(systemparameter);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}

	@RequestMapping(value = "delete/{id}")
	@ResponseBody
	public ModelAndView delete(@PathVariable("id")Long id, RedirectAttributes redirectAttributes) {
		if (!systemparameterService.deleteSystemParameter(id)) {
			return ajaxDoneError("该信息不可删除！");
		}
		return ajaxDoneSuccess("删除成功！");
	}

	@RequestMapping(value = "update/{id}")
	public String updateForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("systemparameter",systemparameterService.getSystemParameter(id));
		return "system/systemparameterForm";
	}
}
