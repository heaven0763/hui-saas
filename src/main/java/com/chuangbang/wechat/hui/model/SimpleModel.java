package com.chuangbang.wechat.hui.model;

public class SimpleModel {

	private String id;
	
	private String name;
	
	private Double sum;
	
	private String month;
	
	private Long count;
	
	private String unitcode;
	
	public String getUnitcode() {
		return unitcode;
	}

	public void setUnitcode(String unitcode) {
		this.unitcode = unitcode;
	}

	public Long getCount() {
		return count == null? 0: count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public Double getSum() {
		return sum == null? 0.00 : sum;
	}

	public void setSum(Double sum) {
		this.sum = sum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
