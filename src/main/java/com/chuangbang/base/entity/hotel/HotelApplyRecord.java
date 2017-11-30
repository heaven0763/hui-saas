package com.chuangbang.base.entity.hotel;

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

/**
 * 申请加入酒店记录Entity
 * @author xtp
 * @version 2017-08-09
 */
@Entity
@Table(name = "hui_apply_record")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotelApplyRecord extends IdEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    /**
	 * 用户id
	 */
    private String userId;
    /**
	 * 酒店id
	 */
    private Long hotelID;
    /**
	 * 申请状态   0 未审核     1审核通过    2审核不通过   3撤销申请
	 */
    private String state;
    
    private Date applyDate;
    
    private Date checkDate;
    
    private String temp;
    private String type;
    
   /* @Column(name="id")
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}*/
	
	@Column(name="user_id")
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@Column(name="hotel_id")
	public Long getHotelID() {
		return hotelID;
	}
	public void setHotelID(Long hotelID) {
		this.hotelID = hotelID;
	}
	
	@Column(name="state")
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	@Column(name="apply_date")
	public Date getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	@Column(name="check_date")
	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public HotelApplyRecord() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HotelApplyRecord(String userId, Long hotelID, String state, Date applyDate,String type) {
		super();
		this.userId = userId;
		this.hotelID = hotelID;
		this.state = state;
		this.applyDate = applyDate;
		this.type = type;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}


