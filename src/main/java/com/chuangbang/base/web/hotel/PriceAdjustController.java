package com.chuangbang.base.web.hotel;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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

import com.chuangbang.base.entity.hotel.PriceAdjust;
import com.chuangbang.base.service.hotel.PriceAdjustService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地价格调整Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/hotel/price/adjust")
public class PriceAdjustController extends BaseController {

	@Autowired
	private PriceAdjustService priceAdjustService;
	
	@ModelAttribute("priceAdjust")
	public PriceAdjust getPriceAdjust(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return priceAdjustService.getEntity(id);
		}
		return new PriceAdjust();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/priceAdjustList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/priceAdjustForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("priceAdjust")PriceAdjust priceAdjust) {
		priceAdjustService.savePriceAdjust(priceAdjust);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PriceAdjust> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<PriceAdjust> page = priceAdjustService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		PriceAdjust priceAdjust = priceAdjustService.getEntity(id);
		model.addAttribute("priceAdjust", priceAdjust);
		return new ModelAndView("hotel/priceAdjustForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		priceAdjustService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
