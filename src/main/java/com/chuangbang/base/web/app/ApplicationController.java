package com.chuangbang.base.web.app;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.base.entity.app.Application;
import com.chuangbang.base.service.app.ApplicationService;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.img.NewImageUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 应用表Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/app/application")
public class ApplicationController extends BaseController {

	@Autowired
	private ApplicationService applicationService;
	
	@ModelAttribute("application")
	public Application getApplication(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return applicationService.getEntity(id);
		}
		return new Application();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "app/applicationList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "app/applicationForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Application application) {
		applicationService.saveApplication(application);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Application> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Application> page = applicationService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Application application = applicationService.getEntity(id);
		model.addAttribute("application", application);
		return new ModelAndView("app/applicationForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		applicationService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping("/upload/resizeimg")
	@ResponseBody
	public Json uploadImg(HttpServletRequest request,HttpServletResponse response,Model model,String base64Str,String dir) throws IOException{
		Json json = new Json();
		String serverPath = new URL(request.getScheme(), request.getServerName(), request.getServerPort(), request.getContextPath()).toString();
		String filename="";
		String ctxPath = request.getSession().getServletContext().getRealPath("/") +  Constant.UPLOADFILE + "/"+dir+"/"; 
		String savePath =Constant.UPLOADFILE + "/"+dir+"/"; 
		// 创建image文件夹，字目录按日期来分  
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
		String ymd = sdf.format(new Date());  
		
		String uploadFolder = ctxPath + Constant.imageLocation + ymd + "/"; 
		String uploadFolder2 = savePath + Constant.imageLocation + ymd + "/"; 
		
		// new file name  
		sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");  
		String yymd = sdf.format(new Date()); 
		String newFileName = yymd+"-"+generateString(6)+Constant.JPG;  
		File pfile = new File(uploadFolder);
		File file = null;
		if(!pfile.exists()){
			while(pfile.mkdirs()){
				file = new File(uploadFolder+newFileName);
			}
		}else{
			file = new File(uploadFolder+newFileName);
		}
		if(NewImageUtils.GenerateImage(base64Str, file)){
			filename = serverPath+"/"+uploadFolder2+newFileName;
			json.setSuccess(true);
			json.setObj(filename);
		}else{
			json.setSuccess(false);
			json.setMsg("上传失败");
		}
		return json;
	}
	
}
