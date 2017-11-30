package tuodan;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.framework.util.AESUtil;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.framework.util.RandomStringUtil;
import com.google.common.collect.Lists;

public class Test {
	public static final String key = "ZEMwcrdVhjibkmMn";
	public static final String TESTADOMAIN = "http://192.168.199.167:8081";
	public static final String DOMAIN = "http://120.77.50.152:8080";
	
	public static void createOrder() throws Exception{
		JSONObject jsonObject = new JSONObject();
		String orderNo = RandomStringUtil.getOrderNo(6);
		jsonObject.put("orderNo", orderNo);
		jsonObject.put("key", "31507459");
		jsonObject.put("hotelId", "1");
		jsonObject.put("hotelSaleId", "b92e86fb-0722-4749-a027-9ff6b97eee86");
		
		jsonObject.put("clientId", "1366");
		jsonObject.put("activityDate", "2017-09-18");
		jsonObject.put("activityTitle", "ghahadf峰会");
		jsonObject.put("organizer", "dgdhdasee");
		jsonObject.put("linkman", "刘小姐");
		jsonObject.put("contactNumber", "15920443565");
		
		jsonObject.put("notifyUrl", "http://hui.xindong99.com/");
		
		List<JSONObject> sites = Lists.newArrayList();
		JSONObject orderDetail = new JSONObject();
		orderDetail.put("ismain", "1");
		orderDetail.put("placeId", "2");
		orderDetail.put("amount", 196668);
		orderDetail.put("commissionFeeRate", 0);
		
		List<JSONObject> siteSchedules = Lists.newArrayList();
		JSONObject siteSchedule = new JSONObject();
		siteSchedule.put("placeScheduleId", 1696);
		siteSchedule.put("placeDate", "2017-09-18");
		siteSchedule.put("placeSchedule", "ALL");
		siteSchedule.put("price", 196668);
		siteSchedule.put("quantity", 1);
		
		siteSchedules.add(siteSchedule);
		orderDetail.put("siteSchedules", siteSchedules);
		sites.add(orderDetail);
		jsonObject.put("sites", sites);
		
		
		List<JSONObject> rooms = Lists.newArrayList();
		JSONObject room1 = new JSONObject();
		room1.put("placeId", 7);
		room1.put("amount", 48000);
		room1.put("quantity", 40);
		
		List<JSONObject> roomSchedules = Lists.newArrayList();
		JSONObject roomSchedule = new JSONObject();
		roomSchedule.put("placeDate", "2017-09-18");
		roomSchedule.put("price", 1200);
		roomSchedule.put("breakfast", 0);
		roomSchedule.put("quantity", 20);
		
		JSONObject roomSchedule2 = new JSONObject();
		roomSchedule2.put("placeDate", "2017-09-18");
		roomSchedule2.put("price", 1200);
		roomSchedule2.put("quantity", 20);
		roomSchedule2.put("breakfast", 0);
		
		roomSchedules.add(roomSchedule);
		roomSchedules.add(roomSchedule2);
		room1.put("roomSchedules", roomSchedules);
		rooms.add(room1);
		jsonObject.put("rooms",rooms);
		
		List<JSONObject> meals = Lists.newArrayList();
		JSONObject meal1 = new JSONObject();
		meal1.put("placeId", "2");
		meal1.put("amount", 24760);
		meal1.put("quantity", 20);
		
		List<JSONObject> mealSchedules = Lists.newArrayList();
		JSONObject mealSchedule1 = new JSONObject();
		mealSchedule1.put("mealType", "01");
		mealSchedule1.put("placeDate", "2017-09-18");
		mealSchedule1.put("placeSchedule", "午餐");
		mealSchedule1.put("price", 1238);
		mealSchedule1.put("quantity", 20);
		
		mealSchedules.add(mealSchedule1);
		meal1.put("mealSchedules", mealSchedules);
		
		JSONObject meal2 = new JSONObject();
		meal2.put("placeId", "9");
		meal2.put("amount", 23990);
		meal2.put("quantity", 20);
		
		mealSchedules = Lists.newArrayList();
		JSONObject mealSchedule3 = new JSONObject();
		mealSchedule3.put("mealType", "02");
		mealSchedule3.put("placeDate", "2017-09-18");
		mealSchedule3.put("placeSchedule", "晚餐");
		mealSchedule3.put("price", 239.9);
		mealSchedule3.put("quantity", 100);
		
		mealSchedules.add(mealSchedule3);
		meal2.put("mealSchedules", mealSchedules);
		meals.add(meal1);
		meals.add(meal2);
		jsonObject.put("meals",meals);
		
		
		jsonObject.put("state","01");
		jsonObject.put("settlementStatus","01");
		
		jsonObject.put("amount", "293418");
		jsonObject.put("zgamount", "293418");
		jsonObject.put("zgdiscount",100);
		jsonObject.put("prepaid", "0");
		jsonObject.put("finalPayment", "293418");
		jsonObject.put("siteAmount", "196668");
		jsonObject.put("siteCommissionFee", "0");
		jsonObject.put("roomAmount", "48000");
		jsonObject.put("diningAmount", "48750");
		
		String params = new String(jsonObject.toJSONString().trim().getBytes(),"UTF-8");
		String encrypt = AESUtil.NoPaddingEncrypt(params, key);
		String sign = CipherUtil.encodeByMD5(encrypt.trim(), "UTF-8");
		jsonObject.put("sign", sign);
		params =URLEncoder.encode(URLEncoder.encode(jsonObject.toJSONString()));
		//5D09E7F47E768739BE757E3CB2CD26E1
		String url = DOMAIN+"/hui/api/place/order";
		String param = "params="+params;
		System.out.println(url+"?"+param);
		String result = HttpUtils.doPost(url, param);
		System.out.println("result>>>>>>"+result);
	}
	
