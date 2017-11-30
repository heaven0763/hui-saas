package com.chuangbang.base.web.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 企业信息Controller
 * @author heaven
 * @version 2016-11-18
 */
@Controller
@RequestMapping(value = "user/company")
public class CompanyController extends BaseController {

	@Autowired
	private CompanyService companyService;
	
	@ModelAttribute("company")
	public Company getCompany(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return companyService.getEntity(id);
		}
		return new Company();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "user/companyList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/companyForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Company company,String parea,String carea,String darea) {
		String companyArea = parea+carea+darea;
		if(StringUtils.isNotBlank(companyArea)){
			company.setCompanyArea(companyArea);
		}
		companyService.saveCompany(company);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Company> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Company> page = companyService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Company company = companyService.getEntity(id);
		model.addAttribute("company", company);
		return new ModelAndView("user/companyForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		companyService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	@RequestMapping("/upload/pic")
	public void uploadImg(HttpServletRequest request,HttpServletResponse response,Model model,String dir) throws IOException{
		String serverPath = new URL(request.getScheme(), request.getServerName(), request.getServerPort(), request.getContextPath()).toString();
		String filename="";
		String err ="";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();  
		// 上传到服务端的路径  
		String ctxPath = request.getSession().getServletContext().getRealPath("/") +  Constant.UPLOADFILE + "/company/"; 
		String savePath =Constant.UPLOADFILE + "/company/"; 
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
		String ymd = sdf.format(new Date());  
		String originalFileName = null;  
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {  
			// 上传文件名  

			MultipartFile mf = entity.getValue(); 

			originalFileName = mf.getOriginalFilename();  

			String fileExt = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toLowerCase();  

			// new file name  
			sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");  
			String yymd = sdf.format(new Date()); 
			String newFileName = yymd+"-"+generateString(6)+"." + fileExt;  
			
			// 是image则进入此处开始执行  
			if (fileExt.equals("jpg") || fileExt.equals("png")|| fileExt.equals("gif")) {  

				// 创建image文件夹，字目录按日期来分  
				String uploadFolder = ctxPath + Constant.imageLocation + ymd + "/"; 
				String uploadFolder2 = savePath + Constant.imageLocation + ymd + "/"; 
				File imageFile = new File(uploadFolder);  
				if (!imageFile.exists()) {  
					imageFile.mkdirs();  
				}  
				String uploadFileLocation = uploadFolder + newFileName;  

				if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)) {  
					filename = serverPath+"/"+uploadFolder2+newFileName;
				} else {  
					err= "fail";  
				}  
			}  else {  // 不是image则调到此处开始执行  
				// 创建others文件夹，字目录按日期来分  
				String uploadFolder3 = ctxPath + Constant.otherLocation + ymd + "/"; 
				String uploadFolder4 = savePath + Constant.otherLocation + ymd + "/";
				File otherFile = new File(uploadFolder3);  
				if (!otherFile.exists()) {  
					otherFile.mkdirs();  
				}  
				String uploadFileLocation = uploadFolder3 + newFileName;  
				if (this.htmlUpload(mf.getInputStream(), uploadFileLocation)) {  
					filename = serverPath+"/"+uploadFolder4+newFileName;
				} else {  
					err="fail";  
				}  
			}  
		}  
		
		JSONObject object = new JSONObject();
		object.put("error", 0);
		object.put("url",filename);
		object.put("title",originalFileName);
		
		PrintWriter out = null;   
		request.setCharacterEncoding("utf-8");     
	    response.setContentType("text/html; charset=utf-8");     
	    out =  response.getWriter();  
	    out.write(object.toJSONString());     
	    out.close(); 
		//return filename.equals("")?err:filename;
		//return "{\"err\":\"" + err + "\",\"msg\":\"/pacmis/" +filename + "\"}";
	}
}
