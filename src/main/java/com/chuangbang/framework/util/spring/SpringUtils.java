package com.chuangbang.framework.util.spring;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.subject.WebSubject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SpringUtils {

	private static final SpringUtils springUtils = new SpringUtils();
	
	private WebApplicationContext context;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	
	public SpringUtils(){
		//logger.debug("SecurityUtils.getSubject().getPrincipal()={}",SecurityUtils.getSubject().getPrincipal());
		//logger.debug("SecurityUtils.getSubject().getSession().getId()={}",SecurityUtils.getSubject().getSession().getId());
		ServletRequest request = ((WebSubject)SecurityUtils.getSubject()).getServletRequest(); 
		HttpSession httpSession = ((HttpServletRequest)request).getSession(); 
		//logger.debug("httpSession.getServletContext():"+httpSession.getServletContext());
		context = WebApplicationContextUtils.getWebApplicationContext(httpSession.getServletContext());
		org.apache.shiro.mgt.SecurityManager securityManager =   
	            (org.apache.shiro.mgt.SecurityManager)context.getBean("securityManager");  
	        SecurityUtils.setSecurityManager(securityManager); 
	}
	
	public static Object getBean(String name){
		return springUtils.getWebApplicationContext().getBean(name);
	}
	
	public static <T extends Object> T getBean(Class<T> clazz){
		return springUtils.getWebApplicationContext().getBean(clazz);
	}
	
	public WebApplicationContext getWebApplicationContext(){
		return context;
	}

}
