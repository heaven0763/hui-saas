package com.chuangbang.base.entity.order;

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
 * 返佣记录Entity
 * @author heaven
 * @version 2017-03-08
 */
@Entity
@Table(name = "hui_comissionRecord")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ComissionRecord extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 所属酒店
	 */
	private Long hotelId;  
	
	/**
	 * 订单编号
	 */
	private String orderNo;  
	/**
	 * 返佣类型
	 */
	private String type;  
	
	
	/**
	 * 订单金额
	 */
	private Double amount;  
	/**
	 * 场地费用
	 */
	private Double meetingAmount;  
	/**
	 * 住房费用
	 */
	private Double houseAmount;  
	/**
	 * 用餐费用
	 */
	private Double dinnerAmount;  
	/**
	 * 其他费用
	 */
	private Double otherAmount;  
	
	
	/**
	 * 住房返佣比例
	 */
	private Double housingCommissionRate;  
	
	/**
	 * 住房返佣
	 */
	private Double housingCommission;  
	
	/**
	 * 餐饮返佣比例
	 */
	private Double dinnerCommissionRate;  
	
	/**
	 * 餐饮返佣
	 */
	private Double dinnerCommission;  
	
	/**
	 * 会议室返佣比例
	 */
	private Double mettingRoomCommissionRate;  
	
	/**
	 * 会议室返佣
	 */
	private Double mettingRoomCommission;  
	
	/**
	 * 其他返佣比例
	 */
	private Double ortherCommissionRate;  
	
	/**
	 * 其他返佣
	 */
	private Double ortherCommission;  
	
	/**
	 * 全单返佣比例
	 */
	private Double allCommissionRate;  
	
	/**
	 * 全单返佣
	 */
	private Double allCommission;  
	
	/**
	 * 佣金总额
	 */
	private Double commissionAmount;  
	
	/**
	 * 状态
	 */
	private String state;  
	
	/**
	 * 审核日期
	 */
	private Date checkDate;  
	
	/**
	 * 审核备注
	 */
	private String checkMemo;  
	
	/**
	 * 创建日期
	 */
	private Date createDate;  
	
	/**
	 * 创建日期
	 */
	private String createUserId;  
	
	/**
	 * 创建日期
	 */
	private String createUserName;  
	
	/**
	 * 备注
	 */
	private String memo;  
	/**
	 * 开票人
	 */
	private String invoiceUname;  
	
	/**
	 * 开具发票号码
	 */
	private String invoiceNo;  
	
	/**
	 * 开具日期
	 */
	private Date invoiceDate; 
	
	/**
	 * 开票操作人编号
	 */
	private String invoiceOpUserId;  
	
	/**
	 * 开票操作人姓名
	 */
	private String invoiceOpUserName;
	/**
	 * 创建日期
	 */
	private Date updateDate;  
	
	/**
	 * 创建人员编号
	 */
	private String updateUserId;  
	
	/**
	 * 创建人员姓名
	 */
	private String updateUserName;  
	/**
	 * 
	 */
	private String isupdate;
	/**
	 * 
	 */
	private Long updateId;
	
	/**
	 * 
	 */
	private String transferRemark;
	/**
	 * 创建日期
	 */
	private Date transferDate;
	
	/**
	 * 原始订单金额
	 */
	private Double originAmount;  
	/**
	 * 原始场地费用
	 */
	private Double originMeetingAmount;  
	/**
	 * 原始住房费用
	 */
	private Double originHouseAmount;  
	/**
	 * 原始用餐费用
	 */
	private Double originDinnerAmount;  
	/**
	 * 原始其他费用
	 */
	private Double originOtherAmount;
	
	
	/**
	 * 原始会议室返佣比例
	 */
	private Double originMettingRoomCommissionRate;  
	/**
	 * 原始住房返佣比例
	 */
	private Double originHousingCommissionRate;
	/**
	 * 原始餐饮返佣比例
	 */
	private Double originDinnerCommissionRate; 
	/**
	 * 原始其他返佣比例
	 */
	private Double originOrtherCommissionRate; 
	
	/**
	 * 原始全单返佣比例
	 */
	private Double originAllCommissionRate;  
	
    public Long getHotelId(){  
      return hotelId;  
    }  
    
    public void setHotelId(Long hotelId){  
      this.hotelId = hotelId;  
    }  
  
    public String getOrderNo(){  
      return orderNo;  
    }  
    
    public void setOrderNo(String orderNo){  
      this.orderNo = orderNo;  
    }  
  
    public Double getAmount(){  
      return amount;  
    }  
    
    public void setAmount(Double amount){  
      this.amount = amount;  
    }  
  
    public String getType(){  
      return type;  
    }  
    
    public void setType(String type){  
      this.type = type;  
    }  
  
    public Double getHousingCommissionRate(){  
      return housingCommissionRate;  
    }  
    
    public void setHousingCommissionRate(Double housingCommissionRate){  
      this.housingCommissionRate = housingCommissionRate;  
    }  
  
    public Double getHousingCommission(){  
      return housingCommission;  
    }  
    
    public void setHousingCommission(Double housingCommission){  
      this.housingCommission = housingCommission;  
    }  
  
    public Double getDinnerCommissionRate(){  
      return dinnerCommissionRate;  
    }  
    
    public void setDinnerCommissionRate(Double dinnerCommissionRate){  
      this.dinnerCommissionRate = dinnerCommissionRate;  
    }  
  
    public Double getDinnerCommission(){  
      return dinnerCommission;  
    }  
    
    public void setDinnerCommission(Double dinnerCommission){  
      this.dinnerCommission = dinnerCommission;  
    }  
  
    public Double getMettingRoomCommissionRate(){  
      return mettingRoomCommissionRate;  
    }  
    
    public void setMettingRoomCommissionRate(Double mettingRoomCommissionRate){  
      this.mettingRoomCommissionRate = mettingRoomCommissionRate;  
    }  
  
    public Double getMettingRoomCommission(){  
      return mettingRoomCommission;  
    }  
    
    public void setMettingRoomCommission(Double mettingRoomCommission){  
      this.mettingRoomCommission = mettingRoomCommission;  
    }  
  
    public Double getOrtherCommissionRate(){  
      return ortherCommissionRate;  
    }  
    
    public void setOrtherCommissionRate(Double ortherCommissionRate){  
      this.ortherCommissionRate = ortherCommissionRate;  
    }  
  
    public Double getOrtherCommission(){  
      return ortherCommission;  
    }  
    
    public void setOrtherCommission(Double ortherCommission){  
      this.ortherCommission = ortherCommission;  
    }  
  
    public Double getAllCommissionRate(){  
      return allCommissionRate;  
    }  
    
    public void setAllCommissionRate(Double allCommissionRate){  
      this.allCommissionRate = allCommissionRate;  
    }  
  
    public Double getAllCommission(){  
      return allCommission;  
    }  
    
    public void setAllCommission(Double allCommission){  
      this.allCommission = allCommission;  
    }  
  
    public Double getCommissionAmount(){  
      return commissionAmount;  
    }  
    
    public void setCommissionAmount(Double commissionAmount){  
      this.commissionAmount = commissionAmount;  
    }  
  
    public String getState(){  
      return state;  
    }  
    
    public void setState(String state){  
      this.state = state;  
    }  
  
    public Date getCheckDate(){  
      return checkDate;  
    }  
    
    public void setCheckDate(Date checkDate){  
      this.checkDate = checkDate;  
    }  
  
    public String getCheckMemo(){  
      return checkMemo;  
    }  
    
    public void setCheckMemo(String checkMemo){  
      this.checkMemo = checkMemo;  
    }  
  
    public Date getCreateDate(){  
      return createDate;  
    }  
    
    public void setCreateDate(Date createDate){  
      this.createDate = createDate;  
    }  
  
    public String getCreateUserId(){  
      return createUserId;  
    }  
    
    public void setCreateUserId(String createUserId){  
      this.createUserId = createUserId;  
    }  
  
    public String getCreateUserName(){  
      return createUserName;  
    }  
    
    public void setCreateUserName(String createUserName){  
      this.createUserName = createUserName;  
    }  
  
    public String getMemo(){  
      return memo;  
    }  
    
    public void setMemo(String memo){  
      this.memo = memo;  
    }
    
	public String getInvoiceUname() {
		return invoiceUname;
	}

	public void setInvoiceUname(String invoiceUname) {
		this.invoiceUname = invoiceUname;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getInvoiceOpUserId() {
		return invoiceOpUserId;
	}

	public void setInvoiceOpUserId(String invoiceOpUserId) {
		this.invoiceOpUserId = invoiceOpUserId;
	}

	public String getInvoiceOpUserName() {
		return invoiceOpUserName;
	}

	public void setInvoiceOpUserName(String invoiceOpUserName) {
		this.invoiceOpUserName = invoiceOpUserName;
	}

	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}

	public String getUpdateUserName() {
		return updateUserName;
	}
	public void setUpdateUserName(String updateUserName) {
		this.updateUserName = updateUserName;
	}

	public Double getMeetingAmount() {
		return meetingAmount;
	}

	public void setMeetingAmount(Double meetingAmount) {
		this.meetingAmount = meetingAmount;
	}

	public Double getHouseAmount() {
		return houseAmount;
	}

	public void setHouseAmount(Double houseAmount) {
		this.houseAmount = houseAmount;
	}

	public Double getDinnerAmount() {
		return dinnerAmount;
	}
	public void setDinnerAmount(Double dinnerAmount) {
		this.dinnerAmount = dinnerAmount;
	}

	public Double getOtherAmount() {
		return otherAmount;
	}
	public void setOtherAmount(Double otherAmount) {
		this.otherAmount = otherAmount;
	}

	public String getIsupdate() {
		return isupdate;
	}
	public void setIsupdate(String isupdate) {
		this.isupdate = isupdate;
	}

	public Long getUpdateId() {
		return updateId;
	}
	public void setUpdateId(Long updateId) {
		this.updateId = updateId;
	}

	@Column(length=500)
	public String getTransferRemark() {
		return transferRemark;
	}
	public void setTransferRemark(String transferRemark) {
		this.transferRemark = transferRemark;
	}

	public Date getTransferDate() {
		return transferDate;
	}
	public void setTransferDate(Date transferDate) {
		this.transferDate = transferDate;
	}

	public Double getOriginAmount() {
		return originAmount;
	}

	public void setOriginAmount(Double originAmount) {
		this.originAmount = originAmount;
	}

	public Double getOriginMeetingAmount() {
		return originMeetingAmount;
	}

	public void setOriginMeetingAmount(Double originMeetingAmount) {
		this.originMeetingAmount = originMeetingAmount;
	}

	public Double getOriginHouseAmount() {
		return originHouseAmount;
	}

	public void setOriginHouseAmount(Double originHouseAmount) {
		this.originHouseAmount = originHouseAmount;
	}

	public Double getOriginDinnerAmount() {
		return originDinnerAmount;
	}

	public void setOriginDinnerAmount(Double originDinnerAmount) {
		this.originDinnerAmount = originDinnerAmount;
	}

	public Double getOriginOtherAmount() {
		return originOtherAmount;
	}

	public void setOriginOtherAmount(Double originOtherAmount) {
		this.originOtherAmount = originOtherAmount;
	}

	public Double getOriginMettingRoomCommissionRate() {
		return originMettingRoomCommissionRate;
	}

	public void setOriginMettingRoomCommissionRate(Double originMettingRoomCommissionRate) {
		this.originMettingRoomCommissionRate = originMettingRoomCommissionRate;
	}

	public Double getOriginHousingCommissionRate() {
		return originHousingCommissionRate;
	}

	public void setOriginHousingCommissionRate(Double originHousingCommissionRate) {
		this.originHousingCommissionRate = originHousingCommissionRate;
	}

	public Double getOriginDinnerCommissionRate() {
		return originDinnerCommissionRate;
	}

	public void setOriginDinnerCommissionRate(Double originDinnerCommissionRate) {
		this.originDinnerCommissionRate = originDinnerCommissionRate;
	}

	public Double getOriginOrtherCommissionRate() {
		return originOrtherCommissionRate;
	}

	public void setOriginOrtherCommissionRate(Double originOrtherCommissionRate) {
		this.originOrtherCommissionRate = originOrtherCommissionRate;
	}

	public Double getOriginAllCommissionRate() {
		return originAllCommissionRate;
	}

	public void setOriginAllCommissionRate(Double originAllCommissionRate) {
		this.originAllCommissionRate = originAllCommissionRate;
	}  
	

	public ComissionRecord(Long hotelId, String orderNo, Double amount, String type, Double housingCommissionRate,
			Double housingCommission, Double dinnerCommissionRate, Double dinnerCommission,
			Double mettingRoomCommissionRate, Double mettingRoomCommission, Double ortherCommissionRate,
			Double ortherCommission, Double allCommissionRate, Double allCommission, Double commissionAmount,
			String state, Date createDate, String createUserId, String createUserName, String memo) {
		super();
		this.hotelId = hotelId;
		this.orderNo = orderNo;
		this.amount = amount;
		this.type = type;
		this.housingCommissionRate = housingCommissionRate;
		this.housingCommission = housingCommission;
		this.dinnerCommissionRate = dinnerCommissionRate;
		this.dinnerCommission = dinnerCommission;
		this.mettingRoomCommissionRate = mettingRoomCommissionRate;
		this.mettingRoomCommission = mettingRoomCommission;
		this.ortherCommissionRate = ortherCommissionRate;
		this.ortherCommission = ortherCommission;
		this.allCommissionRate = allCommissionRate;
		this.allCommission = allCommission;
		this.commissionAmount = commissionAmount;
		this.state = state;
		this.createDate = createDate;
		this.createUserId = createUserId;
		this.createUserName = createUserName;
		this.memo = memo;
	}

	public ComissionRecord() {
		super();
	}

	public void setComissionRecord(Double originAmount, Double originMeetingAmount, Double originHouseAmount,
			Double originDinnerAmount, Double originOtherAmount, Double originMettingRoomCommissionRate,
			Double originHousingCommissionRate, Double originDinnerCommissionRate, Double originOrtherCommissionRate,
			Double originAllCommissionRate) {
		this.originAmount = originAmount;
		this.originMeetingAmount = originMeetingAmount;
		this.originHouseAmount = originHouseAmount;
		this.originDinnerAmount = originDinnerAmount;
		this.originOtherAmount = originOtherAmount;
		this.originMettingRoomCommissionRate = originMettingRoomCommissionRate;
		this.originHousingCommissionRate = originHousingCommissionRate;
		this.originDinnerCommissionRate = originDinnerCommissionRate;
		this.originOrtherCommissionRate = originOrtherCommissionRate;
		this.originAllCommissionRate = originAllCommissionRate;
	}
	
	
	
}


