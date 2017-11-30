package com.chuangbang.plugins.mail.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.plugins.mail.MailInfo;
import com.chuangbang.plugins.mail.SimpleMailSender;

@Component
@Transactional(readOnly = true)
public class EmailService {
	private static Logger logger = LoggerFactory.getLogger(EmailService.class);
	public static String templatePath = "/src/main/java/com/chuangbang/email/template";
	public static String templatePath2 = "WEB-INF/classes/com/chuangbang/email/template";
	@Autowired
	private ChatRecordService chatRecordService;
	
	@Transactional(readOnly = false)
	public Json sendeMail(String email,String title,String content) {
		Json json = new Json();
		try {
			if(StringUtils.isBlank(email)){
				json.setError("邮箱地址为空，请完善邮箱资料！");
				return json;
			}
			if(!isEmail(email)){
				json.setError("邮箱地址格式不合法，请检查邮箱资料！");
				return json;
			}
			//这个类主要是设置邮件  
			MailInfo mailInfo = new MailInfo();   
			mailInfo.setMailServerHost("smtp.exmail.qq.com");   
			mailInfo.setMailServerPort("25");   
			mailInfo.setValidate(true);   
			mailInfo.setUserName("support@hui-china.com");   
			mailInfo.setPassword("su0909HZG");//您的邮箱密码   
			mailInfo.setFromName("会掌柜");
			mailInfo.setFromAddress("support@hui-china.com");   
			mailInfo.setToAddress(email);   
			mailInfo.setSubject(title);   
			mailInfo.setContent(content);   
			//这个类主要来发送邮件  
			//SimpleMailSender.sendTextMail(mailInfo);//发送文体格式   System.getProperty(Constant.WORKDIR)+
			
			Boolean bol = SimpleMailSender.sendMail(mailInfo,"html","","");//发送html格式
			if(bol){
				json.setJson(true, "发送成功！");
				chatRecordService.log("EMAIL", title,content , null, "", "EMAIL", email, "邮件记录");
			}else{
				json.setError("发送错误，请重新发送！");
			}
		} catch (Exception e) {
			json.setError("发送错误，请重新发送！");
			e.printStackTrace();
		}
		return json;
	}
	
	
	
	
	/** 
	 * 检测邮箱地址是否合法 
	 * @param email 
	 * @return true合法 false不合法 
	 */  
	private boolean isEmail(String email){  
		if (null==email || "".equals(email)) return false;    
		Pattern p =  Pattern.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");//复杂匹配  
		Matcher m = p.matcher(email);  
		return m.matches();  
	}  
}
