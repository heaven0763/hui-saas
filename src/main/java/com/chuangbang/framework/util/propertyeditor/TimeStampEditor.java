package com.chuangbang.framework.util.propertyeditor;
/*
import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;

import org.springframework.util.StringUtils;

public class TimeStampEditor extends PropertyEditorSupport {
	private final DateFormat dateFormat;

	private final boolean allowEmpty;

	private final int exactDateLength; 
	
	public TimeStampEditor(boolean allowEmpty){
		this.dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.dateFormat.setLenient(false);
		this.allowEmpty = allowEmpty;
		this.exactDateLength = -1;
	}
	
	public TimeStampEditor(boolean allowEmpty,int exactDateLength){
		this.dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.dateFormat.setLenient(false);
		this.allowEmpty = allowEmpty;
		this.exactDateLength = exactDateLength;
	}
	
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		String theText = text;
		if (this.allowEmpty && !StringUtils.hasText(theText)) {
			// Treat empty String as null value.
			setValue(null);
		}
		else if (theText != null && this.exactDateLength >= 0 && theText.length() != this.exactDateLength) {
			throw new IllegalArgumentException(
					"Could not parse date: it is not exactly" + this.exactDateLength + "characters long");
		}else {
			if (theText.length() < 12) {
				theText = theText + " 00:00:00";
			} else if (12 < theText.length() && theText.length() < 17) {
				theText = theText + ":00";
			}
			try {
				setValue(new Timestamp(this.dateFormat.parse(theText).getTime()));
			}
			catch (ParseException ex) {
				throw new IllegalArgumentException("Could not parse date: " + ex.getMessage(), ex);
			}
		}
	}

	@Override
	public String getAsText() {
		Timestamp value = (Timestamp) getValue();
		String result = value != null ? this.dateFormat.format(value) : "";
		System.out.println("shijian>>>>>>>>>>>>>:"+result);
		if(result.indexOf(" 00:00:00.0") != -1){
			result = result.replace(" 00:00:00.0", "");
		}
		return result;
	}

}
*/