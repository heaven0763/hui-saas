package com.chuangbang.framework.util.generatecode.model;

/**
 * 成员变量
 */
public class Property {
	
	private String name = "";	//成员
	
	private String annotation = "";	//注释
	
	private String dataType = "String";	//类型，注意如果是需要导包的类，可以写为 java.util.List这种形式
	
	private Integer isSearchColunm = 0;	//是否是查询字段
	
	private Integer uiWidth = 50;	//在easyui的list页面的宽度
	
	private String condition = "EQ"; 	//查询条件 ,例如 EQ,LIKE
	
	public Property(String name, String annotation) {
		super();
		this.name = name;
		this.annotation = annotation;
	}
	

	public Property(String name, String annotation, String dataType) {
		super();
		this.name = name;
		this.annotation = annotation;
		this.dataType = dataType;
	}

	public Property(String name, String annotation, Integer isSearchColunm) {
		super();
		this.name = name;
		this.annotation = annotation;
		this.isSearchColunm = isSearchColunm;
	}

	public Property(String name, String annotation, String dataType,
			Integer uiWidth, Integer isSearchColunm, String condition) {
		super();
		this.name = name;
		this.annotation = annotation;
		this.dataType = dataType;
		this.uiWidth = uiWidth;
		this.isSearchColunm = isSearchColunm;
		this.condition = condition;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAnnotation() {
		return annotation;
	}

	public void setAnnotation(String annotation) {
		this.annotation = annotation;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}


	public Integer getUiWidth() {
		return uiWidth;
	}

	public void setUiWidth(Integer uiWidth) {
		this.uiWidth = uiWidth;
	}

	public Integer getIsSearchColunm() {
		return isSearchColunm;
	}


	public void setIsSearchColunm(Integer isSearchColunm) {
		this.isSearchColunm = isSearchColunm;
	}


	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
}
