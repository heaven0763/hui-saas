package com.chuangbang.base.dao.user;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.framework.dao.BaseRepository;

public interface ChatRecordDao extends BaseRepository<ChatRecord, Long>,PagingAndSortingRepository<ChatRecord,Long>{

	public ChatRecord findByMsgTypeAndItemTypeAndItemId(String msgType, String itemType, String userId);

	public ChatRecord findByMsgTypeAndItemIdAndToUserID(String msgType, String itemId, String userId);

	//public List<ChatRecord> findByToUserID();
}
