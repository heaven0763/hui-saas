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

import com.chuangbang.base.entity.user.PointsRecord;
import com.chuangbang.base.service.user.PointsRecordService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 积分记录Controller
 * @author mabelxiao
 * @version 2016-11-15
 */
@Controller
@RequestMapping(value = "base/uesr/pointsrecord")
public class PointsRecordController extends BaseController {

	@Autowired
	private PointsRecordService pointsRecordService;
	
	@ModelAttribute("pointsRecord")
	public PointsRecord getPointsRecord(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return pointsRecordService.getEntity(id);
		}
		return new PointsRecord();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "user/pointsRecordForm";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/pointsRecordForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(PointsRecord pointsRecord) {
		pointsRecordService.savePointsRecord(pointsRecord);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PointsRecord> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<PointsRecord> page = pointsRecordService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		PointsRecord pointsRecord = pointsRecordService.getEntity(id);
		model.addAttribute("pointsRecord", pointsRecord);
		return new ModelAndView("user/pointsRecordForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		pointsRecordService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
