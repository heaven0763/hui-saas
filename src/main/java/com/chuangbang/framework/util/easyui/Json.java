package com.chuangbang.framework.util.easyui;

/**
 * 
 * JSON模型
 * 
 * 用户后台向前台返回的JSON对象
 * 
 * 
 */
public class Json implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private boolean success = false;
	private String error = "";
	private String msg = "";

	private Object obj = null;
	
	private Object other = null;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public Object getOther() {
		return other;
	}

	public void setOther(Object other) {
		this.other = other;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}
	
	public void setJson(boolean success,String msg){
		this.success = success;
		this.msg = msg;
	}
	public void setJson(boolean success,String msg,Object obj){
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}
	public void setJson(boolean success,String msg,Object obj,String error){
		this.success = success;
		this.msg = msg;
		this.obj = obj;
		this.error = error;
	}
}
