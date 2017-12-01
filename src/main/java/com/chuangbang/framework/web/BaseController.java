package com.chuangbang.framework.web;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;
import org.springside.modules.web.Servlets;

import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.enums.GroupType;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.service.system.SystemParameterService;
import com.chuangbang.framework.util.AddressUtils;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.editor.DateEditor;
import com.chuangbang.framework.web.editor.DoubleEditor;
import com.chuangbang.framework.web.editor.IntegerEditor;
import com.chuangbang.framework.web.editor.LongEditor;
import com.google.common.collect.Maps;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public abstract class BaseController {
	@Autowired
	protected ResourceBundleMessageSource _res;
	
	@Autowired
	protected SystemParameterService systemParameterService;
	@Autowired
	protected RegionService regionService;
	public String getSystemFileSavePath(){
		return systemParameterService.getValueByCode("filesavepath");
	}

	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		binder.registerCustomEditor(int.class, new IntegerEditor());
		binder.registerCustomEditor(long.class, new LongEditor());
		binder.registerCustomEditor(double.class, new DoubleEditor());
		binder.registerCustomEditor(Date.class, new DateEditor());
	}

	protected ModelAndView ajaxDone(int statusCode, String message,String closeCurrent,String refreshDatagrid,String navTabId,String forwardUrl,String callbackFn) {
		ModelAndView mav = new ModelAndView("ajaxDone");
		mav.addObject("statusCode", statusCode);
		mav.addObject("message", message);
		mav.addObject("closeCurrent", closeCurrent);
		mav.addObject("refreshDatagrid", refreshDatagrid);
		mav.addObject("navTabId", navTabId);
		mav.addObject("forwardUrl", forwardUrl);
		mav.addObject("callbackFn", callbackFn);
		return mav;
	}
	
	/**
	 * 返回一个新生成的DataGrid
	 * @param pageBean	pageBean
	 * @param list	查找到的记录集合
	 * @return
	 */
	protected DataGrid getDataGrid(PageBean pageBean,List list){
		DataGrid dataGrid = new DataGrid();
		dataGrid.setTotal(pageBean.getTotalCount());
		dataGrid.setRows(list);
		dataGrid.setCurrtPage(pageBean.getPage());
		dataGrid.setTotalPage(pageBean.getTotalPage());
		return dataGrid;
	}
	
	/**
	 * 返回一个新生成的DataGrid
	 * @param list	查找到的记录集合
	 * @return
	 */
	protected DataGrid getDataGrid(List list){
		DataGrid dataGrid = new DataGrid();
		dataGrid.setTotal(Long.valueOf(list.size()));
		dataGrid.setRows(list);
		return dataGrid;
	}
	
	/**
	 * 
	 * @param message		消息 
	 * @param closeCurrent	不为空时关闭当前窗口
	 * @param refreshDatagrid	不为空时刷新datagrid
	 * @param navTabId		不为空时刷新对应tab
	 * @param forwardUrl	不为空时刷新当前tab,url为forwarUrl
	 * @param callbackFn	js回调函数
	 * @return
	 */
	protected ModelAndView ajaxDoneSuccess(String message,String closeCurrent,String refreshDatagrid,String navTabId,String forwardUrl,String callbackFn) {
		return ajaxDone(200, message,closeCurrent,refreshDatagrid,navTabId,forwardUrl,callbackFn);
	}

	protected ModelAndView ajaxDoneError(String message,String closeCurrent,String refreshDatagrid,String navTabId,String forwardUrl,String callbackFn) {
		return ajaxDone(300, message,closeCurrent,refreshDatagrid,navTabId,forwardUrl,callbackFn);
	}
	
	/**
	 * 比较常用的一种
	 * @param message	消息
	 * @param closeCurrent	不为空时关闭当前窗口
	 * @param refreshDatagrid	不为空时刷新datagrid
	 * @return
	 */
	protected ModelAndView ajaxDoneSuccess(String message,String closeCurrent,String refreshDatagrid) {
		return ajaxDone(200, message,closeCurrent,refreshDatagrid,null,null,null);
	}
	
	protected ModelAndView ajaxDoneSuccess(String message) {
		return ajaxDone(200, message,null,null,null,null,null);
	}

	protected ModelAndView ajaxDoneError(String message) {
		return ajaxDone(300, message,null,null,null,null,null);
	}
	protected String getMessage(String code) {
		return this.getMessage(code, new Object[] {});
	}

	protected String getMessage(String code, Object arg0) {
		return getMessage(code, new Object[] { arg0 });
	}

	protected String getMessage(String code, Object arg0, Object arg1) {
		return getMessage(code, new Object[] { arg0, arg1 });
	}

	protected String getMessage(String code, Object arg0, Object arg1,
			Object arg2) {
		return getMessage(code, new Object[] { arg0, arg1, arg2 });
	}

	protected String getMessage(String code, Object arg0, Object arg1,
			Object arg2, Object arg3) {
		return getMessage(code, new Object[] { arg0, arg1, arg2, arg3 });
	}

	protected String getMessage(String code, Object[] args) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		Locale locale = localeResolver.resolveLocale(request);
		return _res.getMessage(code, args, locale);
	}
	
	/**
	 * 获取查询参数
	 * */
	protected Map<String, Object> getSearchParams(ServletRequest request){
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		
		
		return searchParams;
	}
	
	/**
	 * 文件上传
	 * @param entity
	 * @param mFile
	 * @throws IOException
	 */
	public String uploadFile(String middleFolderName,MultipartFile mFile) throws IOException {
		String filePath = "";
		if(mFile != null){
			//当前工作路径
			String fileDir = System.getProperty(Constant.WORKDIR);
			// 获得文件名：
			String realFileName = mFile.getOriginalFilename();
			//如果文件包含中文等特殊字串会无法正常显示，使用时间作为文件名
			String currFileName = new Date().getTime() + realFileName.substring(realFileName.lastIndexOf("."));
			//相对路径
			String currFilePath = Constant.UPLOADFILE + "/" + middleFolderName;
			//保存的文件夹路径
			String policyFileDir = fileDir + currFilePath;
			
			if (realFileName != null && !"".equals(realFileName)) {
				FileUtils.saveFile(policyFileDir, currFileName, mFile.getBytes());
				//最终文件路径
				filePath = currFilePath + "/" + currFileName;
			}
		}else{
			throw new IllegalArgumentException("文件不能为空！");
		}
		return filePath;
	}
	/**
	 * 文件上传
	 * @param entity
	 * @param mFile
	 * @throws IOException
	 */
	public String uploadFilex(String filepath,MultipartFile mFile) throws IOException {
		String filePath = "";
		if(mFile != null){
			// 获得文件名：
			String realFileName = mFile.getOriginalFilename();
			if (realFileName != null && !"".equals(realFileName)) {
				FileUtils.saveFile(filepath, realFileName, mFile.getBytes());
				//最终文件路径
				filePath = filepath + "/" + realFileName;
			}
		}else{
			throw new IllegalArgumentException("文件不能为空！");
		}
		return filePath;
	}
	/**
	 * 文件上传 with 缩略图
	 * @param entity
	 * @param mFile
	 * @throws IOException
	 */
	public String uploadFileWiththum(String middleFolderName,MultipartFile mFile) throws IOException {
		String filePath = "";
		if(mFile != null){
			//当前工作路径
			String fileDir = System.getProperty(Constant.WORKDIR);
			// 获得文件名：
			String realFileName = mFile.getOriginalFilename();
			//如果文件包含中文等特殊字串会无法正常显示，使用时间作为文件名
			String currFileName = new Date().getTime() + realFileName.substring(realFileName.lastIndexOf("."));
			//相对路径
			String currFilePath = Constant.UPLOADFILE + "/" + middleFolderName;
			//保存的文件夹路径
			String policyFileDir = fileDir + currFilePath;
			String fileExt = realFileName.substring(realFileName.lastIndexOf(".") + 1).toLowerCase();
			if(fileExt.equals("jpg") || fileExt.equals("png")){
				if (realFileName != null && !"".equals(realFileName)) {
					FileUtils.saveFile(policyFileDir, currFileName, mFile.getBytes());
					//最终文件路径
					filePath = currFilePath + "/" + currFileName;
					 // 如果图片上传成功，那么就要生成缩略图  
	                String thumnailFileName = "thum_" + currFileName;  
	                String thumnailPath = currFilePath+ "/thumnail";
	                String uploadFolder2 = fileDir+ thumnailPath;
	                File imageThumnailFile = new File(uploadFolder2);  
	                if (!imageThumnailFile.exists()) {
	                    imageThumnailFile.mkdirs();  
	                }  
	                BufferedImage bi = ImageIO.read(mFile.getInputStream());  
	                if (bi != null) {  
	                    String uploadFileLocation2 = uploadFolder2 +"/"+ thumnailFileName;  
	                    if (this.uploadJPGfile(bi, uploadFileLocation2)) {  
	                    	filePath+="$"+thumnailPath+"/"+ thumnailFileName;
	                    } else {  
	                    }  
	                }  
				}
			}
			
		}else{
			throw new IllegalArgumentException("文件不能为空！");
		}
		return filePath;
	}
	
	  /** 
	    * @Title: uploadJPGfile 
	    * @param @param img 
	    * @param @param uploadFileLocation2 服务端输出的路径和文件名 
	    * @return boolean    返回类型 
	    * @throws 
	    */  
	    public boolean uploadJPGfile(BufferedImage img, String uploadFileLocation2) {  
	        try {  
	            // 转为jpg标准格式//  
	            if (img != null) {  
	                int new_w = 220;  
	                int new_h = 220;  
	                BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);  
	                tag.getGraphics().drawImage(img, 0, 0, new_w, new_h, null); // 绘制缩小后的图  
	                FileOutputStream out = new FileOutputStream(uploadFileLocation2); 
	                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
	                encoder.encode(tag);  
	                out.close();  
	                return true;  
	            } else {  
	                return false;  
	            }  
	        } catch (Exception e) {  
	            return false;  
	        }  
	    }  
	
	
	
	/**
	 * 文件下载
	 * */
	protected String getEncodeSearchParams(ServletRequest request){
		return Servlets.encodeParameterStringWithPrefix(Servlets.getParametersStartingWith(request, "search_"), "search_");
	}
	
	protected ModelAndView downloadfile( String filePathAndName,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;

		String filename;
		if (filePathAndName != null && !"".equals(filePathAndName)) {
			filename = filePathAndName .substring(filePathAndName.lastIndexOf("\\") + 1);
		}else{
			throw new IllegalArgumentException("路径和名称不能为空！");
		}
		try {
			long fileLength = new File(filePathAndName).length();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(URLEncoder.encode(filename, "UTF-8")));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(filePathAndName));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
		return null;
	}
	
	
	/**
	 * @Title: htmlUpload
	 * @param @param inputStream 传进一个流
	 * @param @param uploadFile 服务端输出的路径和文件名
	 * @return boolean 返回类型
	 * @throws
	 */
	public boolean htmlUpload(InputStream inputStream, String uploadFile) {
		try {
			byte[] buff = new byte[4096]; // 缓冲区
			FileOutputStream output = new FileOutputStream(uploadFile); // 输出流
			int bytecount = 1;
			while ((bytecount = inputStream.read(buff, 0, 4096)) != -1) { // 当input.read()方法，不能读取到字节流的时候，返回-1
				output.write(buff, 0, bytecount); // 写入字节到文件
			}
			output.flush();
			output.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static final String numberChar = "0123456789";

	public String generateString(int length) // 参数为返回随机数的长度
	{
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			sb.append(numberChar.charAt(random.nextInt(numberChar.length())));
		}
		return sb.toString();
	}
	
	public Map<String, Boolean> groupSetting(Model model){
		Map<String, Boolean> groupMap = Maps.newHashMap();
		
		String groups = "company_sales"+","+"company_finance"+","+"company_operate"+","+"group_administrator"+","+"group_finance"
				+","+"hotel_administrator"
				+","+"hotel_sales"
				+","+"hotel_finance"
				+","+"hotel_hr"
				+","+"hui_hr"
				+","+"group_hr"
				+","+"company_administrator,administrator,hotel_sales_director,company_sales_director,company_finance_director,company_operate_director"
				+",city_partner";
		String [] arr = groups.split(",");
		for (String str : arr) {
			groupMap.put("is"+str.replaceAll("_", ""), false);
		}
		isGroup(groupMap,AccountUtils.getCurrentUser().getGroup().getGroupId());
		model.addAttribute("groupMap",groupMap);
		model.addAttribute("guserId",AccountUtils.getCurrentUserId());
		return groupMap;
	}
	public void isGroup(Map<String, Boolean> groupMap,String groupId){
		GroupType groupType = GroupType.valueOf(groupId);
		groupMap.put("iscompany", false);
		groupMap.put("ishotel", false);
		groupMap.put("isgroup", false);
		switch (groupType) {
		case company_sales:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case company_finance:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case company_operate:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case group_administrator:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("isgroup", true);
			break;
		case group_finance:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("isgroup", true);
			break;
		case hotel_administrator:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case hotel_sales:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case hotel_finance:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case hotel_hr:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case company_hr:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("iscompany", true);
		case group_hr:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("isgroup", true);
		case company_administrator:
			groupMap.put("is"+groupId.replace("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case hotel_sales_director:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case company_sales_director:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case company_finance_director:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case company_operate_director:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case city_partner:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			groupMap.put("ispartner", true);
			break;
		case administrator:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case company_staff:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			break;
		case hotel_staff:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("ishotel", true);
			break;
		case group_staff:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("isgroup", true);
			break;
		case group_sales:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("isgroup", true);
			break;
		case city_sales:
			groupMap.put("is"+groupId.replaceAll("_", ""), true);
			groupMap.put("iscompany", true);
			groupMap.put("ispartner", true);
			break;
		}
	}
	public void permissionSetting(Model model){
		/*'3', 'company_sales
		'4', 'company_finance', '', '公司财务', '11', NULL
		'5', 'company_operate', '', '公司运营', '11', NULL
		'6', 'group_administrator', '', '集团管理员', '12', NULL
		'7', 'group_finance', '', '集团财务', '12', NULL
		'8', 'hotel_administrator', '', '酒店管理员', '12', NULL
		'9', 'hotel_sales', '', '酒店销售', '12', NULL
		'10', 'hotel_finance', '', '酒店财务', '12', NULL*/

	}
	public Integer getCity(HttpServletRequest request) throws Exception{
		
		String cityId = (String) WebUtils.getSessionAttribute(request, "city_id");
		if(null==cityId){
			String ip = request.getLocalAddr();
			String city = AddressUtils.getCity(ip);
			Region region = this.regionService.findByRegionName(city);
			cityId = region==null?"76":region.getId().intValue()+"";
		}
		WebUtils.setSessionAttribute(request, "city_id", "76");
		return Integer.valueOf(cityId);
	}
	
}
