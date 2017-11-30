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

import com.chuangbang.base.entity.app.ApiResult;
import com.chuangbang.base.service.app.ApiResultService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 接口结果表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app//apiresult")
public class ApiResultController extends BaseController {

	@Autowired
	private ApiResultService apiResultService;
	
	@ModelAttribute("apiResult")
	public ApiResult getApiResult(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return apiResultService.getEntity(id);
		}
		return new ApiResult();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/apiResultForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/apiResultForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(ApiResult apiResult) {
		apiResultService.saveApiResult(apiResult);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ApiResult> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<ApiResult> page = apiResultService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		ApiResult apiResult = apiResultService.getEntity(id);
		model.addAttribute("apiResult", apiResult);
		return new ModelAndView("app/apiResultForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		apiResultService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
