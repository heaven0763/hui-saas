package com.chuangbang.base.service.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.framework.service.BaseService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.service.CustomPageService;
import com.chuangbang.framework.util.hibernate.DynamicSqlHelper;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.entity.user.Message;
import com.chuangbang.app.model.MessageModel;
import com.chuangbang.base.dao.user.MessageDao;

/**
 * 留言Service
 * @author mabelxiao
 * @version 2016-11-16
 */
@Component
@Transactional(readOnly = true)
public class MessageService extends BaseService<Message,MessageDao> {

	@Autowired
	private MessageDao messageDao;
	@Autowired
	private CustomPageService customPageService;
	@Autowired
	private CusQueryService cusQueryService;
	
	public Message getEntity(Long id) {
		return messageDao.findOne(id);
	}
	
	@Transactional(readOnly = false)
	public void saveMessage(Message message) {
		if(message.getId()==null){
			message.setCreateDate(new Date());
			message.setMsgDate(new Date());
		}
		messageDao.save(message);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		messageDao.delete(id);
	}
	
	
	public List<MessageModel> getMessagePageList(PageBean<MessageModel> pageBean) {
		String columstr =" m.id as id, m.user_id as userId, m.user_name as userName, m.user_photo as userPhoto, m.item_type as itemType"
				+ ", m.item_id as itemId, m.msg as msg, m.msg_date as msgDate, m.pid as pid";
		String fromWhere = " from hui_message m where 1=1";
		return customPageService.page(pageBean, columstr, fromWhere, MessageModel.class,null);
	} 

	public List<MessageModel> getAllMessage(PageBean<MessageModel> pageBean) {
		String columstr =" m.id as id, m.user_id as userId, m.user_name as userName, m.user_photo as userPhoto, m.item_type as itemType"
				+ ", m.item_id as itemId, m.msg as msg, m.msg_date as msgDate, m.pid as pid";
		String fromWhere = " from hui_message m where 1=1";
		return customPageService.getAll(pageBean, columstr, fromWhere, MessageModel.class, null);
	}
	
	public MessageModel getMessage(Long id) {
		String columstr =" m.id as id, m.user_id as userId, m.user_name as userName, m.user_photo as userPhoto, m.item_type as itemType"
				+ ", m.item_id as itemId, m.msg as msg, m.msg_date as msgDate, m.pid as pid";
		String fromWhere = " from hui_message m where 1=1 and m.id="+id;
		return customPageService.getOne(columstr, fromWhere, MessageModel.class);
	}
	
	public List<Message> getPageMessageList(PageBean<Message> pageBean) {
		String columstr =DynamicSqlHelper.getMappingColumnStr("m.", Message.class);
		columstr+="h.hotel_name hName";
		columstr = columstr.replace("m.msg_type msgType", "c.name msgType");
		String fromWhere = " from hui_message m left join hui_hotel h on h.id=m.hotel_id"
				+ " left join hui_category c on c.val = m.msg_type and kind ='MSGTYPE' where 1=1 ";
		
		pageBean.setSort("m.msg_type,m.msg_date");
		pageBean.setOrder("asc,desc");
		return cusQueryService.page(pageBean, columstr+fromWhere, Message.class,null);
	} 

	public Message getOneMessage(Long id) {
		String columstr =DynamicSqlHelper.getMappingColumnStr("m.", Message.class);
		columstr+="h.hotel_name hName";
		columstr = columstr.replace("m.msg_type msgType", "c.name msgType");
		String fromWhere = " from hui_message m left join hui_hotel h on h.id=m.hotel_id"
				+ " left join hui_category c on c.val = m.msg_type and kind ='MSGTYPE' where m.id= "+id;
		
		return cusQueryService.getOne(columstr+fromWhere, Message.class, null);
	} 
	
}
