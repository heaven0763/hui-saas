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

import com.chuangbang.base.entity.hotel.OfflinePartyPlace;
import com.chuangbang.base.service.hotel.OfflinePartyPlaceService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 线下活动场地Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/hotel/offlinePartyPlace")
public class OfflinePartyPlaceController extends BaseController {

	@Autowired
	private OfflinePartyPlaceService offlinePartyPlaceService;
	
	@ModelAttribute("offlinePartyPlace")
	public OfflinePartyPlace getOfflinePartyPlace(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return offlinePartyPlaceService.getEntity(id);
		}
		return new OfflinePartyPlace();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/offlinePartyPlaceForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/offlinePartyPlaceForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(OfflinePartyPlace offlinePartyPlace) {
		offlinePartyPlaceService.saveOfflinePartyPlace(offlinePartyPlace);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<OfflinePartyPlace> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<OfflinePartyPlace> page = offlinePartyPlaceService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		OfflinePartyPlace offlinePartyPlace = offlinePartyPlaceService.getEntity(id);
		model.addAttribute("offlinePartyPlace", offlinePartyPlace);
		return new ModelAndView("hotel/offlinePartyPlaceForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		offlinePartyPlaceService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
