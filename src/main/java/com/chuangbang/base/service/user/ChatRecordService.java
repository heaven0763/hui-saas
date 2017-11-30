package com.chuangbang.base.service.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.bcel.generic.RETURN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.util.RandomStringUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.js.dao.account.GroupDao;
import com.chuangbang.js.dao.account.UserDao;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.User;
import com.google.common.collect.Maps;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.dao.hotel.HotelDao;
import com.chuangbang.base.dao.user.ChatRecordDao;

@Component
@Transactional(readOnly = true)
public class ChatRecordService extends BaseService<ChatRecord,ChatRecordDao> {

	@Autowired
	private ChatRecordDao chatRecordDao;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private HotelDao hotelDao;
	public ChatRecord getEntity(Long id) {
		return chatRecordDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveChatRecord(ChatRecord ChatRecord) {
		chatRecordDao.save(ChatRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		chatRecordDao.delete(id);
	}
	/**
	 * 发送消息
	 * @param formUserID    发送用户编号
	 * @param formUserName  发送用户姓名
	 * @param toUserID		接受用户编号
	 * @param toUserName	接受用户姓名
	 * @param msgType		消息类型
	 * @param title			标题
	 * @param ptext			消息内容
	 * @param hotelId		酒店编号
	 * @param hotelName		酒店名称
	 * @param itemType		提醒操作项
	 * @param itemId		提醒操作项编号
	 * @param memo			备注
	 */
	@Transactional(readOnly = false)
	public void send(String formUserID, String formUserName, String toUserID, String toUserName, String msgType,
			String title, String ptext, Long hotelId, String hotelName, String itemType, String itemId, String memo) {
		try{
			String batchId = RandomStringUtil.getWthdrwNo(8);
			ChatRecord ChatRecord = new ChatRecord(formUserID, formUserName, toUserID, toUserName, msgType, title, ptext, new Date(), "1", hotelId, hotelName, itemType, itemId, memo,batchId);
			chatRecordDao.save(ChatRecord);
		}catch(Exception e){
		}
	}
	/**
	 * 发送消息
	 * @param formUserID    发送用户编号
	 * @param formUserName  发送用户姓名
	 * @param toUserID		接受用户编号
	 * @param toUserName	接受用户姓名
	 * @param msgType		消息类型
	 * @param title			标题
	 * @param ptext			消息内容
	 * @param hotelId		酒店编号
	 * @param hotelName		酒店名称
	 * @param itemType		提醒操作项
	 * @param itemId		提醒操作项编号
	 * @param memo			备注
	 */
	@Transactional(readOnly = false)
	public void send(String formUserID, String formUserName, String toUserID, String toUserName, String msgType,
			String title, String ptext, Long hotelId, String hotelName, String itemType, String itemId, String memo,String batchId) {
		try{
			
			ChatRecord ChatRecord = new ChatRecord(formUserID, formUserName, toUserID, toUserName, msgType, title, ptext, new Date(), "1", hotelId, hotelName, itemType, itemId, memo,batchId);
			chatRecordDao.save(ChatRecord);
		}catch(Exception e){
		}
	}
	
	/**
	 * 
	 * @param msgType
	 * @param title
	 * @param ptext
	 * @param hotelId
	 * @param hotelName
	 * @param itemType
	 * @param itemId
	 * @param memo
	 */
	@Transactional(readOnly = false)
	public void log(String msgType,String title, String ptext, Long hotelId, String hotelName, String itemType, String itemId, String memo) {
		String batchId = RandomStringUtil.getWthdrwNo(8);
		ChatRecord ChatRecord = new ChatRecord("", "", "", "", msgType, title, ptext, new Date(), "1", hotelId, hotelName, itemType, itemId, memo,batchId);
		chatRecordDao.save(ChatRecord);
	}

	public ChatRecord findByMsgTypeAndItemTypeAndItemId(String msgType, String itemType, String userId) {
		
		return chatRecordDao.findByMsgTypeAndItemTypeAndItemId(msgType, itemType, userId) ;
	}

	public ChatRecord findByToUserIDAndMsgTypeAndItemTypeAndItemIdAndTitle(String toUserID, String msgType,
			String itemType, String itemId, String title) {
		Map<String, Object> filterParams = Maps.newHashMap();
		filterParams.put("EQ_toUserID", toUserID);
		filterParams.put("EQ_msgType", msgType);
		filterParams.put("EQ_itemType", itemType);
		filterParams.put("EQ_itemId", itemId);
		filterParams.put("EQ_title", title);
		filterParams.put("GTE_createdAt", DateUtils.getDate());
		filterParams.put("LTE_createdAt", DateUtils.getDate()+" 23:59:59");
		List<ChatRecord> chatRecords = this.getEntities(filterParams);
		if(chatRecords!=null&&chatRecords.size()>0){
			return chatRecords.get(0);
		}
		return null;
	}
	
	@Transactional(readOnly = false)
	public void msgSend(String msgType, String rutype, String groupId, String userId, String hotelId, String title, String msg) {
		String suId = AccountUtils.getCurrentUserId();
		String suname = AccountUtils.getCurrentRName();
		String batchId = RandomStringUtil.getWthdrwNo(8);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if("1".equals(rutype)){
				List<User> users = userDao.findByState("1");
				for (User user : users) {
					ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", 0L, "HUI", "", null, "",batchId);
					chatRecordDao.save(ChatRecord);
				}
			}else if("2".equals(rutype)){
				String gids [] = groupId.split(",");
				for (String gid : gids) {
					Group group = this.groupDao.findOne(Long.valueOf(gid));
					List<User> users = group.getUsers();
					for (User user : users) {
						ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", 0L, "HUI", "", null, "",batchId);
						chatRecordDao.save(ChatRecord);
					}
				}
			}else if("3".equals(rutype)){
				String uids [] = userId.split(",");
				for (String uid : uids) {
					User user = this.userDao.findOne(uid);
					ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", 0L, "HUI", "", null, "",batchId);
					chatRecordDao.save(ChatRecord);
				}
			}else if("4".equals(rutype)){
				String hids [] = hotelId.split(",");
				for (String hid : hids) {
					List<User> users = userDao.findByStateAndHotelId("1",hid);
					for (User user : users) {
						ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", 0L, "HUI", "", null, "",batchId);
						chatRecordDao.save(ChatRecord);
					}
				}
			}
		}else{
			String chotelId = AccountUtils.getCurrentUserHotelId();
			Hotel hotel = this.hotelDao.findOne(Long.valueOf(chotelId));
			if("1".equals(rutype)){
				
				List<User> users = userDao.findByStateAndHotelId("1",AccountUtils.getCurrentUserHotelId());
				for (User user : users) {
					ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", hotel.getId(), hotel.getHotelName(), "", null, "",batchId);
					chatRecordDao.save(ChatRecord);
				}
			}else if("2".equals(rutype)){
				String gids [] = groupId.split(",");
				for (String gid : gids) {
					Group group = this.groupDao.findOne(Long.valueOf(gid));
					List<User> users = group.getUsers();
					for (User user : users) {
						ChatRecord ChatRecord = new ChatRecord(suId, suname, user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", hotel.getId(), hotel.getHotelName(), "", null, "",batchId);
						chatRecordDao.save(ChatRecord);
					}
				}
			}else if("3".equals(rutype)){
				String uids [] = userId.split(",");
				for (String uid : uids) {
					User user = this.userDao.findOne(uid);
					ChatRecord ChatRecord = new ChatRecord("SYSTEM", "SYSTEM", user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", hotel.getId(), hotel.getHotelName(), "", null, "",batchId);
					chatRecordDao.save(ChatRecord);
				}
			}else if("4".equals(rutype)){
				String hids [] = hotelId.split(",");
				for (String hid : hids) {
					List<User> users = userDao.findByStateAndHotelId("1",hid);
					for (User user : users) {
						ChatRecord chatRecord = new ChatRecord("SYSTEM", "SYSTEM", user.getId(), user.getRname(), msgType, title, msg, new Date(), "1", hotel.getId(), hotel.getHotelName(), "", null, "",batchId);
						chatRecordDao.save(chatRecord);
					}
				}
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void msgRead(String type, String ids,Map<String, Object> filterParams) {
		if("ALL".equals(type)){
			List<ChatRecord> chatRecords = this.getEntities(filterParams);
			for (ChatRecord chatRecord : chatRecords) {
				chatRecord.setState("0");
				chatRecordDao.save(chatRecord);
			}
		}else{
			String cids[] = ids.split(",");
			for (String cid : cids) {
				ChatRecord chatRecord = this.chatRecordDao.findOne(Long.valueOf(cid));
				chatRecord.setState("0");
				chatRecordDao.save(chatRecord);
			}
		}
	}

	public ChatRecord findByMsgTypeAndItemIdAndToUserID(String msgType, String itemId, String userId) {
		return chatRecordDao.findByMsgTypeAndItemIdAndToUserID(msgType,itemId,userId);
	}
	
	
	
	
}
