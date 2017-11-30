package com.chuangbang.framework.scheduling.quartz.dao;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.framework.scheduling.quartz.entity.TimeTask;

import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 定时任务管理DAO接口
 * @author HeavenChen
 * @version 2015-04-22
 */
public interface TimeTaskDao extends BaseRepository<TimeTask, Long>,PagingAndSortingRepository<TimeTask, Long>{

	TimeTask findByTaskId(String taskId);
	
}