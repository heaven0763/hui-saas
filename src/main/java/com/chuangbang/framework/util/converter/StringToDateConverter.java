package com.chuangbang.framework.util.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;


public class StringToDateConverter  implements Converter<String, Date>{
	public static final String PATTERN_STANDARD = "yyyy-MM-dd HH:mm:ss";

	public static final String PATTERN_DATE = "yyyy-MM-dd";
	private Date date = null;
	@Override
	public Date convert(String arg0) {
		if (!StringUtils.hasText(arg0)) {
			date = null;
		} else {
				if(arg0.length()>10){
					date = (string2Date(arg0,StringToDateConverter.PATTERN_STANDARD));
				}else{
					date = (string2Date(arg0, StringToDateConverter.PATTERN_DATE));
				}
		}
		return date;
	}
	
	private Date string2Date(String strDate,String pattern){
		if (strDate == null || strDate.equals("")) {
			throw new RuntimeException("string date is null");
		}
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date date = null;

		try {
			date = sdf.parse(strDate);
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		return date;
	}

}
