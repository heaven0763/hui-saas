package com.chuangbang.plugins.baidu.yun.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.lang3.StringUtils;

import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.plugins.baidu.yun.map.model.BaiduMapResult;
import com.chuangbang.plugins.baidu.yun.map.model.UnGeocoderSearchResponse;

import net.sf.json.JSONObject;
public class BaiduMapUtil {
	public static BaiduMapResult getGeocoding(String address) throws UnsupportedEncodingException{
		String url = "http://api.map.baidu.com/geocoder/v2/?address="+address+"&output=json&ak="+Constant.BAIDUMAPAK;
		System.out.println(url);
		//url = URLEncoder.encode(url, "utf-8");
		String res = HttpUtils.doGet(url);
		System.out.println("res>>>>>>>>>>>>>>>>>>>"+res);
		JSONObject jsonObject = JSONObject.fromObject(res);
		BaiduMapResult baiduMapResult =(BaiduMapResult) JSONObject.toBean(jsonObject.getJSONObject("result"), BaiduMapResult.class);
		return baiduMapResult;
	}
	public static void main(String[] args) {
		System.out.println( ">>>"+BaiduMapUtil.getArea("113.947531,22.529366","city"));
	}
	public static String getArea(String location,String level) {
		System.out.println("location>>>>>>>>>>>"+location);
		if(StringUtils.isBlank(location)){
			return "";
		}
		String[] loctns = location.split(",");
		String lat = loctns[1];//纬度
		String lng = loctns[0];//经度
		String url = "http://api.map.baidu.com/geocoder/v2/?ak="+Constant.BAIDUMAPAK+"&location="+lat+","+lng+"&output=json&pois=0";
		
		System.out.println("url>>>"+url);
		String res = HttpUtils.doGet(url);
		System.out.println(">>>>>>"+res);
		JSONObject jsonObject = JSONObject.fromObject(res);
		UnGeocoderSearchResponse unGeocoderSearchResponse = (UnGeocoderSearchResponse)JSONObject.toBean(jsonObject.getJSONObject("result"), UnGeocoderSearchResponse.class);
		if(unGeocoderSearchResponse!=null&&StringUtils.isNotBlank(unGeocoderSearchResponse.getFormatted_address())){
			if("country".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getCountry();
			}else if("province".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince();
			}else if("city".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince()+unGeocoderSearchResponse.getAddressComponent().getCity();
			}else if("district".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince()+unGeocoderSearchResponse.getAddressComponent().getCity()
						+ unGeocoderSearchResponse.getAddressComponent().getDistrict();
			}else if("street".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince()+unGeocoderSearchResponse.getAddressComponent().getCity()
						+ unGeocoderSearchResponse.getAddressComponent().getDistrict()+unGeocoderSearchResponse.getAddressComponent().getStreet();
			}else if("street_number".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince()+unGeocoderSearchResponse.getAddressComponent().getCity()
						+ unGeocoderSearchResponse.getAddressComponent().getDistrict()+unGeocoderSearchResponse.getAddressComponent().getStreet()
						+ unGeocoderSearchResponse.getAddressComponent().getStreet_number();
			}else if("".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince();
			}else if("".equals(level)){
				return unGeocoderSearchResponse.getAddressComponent().getProvince();
			}
		}
		return "";
	}

	

}
