package com.chuangbang.base.web.hotel;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
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
import org.springframework.web.util.WebUtils;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.app.model.SiteImgModel;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelPlace;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.SiteImgService;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.img.NewImageUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.itextpdf.text.log.SysoLogger;

/**
 * 场地图片Controller
 * @author heaven
 * @version 2016-11-21
 */
@Controller
@RequestMapping(value = "base/hotel/img")
public class SiteImgController extends BaseController {

	@Autowired
	private SiteImgService siteImgService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private CategoryService categoryService;
	@ModelAttribute("siteImg")
	public SiteImg getSiteImg(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return siteImgService.getEntity(id);
		}
		return new SiteImg();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "hotel/siteImgList";
	}
	
	@RequestMapping(value = "toupload")
	public String toupload(Model model,Long hotelId,Long siteId,String siteType,String picType) {
		model.addAttribute("hotelId",hotelId);
		model.addAttribute("siteId",siteId);
		model.addAttribute("siteType",siteType);
		model.addAttribute("picType",picType);
		return "hotel/siteImgUpload";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model,HttpServletRequest request,String type,Long id) {
		Hotel mhotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		if("HOTEL".equals(type)){
			Hotel hotel = this.hotelService.getEntity(id);
			model.addAttribute("hotel",hotel);
			model.addAttribute("title",hotel.getHotelName());
			model.addAttribute("hotelId",hotel.getId());
		}else if("HALL".equals(type)){
			HotelPlace place = this.hotelPlaceService.getEntity(id);
			model.addAttribute("hall",place);
			model.addAttribute("title",place.getPlaceName());
			model.addAttribute("hotelId",place.getHotelId());
		}else if("ROOM".equals(type)){
			HotelPlace room = this.hotelPlaceService.getEntity(id);
			model.addAttribute("room",room);
			model.addAttribute("title",room.getPlaceName());
			model.addAttribute("hotelId",room.getHotelId());
		}else{
			model.addAttribute("id",id);
			model.addAttribute("hotelId",mhotel.getId());
		}
		model.addAttribute("id",id);
		model.addAttribute("type",type);
		
		List<Category> categories = this.categoryService.findByKind("PICTYPE");
		for (Category category : categories) {
			if(!"EXTPIC".equals(category.getVal())){
				List<SiteImg> imgs = this.siteImgService.findBySiteIdAndSiteTypeAndPicType(id, type,category.getVal());
				model.addAttribute(category.getVal().toLowerCase(),imgs);
			}
		}
		model.addAttribute("mhotel",mhotel);
		model.addAttribute("ptypes",categories);
		return "hotel/siteImgForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(SiteImg siteImg,Long hotelId,String siteType,Long siteId,String picType,String imgs,String action) {
		//if("create".equals(action)){
		try {
			siteImgService.saveSiteImg(siteImg,hotelId,siteType,siteId,picType,imgs,"HUIZHANGGUI");
		} catch (IOException e) {
			e.printStackTrace();
			return  ajaxDoneError("操作失败！");
		}
		/*}else{
			siteImgService.saveSiteImg(siteImg);
		}*/
		
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value = "sort/save")
	public ModelAndView sortSave(HttpServletRequest request,String imgid) {
		try {
			siteImgService.sortSave(request,imgid);
		} catch (Exception e) {
			e.printStackTrace();
			return  ajaxDoneError("操作失败！");
		}
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<SiteImgModel> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		/*if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			searchparas.put("OR_EQ;hotelId",hotelIds);
		}*/
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		if(null!=hotel){
			searchparas.put("EQ_s.hotel_id",hotel.getId());
		}
		pageBean.set_filterParams(searchparas);
		List<SiteImgModel> page = siteImgService.getPageSiteImgList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value ="getPiclist")
	@ResponseBody
	public DataGrid getPiclist(PageBean<SiteImg> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		/*if("HUI".equals(AccountUtils.getCurrentUserType())){
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			String hotelIds = this.hotelService.findHotelIdsByCompanyId(AccountUtils.getCurrentUser().getCompanyId());
			hotelIds = StringUtils.isNotBlank(hotelIds)?hotelIds:"PARTNER";
			searchparas.put("OR_EQ;hotelId",hotelIds);
		}*/
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		if(null!=hotel){
			searchparas.put("EQ_hotelId",hotel.getId());
		}
		pageBean.set_filterParams(searchparas);
		Page<SiteImg> page = siteImgService.getEntities(pageBean);
		return getDataGrid(pageBean, page.getContent());//return JsonUtils.success("ok", getDataGrid(pageBean, page.getContent())) ;
	}
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model,HttpServletRequest request) {
		SiteImg siteImg = siteImgService.getEntity(id);
		Hotel hotel = (Hotel) WebUtils.getSessionAttribute(request, "mhotel");
		model.addAttribute("mhotel",hotel);
		model.addAttribute("siteImg", siteImg);
		return new ModelAndView("hotel/siteImgForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		siteImgService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping(value = "batch/delete/{siteid}/{siteType}")
	public ModelAndView batchDelete(@PathVariable("siteid") Long siteid,@PathVariable("siteType") String siteType) {
		
		siteImgService.deleteBySiteid(siteid,siteType);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping(value = "cover/{id}")
	public ModelAndView cover(@PathVariable("id") Long id) {
		siteImgService.cover(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping("/upload")
	public void uploadImg(HttpServletRequest request,HttpServletResponse response,String dir) throws IOException{
		String serverPath = "http://saas.hui-china.com/hui";//new URL(request.getScheme(),request.getRemoteHost(), request.getServerPort(), request.getContextPath()).toString();//
		String filename="";
		String err ="";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;  
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();  
		// 上传到服务端的路径  
		String ctxPath = request.getSession().getServletContext().getRealPath("/") +  Constant.UPLOADFILE + "/"+dir+"/"; 
		String savePath =Constant.UPLOADFILE + "/"+dir+"/"; 
		
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
					System.out.println("uploadFileLocation>>>>"+uploadFileLocation);
					String waterFilePath = request.getSession().getServletContext().getRealPath("/")+"/hui/static/watermark.png";
					NewImageUtils.AddwaterMark(uploadFileLocation, waterFilePath);
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
		object.put("originalFileName",originalFileName);
        
		PrintWriter out = null;   
		request.setCharacterEncoding("utf-8");     
	    response.setContentType("text/html; charset=utf-8");     
	    out =  response.getWriter();  
	    out.write(object.toJSONString());     
	    out.close(); 
	}
	
	
	@RequestMapping(value ="remove")
	@ResponseBody
	public JsonVo deleteFile(String path){
		if(StringUtils.isNotBlank(path)){
			String filePath = System.getProperty(Constant.WORKDIR)+path.substring(path.indexOf("/static"));
			System.out.println("filePath>>>>"+filePath);
			FileUtils.deleteFile(filePath);
		}
		return JsonUtils.success("ok");
	}
	
	

}
