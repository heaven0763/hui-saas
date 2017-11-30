package com.chuangbang.framework.util.json;

public class JsonUtils{
	
	public static String ST_OK = "200";	//成功
	public static String ST_ERROR = "309";	//失败		309是操作失败，300是系统错误
	public static String ST_OTHER = "209";	//不成功,但是有其他提示,需要根据情况进行处理
	
	public static JsonVo success(String message){
		return new JsonVo(ST_OK,message,null);
	}
	
	public static JsonVo success(String message,Object object){
		return new JsonVo(ST_OK,message,object);
	}
	
	public static JsonVo error(String message){
		return new JsonVo(ST_ERROR,message,null);
	}
	
	public static JsonVo error(String message,Object object){
		return new JsonVo(ST_ERROR,message,object);
	}
	
	public static JsonVo other(String message){
		return new JsonVo(ST_OTHER,message,null);
	}
	
	public static JsonVo other(String message,Object object){
		return new JsonVo(ST_OTHER,message,object);
	}
}