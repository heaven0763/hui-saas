package com.chuangbang.base.web.app;

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

import com.chuangbang.base.entity.app.ApiErrorCode;
import com.chuangbang.base.service.app.ApiErrorCodeService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 接口错误码Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app/errorcode")
public class ApiErrorCodeController extends BaseController {

	@Autowired
	private ApiErrorCodeService apiErrorCodeService;
	
	@ModelAttribute("apiErrorCode")
	public ApiErrorCode getApiErrorCode(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return apiErrorCodeService.getEntity(id);
		}
		return new ApiErrorCode();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/apiErrorCodeList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/apiErrorCodeForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(ApiErrorCode apiErrorCode) {
		apiErrorCodeService.saveApiErrorCode(apiErrorCode);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ApiErrorCode> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<ApiErrorCode> page = apiErrorCodeService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		ApiErrorCode apiErrorCode = apiErrorCodeService.getEntity(id);
		model.addAttribute("apiErrorCode", apiErrorCode);
		return new ModelAndView("app/apiErrorCodeForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		apiErrorCodeService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
