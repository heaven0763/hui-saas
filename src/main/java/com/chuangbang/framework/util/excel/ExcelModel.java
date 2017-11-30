package com.chuangbang.framework.util.excel;


public class ExcelModel {

	/**
	 * Excel的header
	 */
	private String headName;

	/**
	 * 实体类的属性
	 */
	private String property;

	/**
	 * 单元格宽度
	 */
	private Integer width;

	/**
	 * 单元格高度
	 */
	private Integer height;
	
	public CellStyle cellStyle;
	
	public enum CellStyle {
		STR,CURRENTY,DEPT,DATE,TYPE,STATE,NUMBER
	}
	
	public ExcelModel(String headName, String property,CellStyle cellStyle) {
		super();
		this.headName = headName;
		this.property = property;
		this.cellStyle = cellStyle;
	}
	
	public ExcelModel(String headName, String property,CellStyle cellStyle, Integer width) {
		super();
		this.headName = headName;
		this.property = property;
		this.width = width;
		this.cellStyle = cellStyle;
	}
	
	public String getHeadName() {
		return headName;
	}

	public void setHeadName(String headName) {
		this.headName = headName;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}
	
	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

}

