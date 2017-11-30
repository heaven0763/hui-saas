package com.chuangbang.framework.util;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * <strong>SpringContextHolder</strong><br>
 * Spring Context Holder<br> 
 * <strong>Create on : 2011-12-31<br></strong>
 * <p>
 * <strong>Copyright (C) Ecointel Software Co.,Ltd.<br></strong>
 * <p>
 * @author peng.shi peng.shi@ecointel.com.cn<br>
 * @version <strong>Ecointel v1.0.0</strong><br>
 */
public class SpringContextHolder implements ApplicationContextAware {

	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) {
		SpringContextHolder.applicationContext = applicationContext;
	}

	/**
	 * 得到Spring 上下文环境
	 * @return
	 */
	public static ApplicationContext getApplicationContext() {
		checkApplicationContext();
		return applicationContext;
	}

	/**
	 * 通过Spring Bean name 得到Bean 
	 * @param name bean 上下文定义名称
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String name) {
		checkApplicationContext();
		return (T) applicationContext.getBean(name);
	}
	
	/**
	 * 通过类型得到Bean
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(Class<T> clazz) {
		checkApplicationContext();
		return (T) applicationContext.getBeansOfType(clazz);
	}

	private static void checkApplicationContext() {
		if (applicationContext == null) {
			throw new IllegalStateException("applicaitonContext未注入,请在application-context.xml中定义SpringContextHolder");
		}
	}
	
	public static String getRootRealPath(){
		String rootRealPath ="";
		try {
			rootRealPath=getApplicationContext().getResource("").getFile().getAbsolutePath();
		} catch (IOException e) {
			System.err.println("获取系统根目录失败");
		}
		return rootRealPath;
	}

}
