package com.chuangbang.framework.util.page;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 类似PageRequest,用来搭配dwz框架
 * */
public class PageBean<T> implements Serializable {

	private static final long serialVersionUID = 1L;
	private List<T> list =Lists.newArrayList();//查询结果
	private Integer page;// 当前页
	private Integer rows;// 每页多少条
	private Integer pageNumShown;// 显示多少页
	private Long totalCount =0L;// 总条数
	private Integer totalPage;//总页数
	private String sort;//排序字段
	private String order;//排序方向
	private Integer firstRec;//第一条记录编号
	
	private Integer limit = 10;
	private Integer offset =0;
	
	public Integer getFirstRec() {
		int ret = (this.getPage()-1) * this.getRows();//+ 1;
		firstRec = (ret < 1)?0:ret;
		return firstRec;
	}

	public void setFirstRec(Integer firstRec) {
		this.firstRec = firstRec;
	}
	
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}

	//查询条件
	private Map<String, Object> _filterParams = Maps.newHashMap();

	public Integer getPage() {
		if(null==page){
			page = offset/limit+1;
		}else if(page<=0){
			page=1;
		}
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		if(null==rows){
			rows = limit;
		}
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	/*
	 * public Integer getCurrentPage() { return currentPage; }
	 * 
	 * public void setCurrentPage(Integer currentPage) { this.currentPage =
	 * currentPage; }
	 */
	public Integer getPageNumShown() {
		return pageNumShown;
	}

	public void setPageNumShown(Integer pageNumShown) {
		if (pageNumShown > 10) {
			pageNumShown = 10;
		}
		this.pageNumShown = pageNumShown;
	}

	public Long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Long totalCount) {
		this.totalCount = totalCount;
	}
	
	public Integer getTotalPage() {
		totalPage = (getTotalCount().intValue() % getRows()) == 0 ? (getTotalCount().intValue() / getRows()) : (getTotalCount().intValue() / getRows()) + 1;
		return totalPage;
	}

	public String getSort() {
		if (sort==null ||sort.length()==0) {
			sort = "id";
		}
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		if (order==null||order.length()==0) {
			order = "desc";
		}
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public Map<String, Object> get_filterParams() {
		return _filterParams;
	}

	public void set_filterParams(Map<String, Object> _filterParams) {
		this._filterParams = _filterParams;
	}

	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}

}
