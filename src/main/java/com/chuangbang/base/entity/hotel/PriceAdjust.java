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
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 场地价格调整Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_price_adjust")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PriceAdjust extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 审核编号
	 */
	private Long auditId;
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
	 * 申请状态
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
	 * 调整价格开始日期
	 */
	private String adjustSdate;  
	
	/**
	 * 调整价格结束日期
	 */
	private String adjustEdate;  
	
	/**
	 * 线上价格调整前
	 */
	private Double onlinePriceBefore;  
	
	/**
	 * 线上价格调整后
	 */
	private Double onlinePriceAfter;  
	
	/**
	 * 线上价格调整比例
	 */
	private Double onlinePriceRate;  
	
	/**
	 * 线下价格调整前
	 */
	private Double offlinePriceBefore;  
	
	/**
	 * 线下价格调整后
	 */
	private Double offlinePriceAfter;  
	
	/**
	 * 线下价格调整比例
	 */
	private Double offlinePriceRate;  
	
	/**
	 * 线上、线下调整比调整前
	 */
	private Double priceBeforeRate;  
	
	/**
	 * 线上、线下调整比调整后
	 */
	private Double priceAfterRate;  
	
	/**
	 * 线上、线下调整比调整比例
	 */
	private Double adjustRate;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
	
    public Long getAuditId() {
		return auditId;
	}

	public void setAuditId(Long auditId) {
		this.auditId = auditId;
	}

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
    @Column(length=50)
    public String getAdjustSdate(){  
      return adjustSdate;  
    }  
    
    public void setAdjustSdate(String adjustSdate){  
      this.adjustSdate = adjustSdate;  
    }  
    @Column(length=50)
    public String getAdjustEdate(){  
      return adjustEdate;  
    }  
    
    public void setAdjustEdate(String adjustEdate){  
      this.adjustEdate = adjustEdate;  
    }  
  
    public Double getOnlinePriceBefore(){  
      return onlinePriceBefore;  
    }  
    
    public void setOnlinePriceBefore(Double onlinePriceBefore){  
      this.onlinePriceBefore = onlinePriceBefore;  
    }  
  
    public Double getOnlinePriceAfter(){  
      return onlinePriceAfter;  
    }  
    
    public void setOnlinePriceAfter(Double onlinePriceAfter){  
      this.onlinePriceAfter = onlinePriceAfter;  
    }  
  
    public Double getOnlinePriceRate(){  
      return onlinePriceRate;  
    }  
    
    public void setOnlinePriceRate(Double onlinePriceRate){  
      this.onlinePriceRate = onlinePriceRate;  
    }  
  
    public Double getOfflinePriceBefore(){  
      return offlinePriceBefore;  
    }  
    
    public void setOfflinePriceBefore(Double offlinePriceBefore){  
      this.offlinePriceBefore = offlinePriceBefore;  
    }  
  
    public Double getOfflinePriceAfter(){  
      return offlinePriceAfter;  
    }  
    
    public void setOfflinePriceAfter(Double offlinePriceAfter){  
      this.offlinePriceAfter = offlinePriceAfter;  
    }  
  
    public Double getOfflinePriceRate(){  
      return offlinePriceRate;  
    }  
    
    public void setOfflinePriceRate(Double offlinePriceRate){  
      this.offlinePriceRate = offlinePriceRate;  
    }  
  
    public Double getPriceBeforeRate(){  
      return priceBeforeRate;  
    }  
    
    public void setPriceBeforeRate(Double priceBeforeRate){  
      this.priceBeforeRate = priceBeforeRate;  
    }  
  
    public Double getPriceAfterRate(){  
      return priceAfterRate;  
    }  
    
    public void setPriceAfterRate(Double priceAfterRate){  
      this.priceAfterRate = priceAfterRate;  
    }  
  
    public Double getAdjustRate(){  
      return adjustRate;  
    }  
    public void setAdjustRate(Double adjustRate){  
      this.adjustRate = adjustRate;  
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

	public PriceAdjust(Long hotelId, String hotelName, Long placeId, String placeName, String state, String applyUserId,
			String applyUserName, Date applyDate, String adjustSdate, String adjustEdate, Double onlinePriceBefore,
			Double onlinePriceAfter, Double onlinePriceRate, Double offlinePriceBefore, Double offlinePriceAfter,
			Double offlinePriceRate, Double priceBeforeRate, Double priceAfterRate, Double adjustRate, Date createDate,
			String memo) {
		super();
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.placeId = placeId;
		this.placeName = placeName;
		this.state = state;
		this.applyUserId = applyUserId;
		this.applyUserName = applyUserName;
		this.applyDate = applyDate;
		this.adjustSdate = adjustSdate;
		this.adjustEdate = adjustEdate;
		this.onlinePriceBefore = onlinePriceBefore;
		this.onlinePriceAfter = onlinePriceAfter;
		this.onlinePriceRate = onlinePriceRate;
		this.offlinePriceBefore = offlinePriceBefore;
		this.offlinePriceAfter = offlinePriceAfter;
		this.offlinePriceRate = offlinePriceRate;
		this.priceBeforeRate = priceBeforeRate;
		this.priceAfterRate = priceAfterRate;
		this.adjustRate = adjustRate;
		this.createDate = createDate;
		this.memo = memo;
	}

	public PriceAdjust() {
		super();
	}

	
}


