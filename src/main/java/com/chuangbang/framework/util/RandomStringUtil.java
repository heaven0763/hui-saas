package com.chuangbang.framework.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

public class RandomStringUtil {
	private static final char[] symbols = new char[62];

	static {
		for (int idx = 0; idx < 10; ++idx)
			symbols[idx] = (char) ('0' + idx);
		for (int idx = 10; idx < 36; ++idx)
			symbols[idx] = (char) ('a' + idx - 10);
		for (int idx = 36; idx < 62; ++idx)
			symbols[idx] = (char) ('A' + idx - 36); 
	}

	private final static Random random = new Random();

	private static char[] buf;

	public static String nextString(int length)
	{
		if (length < 1)
			throw new IllegalArgumentException("length < 1: " + length);
		buf = new char[length];
		for (int idx = 0; idx < buf.length; ++idx) 
			buf[idx] = symbols[random.nextInt(symbols.length)];
		return new String(buf);
	}

	/**
	 * 
	 * @param machineId  集群机器数 1~9；
	 * @return
	 */
	public static String getOrderIdByUUid(int machineId){
		int hashCodeV = UUID.randomUUID().hashCode();
		if(hashCodeV<0){
			hashCodeV = - hashCodeV;
		}
		return machineId+String.format("%09d", hashCodeV);
	}
	public static String getByUUid(){
		int hashCodeV = UUID.randomUUID().hashCode();
		if(hashCodeV<0){
			hashCodeV = - hashCodeV;
		}
		return String.format("%09d", hashCodeV);
	}
	
	public static String getByUUid(String uuid){
		int hashCodeV = uuid.hashCode();
		if(hashCodeV<0){
			hashCodeV = - hashCodeV;
		}
		return String.format("%010d", hashCodeV);
	}
	public static void main(String[] args) {
		System.out.println(RandomStringUtil.nextString(32));
		System.out.println(RandomStringUtil.getByUUid("bd125a73-dcc1-47fb-89e5-b2cf85149337"));
		System.out.println(RandomStringUtil.getByUUid("c1926501-e8f6-4712-ae66-dabf3c082a90"));
		System.out.println("http://saas.hui-china.com/hui/static/uploadfiles/image/images/20171107/2017-11-07-19-11-46-104111.jpg".indexOf("/static"));
	}

	public static String getOrderNo(int len){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String ymd = sdf.format(new Date());  
		return ymd+nextNumString(len);
	}
	
	public static String getWthdrwNo(int len){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String ymd = sdf.format(new Date());  
		return ymd+nextNumString(len);
	}
	
	
	public static String nextNumString(int length) {
		if (length < 1)
			throw new IllegalArgumentException("length < 1: " + length);
		buf = new char[length];
		for (int idx = 0; idx < buf.length; ++idx) 
			buf[idx] = symbols[random.nextInt(10)];
		return new String(buf);
	}
	public static String getConsumeCode(String orderNo) throws Exception {

		return CipherUtil.Bit16(orderNo);
	}
	
}
