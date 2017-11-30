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

/**
 * 审核表Entity
 * @author mabelxiao
 * @version 2016-11-15
 */
@Entity
@Table(name = "hui_audit")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Audit extends IdEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 审核类型
	 */
	private String auditType;  
	
	/**
	 * 审核事项编号
	 */
	private String itemId;  
	
	/**
	 * 区域
	 */
	private String area;  
	
	/**
	 * 酒店编号
	 */
	private Long hotelId;  
	
	/**
	 * 酒店名称
	 */
	private String hotelName;  
	
	/**
	 * 申请状态
	 */
	private String state;  
	
	/**
	 * 返佣比例原比例
	 */
	private String commissionOldRate;  
	
	/**
	 * 返佣比例现比例
	 */
	private String commissionNewRate;  
	
	/**
	 * 调整原因
	 */
	private String auditReason;  
	
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
	private Date applyDate;  
	
	/**
	 * 提交意见
	 */
	private String applyReason;  
	
	/**
	 * 初审人员编号
	 */
	private String firstTrialUserId;  
	
	/**
	 * 初审人员姓名
	 */
	private String firstTrialUserName;  
	
	/**
	 * 初审时间
	 */
	private Date firstTrialDate;  
	
	/**
	 * 初审意见
	 */
	private String firstTrialReason;  
	
	/**
	 * 复审人员编号
	 */
	private String reviewUserId;  
	
	/**
	 * 复审人员姓名
	 */
	private String reviewUserName;  
	
	/**
	 * 复审时间
	 */
	private Date reviewDate;  
	
	/**
	 * 复审意见
	 */
	private String reviewReason;  
	
	/**
	 * 创建时间
	 */
	private Date createDate;  
	
	/**
	 * 备注
	 */
	private String memo;  
	
   @Column(length=50)
    public String getAuditType(){  
      return auditType;  
    }  
    public void setAuditType(String auditType){  
      this.auditType = auditType;  
    }  
    @Column(length=50)
    public String getItemId(){  
      return itemId;  
    }  
    public void setItemId(String itemId){  
      this.itemId = itemId;  
    }  
    @Column(length=50)
    public String getArea(){  
      return area;  
    }  
    public void setArea(String area){  
      this.area = area;  
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
    @Column(length=50)
    public String getState(){  
      return state;  
    }  
    public void setState(String state){  
      this.state = state;  
    }  
    @Column(length=50)
    public String getCommissionOldRate(){  
      return commissionOldRate;  
    }  
    public void setCommissionOldRate(String commissionOldRate){  
      this.commissionOldRate = commissionOldRate;  
    }  
    @Column(length=50)
    public String getCommissionNewRate(){  
      return commissionNewRate;  
    }  
    public void setCommissionNewRate(String commissionNewRate){  
      this.commissionNewRate = commissionNewRate;  
    }  
    @Column(length=500)
    public String getAuditReason(){  
      return auditReason;  
    }  
    public void setAuditReason(String auditReason){  
      this.auditReason = auditReason;  
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
    
    @Column(length=500)
    public String getApplyReason(){  
      return applyReason;  
    }  
    public void setApplyReason(String applyReason){  
      this.applyReason = applyReason;  
    }  
    
    @Column(length=50)
    public String getFirstTrialUserId(){  
      return firstTrialUserId;  
    }  
    public void setFirstTrialUserId(String firstTrialUserId){  
      this.firstTrialUserId = firstTrialUserId;  
    }  
  
    @Column(length=50)
    public String getFirstTrialUserName(){  
      return firstTrialUserName;  
    }  
    public void setFirstTrialUserName(String firstTrialUserName){  
      this.firstTrialUserName = firstTrialUserName;  
    }  
  
    public Date getFirstTrialDate(){  
      return firstTrialDate;  
    }  
    public void setFirstTrialDate(Date firstTrialDate){  
      this.firstTrialDate = firstTrialDate;  
    }  
  
    @Column(length=500)
    public String getFirstTrialReason(){  
      return firstTrialReason;  
    }  
    public void setFirstTrialReason(String firstTrialReason){  
      this.firstTrialReason = firstTrialReason;  
    }  
  
    @Column(length=50)
    public String getReviewUserId(){  
      return reviewUserId;  
    }  
    public void setReviewUserId(String reviewUserId){  
      this.reviewUserId = reviewUserId;  
    }  
  
    @Column(length=50)
    public String getReviewUserName(){  
      return reviewUserName;  
    }  
    public void setReviewUserName(String reviewUserName){  
      this.reviewUserName = reviewUserName;  
    }  
  
    public Date getReviewDate(){  
      return reviewDate;  
    }  
    public void setReviewDate(Date reviewDate){  
      this.reviewDate = reviewDate;  
    }  
    
    @Column(length=500)
    public String getReviewReason(){  
      return reviewReason;  
    }  
    public void setReviewReason(String reviewReason){  
      this.reviewReason = reviewReason;  
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
}


