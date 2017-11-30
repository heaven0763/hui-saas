package com.chuangbang.framework.scheduling.quartz.test;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/*@Service("taskDemoService")*/
public class TaskDemo implements Job{
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("----------任务测试-------" + new Date().getTime());
		
	}
	
}
