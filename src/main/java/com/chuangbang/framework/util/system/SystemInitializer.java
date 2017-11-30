/**
 * 初始化数据库数据
 */
package com.chuangbang.framework.util.system;

import javax.annotation.PostConstruct;

import org.hibernate.service.spi.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;

import com.chuangbang.framework.util.sql.SQLExec;
import com.chuangbang.js.dao.account.UserDao;

/**
 * @author hlw
 *
 */
@Component
@Lazy(false)
public class SystemInitializer {

	private static final Logger logger = LoggerFactory.getLogger(SystemInitializer.class);
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	org.apache.commons.dbcp.BasicDataSource dataSource;


	public SystemInitializer(){
	}

	@PostConstruct
	public void initAll(){
		logger.info("初始化数据方法执行......");
		//initData();
	}

	private void initData() {

		if(null == userDao.findOne("1")){
			//超级权限存在与否来判断是否已经初始化
			logger.info("初始化数据开始......");
			try {
				execSqlFile();
			} catch (Exception e) {
				logger.error("初始化数据时出现异常!", e);
				e.printStackTrace();
				throw new ServiceException("初始化数据时出现异常!", e);
			}
			logger.info("初始化数据结束......");
		}
	}
	
	private void execSqlFile() throws Exception{
		ResourceLoader resourceLoader = new DefaultResourceLoader();
		SQLExec sqlExec = new SQLExec();   
		//设置数据库参数   
		sqlExec.setDriver(dataSource.getDriverClassName());   
		sqlExec.setUrl(dataSource.getUrl());  
		sqlExec.setUserid(dataSource.getUsername());   
		//dataSource.getPassword()已经被覆写成 :
		//return "Password not available as DataSource/JMX operation";
		//所以要改成其它方法来获取password
		sqlExec.setPassword(dataSource.getPassword());   
		//要执行的脚本      
		//要执行的脚本   
		sqlExec.setSrc(resourceLoader.getResource(
				"classpath:/sql/mssql/data.sql").getFile());  
		//有出错的语句该如何处理
		sqlExec.setOnerror(SQLExec.ON_ERROR_ABORT); //abort/conitue/stop
		sqlExec.setPrint(true); //设置是否输出
		
		//输出到文件 sql.out 中；不设置该属性，默认输出到控制台
		//sqlExec.setOutput(new File("src/sql.out"));
		sqlExec.execute();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
	}

}