	public static String postUrl(String url,JSONObject jsonObject) throws Exception{
		String params = jsonObject.toJSONString();
		String encrypt = AESUtil.NoPaddingEncrypt(params, key);
		String sign =CipherUtil.encodeByMD5(encrypt, "utf-8");
		jsonObject.put("sign", sign);
		System.out.println(jsonObject.toJSONString());
		params =URLEncoder.encode(URLEncoder.encode(jsonObject.toJSONString()));
		System.out.println(">>>>URLEncoder>>>>"+params);
		System.out.println(">>>>URLDecoder>>>>"+URLDecoder.decode(params));
		String param = "params="+params;
		System.out.println(url+"?"+param);
		//String result = HttpUtils.doPost(url, param);
		return "";//result;
	} 
	
	
	public static void main(String[] args) throws Exception {
		//Test.createOrder();person 	0,5000
		//String params = "{\"area\":\"500,1000\",\"key\":\"31507459\",\"page\":\"1\",\"person\":\"500,1000\",\"price\":\"5001,10000\",\"purpose\":\"100\",\"rows\":\"10\"}";
		//,\"kind\":\"HOTELSUPORTING\" ,\"keyword\":\"\",\"page\":\"1\",\"rows\":\"10\",\"dualbednum\":\"1\",\"purpose\":\"100\",\"qsbednum\":\"1\",\"venuenum\":\"1\"
		//String params = "{\"hotelId\":\"1\",\"key\":\"31507459\"}";//,\"kind\":\"HOTELSUPORTING\",\"regionType\":\"DISTRICT\"
		String params = "{\"key\":\"31507459\",\"page\":\"1\",\"rows\":\"10\"}";
		System.out.println("明文>>>>"+params);
		String encrypt = AESUtil.NoPaddingEncrypt(params, "ZEMwcrdVhjibkmMn");
		System.out.println("AES密文："+encrypt);
		String sign =CipherUtil.encodeByMD5(encrypt, "utf-8");
		System.out.println("MD5密文："+sign);
		System.out.println("sign>>>>"+sign);
		//params = "{\"hotelId\":\"1\",\"key\":\"31507459\",\"sign\":\""+sign+"\"}";//,\"kind\":\"HOTELSUPORTING\"
		//params = "{\"area\":\"500,1000\",\"key\":\"31507459\",\"page\":\"1\",\"person\":\"500,1000\",\"price\":\"5001,10000\",\"purpose\":\"100\",\"rows\":\"10\",\"sign\":\""+sign+"\"}";
		//,\"kind\":\"HOTELSUPORTING\" ,\"keyword\":\"\",\"page\":\"1\",\"rows\":\"10\" ,\"regionType\":\"DISTRICT\"
		params = "{\"key\":\"31507459\",\"page\":\"1\",\"rows\":\"10\",\"sign\":\""+sign+"\"}";
		String url = DOMAIN+"/hui/api/hui/dynamices";
		params =URLEncoder.encode(URLEncoder.encode(params));
		String param = "params="+params;
		System.out.println(url+"?"+param);
		String result = HttpUtils.doPost(url, param);
		System.out.println("result>>>>>>"+result);
		JSONObject jsonObject = JSONObject.parseObject(result);
		System.out.println(jsonObject.getString("data"));
		System.out.println(AESUtil.NoPaddingDecrypt(jsonObject.getString("data"), "ZEMwcrdVhjibkmMn").trim());
		//Test.testUpdateOrderState("PAY","20170519104827241781");
	}
	
