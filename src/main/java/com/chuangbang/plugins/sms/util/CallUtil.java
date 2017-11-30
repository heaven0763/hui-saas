package com.chuangbang.plugins.sms.util;

import java.rmi.RemoteException;

import org.apache.commons.lang3.StringUtils;
import org.tempuri.WmgwSoapProxy;

import com.chuangbang.framework.util.common.MobileUtil;
import com.chuangbang.framework.util.xml.XMLutil;
import com.chuangbang.plugins.sms.interfacej.SmsClientKeyword;
import com.chuangbang.plugins.sms.interfacej.SmsClientOverage;
import com.chuangbang.plugins.sms.interfacej.SmsClientQueryCall;
import com.chuangbang.plugins.sms.interfacej.SmsClientQueryStatusReport;
import com.chuangbang.plugins.sms.vo.ReturnSms;

public class CallUtil {
	
	final static String STATUS_URL="http://hyt.uewang.net/v2statusApi.aspx";
	final static String  CALL_URL = "http://hyt.uewang.net/v2callApi.aspx";
	public static String OVERAGE_URL = "http://hyt.uewang.net/v2sms.aspx";
	public static String url = "http://hyt.uewang.net/sms.aspx";
	public static String userid = "165";
	public static String account = "chuangbang";
	public static String password = "123456qwe";

	
	final static String MWG_URL = "http://61.145.229.29:7902/MWGate/wmgw.asmx";
	final static String MWGW_URL = "http://61.145.229.28:8803/MWGate/wmgw.asmx";
	
	public static String MWG_account = "J22807";
	public static String MWG_password = "546412";
	
	public static String MWGW_account = "J90602";
	public static String MWGW_password = "662105";
	/**
	 * 
	 * @param content 发送的短信内容
	 * @param mobileString 目标手机号码,多个手机号码以英文逗号隔开
	 * @return
	 */
	public static String sendmsg(String content,String mobile){
		//短信提交  
		if(StringUtils.isNotBlank(mobile)&&MobileUtil.isMobileNO(mobile)){
			 WmgwSoapProxy wmgwSoapProxy = new WmgwSoapProxy();
			  try {
				String result = wmgwSoapProxy.mongateCsSpSendSmsNew(MWG_account, MWG_password, mobile, content, 1, "");
				System.out.println(">>>>>>>>>>>>"+result);
				return "SUCCESS";
			} catch (RemoteException e) {
				e.printStackTrace();
				return "FAIL";
			}
		}else{
			return "FAIL";
		}
		
	}
	
	public static String queryKeyWord(String content){
		SmsClientKeyword smsClientKeyword = new  SmsClientKeyword();
		String submitresult=smsClientKeyword.queryKeyWord(url, userid, account, password, content);
		return submitresult;
	}
	
	public static ReturnSms  queryMo(){
		SmsClientOverage smsClientOverage = new  SmsClientOverage();
		String querymoresult=smsClientOverage.queryOverage(url, userid, account, password);
		ReturnSms returnSms = (ReturnSms) XMLutil.xmlStrToBean(querymoresult, ReturnSms.class);
		return returnSms;
	}
	public static String  queryCall(){
		SmsClientQueryCall smsClientQueryCall = new  SmsClientQueryCall();
		String querymoresult=smsClientQueryCall.queryStatusReport(CALL_URL, userid, account, password);
		return querymoresult;
	}
	
	public static String  queryStatus(){
		SmsClientQueryStatusReport smsClientQueryStatusReport = new  SmsClientQueryStatusReport();
		String querymoresult=smsClientQueryStatusReport.queryStatusReport(STATUS_URL, userid, account, password);
		return querymoresult;
	}
	
	public static void main(String[] args) {
		//以下信息，根据自己的账户信息修改
		
		//发送的短信内容和目标手机号码,多个手机号码以英文逗号隔开。
		String content = "【会掌柜】您的验证码为685221；十分钟内有效!";
		String mobileString = "13632332694";
		//短信提交
		
		String returnSmss = CallUtil.sendmsg(content, mobileString);
		System.out.println(returnSmss);
		//查询余额
		/*ReturnSms returnSms = CallUtil.queryMo();
		System.out.println(returnSms.getOverage());*/
		
		/*//状态报告
		String reportresult=CallUtil.queryStatus();
		System.out.println(reportresult);
		
		//短信回复
		String receiveresult=CallUtil.queryCall();
		System.out.println(receiveresult);
		
		//检查关键字
		String keyresult  = CallUtil.queryKeyWord(content);
		System.out.println(keyresult);*/

	}

}
