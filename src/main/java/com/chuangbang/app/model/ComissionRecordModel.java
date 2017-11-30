package com.chuangbang.app.model;

import com.chuangbang.base.entity.order.ComissionCheckRecord;
import com.chuangbang.base.entity.order.ComissionRecord;

public class ComissionRecordModel {

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

	public ComissionRecordModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ComissionRecordModel(Double amount, Double meetingAmount, Double houseAmount, Double dinnerAmount,
			Double otherAmount, Double housingCommissionRate, Double housingCommission, Double dinnerCommissionRate,
			Double dinnerCommission, Double mettingRoomCommissionRate, Double mettingRoomCommission,
			Double ortherCommissionRate, Double ortherCommission, Double allCommissionRate, Double allCommission,
			Double commissionAmount) {
		super();
		this.amount = amount;
		this.meetingAmount = meetingAmount;
		this.houseAmount = houseAmount;
		this.dinnerAmount = dinnerAmount;
		this.otherAmount = otherAmount;
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
	}  
	
	public ComissionRecordModel(ComissionRecord comissionRecord) {
		super();
		this.amount = comissionRecord.getAmount();
		this.meetingAmount = comissionRecord.getMeetingAmount();
		this.houseAmount = comissionRecord.getHouseAmount();
		this.dinnerAmount = comissionRecord.getDinnerAmount();
		this.otherAmount = comissionRecord.getOtherAmount();
		this.housingCommissionRate = comissionRecord.getHousingCommissionRate();
		this.housingCommission = comissionRecord.getHousingCommission();
		this.dinnerCommissionRate = comissionRecord.getDinnerCommissionRate();
		this.dinnerCommission = comissionRecord.getDinnerCommission();
		this.mettingRoomCommissionRate = comissionRecord.getMettingRoomCommissionRate();
		this.mettingRoomCommission = comissionRecord.getMettingRoomCommission();
		this.ortherCommissionRate = comissionRecord.getOrtherCommissionRate();
		this.ortherCommission = comissionRecord.getOrtherCommission();
		this.allCommissionRate = comissionRecord.getAllCommissionRate();
		this.allCommission = comissionRecord.getAllCommission();
		this.commissionAmount = comissionRecord.getCommissionAmount();
	}  
	
	public ComissionRecordModel(ComissionCheckRecord comissionRecord) {
		super();
		this.amount = comissionRecord.getAmount();
		this.meetingAmount = comissionRecord.getMeetingAmount();
		this.houseAmount = comissionRecord.getHouseAmount();
		this.dinnerAmount = comissionRecord.getDinnerAmount();
		this.otherAmount = comissionRecord.getOtherAmount();
		this.housingCommissionRate = comissionRecord.getHousingCommissionRate();
		this.housingCommission = comissionRecord.getHousingCommission();
		this.dinnerCommissionRate = comissionRecord.getDinnerCommissionRate();
		this.dinnerCommission = comissionRecord.getDinnerCommission();
		this.mettingRoomCommissionRate = comissionRecord.getMettingRoomCommissionRate();
		this.mettingRoomCommission = comissionRecord.getMettingRoomCommission();
		this.ortherCommissionRate = comissionRecord.getOrtherCommissionRate();
		this.ortherCommission = comissionRecord.getOrtherCommission();
		this.allCommissionRate = comissionRecord.getAllCommissionRate();
		this.allCommission = comissionRecord.getAllCommission();
		this.commissionAmount = comissionRecord.getCommissionAmount();
	}  
	
}
