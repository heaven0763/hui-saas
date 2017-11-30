package com.chuangbang.app.message;

public class MsgItem {

	String type;
	Object templateData;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Object getTemplateData() {
		return templateData;
	}
	public void setTemplateData(Object templateData) {
		this.templateData = templateData;
	}
	
	
	public MsgItem() {
	}
	public MsgItem(String type, Object templateData) {
		super();
		this.type = type;
		this.templateData = templateData;
	}
	
	
}
