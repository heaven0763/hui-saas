package com.chuangbang.framework.util;

import java.util.Map;

import com.google.common.collect.Maps;

public class CommissionStatusUtil {

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
		hotel.put("03", "已对账");
		hotel.put("04", "已对账");
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
