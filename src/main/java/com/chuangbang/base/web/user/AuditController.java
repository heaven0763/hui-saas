package com.chuangbang.base.web.user;

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

import com.chuangbang.base.entity.user.Audit;
import com.chuangbang.base.service.user.AuditService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 审核表Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/uesr/audit")
public class AuditController extends BaseController {

	@Autowired
	private AuditService auditService;
	
	@ModelAttribute("audit")
	public Audit getAudit(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return auditService.getEntity(id);
		}
		return new Audit();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "user/auditForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/auditForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Audit audit) {
		auditService.saveAudit(audit);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Audit> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Audit> page = auditService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Audit audit = auditService.getEntity(id);
		model.addAttribute("audit", audit);
		return new ModelAndView("user/auditForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		auditService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
