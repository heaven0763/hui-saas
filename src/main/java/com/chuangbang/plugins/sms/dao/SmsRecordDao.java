package com.chuangbang.plugins.sms.dao;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.framework.dao.BaseRepository;
import com.chuangbang.plugins.sms.entity.SmsRecord;

public interface SmsRecordDao extends BaseRepository<SmsRecord, Long>,PagingAndSortingRepository<SmsRecord, Long>{


}
