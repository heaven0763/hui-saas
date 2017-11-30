package com.chuangbang.plugins.sms.vo;

public class ErrorStatus {
	private String error;
	private String remark;
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return "ErrorStatus [error=" + error + ", remark=" + remark + "]";
	}
	
}
