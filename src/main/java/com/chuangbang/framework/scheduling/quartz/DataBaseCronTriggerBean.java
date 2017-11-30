package com.chuangbang.framework.scheduling.quartz;
/*
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.CronTriggerBean;

import com.chuangbang.framework.scheduling.quartz.entity.TimeTask;
import com.chuangbang.framework.scheduling.quartz.service.TimeTaskService;
*//**
 * 在原有功能的基础上面增加数据库的读取
 * @author JueYue
 * @date 2013-9-22
 * @version 1.0
 *//*
public class DataBaseCronTriggerBean extends CronTriggerBean{

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private TimeTaskService timeTaskService;
	*//**
	 * 读取数据库更新文件
	 *//*
	public void afterPropertiesSet() throws Exception {
		System.out.println("-------DataBaseCronTriggerBean---------");
		super.afterPropertiesSet();
		TimeTask task = timeTaskService.findByTaskId(this.getName());
		if(task!=null&&task.getIsEffect().equals("1")
				&&!task.getCronExpression().equals(this.getCronExpression())){
			this.setCronExpression(task.getCronExpression());
			DynamicTask.updateSpringMvcTaskXML(this,task.getCronExpression());
		}
	}

}
*/