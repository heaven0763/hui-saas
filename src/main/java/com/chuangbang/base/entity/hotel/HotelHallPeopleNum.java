package com.chuangbang.base.entity.hotel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;

/**
 * 大厅容纳人数Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_hotelHallPeopleNum")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelHallPeopleNum extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 大厅编号
	 */
	private Long hallId;
	/**
	 * 摆放编号
	 */
	private Long displayId; 
	/**
	 * 摆放图标
	 */
	private String 	putImg;

	/**
	 * 摆放方式
	 */
	private String putType;  
	
	/**
	 * 人数
	 */
	private Long peopleNum;  
	
  
    public Long getHallId(){  
      return hallId;  
    }  
    public void setHallId(Long hallId){  
      this.hallId = hallId;  
    }  
    
    @Column(length=50)
    public String getPutType(){  
      return putType;  
    }  
    public void setPutType(String putType){  
      this.putType = putType;  
    }  
  
    public Long getPeopleNum(){  
      return peopleNum;  
    }  
    public void setPeopleNum(Long peopleNum){  
      this.peopleNum = peopleNum;  
    }
    
    @Column(length=200)
	public String getPutImg() {
		return putImg;
	}
	public void setPutImg(String putImg) {
		this.putImg = putImg;
	}
	public HotelHallPeopleNum() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Long getDisplayId() {
		return displayId;
	}
	public void setDisplayId(Long displayId) {
		this.displayId = displayId;
	}  
	
	public HotelHallPeopleNum(Long hallId, Long displayId, String putImg, String putType, Long peopleNum) {
		super();
		this.hallId = hallId;
		this.displayId = displayId;
		this.putImg = putImg;
		this.putType = putType;
		this.peopleNum = peopleNum;
	}
    
    
}


