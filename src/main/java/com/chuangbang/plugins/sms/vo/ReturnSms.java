package com.chuangbang.plugins.sms.vo;

public class ReturnSms {
	
	private String returnstatus;
	private String message;
	private String remainpoint;
	private String taskID;
	private Long successCounts;
	private String payinfo;
	private Long overage;
	private String sendTotal;
	private ErrorStatus errorstatus; 
	private String checkCounts;
	
	
	public String getReturnstatus() {
		return returnstatus;
	}
	public void setReturnstatus(String returnstatus) {
		this.returnstatus = returnstatus;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getRemainpoint() {
		return remainpoint;
	}
	public void setRemainpoint(String remainpoint) {
		this.remainpoint = remainpoint;
	}
	public String getTaskID() {
		return taskID;
	}
	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}
	public Long getSuccessCounts() {
		return successCounts;
	}
	public void setSuccessCounts(Long successCounts) {
		this.successCounts = successCounts;
	}
	public String getPayinfo() {
		return payinfo;
	}
	public void setPayinfo(String payinfo) {
		this.payinfo = payinfo;
	}
	public Long getOverage() {
		return overage;
	}
	public void setOverage(Long overage) {
		this.overage = overage;
	}
	public String getSendTotal() {
		return sendTotal;
	}
	public void setSendTotal(String sendTotal) {
		this.sendTotal = sendTotal;
	}
	public ErrorStatus getErrorstatus() {
		return errorstatus;
	}
	public void setErrorstatus(ErrorStatus errorstatus) {
		this.errorstatus = errorstatus;
	}
	public String getCheckCounts() {
		return checkCounts;
	}
	public void setCheckCounts(String checkCounts) {
		this.checkCounts = checkCounts;
	}
	
	
	
}
