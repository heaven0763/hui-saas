package com.chuangbang.framework.util.json;

public class JsonVo {
	
	private String statusCode;
	
	private String message;
	
	private Object object;

	public JsonVo() {
		super();
	}
	

	public JsonVo(String statusCode, String message, Object object) {
		super();
		this.statusCode = statusCode;
		this.message = message;
		this.object = object;
	}



	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}
	
	
	
	
	

}
