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

import com.chuangbang.base.entity.app.Api;
import com.chuangbang.base.service.app.ApiService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 接口表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app/api")
public class ApiController extends BaseController {

	@Autowired
	private ApiService apiService;
	
	@ModelAttribute("api")
	public Api getApi(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return apiService.getEntity(id);
		}
		return new Api();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/apiList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/apiForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Api api) {
		apiService.saveApi(api);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Api> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Api> page = apiService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Api api = apiService.getEntity(id);
		model.addAttribute("api", api);
		return new ModelAndView("app/apiForm");
	}
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model) {
		Api api = apiService.getEntity(id);
		model.addAttribute("api", api);
		return new ModelAndView("app/apiDetail");
	}
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		apiService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
