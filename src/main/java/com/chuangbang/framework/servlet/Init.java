package com.chuangbang.framework.servlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.chuangbang.framework.constant.Constant;

public class Init extends HttpServlet {

	private Logger logger = LoggerFactory.getLogger(getClass());
	/**
	 * Constructor of the object.
	 */
	public Init() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	@Override
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	

	/**
	 * Returns information about the servlet, such as 
	 * author, version, and copyright. 
	 *
	 * @return String information about this servlet
	 */
	@Override
	public String getServletInfo() {
		return "This is my default servlet created by Eclipse";
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init();
        String realPath = config.getServletContext().getRealPath("/"); 
        System.setProperty(Constant.WORKDIR, realPath);
        logger.info("项目绝对路径保存在系统变量Constant.WORKDIR中,可通过System.setProperty(Constant.WORKDIR)获取,项目绝对路径:"+realPath);
        //设置接口地址
        logger.info("init OK"); 
	}

}
