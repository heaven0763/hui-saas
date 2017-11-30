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

import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地风格Controller
 * @author heaven
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "base/hotel/category")
public class CategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;
	
	@ModelAttribute("category")
	public Category getCategory(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return categoryService.getEntity(id);
		}
		return new Category();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/categoryList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/categoryForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Category category) {
		categoryService.saveCategory(category);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Category> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Category> page = categoryService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Category category = categoryService.getEntity(id);
		model.addAttribute("category", category);
		return new ModelAndView("hotel/categoryForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		categoryService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
