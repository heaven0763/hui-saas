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

import com.chuangbang.base.entity.app.Log;
import com.chuangbang.base.service.app.LogService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 日志表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;
	
	@ModelAttribute("log")
	public Log getLog(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return logService.getEntity(id);
		}
		return new Log();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/logForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/logForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Log log) {
		logService.saveLog(log);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Log> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Log> page = logService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Log log = logService.getEntity(id);
		model.addAttribute("log", log);
		return new ModelAndView("app/logForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		logService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
