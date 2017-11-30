package com.chuangbang.plugins.mail;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;

import com.chuangbang.base.entity.order.Order;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.generatecode.util.FreeMarkers;
import com.google.common.collect.Maps;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**  
 * 简单邮件（不带附件的邮件）发送器  
 */   
public class SimpleMailSender  {   
	
	private static Logger logger = LoggerFactory.getLogger(SimpleMailSender.class);
	
	private static String templatePath = "/src/main/java/com/chuangbang/email/template";
	/**  
	 * 以文本格式发送邮件  
	 * @param mailInfo 待发送的邮件的信息  
	 */   
	public static boolean sendTextMail(MailInfo mailInfo) {   
		// 判断是否需要身份认证   
		MyAuthenticator authenticator = null;   
		Properties pro = mailInfo.getProperties();  
		if (mailInfo.isValidate()) {   
			// 如果需要身份认证，则创建一个密码验证器   
			authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());   
		}  
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session   
		Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
		try {   
			// 根据session创建一个邮件消息   
			Message mailMessage = new MimeMessage(sendMailSession);   
			// 创建邮件发送者地址   
			Address from = new InternetAddress(mailInfo.getFromAddress());   
			// 设置邮件消息的发送者   
			mailMessage.setFrom(from);   
			// 创建邮件的接收者地址，并设置到邮件消息中   
			Address to = new InternetAddress(mailInfo.getToAddress());   
			mailMessage.setRecipient(Message.RecipientType.TO,to);   
			// 设置邮件消息的主题   
			mailMessage.setSubject(mailInfo.getSubject());   
			// 设置邮件消息发送的时间   
			mailMessage.setSentDate(new Date());   
			// 设置邮件消息的主要内容   
			String mailContent = mailInfo.getContent();   
			mailMessage.setText(mailContent);   
			// 发送邮件   
			Transport.send(mailMessage);  
			return true;   
		} catch (MessagingException ex) {   
			ex.printStackTrace();   
		}   
		return false;   
	}   

	/**  
	 * 以HTML格式发送邮件  
	 * @param mailInfo 待发送的邮件信息  
	 */   
	public static boolean sendHtmlMail(MailInfo mailInfo){   
		// 判断是否需要身份认证   
		MyAuthenticator authenticator = null;  
		Properties pro = mailInfo.getProperties();  
		//如果需要身份认证，则创建一个密码验证器    
		if (mailInfo.isValidate()) {   
			authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());  
		}   
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session   
		Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
		try {   
			// 根据session创建一个邮件消息   
			Message mailMessage = new MimeMessage(sendMailSession);   
			// 创建邮件发送者地址   
			Address from = new InternetAddress(mailInfo.getFromAddress());   
			// 设置邮件消息的发送者   
			mailMessage.setFrom(from);   
			// 创建邮件的接收者地址，并设置到邮件消息中   
			Address to = new InternetAddress(mailInfo.getToAddress());   
			// Message.RecipientType.TO属性表示接收者的类型为TO   
			mailMessage.setRecipient(Message.RecipientType.TO,to);   
			// 设置邮件消息的主题   
			mailMessage.setSubject(mailInfo.getSubject());   
			// 设置邮件消息发送的时间   
			mailMessage.setSentDate(new Date());   
			// MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象   
			Multipart mainPart = new MimeMultipart();   
			// 创建一个包含HTML内容的MimeBodyPart   
			BodyPart html = new MimeBodyPart();   
			// 设置HTML内容   
			html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");   
			mainPart.addBodyPart(html);   
			// 将MiniMultipart对象设置为邮件内容   
			mailMessage.setContent(mainPart);   
			// 发送邮件   
			Transport.send(mailMessage);   
			return true;   
		} catch (MessagingException ex) {   
			ex.printStackTrace();   
		}   
		return false;   
	}   

	public static boolean sendMail(MailInfo mailInfo,String format,String img,String attachment){

		if(format.equals("html")){
			if(StringUtils.isNotBlank(img)&&StringUtils.isNotBlank(attachment)){
				return sendMixedMail(mailInfo, attachment, img);
			}else if(StringUtils.isNotBlank(img)&&StringUtils.isBlank(attachment)){
				return sendImageMail(mailInfo,img);
			}else if(StringUtils.isBlank(img)&&StringUtils.isNotBlank(attachment)){
				return sendAttachMail( mailInfo, attachment);
			}else if(StringUtils.isBlank(img)&&StringUtils.isBlank(attachment)){
				return sendHtmlMail(mailInfo);
			}
		}else{
			return sendTextMail(mailInfo);
		}
		return false;
	}


	/**
	 * 发送一封邮件正文带图片的邮件
	 * @param template
	 * @param mailInfo
	 * @param img
	 * @return
	 */
	public static boolean sendImageMail(MailInfo mailInfo,String img) {
		MyAuthenticator authenticator = null;  
		Properties pro = mailInfo.getProperties();  
		//如果需要身份认证，则创建一个密码验证器    
		if (mailInfo.isValidate()) {   
			authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());  
		}   
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session   
		Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
		try {   //创建邮件
			MimeMessage message = new MimeMessage(sendMailSession);
			// 设置邮件的基本信息
			//发件人
			message.setFrom(new InternetAddress(mailInfo.getFromAddress()));
			//收件人
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailInfo.getToAddress()));
			//邮件标题
			message.setSubject(mailInfo.getSubject());

			// 准备邮件数据
			// 准备邮件正文数据
			MimeBodyPart text = new MimeBodyPart();
			text.setContent(mailInfo.getContent()+"<br/><img src='cid:xxx.jpg'>", "text/html;charset=UTF-8");
			// 准备图片数据
			MimeBodyPart image = new MimeBodyPart();
			DataHandler dh = new DataHandler(new FileDataSource(img));
			image.setDataHandler(dh);
			image.setContentID("xxx.jpg");
			// 描述数据关系
			MimeMultipart mm = new MimeMultipart();
			mm.addBodyPart(text);
			mm.addBodyPart(image);
			mm.setSubType("related");
			
			message.setSentDate(new Date()); 
			message.setContent(mm);
			message.saveChanges();
			//将创建好的邮件写入到E盘以文件的形式进行保存
			//message.writeTo(new FileOutputStream("H:\\EMAIL\\ImageMail.eml"));
			
			Transport.send(message);   
			return true;
		}catch(Exception e){
			
		}
		
		return false;
	}
	/**
	 * 发送一封带附件的邮件
	 * @param template
	 * @param mailInfo
	 * @param attachment
	 * @return
	 * @throws Exception
	 */
	public static boolean sendAttachMail(MailInfo mailInfo,String attachment){
		
		MyAuthenticator authenticator = null;  
		Properties pro = mailInfo.getProperties();  
		//如果需要身份认证，则创建一个密码验证器    
		if (mailInfo.isValidate()) {   
			authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());  
		}   
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session   
		Session sendMailSession = Session.getInstance(pro,authenticator);   
		try {   //创建邮件
			MimeMessage message = new MimeMessage(sendMailSession);
		
			//设置邮件的基本信息
			//发件人
			if(StringUtils.isNotBlank(mailInfo.getFromName())){
				message.setFrom(new InternetAddress(mailInfo.getFromAddress(),mailInfo.getFromName(),"UTF-8"));
			}else{
				message.setFrom(new InternetAddress(mailInfo.getFromAddress()));
			}
			
			//收件人
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailInfo.getToAddress()));
			//邮件标题
			message.setSubject(mailInfo.getSubject());
		
			//创建邮件正文，为了避免邮件正文中文乱码问题，需要使用charset=UTF-8指明字符编码
			MimeBodyPart text = new MimeBodyPart();
			text.setContent(mailInfo.getContent(), "text/html;charset=UTF-8");
		
			//创建邮件附件
			MimeBodyPart attach = new MimeBodyPart();
			DataHandler dh = new DataHandler(new FileDataSource(attachment));
			attach.setDataHandler(dh);
			attach.setFileName(MimeUtility.encodeText(dh.getName()));  //
		
			//创建容器描述数据关系
			MimeMultipart mp = new MimeMultipart();
			mp.addBodyPart(text);
			mp.addBodyPart(attach);
			mp.setSubType("mixed");
			
			message.setSentDate(new Date()); 
			message.setContent(mp);
			message.saveChanges();
			//将创建的Email写入到E盘存储
			//message.writeTo(new FileOutputStream("H:\\EMAIL\\attachMail.eml"));
			
			Transport.send(message);   
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 发送一封带附件和带图片的邮件
	 * @param template
	 * @param mailInfo
	 * @param attachment
	 * @param img
	 * @return
	 * @throws Exception
	 */
	public static boolean sendMixedMail(MailInfo mailInfo,String attachment,String img) {
		MyAuthenticator authenticator = null;  
		Properties pro = mailInfo.getProperties();  
		//如果需要身份认证，则创建一个密码验证器    
		if (mailInfo.isValidate()) {   
			authenticator = new MyAuthenticator(mailInfo.getUserName(), mailInfo.getPassword());  
		}   
		// 根据邮件会话属性和密码验证器构造一个发送邮件的session   
		Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
		try {   //创建邮件
			MimeMessage message = new MimeMessage(sendMailSession);
	
			//设置邮件的基本信息
			message.setFrom(new InternetAddress(mailInfo.getFromAddress()));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailInfo.getToAddress()));
			message.setSubject(mailInfo.getSubject());
	
			//正文
			MimeBodyPart text = new MimeBodyPart();
			text.setContent(mailInfo.getContent()+"<img style='text-align:center;' src='cid:aaa.jpg'>","text/html;charset=UTF-8");
	
			//图片
			MimeBodyPart image = new MimeBodyPart();
			System.out.println(">>>>>>>>>>>>>>>>>>>>>"+img);
			image.setDataHandler(new DataHandler(new FileDataSource(img)));
			image.setContentID("aaa.jpg");
			
			//描述关系:正文和图片
			MimeMultipart mp1 = new MimeMultipart();
			mp1.addBodyPart(text);
			mp1.addBodyPart(image);
			mp1.setSubType("related");
	
			//附件1
			MimeBodyPart attach = new MimeBodyPart();
			DataHandler dh = new DataHandler(new FileDataSource(attachment));
			attach.setDataHandler(dh);
			attach.setFileName(dh.getName());
	
			/*//附件2
			MimeBodyPart attach2 = new MimeBodyPart();
			DataHandler dh2 = new DataHandler(new FileDataSource("src\\波子.zip"));
			attach2.setDataHandler(dh2);
			attach2.setFileName(MimeUtility.encodeText(dh2.getName()));*/
	
			//描述关系:正文和附件
			MimeMultipart mp2 = new MimeMultipart();
			mp2.addBodyPart(attach);
			//mp2.addBodyPart(attach2);
	
			//代表正文的bodypart
			MimeBodyPart content = new MimeBodyPart();
			content.setContent(mp1);
			mp2.addBodyPart(content);
			mp2.setSubType("mixed");
	
			message.setContent(mp2);
			message.saveChanges();
	
			//message.writeTo(new FileOutputStream("H:\\EMAIL\\MixedMail.eml"));

			Transport.send(message);   
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	public static void sendEmail(Map<String, Object> model,String imgPath,String pdfPath,Order order) throws IOException{  

		// 获取工程路径
		File projectPath = new DefaultResourceLoader().getResource("").getFile();
		while(!new File(projectPath.getPath()+File.separator+"src"+File.separator+"main").exists()){
			projectPath = projectPath.getParentFile();
		}
		logger.info("Project Path: {}", projectPath);
		
		// 模板文件路径
		String tplPath = StringUtils.replace(projectPath + templatePath, "/", File.separator);
		System.out.println(tplPath);
		logger.info("Template Path: {}", tplPath);
		
		
		// 代码模板配置
		Configuration cfg = new Configuration();
		cfg.setDirectoryForTemplateLoading(new File(tplPath));
		Template template = cfg.getTemplate("htmlmail3.ftl","UTF-8");
		template.setEncoding("UTF-8");
		String content = "";//FreeMarkers.renderTemplate(template, model);
		System.out.println(content);
		String title = "【会掌柜】订单详情";
		//这个类主要是设置邮件  
		MailInfo mailInfo = new MailInfo();   
		mailInfo.setMailServerHost("smtp.exmail.qq.com");   
		mailInfo.setMailServerPort("25");   
		mailInfo.setValidate(true);   
		mailInfo.setUserName("support@hui-china.com");   
		mailInfo.setPassword("su0909HZG");//您的邮箱密码   
		mailInfo.setFromName("会掌柜");
		mailInfo.setFromAddress("support@hui-china.com");   
		mailInfo.setToAddress(order.getEmail());   
		mailInfo.setSubject(title);   
		mailInfo.setContent(content);    
		System.out.println(mailInfo.toString());
		//这个类主要来发送邮件  
		//SimpleMailSender.sendTextMail(mailInfo);//发送文体格式   System.getProperty(Constant.WORKDIR)+
		Boolean bol = SimpleMailSender.sendMail(mailInfo,"html",imgPath,pdfPath);//发送html格式
	} 
	
	public static String getEmailContent(Map<String, Object> model,String flt){
		try{
			File projectPath = new DefaultResourceLoader().getResource("").getFile();
			while(!new File(projectPath.getPath()+File.separator+"src"+File.separator+"main").exists()){
				projectPath = projectPath.getParentFile();
			}
			logger.info("Project Path: {}", projectPath);
			
			// 模板文件路径
			String tplPath = StringUtils.replace(projectPath + templatePath, "/", File.separator);
			System.out.println(tplPath);
			logger.info("Template Path: {}", tplPath);
			
			
			// 代码模板配置
			Configuration cfg = new Configuration();
			cfg.setDirectoryForTemplateLoading(new File(tplPath));
			Template template = cfg.getTemplate(flt,"UTF-8");
			template.setEncoding("UTF-8");
			String content = FreeMarkers.renderTemplate(template, model);
			return content;
		}catch(IOException e){
			return null;
		}
	}
	
	
	public static MailInfo getMailInfo(String toMail,String title,String content){
		MailInfo mailInfo = new MailInfo();   
		mailInfo.setMailServerHost("smtp.exmail.qq.com");   
		mailInfo.setMailServerPort("25");   
		mailInfo.setValidate(true);   
		mailInfo.setUserName("support@hui-china.com");   
		mailInfo.setPassword("su0909HZG");//您的邮箱密码   
		mailInfo.setFromName("会掌柜");
		mailInfo.setFromAddress("support@hui-china.com");   
		mailInfo.setToAddress(toMail);   
		mailInfo.setSubject(title);   
		mailInfo.setContent(content);  
		return mailInfo;
	}
}   