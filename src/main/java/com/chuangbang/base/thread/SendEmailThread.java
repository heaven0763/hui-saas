package com.chuangbang.base.thread;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.chuangbang.framework.util.HttpUtils;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.file.pdf.PdfUtils;
import com.chuangbang.plugins.mail.MailInfo;
import com.chuangbang.plugins.mail.SimpleMailSender;

public class SendEmailThread extends Thread{
	private Long orderId;
	private String orderNo;
	private String email;
	private String tplPath;
	private String title;
	private static String DOMAIN = "http://saas.hui-china.com/hui";
	@Override
	public void run(){
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
		System.out.println("SendEmailThread.run()>>>>>>>>"+new Date());
		System.out.println("SendEmailThread.run()>>>>>>>>"+orderId);
		System.out.println(DOMAIN+"/base/order/pdf/detail/"+orderId);
		String html= HttpUtils.doGet(DOMAIN+"/base/order/pdf/detail/"+orderId);//PdfUtils.getHtmlFile("http://192.168.199.167:8081/hui/base/order/pdf/detail/114"); //
	  	html = html.replaceAll("&nbsp;", " ");
		html = html.replaceAll("pt;", "px;");
		System.out.println("html>>>>"+html);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
		String ymd = sdf.format(new Date());  
		String pdFileName = tplPath+"order/"+ymd+"/order_"+orderNo+"_"+new Date().getTime()+".pdf";
		try {
			pdFileName = pdFileName.replace("\\", "/");
			System.out.println("pdFileName>>>>>>>>>>>>>>>>>>>>>>"+pdFileName);
			System.out.println("start>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
			PdfUtils.generateToFile(html,tplPath+"img/",pdFileName);
			System.out.println("end>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
			MailInfo mailInfo = SimpleMailSender.getMailInfo(email, title, html);
			boolean bol = SimpleMailSender.sendAttachMail(mailInfo, pdFileName);
			System.out.println("******************>>>>>>>>>"+bol);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public SendEmailThread() {
		super();
	}
	
	public SendEmailThread(Long orderId, String orderNo, String email, String tplPath, String title) {
		super();
		this.orderId = orderId;
		this.orderNo = orderNo;
		this.email = email;
		this.tplPath = tplPath;
		this.title = title;
	}

	
}
