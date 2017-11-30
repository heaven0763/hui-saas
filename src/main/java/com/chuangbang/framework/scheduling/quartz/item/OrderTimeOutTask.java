package com.chuangbang.framework.scheduling.quartz.item;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.chuangbang.base.service.CommonBussinessService;
import com.chuangbang.framework.util.spring.SpringUtils;
/*@Service("taskDemoService")*/
public class OrderTimeOutTask implements Job{
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("----------OrderCancelTask---execute----" + new Date().getTime());
		CommonBussinessService commonBussinessService = (CommonBussinessService) SpringUtils.getBean("commonBussinessService");
		commonBussinessService.queryAndCancelTimeOutOrder();
	}
	
}
