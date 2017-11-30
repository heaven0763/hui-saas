package com.chuangbang.framework.util.json;

import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ModelAndViewUtils {
	
	private static ObjectMapper objectMapper = new ObjectMapper();
	
	public static String ST_OK = "200";	//成功
	public static String ST_ERROR = "300";	//失败
	public static String ST_OTHER = "209";	//不成功,但是有其他提示,需要根据情况进行处理
	
	public static ModelAndView success(String message){
		return ModelAndViewUtils.done(ST_OK, message, null);
	}
	
	public static ModelAndView success(String message,Object object){
		return ModelAndViewUtils.done(ST_OK, message, object);
	}
	
	public static ModelAndView error(String message){
		return ModelAndViewUtils.done(ST_ERROR, message, null);
	}
	
	public static ModelAndView error(String message,Object object){
		return ModelAndViewUtils.done(ST_ERROR, message, object);
	}
	
	public static ModelAndView other(String message){
		return ModelAndViewUtils.done(ST_OTHER, message, null);
	}
	
	public static ModelAndView other(String message,Object object){
		return ModelAndViewUtils.done(ST_OTHER, message, object);
	}
	
	public static ModelAndView done(String statusCode,String message,Object object){
		ModelAndView mav = new ModelAndView("ajaxDone");
		String cbObj1 = "{}";
		try {
			cbObj1 = objectMapper.writeValueAsString(object);
		} catch (JsonProcessingException e) {
			statusCode = ST_ERROR;
			message = "json对象转字符串失败！";
			e.printStackTrace();
		}
		mav.addObject("statusCode", statusCode);
		mav.addObject("message", message);
		mav.addObject("cbObj1", cbObj1);
		return mav;
	}
	
	
}
