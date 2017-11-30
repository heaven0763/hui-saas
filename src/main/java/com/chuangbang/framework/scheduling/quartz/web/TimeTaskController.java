package com.chuangbang.framework.scheduling.quartz.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.scheduling.quartz.entity.TimeTask;
import com.chuangbang.framework.scheduling.quartz.service.TimeTaskService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 定时任务管理Controller
 * @author HeavenChen
 * @version 2015-04-22
 */
@Controller
@RequestMapping(value = "base/quartz")
public class TimeTaskController extends BaseController {

	@Autowired
	private TimeTaskService timeTaskService;
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "quartz/timeTaskList";
	}
	
	@RequestMapping(value = "cronCreator")
	public String cronCreator(Model model) {
		return "quartz/cronCreator";
	}
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "quartz/timeTaskForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(TimeTask timeTask) {
		/*CronTrigger trigger = new CronTrigger();
		try {
			trigger.setCronExpression(timeTask.getCronExpression());
		} catch (ParseException e) {
			return ajaxDoneError("Cron表达式错误!");
		}*/
		timeTaskService.saveTimeTask(timeTask);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	/**
	 * 启动任务
	 */
	@RequestMapping(value = "startJob/{id}")
	@ResponseBody
	public ModelAndView startOrStopTask(@PathVariable("id")Long id,String start, HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.startJob(timeTask);
		return ajaxDoneSuccess("定时任务管理启动成功", "closeCurrent", "refreshDatagrid");
	}
	
	/**
	 * 更新任务时间使之生效
	 */
	@RequestMapping(value = "updateJob/{id}")
	@ResponseBody
	public ModelAndView updateTime(@PathVariable("id")Long id,HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.updateJob(timeTask);
		return ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	/**
	 * 暂停任务
	 */
	@RequestMapping(value = "pauseJob/{id}")
	@ResponseBody
	public ModelAndView pauseJob(@PathVariable("id")Long id,HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.pauseJob(timeTask);
		return ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	
	/**
	 * 恢复任务
	 */
	@RequestMapping(value = "resumeJob/{id}")
	@ResponseBody
	public ModelAndView resumeJob(@PathVariable("id")Long id,HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.resumeJob(timeTask);
		return ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	/**
	 * 删除任务
	 */
	@RequestMapping(value = "deleteJob/{id}")
	@ResponseBody
	public ModelAndView deleteJob(@PathVariable("id")Long id,HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.deleteJob(timeTask);
		return ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	/**
	 * 执行一次任务
	 */
	@RequestMapping(value = "triggerJob/{id}")
	@ResponseBody
	public ModelAndView triggerJob(@PathVariable("id")Long id,HttpServletRequest request) {
		TimeTask timeTask = timeTaskService.getEntity(id);
		timeTaskService.triggerJob(timeTask);
		return ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<TimeTask> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<TimeTask> page = timeTaskService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		TimeTask timeTaskEntity = timeTaskService.getEntity(id);
		model.addAttribute("timeTask", timeTaskEntity);
		return new ModelAndView("quartz/timeTaskForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		timeTaskService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
