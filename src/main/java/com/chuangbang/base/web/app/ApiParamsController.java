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

import com.chuangbang.base.entity.app.ApiParams;
import com.chuangbang.base.service.app.ApiParamsService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 接口参数表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app/apiparams")
public class ApiParamsController extends BaseController {

	@Autowired
	private ApiParamsService apiParamsService;
	
	@ModelAttribute("apiParams")
	public ApiParams getApiParams(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return apiParamsService.getEntity(id);
		}
		return new ApiParams();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/apiParamsForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/apiParamsForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(ApiParams apiParams) {
		apiParamsService.saveApiParams(apiParams);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<ApiParams> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<ApiParams> page = apiParamsService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		ApiParams apiParams = apiParamsService.getEntity(id);
		model.addAttribute("apiParams", apiParams);
		return new ModelAndView("app/apiParamsForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		apiParamsService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
