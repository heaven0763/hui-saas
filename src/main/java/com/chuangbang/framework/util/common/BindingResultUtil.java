package com.chuangbang.framework.util.common;

import java.util.List;

import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

/**
 * 用来获取BindingResult中的错误信息
 * @author Administrator
 *
 */
public class BindingResultUtil {

	/**
	 * 获取所有错误信息，用；分隔
	 * @param result result
	 * @return
	 */
	public static String getAllErrorMessage(BindingResult result){
		return getAllErrorMessage(result, "；");
	}
	
	/**
	 * 获取所有错误信息
	 * @param result   result
	 * @param splitStr 分隔的字符
	 * @return
	 */
	public static String getAllErrorMessage(BindingResult result,String splitStr){
		List<ObjectError>  errors =  result.getAllErrors();
		StringBuilder sbd = new StringBuilder();
		for(ObjectError error : errors){
			sbd.append(error.getDefaultMessage() + splitStr);
		}
		return sbd.toString();
	}
	
}
