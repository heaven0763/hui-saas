package com.chuangbang.framework.util.excel;

import java.text.DecimalFormat;
import java.util.Date;

import org.apache.commons.lang.time.FastDateFormat;

public class FormatUtils {

	public static final String TO_DOUBLE = "toDouble";
	public static final String TO_DAY = "toDay";
	public static final String TO_HOUR = "toHour";
	public static final String TO_MINUTE = "toMinute";
	public static final String TO_SECOND = "toSecond";
	
	private static final String PATTERN_DATE = "yyyy-MM-dd";
	private static final String PATTERN_TO_HOUR = "yyyy-MM-dd HH";
	private static final String PATTERN_TO_MINUTE = "yyyy-MM-dd HH:mm";
	private static final String PATTERN_TO_SECOND = "yyyy-MM-dd HH:mm:ss";
	
	private static final DecimalFormat df = new DecimalFormat("##,###,###,###,##0.00");
	
	public static String toDouble(Double value){
		return value == null ? "0.00":df.format(value);
	}
	
	public static String toDouble(String value){
		return value == null ? "0.00":df.format(Double.valueOf(value));
	}
	
	public static String toDay(Date date){
		return date==null? "":FastDateFormat.getInstance(PATTERN_DATE).format(date);
	}
	
	public static String toDay(String date){
		return date==null? "":FastDateFormat.getInstance(PATTERN_DATE).format(java.sql.Timestamp.valueOf(date));
	}
	
	public static String toHour(String date){
		return date==null? "":FastDateFormat.getInstance(PATTERN_TO_HOUR).format(java.sql.Timestamp.valueOf(date));
	}
	
	public static String toMinute(String date){
		return date==null? "":FastDateFormat.getInstance(PATTERN_TO_MINUTE).format(java.sql.Timestamp.valueOf(date));
	}
	
	public static String toSecond(String date){
		return date==null? "":FastDateFormat.getInstance(PATTERN_TO_SECOND).format(java.sql.Timestamp.valueOf(date));
	}
	
	
}
