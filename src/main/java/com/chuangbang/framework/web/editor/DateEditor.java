package com.chuangbang.framework.web.editor;

import java.beans.PropertyEditorSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.util.StringUtils;

import com.chuangbang.framework.util.common.DateTimeUtils;


public class DateEditor extends PropertyEditorSupport {
	
	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy",Locale.ENGLISH);
	
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		try {
			if (!StringUtils.hasText(text)) {
				setValue(null);
			} else if (!text.contains("CST")) {
				setValue(DateUtils.parseDate(text, new String[] { "yyyy-MM-dd","yyyy-MM-dd HH", "yyyy-MM-dd HH:mm",
						"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm:ss.SSS" }));
			} else {
				setValue(simpleDateFormat.parse(text));
			}
		} catch (java.text.ParseException e) {
			setValue(null);
		}
	}

	@Override
	public String getAsText() {
		Date date = (Date) getValue();
		if(date != null){
			String dateString = DateTimeUtils.toSecond(date);
			if(dateString.indexOf("00:00:00") != -1){
				return dateString.substring(0, 10);
			}
			return dateString.substring(0, 19);
		}else{
			return null;
		}
	}
}
