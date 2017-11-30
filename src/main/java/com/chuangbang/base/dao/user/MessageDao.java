package com.chuangbang.base.dao.user;

import com.chuangbang.base.entity.user.Message;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.chuangbang.framework.dao.BaseRepository;

/**
 * 留言DAO接口
 * @author mabelxiao
 * @version 2016-11-16
 */
public interface MessageDao extends BaseRepository<Message, Long>,PagingAndSortingRepository<Message, Long>{

}