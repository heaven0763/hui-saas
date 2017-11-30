package com.chuangbang.framework.util.common;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.common.collect.Maps;

public class MobileUtil {
	 /**
     * 正则表达式：验证邮箱
     */
    public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    
	public static boolean isMobileNO(String mobiles){  
		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9])|(170))\\d{8}$");  
		Matcher m = p.matcher(mobiles);  
		return m.matches();  
	} 
	
	public static String subMobile(String mobile){
		if(MobileUtil.isMobileNO(mobile))
		  return mobile.substring(0, 3)+"****"+mobile.substring(7);
		return null;
	}
	
	public static void main(String[] args) {
		System.out.println(MobileUtil.subMobile("13632332694"));
	}
	
	 /**
     * 校验邮箱
     * 
     * @param email
     * @return 校验通过返回true，否则返回false
     */
    public static boolean isEmail(String email) {
        return Pattern.matches(REGEX_EMAIL, email);
    }
	
    public static String getCommissionStatus(String type,String code){
		
		Map<String, String> hui = Maps.newHashMap();
		hui.put("00", "未返佣");
		hui.put("01", "待返佣");
		hui.put("02", "已对账");
		hui.put("03", "已开票");
		hui.put("04", "已领票");
		hui.put("05", "已开票");
		hui.put("06", "已开票");
		hui.put("07", "已收款");
		
		Map<String, String> hotel =Maps.newHashMap();
		hotel.put("00", "未返佣");
		hotel.put("01", "待返佣");
		hotel.put("02", "已对账");
		hotel.put("03", "已开票");
		hotel.put("04", "已开票");
		hotel.put("05", "已收票");
		hotel.put("06", "已付款");
		hotel.put("07", "已付款");
		
		if("HOTEL".equals(type)){
			return hotel.get(code);
		}else{
			return hui.get(code);
		}
	}
}
