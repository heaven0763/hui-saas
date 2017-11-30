package com.chuangbang.base.entity.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 留言/评论
 * @author mabelxiao
 * @version 2016-11-16
 */
@Entity
@Table(name = "hui_message")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Message extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 酒店编号
	 */
	private Long hotelId;
	/**
	 * 会员编号
	 */
	private String userId;  
	/**
	 * 会员姓名
	 */
	private String userName; 
	/**
	 * 会员头像
	 */
	private String userPhoto;
	/**
	 * 会员联系方式
	 */
	private String mobile;
	/**
	 * 会员邮箱
	 */
	private String email;
	/**
	 * 订单编号
	 */
	private String orderNo;
	
	/**
	 * 留言、评论类型     咨询：CONSULT、评论:COMMENT、留言:MESSAGE、订单投诉:ORDERCOMPLAINT、反馈:FEEDBACK
	 */
	private String msgType;  
	
	/**
	 * 留言主体类型  HOTEL,HALL,ROOM,HOTELDYNAMICE
	 */
	private String itemType;
	/**
	 * 留言主体
	 */
	private String itemId;  
	
	/**
	 * 留言
	 */
	private String msg;  
	
	
	/**
	 * 留言日期
	 */
	private Date msgDate;  
	
	/**
	 * 留言状态
	 */
	private String state;  
	
	/**
	 * 父编号
	 */
	@JsonIgnore
	private Long pid;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	/**
	 * 酒店名称
	 */
	private String hName;  
	/**
	 * 酒店名称
	 */
	private Object item;
	public Long getHotelId() {
		return hotelId;
	}
	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}
	@Column(length=50)
    public String getMsgType(){  
      return msgType;  
    }  
    public void setMsgType(String msgType){  
      this.msgType = msgType;  
    }  
    
    @Column(length=50)
    public String getItemId(){  
      return itemId;  
    }  
    public void setItemId(String itemId){  
      this.itemId = itemId;  
    }  
  
    @Column(length=50)
    public String getUserId(){  
      return userId;  
    }  
    public void setUserId(String userId){  
      this.userId = userId;  
    }  
  
    @Column(length=500)
    public String getMsg(){  
      return msg;  
    }  
    public void setMsg(String msg){  
      this.msg = msg;  
    }  
  
    public Date getMsgDate(){  
      return msgDate;  
    }  
    public void setMsgDate(Date msgDate){  
      this.msgDate = msgDate;  
    }  
  
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
  
    public Long getPid(){  
      return pid;  
    }  
    public void setPid(Long pid){  
      this.pid = pid;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
  
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
    @Column(length=50)
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	@Column(length=500)
	public String getUserPhoto() {
		return userPhoto;
	}
	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}
	
	
	@Column(length=50)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	@Column(length=50)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Column(length=50)
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	@Column(length=50)
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	
	
	public Message() {
		super();
	}
	public Message(String msgType,String itemType, String itemId, String userId, String userName, String userPhoto, String msg,String state) {
		super();
		this.msgType = msgType;
		this.itemType = itemType;
		this.itemId = itemId;
		this.userId = userId;
		this.userName = userName;
		this.userPhoto = userPhoto;
		this.msg = msg;
		this.state = state;
	}
	
	public Message(Long hotelId,String userId, String userName, String userPhoto, String mobile, String email, String orderNo,
			String msgType, String itemType, String itemId, String msg, Date msgDate, String state, Date createDate,
			String memo) {
		super();
		this.hotelId = hotelId;
		this.userId = userId;
		this.userName = userName;
		this.userPhoto = userPhoto;
		this.mobile = mobile;
		this.email = email;
		this.orderNo = orderNo;
		this.msgType = msgType;
		this.itemType = itemType;
		this.itemId = itemId;
		this.msg = msg;
		this.msgDate = msgDate;
		this.state = state;
		this.createDate = createDate;
		this.memo = memo;
	}
	
	public Message(Long hotelId,String userId, String userName, String userPhoto, String mobile, String email, String orderNo,
			String msgType, String itemType, String itemId, String msg,String state) {
		super();
		this.hotelId = hotelId;
		this.userId = userId;
		this.userName = userName;
		this.userPhoto = userPhoto;
		this.mobile = mobile;
		this.email = email;
		this.orderNo = orderNo;
		this.msgType = msgType;
		this.itemType = itemType;
		this.itemId = itemId;
		this.msg = msg;
		this.state = state;
	}
	
	@Transient
	public String gethName() {
		return hName;
	}
	public void sethName(String hName) {
		this.hName = hName;
	}
	
	@Transient
	public Object getItem() {
		return item;
	}
	public void setItem(Object item) {
		this.item = item;
	}
    
}


