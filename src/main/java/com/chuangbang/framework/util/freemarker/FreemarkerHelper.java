package com.chuangbang.framework.util.freemarker;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 
 * @Title:FreemarkerHelper
 * @description:Freemarker引擎工具类
 * 
 */
public class FreemarkerHelper {
	
	public static Configuration _tplConfig = new Configuration();

	/**
	 * 创建和调整配置
	 * @param dir 模板文件所在目录
	 * eg. request.getSession().getServletContext().getRealPath("/")+"WEB-INF/views"
	 */
	public static void init(String dir){
		try {
			_tplConfig.setDirectoryForTemplateLoading(new File(dir));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 解析ftl
	 * 
	 * @param tplName 模板名
	 * @param encoding   编码
	 * @param paras  参数
	 * @return
	 */
	public static String parseTemplate(String tplName, String encoding,
			Map<String, Object> paras) {
		try {
			StringWriter swriter = new StringWriter();
			Template mytpl = _tplConfig.getTemplate(tplName, encoding);
			mytpl.process(paras, swriter);
			return swriter.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return e.toString();
		}

	}

	/**
	 * 解析ftl
	 * 
	 * @param tplName  模板名
	 * @param paras    参数
	 * @return
	 */
	public static String parseTemplate(String tplName, Map<String, Object> paras) {
		return parseTemplate(tplName, "utf-8", paras);
	}
}