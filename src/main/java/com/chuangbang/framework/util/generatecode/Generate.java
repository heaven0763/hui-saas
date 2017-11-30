package com.chuangbang.framework.util.generatecode;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;

import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.generatecode.model.Property;
import com.chuangbang.framework.util.generatecode.util.DateUtils;
import com.chuangbang.framework.util.generatecode.util.FreeMarkers;
import com.google.common.collect.Maps;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 代码生成器
 * @version 2013-06-21
 */
public class Generate {
	
	private static Logger logger = LoggerFactory.getLogger(Generate.class);
	
	

	/** ========== ↓↓↓↓↓↓ 执行前请修改参数，谨慎执行。↓↓↓↓↓↓ ==================== */
	private static String moduleName = "order";			// 模块名，例：sys
	private static String subModuleName = "order";				// 子模块名（可选） 
	private static String className = "OrderPayedRecord";			// 类名，例：user
	private static String functionName = "订单付款记录";			// 类注释，例：用户

	
	// 主要提供基本功能模块代码生成。
	private static String templatePath = "/src/main/java/com/chuangbang/framework/util/generatecode/template"; // 模板文件路径
	private static String packageName = "com.chuangbang.base";	//包名
	//private static String appPackageName = "com.chuangbang.app";
	private static String tableName ="hui_" +className ;
	private static String classAuthor = "heaven";		// 类作者，例：ThinkGem
	private static List<Property>  properties = new ArrayList<Property>();	//成员变量

	private static Integer formWidth = 380;	   //form窗口宽度
	private static Integer formHeight = 300;   //form窗口高度
	//初始化成员变量
	static{
		properties.add(new Property("hotelId","所属酒店","Long"));
		properties.add(new Property("orderId","订单编号","Long"));
		properties.add(new Property("type","付款类型"));
		properties.add(new Property("amount","订单金额","Double"));
		properties.add(new Property("payAmount","付款金额","Double"));
		properties.add(new Property("unpayAmount","未付款金额","Double"));
		properties.add(new Property("payedAmount","已付款金额","Double"));
		properties.add(new Property("payDate","付款时间","Date"));
		properties.add(new Property("payedUserId","创建人员编号"));
		properties.add(new Property("createDate","创建日期","Date"));
		properties.add(new Property("memo","创建日期"));
		/*=======		
		//properties.add(new Property("____","___"));
		properties.add(new Property("name","集团名称"));
		properties.add(new Property("logo","集团logo"));
		properties.add(new Property("introduction","集团介绍"));
		properties.add(new Property("linkman","联系人"));
		properties.add(new Property("tel","联系电话"));
		properties.add(new Property("email","邮箱"));
		
		properties.add(new Property("createUserId","创建人员"));
		properties.add(new Property("createUserName","创建日期","Date"));
		properties.add(new Property("memo","备注"));

		
		properties.add(new Property("shopId","商家编号"));
		properties.add(new Property("name","活动名称"));
		properties.add(new Property("area","区域"));
		properties.add(new Property("address","详细地址"));
		properties.add(new Property("scale","活动人数"));
		properties.add(new Property("partStime","活动开始时间","Date"));
		properties.add(new Property("partEtime","活动结束时间","Date"));
		properties.add(new Property("introduction","活动介绍"));
		properties.add(new Property("coverPhoto","封面图片"));
		properties.add(new Property("imgs","介绍图片"));
		properties.add(new Property("state","状态"));
		properties.add(new Property("addate","添加时间","Date"));
		properties.add(new Property("memo","备注"));
		properties.add(new Property("isjoin","是否"));
		
		properties.add(new Property("hotelId","所属酒店","Long"));
		properties.add(new Property("cpId","订单编号","Long"));
		
		properties.add(new Property("type","返佣类型"));
		properties.add(new Property("pointsRateType","积分计算类型"));
		
		properties.add(new Property("bfhousingCommissionRate","原住房返佣比例","Double"));
		properties.add(new Property("bfdinnerCommissionRate","原餐饮返佣比例","Double"));
		properties.add(new Property("bfmettingRoomCommissionRate","原会议室返佣比例","Double"));
		properties.add(new Property("bfortherCommissionRate","原其他返佣比例","Double"));
		properties.add(new Property("bfallCommissionRate","原全单返佣比例","Double"));
		properties.add(new Property("bfpointsRate","原积分计算比例","Double"));
		
		properties.add(new Property("afhousingCommissionRate","修改后住房返佣比例","Double"));
		properties.add(new Property("afdinnerCommissionRate","修改后餐饮返佣比例","Double"));
		properties.add(new Property("afmettingRoomCommissionRate","修改后会议室返佣比例","Double"));
		properties.add(new Property("afortherCommissionRate","修改后其他返佣比例","Double"));
		properties.add(new Property("afallCommissionRate","修改后全单返佣比例","Double"));
		properties.add(new Property("afpointsRate","修改后积分计算比例","Double"));
		properties.add(new Property("checkDate","审核日期"));
		properties.add(new Property("checkMemo","审核备注"));
		properties.add(new Property("checkUserId","创建日期"));
		properties.add(new Property("checkUserName","创建日期"));
		
		properties.add(new Property("applyReason","审核备注"));
		properties.add(new Property("applyDate","创建日期"));
		properties.add(new Property("applyUserId","创建日期"));
		properties.add(new Property("applyUserName","创建日期"));
		
>>>>>>> .r4*/
	}
	/** ========== ↑↑↑↑↑↑ 执行前请修改参数，谨慎执行。↑↑↑↑↑↑ ==================== */
	
