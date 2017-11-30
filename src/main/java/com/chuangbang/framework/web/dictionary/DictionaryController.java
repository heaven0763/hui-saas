package com.chuangbang.framework.web.dictionary;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.entity.dictionary.Dictionary;
import com.chuangbang.framework.service.dictionary.DictionaryService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Lists;

@Controller
@RequestMapping(value = "/framework/dictionary")
public class DictionaryController extends BaseController{
	
	@Autowired
	private DictionaryService dictionaryService;
	
	@RequestMapping("/index")
	public String index() {
		return  "system/dictionaryList";
	}
	
	@RequestMapping("/create")
	public  String  create(){
		return  "system/dictionaryForm";
	}
	
	@RequestMapping("/save")
	public  ModelAndView save(Dictionary dictionary,BindingResult result){
		/*if(result.hasErrors()) { //如果dictionary模型对象验证失败
		   return ajaxDoneError(BindingResultUtil.getAllErrorMessage(result));
		}*/
		dictionaryService.saveDictionary(dictionary);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Model model,PageBean<Dictionary> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		pageBean.set_filterParams(searchParams);
		Page<Dictionary> p = dictionaryService.getEntities(pageBean);
		
		return getDataGrid(pageBean,p.getContent());
	}
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id")Long id,Model model) {
		model.addAttribute("dictionary", dictionaryService.getDictionary(id));
		return new ModelAndView("system/dictionaryForm");
	}
	@RequestMapping("/delete/{id}")
	public ModelAndView delete(@PathVariable("id")Long id) {
		dictionaryService.deleteDictionary(id);
		return ajaxDoneSuccess("删除成功！");
	}
	
	@RequestMapping(value = "trslCombox",produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String trslCombox(String sql,String[] paras,String value,String[] addBefore)throws Exception {
		List<Object> objects = Lists.newArrayList();
		if(paras != null){
			for(Object o:paras){
				objects.add(o);
			}
		}
		return dictionaryService.trslCombox(sql, objects, value,addBefore);
	}
	
	@RequestMapping(value ="listAll")
	@ResponseBody
	public DataGrid listAll(HttpServletRequest request,Model model,PageBean<Dictionary> pageBean) {
		List<Dictionary> dictionarys = dictionaryService.findAllOrderByCode();
		return getDataGrid(pageBean,dictionarys);
	}
}