	//sign>>>>F6ECA5DAB97925AB6EC5BF622D7B4B14
	
	public static void testUpdateOrderState(String state,String orderNo) throws Exception{
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("action", state);
		jsonObject.put("key", "31507459");
		jsonObject.put("orderNo", orderNo);
		jsonObject.put("clientId", 1366);
		String url = TESTADOMAIN+"/hui/api/order/state";
		String result =postUrl(url,jsonObject);
		System.out.println("result>>>>"+result);
	}
	
	public static void test() throws Exception{
		Double longitude=113.32877705179;
		Double latitude=23.041506430963;
		JSONObject jsonObject = new JSONObject();
		String orderNo = RandomStringUtil.getOrderNo(6);
		jsonObject.put("clientId", "1335");
		jsonObject.put("orderNo", orderNo);
		jsonObject.put("key", "31507459");
		
		
		/*jsonObject.put("key", "31507459");
		jsonObject.put("orderNo", "170113155122513780");
		jsonObject.put("action", "PAY");
		/*jsonObject.put("key", "31507459");
		jsonObject.put("orderNo", "20161208161752320125");
		jsonObject.put("hotelId", "1");
		jsonObject.put("hotelName", "拔高酒店");
		jsonObject.put("evaluateType", "SITE");
		jsonObject.put("itemType", "HOTEL");
		jsonObject.put("itemId", "1");
		jsonObject.put("itemName", "拔高酒店");
		
		jsonObject.put("goodsEvaluation", 5);
		jsonObject.put("attitude", 5);
		jsonObject.put("responseSpeed", 5);
		
		jsonObject.put("facilities", 5);
		jsonObject.put("hygiene", 5);
		jsonObject.put("service", 5);
		jsonObject.put("location", 5);
		
		jsonObject.put("comprehensive", 5);
		
		
		
		jsonObject.put("tag", "是对方身份,是否干撒,过水,电费");
		jsonObject.put("econtent", "是否会萨科技粉红色快捷方式三年级非是即否开发福利卡快捷方式开发技术的李开复考虑非金属卡飞机速度快浪费；");
		
		jsonObject.put("saleId", "6efeedbc-fa5c-427f-8a2b-a5c2b551cf1c");
		jsonObject.put("saleName", "sfs");
		
		jsonObject.put("userId", "1335");
		jsonObject.put("userName", "fsfsssgs");
		jsonObject.put("isanonymous", "0");
		//jsonObject.put("area", "0,50");
		//jsonObject.put("key", "31507459");
		//jsonObject.put("orderType", "HALL");
		
		jsonObject.put("key", "31507459");
		String orderNo =  RandomStringUtil.getOrderNo(6);
		jsonObject.put("orderNo",orderNo);
		jsonObject.put("hotelId", "1");
		jsonObject.put("hotelName", "拔高酒店");
		jsonObject.put("hotelSaleId", "6efeedbc-fa5c-427f-8a2b-a5c2b551cf1c");
		jsonObject.put("hotelSaleName", "sfs");
		jsonObject.put("hotelSaleMobile", "13652525454");
		
		jsonObject.put("amount", "195");
		jsonObject.put("zgamount", "195");
		jsonObject.put("prepaid", "100");
		jsonObject.put("finalPayment", "100");
		jsonObject.put("siteAmount", "195");
		jsonObject.put("siteCommissionFee", "100");
		jsonObject.put("roomAmount", "195");
		jsonObject.put("diningAmount", "100");
		
		jsonObject.put("clientId", "1335");
		
		//jsonObject.put("activityDate", "2017-01-25");
		jsonObject.put("activityTitle", "舒服舒服");
		jsonObject.put("organizer", "都是");
		jsonObject.put("linkman", "黄小姐");
		jsonObject.put("contactNumber", "13632021225");
		jsonObject.put("state", "01");
		jsonObject.put("settlementStatus", "01");
		
		//活动场地****************************************
		List<JSONObject> sites = Lists.newArrayList();
		JSONObject orderDetail = new JSONObject();
		orderDetail.put("type", "01");
		orderDetail.put("orderNo", orderNo);
		orderDetail.put("ismain", "1");
		orderDetail.put("placeId", "2");
		orderDetail.put("placeName", "玫瑰");
		orderDetail.put("amount", "10000");
		orderDetail.put("commissionFeeRate", "10");
		
		List<JSONObject> siteSchedules = Lists.newArrayList();
		JSONObject siteSchedule = new JSONObject();
		siteSchedule.put("placeScheduleId", "537");
		siteSchedule.put("placeDate", "2017-01-22");
		siteSchedule.put("placeSchedule", "晚上");
		siteSchedule.put("price", 10000);
		siteSchedule.put("quantity", "1");
		
		JSONObject siteSchedule1 = new JSONObject();
		siteSchedule1.put("placeScheduleId", "541");
		siteSchedule1.put("placeDate", "2017-01-23");
		siteSchedule1.put("placeSchedule", "晚上");
		siteSchedule1.put("price", 10000);
		siteSchedule1.put("quantity", "1");
		
		siteSchedules.add(siteSchedule);
		siteSchedules.add(siteSchedule1);
		orderDetail.put("siteSchedules", siteSchedules);
		
		JSONObject orderDetail1 = new JSONObject();
		orderDetail1.put("type", "01");
		orderDetail1.put("orderNo", orderNo);
		orderDetail1.put("ismain", "0");
		orderDetail1.put("placeId", "1");
		orderDetail1.put("placeName", "紫荆花");
		orderDetail1.put("amount", "10000");
		orderDetail1.put("commissionFeeRate", "10");
		
		siteSchedules = Lists.newArrayList();
		JSONObject siteSchedule2 = new JSONObject();
		siteSchedule2.put("placeScheduleId", "177");
		siteSchedule2.put("placeDate", "2017-01-22");
		siteSchedule2.put("placeSchedule", "上午");
		siteSchedule2.put("price", 10000);
		siteSchedule2.put("quantity", "1");
		JSONObject siteSchedule3 = new JSONObject();
		siteSchedule3.put("placeScheduleId", "181");
		siteSchedule3.put("placeDate", "2017-01-23");
		siteSchedule3.put("placeSchedule", "上午");
		siteSchedule3.put("price", 10000);
		siteSchedule3.put("quantity", "1");
		
		siteSchedules.add(siteSchedule2);
		siteSchedules.add(siteSchedule3);
		orderDetail1.put("siteSchedules", siteSchedules);
		
		sites.add(orderDetail);
		sites.add(orderDetail1);
		jsonObject.put("sites",sites);
		//住房**********************************************
		List<JSONObject> rooms = Lists.newArrayList();
		JSONObject room1 = new JSONObject();
		room1.put("type", "02");
		room1.put("orderNo", orderNo);
		room1.put("placeId", "7");
		room1.put("placeName", "豪华双人床");
		room1.put("amount", "3180");
		List<JSONObject> roomSchedules = Lists.newArrayList();
		JSONObject roomSchedule = new JSONObject();
		roomSchedule.put("placeDate", "2017-01-22");
		roomSchedule.put("price", 159);
		roomSchedule.put("quantity", "10");
		JSONObject roomSchedule2 = new JSONObject();
		roomSchedule2.put("placeDate", "2017-01-23");
		roomSchedule2.put("price", 159);
		roomSchedule2.put("quantity", "10");
		roomSchedules.add(roomSchedule);
		roomSchedules.add(roomSchedule2);
		
		room1.put("roomSchedules", roomSchedules);
		
		JSONObject room2 = new JSONObject();
		room2.put("type", "02");
		room2.put("orderNo", orderNo);
		room2.put("placeId", "5");
		room2.put("placeName", "双人大床房");
		room2.put("amount", 5980);
		roomSchedules = Lists.newArrayList();
		JSONObject roomSchedule3 = new JSONObject();
		roomSchedule3.put("placeDate", "2017-01-22");
		roomSchedule3.put("price", 149);
		roomSchedule3.put("quantity", 20);
		JSONObject roomSchedule4 = new JSONObject();
		roomSchedule4.put("placeDate", "2017-01-23");
		roomSchedule4.put("price", 149);
		roomSchedule4.put("quantity", 20);
		roomSchedules.add(roomSchedule3);
		roomSchedules.add(roomSchedule4);
		room2.put("roomSchedules", roomSchedules);
		
		rooms.add(room1);
		rooms.add(room2);
		jsonObject.put("rooms",rooms);
		
		//用餐***********************************************
		
		List<JSONObject> meals = Lists.newArrayList();
		JSONObject meal1 = new JSONObject();
		meal1.put("type", "03");
		meal1.put("orderNo", orderNo);
		meal1.put("placeId", "2");
		meal1.put("mealType", "01");
		meal1.put("placeName", "标准国宴");
		meal1.put("amount", 24760);
		
		List<JSONObject> mealSchedules = Lists.newArrayList();
		JSONObject mealSchedule1 = new JSONObject();
		mealSchedule1.put("placeDate", "2017-01-22");
		mealSchedule1.put("placeSchedule", "中餐");
		mealSchedule1.put("price", 1238);
		mealSchedule1.put("quantity", "10");
		JSONObject mealSchedule2 = new JSONObject();
		mealSchedule2.put("placeDate", "2017-01-22");
		mealSchedule2.put("placeSchedule", "晚餐");
		mealSchedule2.put("price", 1238);
		mealSchedule2.put("quantity", "10");
		
		mealSchedules.add(mealSchedule1);
		mealSchedules.add(mealSchedule2);
		meal1.put("mealSchedules", mealSchedules);
		
		JSONObject meal2 = new JSONObject();
		meal2.put("type", "03");
		meal2.put("mealType", "01");
		meal2.put("orderNo", orderNo);
		meal2.put("placeId", "8");
		meal2.put("placeName", "标准国宴");
		meal2.put("amount", 33980);
		mealSchedules = Lists.newArrayList();
		JSONObject mealSchedule3 = new JSONObject();
		mealSchedule3.put("placeDate", "2017-01-23");
		mealSchedule3.put("placeSchedule", "中餐");
		mealSchedule3.put("price", 1699);
		mealSchedule3.put("quantity", "10");
		JSONObject mealSchedule4 = new JSONObject();
		mealSchedule4.put("placeDate", "2017-01-23");
		mealSchedule4.put("placeSchedule", "晚餐");
		mealSchedule4.put("price", 1699);
		mealSchedule4.put("quantity", "10");
		mealSchedules.add(mealSchedule3);
		mealSchedules.add(mealSchedule4);
		meal2.put("mealSchedules", mealSchedules);
		meals.add(meal1);
		meals.add(meal2);
		jsonObject.put("meals",meals);
		
		/*
		jsonObject.put("itemId", "1");*/
		/*jsonObject.put("quyu", "广州市");
		
		
		jsonObject.put("dealNum", "desc");
		jsonObject.put("istui", "desc");
		jsonObject.put("decorationTime", "desc");
		jsonObject.put("priceSort", "desc");
		jsonObject.put("area", "");
		jsonObject.put("hotelName", "拔高酒店");
		jsonObject.put("city", "");
		jsonObject.put("region", "");
		jsonObject.put("district", "");
		jsonObject.put("star", "");
		jsonObject.put("area", "");
		
		jsonObject.put("person", "");
		jsonObject.put("price", "");
		jsonObject.put("style", "");
		jsonObject.put("support", "");
		
		jsonObject.put("page", "1");
		jsonObject.put("rows", "10");*/
		
		/*jsonObject.put("longitude", longitude);
		 
		jsonObject.put("latitude", latitude);*/
		
		String params = jsonObject.toJSONString();
		
		String sign =CipherUtil.encodeByMD5(AESUtil.NoPaddingEncrypt(params, key), "utf-8");
		jsonObject.put("sign", sign);
		System.out.println(jsonObject.toJSONString());
		params =URLEncoder.encode(URLEncoder.encode(jsonObject.toJSONString()));
		System.out.println("URLEHGHHYFGFncoder>>>>"+params);
		System.out.println("URLDGHFHecoder>>>>"+URLDecoder.decode(params));
		
		
		String url = "";
		String param = "";
		HttpUtils.doPost(url, param);
	}

}
