package com.chuangbang.framework.scheduling.quartz.service;

import java.util.Date;
import java.util.Map;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.scheduling.quartz.dao.TimeTaskDao;
import com.chuangbang.framework.scheduling.quartz.entity.TimeTask;
import com.chuangbang.framework.service.BaseService;

/**
 * 定时任务管理Service
 * @author HeavenChen
 * @version 2015-04-22
 */
@Component
@Transactional(readOnly = true)
public class TimeTaskService extends BaseService<TimeTask,TimeTaskDao> {

	@Autowired
	private TimeTaskDao timeTaskDao;
	
	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;
	
	@Override
	public TimeTask getEntity(Long id) {
		return timeTaskDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveTimeTask(TimeTask timeTask) {
		if(null==timeTask.getId()){
			timeTask.setCreateDate(new Date());
			timeTask.setIsEffect("0");
			timeTask.setIsStart("0");
		}
		timeTaskDao.save(timeTask);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		timeTaskDao.delete(id);
	}

	public TimeTask findByTaskId(String taskId){
		return timeTaskDao.findByTaskId(taskId);
	}
	
	public boolean startJob(TimeTask timeTask,Map<String,Object> map){
		boolean result = false;
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		TriggerKey triggerKey = TriggerKey.triggerKey(timeTask.getTaskId(), timeTask.getGroupName());
		//获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
		try {
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
			//不存在，创建一个
			if (trigger == null) {
				JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) Thread.currentThread().getContextClassLoader().loadClass(timeTask.getClazz()))
					.withIdentity(timeTask.getTaskId(), timeTask.getGroupName()).build();
				jobDetail.getJobDataMap().put(timeTask.getTaskId(), timeTask);
				if(map != null){
					jobDetail.getJobDataMap().putAll(map);
				}
		 
				//表达式调度构建器
				CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(timeTask.getCronExpression());
		 
				//按新的cronExpression表达式构建一个新的trigger
				trigger = TriggerBuilder.newTrigger().withIdentity(timeTask.getTaskId(),timeTask.getGroupName()).withSchedule(scheduleBuilder).build();
		 
				scheduler.scheduleJob(jobDetail, trigger);
			} 
			result = true;
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeTask.setIsStart("run");
		this.timeTaskDao.save(timeTask);
		return result;
	}
	
	@Transactional(readOnly = false)
	public boolean startJob(TimeTask timeTask){
		return startJob(timeTask,null);
	}
	
	@Transactional(readOnly = false)
	public boolean updateJob(TimeTask timeTask){
		boolean result = false;
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		TriggerKey triggerKey = TriggerKey.triggerKey(timeTask.getTaskId(), timeTask.getGroupName());
		try {
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
			// Trigger已存在，那么更新相应的定时设置
			//表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(timeTask.getCronExpression());
		
			//按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey)
				.withSchedule(scheduleBuilder).build();
		
			//按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
			result = true;
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 暂停任务
	 * @param timeTask
	 * @return
	 */
	@Transactional(readOnly = false)
	public boolean pauseJob(TimeTask timeTask){
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(timeTask.getTaskId(), timeTask.getGroupName());
		try {
			scheduler.pauseJob(jobKey);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeTask.setIsStart("pause");
		this.timeTaskDao.save(timeTask);
		return true;
	}
	
	/**
	 * 恢复任务
	 * @param timeTask
	 * @return
	 */
	@Transactional(readOnly = false)
	public boolean resumeJob(TimeTask timeTask){
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(timeTask.getTaskId(), timeTask.getGroupName());
		try {
			scheduler.resumeJob(jobKey);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeTask.setIsStart("run");
		this.timeTaskDao.save(timeTask);
		return true;
	}
	
	/**
	 * 删除任务
	 * @param timeTask
	 * @return
	 */
	@Transactional(readOnly = false)
	public boolean deleteJob(TimeTask timeTask){
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(timeTask.getTaskId(), timeTask.getGroupName());
		try {
			scheduler.deleteJob(jobKey);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeTask.setIsStart("stop");
		this.timeTaskDao.save(timeTask);
		return true;
	}
	
	/**
	 * 执行一次任务
	 * @param timeTask
	 * @return
	 */
	@Transactional(readOnly = false)
	public boolean triggerJob(TimeTask timeTask){
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		JobKey jobKey = JobKey.jobKey(timeTask.getTaskId(), timeTask.getGroupName());
		try {
			scheduler.triggerJob(jobKey);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	
}
