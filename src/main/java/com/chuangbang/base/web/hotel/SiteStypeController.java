package com.chuangbang.base.web.hotel;

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

import com.chuangbang.base.entity.hotel.SiteStype;
import com.chuangbang.base.service.hotel.SiteStypeService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地风格Controller
 * @author heaven
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "base/hotel/sitestype")
public class SiteStypeController extends BaseController {

	@Autowired
	private SiteStypeService siteStypeService;
	
	@ModelAttribute("siteStype")
	public SiteStype getSiteStype(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return siteStypeService.getEntity(id);
		}
		return new SiteStype();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/siteStypeList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/siteStypeForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(SiteStype siteStype) {
		siteStypeService.saveSiteStype(siteStype);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<SiteStype> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<SiteStype> page = siteStypeService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		SiteStype siteStype = siteStypeService.getEntity(id);
		model.addAttribute("siteStype", siteStype);
		return new ModelAndView("hotel/siteStypeForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		siteStypeService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
