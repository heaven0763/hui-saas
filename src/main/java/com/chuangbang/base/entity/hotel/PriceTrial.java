package com.chuangbang.base.entity.hotel;

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
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 场地价格调整Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_price_trial")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PriceTrial extends IdEntity implements Serializable {
	
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
	 * 场地编号
	 */
	private Long placeId;  
	
	/**
	 * 场地名称
	 */
	private String placeName;  
	
	/**
	 * 申请状态    0:初始状态；1：初审通过;2:终审通过；3：初审不通过；4：终审不通过
	 */
	private String state;  
	
	/**
	 * 提交人员编号
	 */
	private String applyUserId;  
	
	/**
	 * 提交人员姓名
	 */
	private String applyUserName;  
	
	/**
	 * 提交时间
	 */
	@JsonFormat(pattern="yyyy-MM-dd", timezone="GMT+08:00")
	private Date applyDate;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  

	/**
	 * 调整价格开始日期
	 */
	private String adjustSdate;  
	
	/**
	 * 调整价格结束日期
	 */
	private String adjustEdate; 
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date trialDate;
	
	private String trialUserId;
	
	private String trialUserName;
	
	private String trialReason;
	/**
	 * 1：初审通过；2：不通过
	 */
	private String trialState;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT+08:00")
	private Date finalDate;
	
	private String finalUserId;
	
	private String finalUserName;
	
	private String finalReason;
	/**
	 * 1：终审通过；2：不通过
	 */
	private String finalState;
	
	private String area;
	/**
	 * 价格类型
	 */
	private String priceType;
  
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
    @Column(length=50)
    public String getHotelName(){  
      return hotelName;  
    }  
    
    public void setHotelName(String hotelName){  
      this.hotelName = hotelName;  
    }  
  
    public Long getPlaceId(){  
      return placeId;  
    }  
    
    public void setPlaceId(Long placeId){  
      this.placeId = placeId;  
    }  
    @Column(length=50)
    public String getPlaceName(){  
      return placeName;  
    }  
    
    public void setPlaceName(String placeName){  
      this.placeName = placeName;  
    }  
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
    }  
    @Column(length=50)
    public String getApplyUserId(){  
      return applyUserId;  
    }  
    
    public void setApplyUserId(String applyUserId){  
      this.applyUserId = applyUserId;  
    }  
    @Column(length=50)
    public String getApplyUserName(){  
      return applyUserName;  
    }  
    
    public void setApplyUserName(String applyUserName){  
      this.applyUserName = applyUserName;  
    }  
    public Date getApplyDate(){  
      return applyDate;  
    }  
    
    public void setApplyDate(Date applyDate){  
      this.applyDate = applyDate;  
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

	public PriceTrial(Long hotelId, String hotelName, Long placeId, String placeName, String state, String applyUserId,
			String applyUserName, Date applyDate, Date createDate,String memo) {
		super();
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.placeId = placeId;
		this.placeName = placeName;
		this.state = state;
		this.applyUserId = applyUserId;
		this.applyUserName = applyUserName;
		this.applyDate = applyDate;
		this.createDate = createDate;
		this.memo = memo;
	}

	public PriceTrial() {
		super();
	}
	public Date getTrialDate() {
		return trialDate;
	}

	public void setTrialDate(Date trialDate) {
		this.trialDate = trialDate;
	}
	public String getTrialUserId() {
		return trialUserId;
	}

	public void setTrialUserId(String trialUserId) {
		this.trialUserId = trialUserId;
	}
	public String getTrialUserName() {
		return trialUserName;
	}

	public void setTrialUserName(String trialUserName) {
		this.trialUserName = trialUserName;
	}

	public String getTrialReason() {
		return trialReason;
	}

	public void setTrialReason(String trialReason) {
		this.trialReason = trialReason;
	}

	public String getTrialState() {
		return trialState;
	}

	public void setTrialState(String trialState) {
		this.trialState = trialState;
	}

	public Date getFinalDate() {
		return finalDate;
	}

	public void setFinalDate(Date finalDate) {
		this.finalDate = finalDate;
	}

	public String getFinalUserId() {
		return finalUserId;
	}

	public void setFinalUserId(String finalUserId) {
		this.finalUserId = finalUserId;
	}

	public String getFinalUserName() {
		return finalUserName;
	}

	public void setFinalUserName(String finalUserName) {
		this.finalUserName = finalUserName;
	}

	public String getFinalReason() {
		return finalReason;
	}

	public void setFinalReason(String finalReason) {
		this.finalReason = finalReason;
	}

	public String getFinalState() {
		return finalState;
	}

	public void setFinalState(String finalState) {
		this.finalState = finalState;
	}

	@Transient
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}

	public String getAdjustSdate() {
		return adjustSdate;
	}
	public void setAdjustSdate(String adjustSdate) {
		this.adjustSdate = adjustSdate;
	}

	public String getAdjustEdate() {
		return adjustEdate;
	}
	public void setAdjustEdate(String adjustEdate) {
		this.adjustEdate = adjustEdate;
	}

	public String getPriceType() {
		return priceType;
	}
	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}
	
}


