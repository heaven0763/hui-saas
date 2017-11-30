package com.chuangbang.framework.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BrowseTool {
	public final static String IE9="MSIE 9.0";  
	public final static String IE8="MSIE 8.0";  
	public final static String IE7="MSIE 7.0";  
	public final static String IE6="MSIE 6.0";  
	public final static String MAXTHON="Maxthon";  
	public final static String QQ="QQBrowser";  
	public final static String GREEN="GreenBrowser";  
	public final static String SE360="360SE";  
	public final static String FIREFOX="Firefox";  
    public final static String OPERA="Opera";  
    public final static String CHROME="Chrome";  
    public final static String SAFARI="Safari";  
    public final static String MicroMessenger="MicroMessenger";
    public final static String OTHER="其它";  
      
     
    public static boolean isWeixin(String userAgent){
    	 if(regex(MicroMessenger,userAgent))return true;
    	 if(regex("Mobile",userAgent))return true;//为了方便测试
    	 return false;
    }
    public 	static String checkBrowse(String userAgent){  
        if(regex(OPERA, userAgent))return OPERA;  
        if(regex(CHROME, userAgent))return CHROME;  
        if(regex(FIREFOX, userAgent))return FIREFOX;  
        if(regex(SAFARI, userAgent))return SAFARI;  
        if(regex(SE360, userAgent))return SE360;  
        if(regex(GREEN,userAgent))return GREEN;  
        if(regex(QQ,userAgent))return QQ;  
        if(regex(MAXTHON, userAgent))return MAXTHON;  
        if(regex(IE9,userAgent))return IE9;  
        if(regex(IE8,userAgent))return IE8;  
        if(regex(IE7,userAgent))return IE7;  
        if(regex(IE6,userAgent))return IE6;  
        if(regex(MicroMessenger,userAgent))return MicroMessenger;  
        return OTHER;  
    }  
    public static boolean regex(String regex,String str){  
        Pattern p =Pattern.compile(regex,Pattern.MULTILINE);  
        Matcher m=p.matcher(str);  
        return m.find();  
    }  
      
    public static void main(String[] args) {  
        String ie9    ="Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)";  
        String ie8    ="Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322)";  
        String ie7    ="Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2; .NET CLR 1.1.4322)";  
        String ie6    ="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322)";  
        String aoyou  ="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; Maxthon 2.0)";  
        String qq     ="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322) QQBrowser/6.8.10793.201";  
        String green  ="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; GreenBrowser)";  
        String se360  ="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; 360SE)";  
          
        String chrome ="Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.11 (KHTML, like Gecko) Chrome/9.0.570.0 Safari/534.11";                 
        String safari ="Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8";  
        String fireFox="Mozilla/5.0 (Windows NT 5.2; rv:7.0.1) Gecko/20100101 Firefox/7.0.1";  
        String opera  ="Opera/9.80  (Windows NT 5.2; U; zh-cn) Presto/2.9.168 Version/11.51";  
        String other  ="(Windows NT 5.2; U; zh-cn) Presto/2.9.168 Version/11.51";  
        BrowseTool b=new BrowseTool();  
        System.out.println(BrowseTool.checkBrowse(ie9));  
        System.out.println(BrowseTool.checkBrowse(ie8));  
        System.out.println(BrowseTool.checkBrowse(ie7));  
        System.out.println(BrowseTool.checkBrowse(ie6));  
        System.out.println(BrowseTool.checkBrowse(aoyou));  
        System.out.println(BrowseTool.checkBrowse(qq));  
        System.out.println(BrowseTool.checkBrowse(green));  
        System.out.println(BrowseTool.checkBrowse(se360));  
        System.out.println(BrowseTool.checkBrowse(chrome));  
        System.out.println(BrowseTool.checkBrowse(safari));  
        System.out.println(BrowseTool.checkBrowse(fireFox));  
        System.out.println(BrowseTool.checkBrowse(opera));  
        System.out.println(BrowseTool.checkBrowse(other));  
    }  
}
