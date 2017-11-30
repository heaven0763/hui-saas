package com.chuangbang.js.web.account;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.service.account.MenuService;

@Controller
@RequestMapping(value = "/account/menu")
public class MenuController extends BaseController{
	@Autowired
	private MenuService menuService;

	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		return "account/menuList";
	}
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Menu menu,Model model,PageBean<Menu> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		System.out.println(searchParams.toString());
		pageBean.set_filterParams(searchParams);
		pageBean.setOrder("desc");
		Page<Menu> p = menuService.getEntities(pageBean);
		for (Menu m : p.getContent()) {
			if(m.getParentId()!=0){
				m.setPname(menuService.getEntity(m.getParentId()).getName());
			}else{
				m.setPname("--");
			}
		}
		return getDataGrid(pageBean, p.getContent());
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		model.addAttribute("menuBean", new Menu());
		model.addAttribute("formActionName", "添加");
		return "account/menuForm";
	}
	
	@RequestMapping(value = "update/{id}")
	public String updateForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("menuBean", menuService.getMenu(id));
		model.addAttribute("formActionName", "修改");
		return "account/menuForm";
	}
	@RequestMapping("/save")
	@ResponseBody
	public Json add(Menu menu) {
		Json json = new Json();
		/*System.out.println(id);
		Menu menu = new Menu(parentId, name, url, orderId, type, icon, tab);
		if(null!=id){
			menu.setId(id);
		}*/
		try{
			menuService.saveEntity(menu);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}

	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Json delete(@PathVariable("id")Long id) {
		Json json = new Json();
		try{
			menuService.deleteEntity(id);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}
	
	@RequestMapping("/batchDelete")
	@ResponseBody
	public Json batchDelete(String ids) throws InterruptedException {
		System.out.println("编号："+ids);
		String[] idstr = ids.split(",");
		Long[] idint = new Long[idstr.length];
		for (int i = 0; i < idstr.length; i++) {
			idint[i] = Long.valueOf(idstr[i]);
			System.out.println("编号："+idint[i]);
		}
		Json json = new Json();
		try{
			menuService.batchDelete(idint);
			json.setSuccess(true);
			json.setMsg("操作成功");
		}catch (Exception e) {
			json.setSuccess(false);
			json.setMsg("操作失败");
		}
		return  json;
	}
	
}