package com.chuangbang.framework.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {
	
	
	public static String NoPaddingEncrypt(String sSrc, String sKey) throws Exception {
        if (sKey == null) {
            System.out.print("Key为空null");
            return null;
        }
        // 判断Key是否为16位
        if (sKey.length() != 16) {
            System.out.print("Key长度不是16位");
            return null;
        }
        byte[] raw = sKey.getBytes();
       
        Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
        int blockSize = cipher.getBlockSize();
        byte[] dataBytes = sSrc.getBytes();
        int plaintextLength = dataBytes.length;
        if (plaintextLength % blockSize != 0) {
          plaintextLength = plaintextLength + (blockSize - (plaintextLength % blockSize));
        }
        byte[] plaintext = new byte[plaintextLength];
        System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);
        
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        IvParameterSpec iv = new IvParameterSpec("0102030405060708".getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
        
        byte[] encrypted = cipher.doFinal(plaintext);
        return byte2hex(encrypted).toUpperCase();
    }
	
	// 解密
    public static String NoPaddingDecrypt(String sSrc, String sKey) throws Exception {
        try {
            // 判断Key是否正确
            if (sKey == null) {
                System.out.print("Key为空null");
                return null;
            }
            // 判断Key是否为16位
            if (sKey.length() != 16) {
                System.out.print("Key长度不是16位");
                return null;
            }
            byte[] raw = sKey.getBytes("ASCII");
            SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
            IvParameterSpec iv = new IvParameterSpec("0102030405060708".getBytes());
            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
            byte[] encrypted1 = hex2byte(sSrc);
            try {
                byte[] original = cipher.doFinal(encrypted1);
                String originalString = new String(original);
                return originalString;
            } catch (Exception e) {
                System.out.println(e.toString());
                return null;
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return null;
        }
    }
    
    // 加密
    public static String Encrypt(String sSrc, String sKey) throws Exception {
        if (sKey == null) {
            System.out.print("Key为空null");
            return null;
        }
        // 判断Key是否为16位
        if (sKey.length() != 16) {
            System.out.print("Key长度不是16位");
            return null;
        }
        byte[] raw = sKey.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        IvParameterSpec iv = new IvParameterSpec("0102030405060708".getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
        byte[] encrypted = cipher.doFinal(sSrc.getBytes());

        return byte2hex(encrypted).toLowerCase();
    }

    // 解密
    public static String Decrypt(String sSrc, String sKey) throws Exception {
        try {
            // 判断Key是否正确
            if (sKey == null) {
                System.out.print("Key为空null");
                return null;
            }
            // 判断Key是否为16位
            if (sKey.length() != 16) {
                System.out.print("Key长度不是16位");
                return null;
            }
            byte[] raw = sKey.getBytes("ASCII");
            SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            IvParameterSpec iv = new IvParameterSpec("0102030405060708".getBytes());
            cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
            byte[] encrypted1 = hex2byte(sSrc);
            try {
                byte[] original = cipher.doFinal(encrypted1);
                String originalString = new String(original);
                return originalString;
            } catch (Exception e) {
                System.out.println(e.toString());
                return null;
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return null;
        }
    }

    public static byte[] hex2byte(String strhex) {
        if (strhex == null) {
            return null;
        }
        int l = strhex.length();
        if (l % 2 == 1) {
            return null;
        }
        byte[] b = new byte[l / 2];
        for (int i = 0; i != l / 2; i++) {
            b[i] = (byte) Integer.parseInt(strhex.substring(i * 2, i * 2 + 2),
                    16);
        }
        return b;
    }

    public static String byte2hex(byte[] b) {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1) {
                hs = hs + "0" + stmp;
            } else {
                hs = hs + stmp;
            }
        }
        return hs.toUpperCase();
    }

    public static void main(String[] args) throws Exception {
        /*
         * 加密用的Key 可以用26个字母和数字组成，最好不要用保留字符，虽然不会错，至于怎么裁决，个人看情况而定
         */
        String cKey = "ZEMwcrdVhjibkmMn";
        // 需要加密的字串
        String cSrc = "{\"activityDate\":\"2017-09-16\",\"activityTitle\":\"ghahadf峰会\",\"amount\":\"293418\",\"clientId\":\"1366\",\"contactNumber\":\"15920443565\",\"diningAmount\":\"48750\",\"finalPayment\":\"293418\",\"hotelId\":\"1\",\"hotelSaleId\":\"6efeedbc-fa5c-427f-8a2b-a5c2b551cf1c\",\"key\":\"31507459\",\"linkman\":\"刘小姐\",\"meals\":[{\"amount\":24760,\"mealSchedules\":[{\"mealType\":\"01\",\"placeDate\":\"2017-09-16\",\"placeSchedule\":\"午餐\",\"price\":1238,\"quantity\":20}],\"placeId\":\"2\",\"quantity\":20},{\"amount\":23990,\"mealSchedules\":[{\"mealType\":\"02\",\"placeDate\":\"2017-09-16\",\"placeSchedule\":\"晚餐\",\"price\":239.9,\"quantity\":100}],\"placeId\":\"9\",\"quantity\":20}],\"notifyUrl\":\"http://hui.xindong99.com/\",\"orderNo\":\"20170907162938463360\",\"organizer\":\"dgdhdasee\",\"prepaid\":\"0\",\"roomAmount\":\"48000\",\"rooms\":[{\"amount\":48000,\"placeId\":7,\"quantity\":40,\"roomSchedules\":[{\"breakfast\":0,\"placeDate\":\"2017-06-15\",\"price\":1200,\"quantity\":20},{\"breakfast\":0,\"placeDate\":\"2017-09-16\",\"price\":1200,\"quantity\":20}]}],\"settlementStatus\":\"01\",\"siteAmount\":\"196668\",\"siteCommissionFee\":\"0\",\"sites\":[{\"amount\":196668,\"commissionFeeRate\":0,\"ismain\":\"1\",\"placeId\":\"2\",\"siteSchedules\":[{\"placeDate\":\"2017-09-16\",\"placeSchedule\":\"ALL\",\"placeScheduleId\":1696,\"price\":196668,\"quantity\":1}]}],\"state\":\"01\",\"zgamount\":\"293418\",\"zgdiscount\":100}";
        System.out.println(cSrc);
        // 加密
        long lStart = System.currentTimeMillis();
        String enString = AESUtil.NoPaddingEncrypt(cSrc, cKey);
        System.out.println("加密后的字串是：" + enString);

        long lUseTime = System.currentTimeMillis() - lStart;
        System.out.println("加密耗时：" + lUseTime + "毫秒");
        // 解密
        lStart = System.currentTimeMillis();
        String DeString = AESUtil.NoPaddingDecrypt(enString, cKey);
        System.out.println("解密后的字串是：" + DeString);
        lUseTime = System.currentTimeMillis() - lStart;
        System.out.println("解密耗时：" + lUseTime + "毫秒");
    }
}
