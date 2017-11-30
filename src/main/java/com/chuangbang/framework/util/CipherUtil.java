package com.chuangbang.framework.util;

import java.math.BigInteger;
import java.security.MessageDigest;

import org.apache.commons.codec.binary.Hex;

import com.chuangbang.framework.constant.Constant;

/** 
 * 对密码进行加密和验证的类
 */
public class CipherUtil{
    //十六进制下数字到字符的映射数组
    private final static String[] hexDigits = {"0", "1", "2", "3", "4",
        "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};
    
    private static final int RADIX = 16;
	private static final String SEED = "0933910847463829232312312";
    
    /** * 把inputString加密     */
    public static String generatePassword(String inputString){
        return encodeByMD5(inputString);
    }
    
      /**
       * 验证输入的密码是否正确
     * @param password    加密后的密码
     * @param inputString    输入的字符串
     * @return    验证结果，TRUE:正确 FALSE:错误
     */
    public static boolean validatePassword(String password, String inputString){
        if(password.equals(encodeByMD5(inputString))){
            return true;
        } else{
            return false;
        }
    }
    /**  对字符串进行MD5加密     */
    private static String encodeByMD5(String originString){
        if (originString != null){
            try{
                //创建具有指定算法名称的信息摘要
                MessageDigest md = MessageDigest.getInstance("MD5");
                //使用指定的字节数组对摘要进行最后更新，然后完成摘要计算
                byte[] results = md.digest(originString.getBytes());
                //将得到的字节数组变成字符串返回
                String resultString = byteArrayToHexString(results);
                return resultString.toUpperCase();
            } catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return null;
    }
    
    /**  对字符串进行MD5加密     */
    /**
     * 
     * @param originString
     * @param characterEncoding
     * @return
     */
    public static String encodeByMD5(String originString,String characterEncoding){
        if (originString != null){
            try{
                //创建具有指定算法名称的信息摘要
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(originString.getBytes(characterEncoding));
                //使用指定的字节数组对摘要进行最后更新，然后完成摘要计算
                byte[] results = md.digest();
                //将得到的字节数组变成字符串返回
                String resultString = byteArrayToHexString(results);
                return resultString.toUpperCase();
            } catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return null;
    }
    
    /** 
     * 转换字节数组为十六进制字符串
     * @param     字节数组
     * @return    十六进制字符串
     */
    public static String byteArrayToHexString(byte[] b){
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++){
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }
    
    /** 将一个字节转化成十六进制形式的字符串     */
    private static String byteToHexString(byte b){
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }
    
    public static final String encrypt(String password) {
		if (password == null)
			return "";
		if (password.length() == 0)
			return "";

		BigInteger bi_passwd = new BigInteger(password.getBytes());

		BigInteger bi_r0 = new BigInteger(SEED);
		BigInteger bi_r1 = bi_r0.xor(bi_passwd);

		return bi_r1.toString(RADIX);
	}

	public static final String decrypt(String encrypted) {
		if (encrypted == null)
			return "";
		if (encrypted.length() == 0)
			return "";

		BigInteger bi_confuse = new BigInteger(SEED);

		try {
			BigInteger bi_r1 = new BigInteger(encrypted, RADIX);
			BigInteger bi_r0 = bi_r1.xor(bi_confuse);

			return new String(bi_r0.toByteArray());
		} catch (Exception e) {
			return "";
		}
	}
	
	public static final String encrypt(String password,final String key) {
		if (password == null)
			return "";
		if (password.length() == 0)
			return "";

		BigInteger bi_passwd = new BigInteger(password.getBytes());

		BigInteger bi_r0 = new BigInteger(key);
		BigInteger bi_r1 = bi_r0.xor(bi_passwd);

		return bi_r1.toString(RADIX);
	}

	public static final String decrypt(String encrypted,final String key) {
		if (encrypted == null)
			return "";
		if (encrypted.length() == 0)
			return "";

		BigInteger bi_confuse = new BigInteger(key);

		try {
			BigInteger bi_r1 = new BigInteger(encrypted, RADIX);
			BigInteger bi_r0 = bi_r1.xor(bi_confuse);

			return new String(bi_r0.toByteArray());
		} catch (Exception e) {
			return "";
		}
	}
	
	public static String Bit32(String SourceString) throws Exception {  
	    MessageDigest digest = java.security.MessageDigest.getInstance("MD5");  
	    digest.update(SourceString.getBytes());  
	    byte messageDigest[] = digest.digest();  
	    return byteArrayToHexString(messageDigest);  
	} 
	public static String Bit16(String SourceString) throws Exception {  
	    return Bit32(SourceString).substring(8, 24);  
	} 
	
	public static void main(String[] args) {
		String mms = "acVnV5H2lAV7sLOs5hJ3DAQwZShI6kXEd8OQYyM4ckj4oVZNlkZcg9NZq+83a/YDQQZFAlvv4NvI";
		mms += "7U07kV2yoghIujbvH0yIiKTinTW4jMkhqPVcWndwFJZKEsTnAbjQJSJg3HT/9aUB/aD+mBT9q5Hn";
		mms += "Iq/YnVixz6jumP4iIV8hyCwyaLjKMpiNLonvKUYrXkAyVMW6Yktih9z+c9nfiMT/SVZ6gCz+STlm";
		mms += "+/oIhwsSbZOlpMe6uoQG0/zvn33jtavvCKX84B8ZrLR3jWMZbpNh3mwqOxze/+NiebtKStaQxset";
		mms += "h3Lhq17DJoFotX0Y+wKee786NDZhW22Y9UEVkhFk7ivRsqHM0JHuMpkFuRb/W7JZr5g9cE3Zhymk";
		mms += "ST1PG9/QnX6Z+ZSXXkemjDvxOTNUFvPXPwcP5rJ2WaFptqdhWobYzRsAwK6gUqUVZ43ZvL8tAToD";
		mms += "mEE6T44BqS0Ad8W3dXEfroIid+CjKR67OnK3D0/ThjCPKUBGJv11GWjg2XSXBSitRNBrXLqcET3h";
		mms += "UdsmlgpRBywQ3VjiZL7jmQ2kByfpvO1rqIasT3IXmGYK0jgwxeL6t0/L99EDHnu1ESA/EcOcaLao";
		mms += "PYsCY/q8Ij2aVi9AMPOCVLrpUnYqqXlcIrYdo4vEoxahFv8LeUCfHHgutTBoHAIQ5k+u0uUnk0lT";
		mms += "dV6bpnuwSDEyMlQiRpU0w3Ch2gC3X2SPuf9AJZ+3uXsEU6H7Aygn3mOyjRi6vF4O4yib7gEQn4E9";
		mms += "4lPEJvgJrpHVNhHDE3WXZJnf4qAwyLXxju9BuPJxsjWdEu9SktWz4k5hO0ui/sg/vTIiFcDlczHN";
		mms += "Fqy/xW5SizPFbr91h/VLkFa89DVu+5WAYtF/y9A7Ea7wStCAtX9LXfWA5FacIwXTlFLP+V6MqdVr";
		mms += "wfZo67h5XeqfEzYCngDE3w/Hsd8BDlmgq3IBvlrFnpnu1TJ+2zTiAE0h3Y8GjPu9G8w4h4PNbxNj";
		mms += "NqznPPFq3Yn4RBJWCcOw35IXvAr+HgVQM0n7fRPW8kTsXuW836lgNqzZBf4/cARvW7JzodvnS1UZ";
		mms += "WaoaQVdfrP5A4CXURBfuatAaSbQ6KDqYvBO+n6yVXVZ8z6MAb0c/ZJ8bMHk/bpVAo0CyRmKVZApK";
		mms += "RGKDfk9+47Cc1FkJv3/jdW7LkddJfrp8mjiVUT/K8uDpF9FlF+EoZdl6h2yOZqGt4xS+p3JsnWCE";
		mms += "FySoEkbZ7s8faR9THeyN+juUwi6+OZg5Sgq7lBLp+6jMTczRg7dpjSrEk5vGanK3DwrXWA5cpXz0";
		mms += "B9w3kkxHVC30o7GI3xj+r1iLKa0ABILuWgJsGLO+qgRn+EMoMNUwjarRDjDtzguHAiDdWyER8KFO";
		mms += "akAI7Tey7xBuhTAGerJqnc5m6eBkIuUiu4rHe/Sn7TsO/vAgi1E9X/7Iszu2Bfd22etcuF1S4av3";
		mms += "tEZ1LsaO4+DIHrd/9ji9BFvk3vu1WYhYrar1rn3f2z4/eYp1AM/TcVELezsOqaV6B9GJVxgwuKHy";
		mms += "omTrqOg5/cas9PZlAGenUDDRGqitGL/NmN7kwLg3C2Zxg/Vq3uRZmgDgzfpOTpcifQGL+hDluZnz";
		mms += "mIJwn7R6X9M3MEUMmYG5Nn5/HgWB5eyZrtMjVzGZ7ZG6c2GDv9K2yjdCiY1D/hNgGYqTXuYve7nm";
		mms += "MXhHdWb/1VV53A==";
		
		String mmss = "acVnV5H2lAV7sLOs5hJ3DAQwZShI6kXEd8OQYyM4ckj4oVZNlkZcg9NZq+83a/YDQQZFAlvv4NvI";
		mmss += "7U07kV2yoghIujbvH0yIiKTinTW4jMkhqPVcWndwFJZKEsTnAbjQJSJg3HT/9aUB/aD+mBT9q5Hn";
		mmss += "Iq/YnVixz6jumP4iIV8hyCwyaLjKMpiNLonvKUYrXkAyVMW6Yktih9z+c9nfiMT/SVZ6gCz+STlm";
		mmss += "+/oIhwsSbZOlpMe6uoQG0/zvn33jtavvCKX84B8ZrLR3jWMZbpNh3mwqOxze/+NiebtKStaQxset";
		mmss += "h3Lhq17DJoFotX0Y+wKee786NDZhW22Y9UEVkhFk7ivRsqHM0JHuMpkFuRb/W7JZr5g9cE3Zhymk";
		mmss += "ST1PG9/QnX6Z+ZSXXkemjDvxOTNUFvPXPwcP5rJ2WaFptqdhWobYzRsAwK6gUqUVZ43ZvL8tAToD";
		mmss += "mEE6T44BqS0Ad8W3dXEfroIid+CjKR67OnK3D0/ThjCPKUBGJv11GWjg2XSXBSitRNBrXLqcET3h";
		mmss += "UdsmlgpRBywQ3VjiZL7jmQ2kByfpvO1rqIasT3IXmGYK0jgwxeL6t0/L99EDHnu1ESA/EcOcaLao";
		mmss += "PYsCY/q8Ij2aVi9AMPOCVLrpUnYqqXlcIrYdo4vEoxahFv8LeUCfHHgutTBoHAIQ5k+u0uUnk0lT";
		mmss += "dV6bpnuwSDEyMlQiRpU0w3Ch2gC3X2SPuf9AJZ+3uXsEU6H7Aygn3mOyjRi6vF4O4yib7gEQn4E9";
		mmss += "4lPEJvgJrpHVNhHDE3WXZJnf4qAwyLXxju9BuPJxsjWdEu9SktWz4k5hO0ui/sg/vTIiFcDlczHN";
		mmss += "Fqy/xW5SizPFbr91h/VLkFa89DVu+5WAYtF/y9A7Ea7wStCAtX9LXfWA5FacIwXTlFLP+V6MqdVr";
		mmss += "wfZo67h5XeqfEzYCngDE3w/Hsd8BDlmgq3IBvlrFnpnu1TJ+2zTiAE0h3Y8GjPu9G8w4h4PNbxNj";
		mmss += "NqznPPFq3Yn4RBJWCcOw35IXvAr+HgVQM0n7fRPW8kTsXuW836lgNqzZBf4/cARvW7JzodvnS1UZ";
		mmss += "WaoaQVdfrP5A4CXURBfuatAaSbQ6KDqYvBO+n6yVXVZ8z6MAb0c/ZJ8bMHk/bpVAo0CyRmKVZApK";
		mmss += "RGKDfk9+47Cc1FkJv3/jdW7LkddJfrp8mjiVUT/K8uDpF9FlF+EoZdl6h2yOZqGt4xS+p3JsnWCE";
		mmss += "FySoEkbZ7s8faR9THeyN+juUwi6+OZg5Sgq7lBLp+6jMTczRg7dpjSrEk5vGanK3DwrXWA5cpXz0";
		mmss += "B9w3kkxHVC30o7GI3xj+r1iLKa0ABILuWgJsGLO+qgRn+EMoMNUwjarRDjDtzguHAiDdWyER8KFO";
		mmss += "akAI7Tey7xBuhTAGerJqnc5m6eBkIuUiu4rHe/Sn7TsO/vAgi1E9X/7Iszu2Bfd22etcuF1S4av3";
		mmss += "tEZ1LsaO4+DIHrd/9ji9BFvk3vu1WYhYrar1rn3f2z4/eYp1AM/TcVELezsOqaV6B9GJVxgwuKHy";
		mmss += "omTrqOg5/cas9PZlAGenUDDRGqitGL/NmN7kwLg3C2Zxg/Vq3uRZmgDgzfpOTpcifQGL+hDluZnz";
		mmss += "mIJwn7R6X9M3MEUMmYG5Nn5/HgWB5eyZrtMjVzGZ7ZG6c2GDv9K2yjdCiY1D/hNgGYqTXuYve7nm";
		mmss += "MXhHdWb/1VV53A==";
		
		System.out.println(mmss.equals(mms));
		System.out.println(CipherUtil.encodeByMD5(mms));
		System.out.println(CipherUtil.encodeByMD5(mmss));
		/*String pwd1=Constant.ENCRYPT_KEY;
		String key = "7866660105972784";
		System.out.println(">>>>>"+pwd1);
		String miwen = CipherUtil.encrypt(pwd1, key);
		System.out.println("密文:"+miwen);
		String mingwen = CipherUtil.decrypt(miwen, key);
		System.out.print("明文"+mingwen);*/
	}

}