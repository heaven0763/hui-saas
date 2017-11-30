package com.chuangbang.framework.util.hibernate.persistence;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;

public class SearchFilter {

	/**
	 * ISN = IS NULL
	 * ISNN = IS NOT NULL
	 * */
	public enum Operator {
		EQ, NE, LIKE, LLIKE, RLIKE, GT, LT, GTE, LTE,ISN,ISNN,OR,IN
	}

	public String fieldName;
	public Object value;
	public Operator operator;

	public SearchFilter(String fieldName, Operator operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.operator = operator;
	}

	public static List<SearchFilter> parse(Map<String, Object> filterParams) {
		List<SearchFilter> filters = Lists.newArrayList();
		
		for (Entry<String, Object> entry : filterParams.entrySet()) {
			String[] names = StringUtils.split(entry.getKey(), "_");
			if (names.length < 2) {
				throw new IllegalArgumentException(entry.getKey() + " is not a valid search filter name");
			}
			//去掉空字符串
			if(entry.getValue() instanceof String && !"".equals(entry.getValue()) || !(entry.getValue() instanceof String)){
				
				SearchFilter filter = new SearchFilter(names[1], Operator.valueOf(names[0]), entry.getValue());
				filters.add( filter);
				
			}
		}
		
		return filters;
	}
}
