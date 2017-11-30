package com.chuangbang.base.entity.order;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.chuangbang.framework.entity.IdEntity;
@Entity
@Table(name = "hui_comissionCheckRecord")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ComissionCheckRecord  extends IdEntity {
	
	private Long recordId;
	
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
	 * 订单金额
	 */
	private Double originAmount;  
	/**
	 * 场地费用
	 */
	private Double originMeetingAmount;  
	/**
	 * 住房费用
	 */
	private Double originHouseAmount;  
	/**
	 * 用餐费用
	 */
	private Double originDinnerAmount;  
	/**
	 * 其他费用
	 */
	private Double originOtherAmount;
	
	/**
	 * 返佣类型
	 */
	private String type;  
	
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
	 * 创建人编号
	 */
	private String createUserId;  
	
	/**
	 * 创建人姓名
	 */
	private String createUserName;  
	
	/**
	 * 备注
	 */
	private String memo;

	public Long getRecordId() {
		return recordId;
	}

	public void setRecordId(Long recordId) {
		this.recordId = recordId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getHousingCommissionRate() {
		return housingCommissionRate;
	}

	public void setHousingCommissionRate(Double housingCommissionRate) {
		this.housingCommissionRate = housingCommissionRate;
	}

	public Double getHousingCommission() {
		return housingCommission;
	}

	public void setHousingCommission(Double housingCommission) {
		this.housingCommission = housingCommission;
	}

	public Double getDinnerCommissionRate() {
		return dinnerCommissionRate;
	}

	public void setDinnerCommissionRate(Double dinnerCommissionRate) {
		this.dinnerCommissionRate = dinnerCommissionRate;
	}

	public Double getDinnerCommission() {
		return dinnerCommission;
	}

	public void setDinnerCommission(Double dinnerCommission) {
		this.dinnerCommission = dinnerCommission;
	}

	public Double getMettingRoomCommissionRate() {
		return mettingRoomCommissionRate;
	}

	public void setMettingRoomCommissionRate(Double mettingRoomCommissionRate) {
		this.mettingRoomCommissionRate = mettingRoomCommissionRate;
	}

	public Double getMettingRoomCommission() {
		return mettingRoomCommission;
	}

	public void setMettingRoomCommission(Double mettingRoomCommission) {
		this.mettingRoomCommission = mettingRoomCommission;
	}

	public Double getOrtherCommissionRate() {
		return ortherCommissionRate;
	}

	public void setOrtherCommissionRate(Double ortherCommissionRate) {
		this.ortherCommissionRate = ortherCommissionRate;
	}

	public Double getOrtherCommission() {
		return ortherCommission;
	}

	public void setOrtherCommission(Double ortherCommission) {
		this.ortherCommission = ortherCommission;
	}

	public Double getAllCommissionRate() {
		return allCommissionRate;
	}

	public void setAllCommissionRate(Double allCommissionRate) {
		this.allCommissionRate = allCommissionRate;
	}

	public Double getAllCommission() {
		return allCommission;
	}

	public void setAllCommission(Double allCommission) {
		this.allCommission = allCommission;
	}

	public Double getCommissionAmount() {
		return commissionAmount;
	}

	public void setCommissionAmount(Double commissionAmount) {
		this.commissionAmount = commissionAmount;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getCheckMemo() {
		return checkMemo;
	}

	public void setCheckMemo(String checkMemo) {
		this.checkMemo = checkMemo;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getCreateUserName() {
		return createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public ComissionCheckRecord(Long recordId, Double meetingAmount, Double houseAmount,
			Double dinnerAmount, Double otherAmount, Double originMeetingAmount,
			Double originHouseAmount, Double originDinnerAmount, Double originOtherAmount, String type,
			Double housingCommissionRate, Double housingCommission, Double dinnerCommissionRate,
			Double dinnerCommission, Double mettingRoomCommissionRate, Double mettingRoomCommission,
			Double ortherCommissionRate, Double ortherCommission, Double commissionAmount, String state, Date checkDate, Date createDate,
			String createUserId, String createUserName) {
		super();
		this.recordId = recordId;
		this.meetingAmount = meetingAmount;
		this.houseAmount = houseAmount;
		this.dinnerAmount = dinnerAmount;
		this.otherAmount = otherAmount;
		this.originMeetingAmount = originMeetingAmount;
		this.originHouseAmount = originHouseAmount;
		this.originDinnerAmount = originDinnerAmount;
		this.originOtherAmount = originOtherAmount;
		this.type = type;
		this.housingCommissionRate = housingCommissionRate;
		this.housingCommission = housingCommission;
		this.dinnerCommissionRate = dinnerCommissionRate;
		this.dinnerCommission = dinnerCommission;
		this.mettingRoomCommissionRate = mettingRoomCommissionRate;
		this.mettingRoomCommission = mettingRoomCommission;
		this.ortherCommissionRate = ortherCommissionRate;
		this.ortherCommission = ortherCommission;
		this.commissionAmount = commissionAmount;
		this.state = state;
		this.checkDate = checkDate;
		this.createDate = createDate;
		this.createUserId = createUserId;
		this.createUserName = createUserName;
	}

	
	public ComissionCheckRecord(Long recordId, Double amount, Double originAmount, String type,
			Double allCommissionRate, Double allCommission, Double commissionAmount, String state, Date checkDate,
			Date createDate, String createUserId, String createUserName) {
		super();
		this.recordId = recordId;
		this.amount = amount;
		this.originAmount = originAmount;
		this.type = type;
		this.allCommissionRate = allCommissionRate;
		this.allCommission = allCommission;
		this.commissionAmount = commissionAmount;
		this.state = state;
		this.checkDate = checkDate;
		this.createDate = createDate;
		this.createUserId = createUserId;
		this.createUserName = createUserName;
	}

	public ComissionCheckRecord() {
		super();
	} 
	
	
	
}
