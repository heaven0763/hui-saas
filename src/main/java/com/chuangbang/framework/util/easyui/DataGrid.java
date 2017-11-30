package com.chuangbang.framework.util.easyui;

import java.util.ArrayList;
import java.util.List;

public class DataGrid implements java.io.Serializable {
	
	private Long total = 0L;
	private Integer totalPage = 0;
	private Integer currtPage = 0;
	private List rows = new ArrayList();

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getCurrtPage() {
		return currtPage;
	}

	public void setCurrtPage(Integer currtPage) {
		this.currtPage = currtPage;
	}


}
