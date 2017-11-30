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

import com.chuangbang.base.entity.hotel.OfflineParty;
import com.chuangbang.base.service.hotel.OfflinePartyService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 线下活动Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/hotel/offlineParty")
public class OfflinePartyController extends BaseController {

	@Autowired
	private OfflinePartyService offlinePartyService;
	
	@ModelAttribute("offlineParty")
	public OfflineParty getOfflineParty(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return offlinePartyService.getEntity(id);
		}
		return new OfflineParty();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/offlinePartyForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/offlinePartyForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(OfflineParty offlineParty) {
		offlinePartyService.saveOfflineParty(offlineParty);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<OfflineParty> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<OfflineParty> page = offlinePartyService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		OfflineParty offlineParty = offlinePartyService.getEntity(id);
		model.addAttribute("offlineParty", offlineParty);
		return new ModelAndView("hotel/offlinePartyForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		offlinePartyService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