	public static void main(String[] args)  {
		try {
			generate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void generate() throws Exception{
		
		// packageName 包名，这里如果更改包名，请在applicationContext.xml和srping-mvc.xml中配置base-package、packagesToScan属性，来指定多个（共4处需要修改）。
		
		// 是否启用生成工具
		Boolean isEnable = true;			
		
		if (!isEnable){
			logger.error("请启用代码生成工具，设置参数：isEnable = true");
			return;
		}
		//StringUtils.isBlank(moduleName) || StringUtils.isBlank(moduleName) 
		if ( StringUtils.isBlank(className) || StringUtils.isBlank(functionName)){
			logger.error("参数设置错误：包名、模块名、类名、功能名不能为空。");
			return;
		}
		
		// 获取文件分隔符
		String separator = File.separator;
		
		// 获取工程路径
		File projectPath = new DefaultResourceLoader().getResource("").getFile();
		while(!new File(projectPath.getPath()+separator+"src"+separator+"main").exists()){
			projectPath = projectPath.getParentFile();
		}
		logger.info("Project Path: {}", projectPath);
		
		// 模板文件路径
		String tplPath = StringUtils.replace(projectPath + templatePath, "/", separator);
		logger.info("Template Path: {}", tplPath);
		
		// Java文件路径
		String javaPath = StringUtils.replaceEach(projectPath+"/src/main/java/"+StringUtils.lowerCase(packageName), 
				new String[]{"/", "."}, new String[]{separator, separator});
		logger.info("Java Path: {}", javaPath);
		/*// Java APP WEB 文件路径
		String javaAppPath = StringUtils.replaceEach(projectPath+"/src/main/java/"+StringUtils.lowerCase(appPackageName), 
				new String[]{"/", "."}, new String[]{separator, separator});
		logger.info("Java Path: {}", javaAppPath);*/
		// 视图文件路径
		String viewPath = StringUtils.replace(projectPath+"/src/main/webapp/WEB-INF/views", "/", separator);
		logger.info("View Path: {}", viewPath);
		
		// 代码模板配置
		Configuration cfg = new Configuration();
		cfg.setDirectoryForTemplateLoading(new File(tplPath));

		// 定义模板变量
		Map<String, Object> model = Maps.newHashMap();
		model.put("packageName", StringUtils.lowerCase(packageName));
		model.put("moduleName", StringUtils.lowerCase(moduleName));
		model.put("subModuleName", StringUtils.isNotBlank(subModuleName)?"."+StringUtils.lowerCase(subModuleName):"");
		model.put("className", StringUtils.uncapitalize(className));
		model.put("ClassName", StringUtils.capitalize(className));
		model.put("classAuthor", StringUtils.isNotBlank(classAuthor)?classAuthor:"Generate Tools");
		model.put("classVersion", DateUtils.getDate());
		model.put("functionName", functionName);
		model.put("tableName", tableName);
		model.put("urlPrefix", model.get("moduleName")+(StringUtils.isNotBlank(subModuleName)?"/"+StringUtils.lowerCase(subModuleName):"")+"/"+model.get("className"));
		model.put("viewPrefix", //StringUtils.substringAfterLast(model.get("packageName"),".")+"/"+
				model.get("urlPrefix"));
		model.put("permissionPrefix", model.get("moduleName")+(StringUtils.isNotBlank(subModuleName)
				?":"+StringUtils.lowerCase(subModuleName):"")+":"+model.get("className"));
		//成员变量
		model.put("properties", properties);  
		model.put("formHeight", formHeight);  
		model.put("formWidth", formWidth);  
		// 生成 Entity
		Template template = cfg.getTemplate("entity.ftl");
		String content = FreeMarkers.renderTemplate(template, model);
		String filePath = javaPath+separator+"entity"+separator+model.get("moduleName")
				+separator+model.get("ClassName")+".java";//+separator+StringUtils.lowerCase(subModuleName)
		writeFile(content, filePath);
		logger.info("Entity: {}", filePath);
		
		// 生成 Dao
		template = cfg.getTemplate("dao.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = javaPath+separator+"dao"+separator+model.get("moduleName")
					+separator+model.get("ClassName")+"Dao.java";//+separator+StringUtils.lowerCase(subModuleName)
		writeFile(content, filePath);
		logger.info("Dao: {}", filePath);
		
		// 生成 Service
		template = cfg.getTemplate("service.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = javaPath+separator+"service"+separator+model.get("moduleName")
					+separator+model.get("ClassName")+"Service.java";//+separator+StringUtils.lowerCase(subModuleName)
		writeFile(content, filePath);
		logger.info("Service: {}", filePath);
		
		// 生成 Controller
		template = cfg.getTemplate("controller.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = javaPath+separator+"web"+separator+model.get("moduleName")
					+separator+model.get("ClassName")+"Controller.java";//+separator+StringUtils.lowerCase(subModuleName)
		writeFile(content, filePath);
		logger.info("Controller: {}", filePath);
		
		// 生成 APPController
		/*template = cfg.getTemplate("appcontroller.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = javaAppPath+separator+"web"+separator+model.get("moduleName")
					+separator+model.get("ClassName")+"APIController.java";
		writeFile(content, filePath);
		logger.info("Controller: {}", filePath);*/
		
		// 生成 ViewForm
		template = cfg.getTemplate("viewForm.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = viewPath+separator+StringUtils.lowerCase(subModuleName)
				+separator+model.get("className")+"Form.jsp";
		writeFile(content, filePath);
		logger.info("ViewForm: {}", filePath);
		
		// 生成 ViewList
		template = cfg.getTemplate("viewList.ftl");
		content = FreeMarkers.renderTemplate(template, model);
		filePath = viewPath+separator+StringUtils.lowerCase(subModuleName)
				+separator+model.get("className")+"List.jsp";
		writeFile(content, filePath);
		logger.info("ViewList: {}", filePath);
		
		logger.info("Generate Success.");
	}
	
	/**
	 * 将内容写入文件
	 * @param content
	 * @param filePath
	 */
	public static void writeFile(String content, String filePath) {
		try {
			FileWriter fileWriter = new FileWriter(filePath, FileUtils.createFile(filePath));
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(content);
			bufferedWriter.close();
			fileWriter.close();
			//logger.info("生成失败，文件已存在！");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
