package com.chuangbang.base.entity.user;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 消息记录Entity
 * @author HeavenChen
 * @version 2016-09-21
 */
@Entity
@Table(name = "hui_chat_record")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ChatRecord extends IdEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;


	/**
	 * 酒店编号
	 */
	private Long hotelId; 
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	/**
	 * 发送者编号
	 */
	private String formUserID;  
	
	/**
	 * 发送者姓名
	 */
	private String formUserName;  
	
	
	/**
	 * 接收者
	 */
	private String toUserID;  
	
	/**
	 * 接收者姓名
	 */
	private String toUserName;  
	
	
	/**
	 * 消息类型  提醒消息：ALERTMSG；系统消息：SYSTEMMSG
	 */
	private String msgType;  
	
	/**
	 * 消息标题
	 */
	private String title;  
	
	/**
	 * 消息内容
	 */
	private String ptext;  
	
	/**
	 * 发送时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date createdAt;  
	
	/**
	 * 状态 1：未读，0已读
	 */
	private String state;  
	
	/**
	 * 栏目类型 对应实体名
	 */
	private String itemType;  
	
	/**
	 * 栏目编号
	 */
	private String itemId;  
	
	/**
	 * 栏目名称	
	 */
	private String itemName;  
	
	/**
	 * 介绍
	 */
	private String itemDesc;  
	
	/**
	 * 图片
	 */
	private String img;  
	
	/**
	 * 备注	
	 */
	private String memo;  
	/**
	 * 发送批次编号	
	 */
	private String batchId;
	
	@Column(length=50)
    public String getFormUserID(){  
      return formUserID;  
    }  
    
    public void setFormUserID(String formUserID){  
      this.formUserID = formUserID;  
    }  
    @Column(length=50)
    public String getFormUserName(){  
      return formUserName;  
    }  
    
    public void setFormUserName(String formUserName){  
      this.formUserName = formUserName;  
    }  
  
    @Column(length=50)
    public String getToUserID(){  
      return toUserID;  
    }  
    
    public void setToUserID(String toUserID){  
      this.toUserID = toUserID;  
    }  
    @Column(length=50)
    public String getToUserName(){  
      return toUserName;  
    }  
    public void setToUserName(String toUserName){  
      this.toUserName = toUserName;  
    }  
    
    @Column(length=5)
    public String getMsgType(){  
      return msgType;  
    }  
    public void setMsgType(String msgType){  
      this.msgType = msgType;  
    }  
    
    @Column(length=200)
    public String getTitle(){  
      return title;  
    }  
    public void setTitle(String title){  
      this.title = title;  
    }  
    
    @Column(columnDefinition="text")
    public String getPtext(){  
      return ptext;  
    }  
    public void setPtext(String ptext){  
      this.ptext = ptext;  
    }  
  
    public Date getCreatedAt(){  
      return createdAt;  
    }  
    public void setCreatedAt(Date createdAt){  
      this.createdAt = createdAt;  
    } 
    
    @Column(length=5)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
    
    @Column(length=20)
    public String getItemType(){  
      return itemType;  
    }  
    public void setItemType(String itemType){  
      this.itemType = itemType;  
    }  
    
    @Column(length=50)
    public String getItemId(){  
      return itemId;  
    }  
    public void setItemId(String itemId){  
      this.itemId = itemId;  
    }  
    
    @Column(length=50)
    public String getItemName(){  
      return itemName;  
    }  
    public void setItemName(String itemName){  
      this.itemName = itemName;  
    } 
    
    @Column(length=500)
    public String getItemDesc(){  
      return itemDesc;  
    }  
    public void setItemDesc(String itemDesc){  
      this.itemDesc = itemDesc;  
    } 
    
    @Column(length=500)
    public String getImg(){  
      return img;  
    }  
    public void setImg(String img){  
      this.img = img;  
    }  
    
    @Column(length=500)
    public String getMemo(){  
      return memo;  
    }  
    public void setMemo(String memo){  
      this.memo = memo;  
    }
	
	public Long getHotelId() {
		return hotelId;
	}
	public void setHotelId(Long hotelId) {
		this.hotelId = hotelId;
	}
	
	@Column(length=50)
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	
	public ChatRecord() {
		super();
	}	
	
	public ChatRecord(String formUserID, String formUserName, String toUserID, String toUserName, String msgType,
			String title, String ptext, Date createdAt, String state, Long hotelId, String hotelName, String itemType,
			String itemId, String memo,String batchId) {
		super();
		this.formUserID = formUserID;
		this.formUserName = formUserName;
		this.toUserID = toUserID;
		this.toUserName = toUserName;
		this.msgType = msgType;
		this.title = title;
		this.ptext = ptext;
		this.createdAt = createdAt;
		this.state = state;
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.itemType = itemType;
		this.itemId = itemId;
		this.memo = memo;
	}

	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	
	
}


