package com.chuangbang.app.message;

public class Message {
	
	private String err_code;
	private String err_msg;
	private Object data;

	public String getErr_code() {
		return err_code;
	}

	public void setErr_code(String err_code) {
		this.err_code = err_code;
	}

	public String getErr_msg() {
		return err_msg;
	}

	public void setErr_msg(String err_msg) {
		this.err_msg = err_msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Message() {

	}
	public Message(String err_code, String err_msg) {
		super();
		this.err_code = err_code;
		this.err_msg = err_msg;
	}
	public Message(String err_code, String err_msg, Object data) {
		super();
		this.err_code = err_code;
		this.err_msg = err_msg;
		this.data = data;
	}
	public void setMsg(String err_code, String err_msg) {
		this.err_code = err_code;
		this.err_msg = err_msg;
		this.data = "no data";
	}
	public void setMsg(String err_code, String err_msg, Object data) {
		this.err_code = err_code;
		this.err_msg = err_msg;
		this.data = data;
	}

}
