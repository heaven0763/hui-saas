package com.chuangbang.wechat.hui.web.hotel;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import com.chuangbang.base.entity.hotel.HotelSchedule;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 场地档期Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotel/schedule")
public class WxHotelScheduleController extends BaseController {

	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private CategoryService categoryService;
	
	@ModelAttribute("hotelSchedule")
	public HotelSchedule getHotelSchedule(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return hotelScheduleService.getEntity(id);
		}
		return new HotelSchedule();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "weixin/hotel/scheduleIndex";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/hotelScheduleForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(HotelSchedule hotelSchedule,String action) {
		if("create".equals(action)){
			hotelScheduleService.saveHotelSchedule(hotelSchedule,hotelSchedule.getPlaceSchedule());
		}else{
			hotelScheduleService.saveHotelSchedule(hotelSchedule);
		}
		
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<HotelSchedule> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		pageBean.setSort("placeId,placeDate,placeSchedule");
		pageBean.setOrder("asc,asc,asc");
		Page<HotelSchedule> page = hotelScheduleService.getEntities(pageBean);
		for (HotelSchedule hotelSchedule : page) {
			hotelSchedule.setPlaceSchedule(categoryService.getEntity(Long.valueOf(hotelSchedule.getPlaceSchedule())).getName());
		}
		return getDataGrid(pageBean, page.getContent());
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		HotelSchedule hotelSchedule = hotelScheduleService.getEntity(id);
		model.addAttribute("hotelSchedule", hotelSchedule);
		return new ModelAndView("hotel/hotelScheduleForm");
	}
	
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		hotelScheduleService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping("/batch/upload/index")
	public String uploadindex(HttpServletRequest request,Model model){
		return "weixin/hotel/batchScheudleImport";
	}
	
	@RequestMapping("/upload")
	@ResponseBody
	public JsonVo upload(HttpServletRequest request,Model model){
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartHttpServletRequest.getFile("excel");
		//处理文件  
        String fileName = file.getOriginalFilename();  
        //获取文件扩展名  
        String extName = fileName.substring(fileName.lastIndexOf("."));  
        if(!"xls".equals(extName.replace(".", ""))&&!"xlsx".equals(extName.replace(".", ""))){
        	return JsonUtils.error("上传文件格式错误！只能上Excel文件。");
        }
        //生成UUID文件名  
        String newName = UUID.randomUUID().toString();  
        String rootPath = request.getServletContext().getRealPath("/hui");  
        String newPath = rootPath+"/static/excel/";  
        String realPath = "";
        try {
        	File dir = new File(newPath);
        	if(!dir.exists()){
        		dir.mkdirs();
        	}
        	realPath = FileUtils.saveFile(newPath, newName+extName, file.getBytes());
		} catch (IOException e) {
			return JsonUtils.error("上传失败！");
		}
        //List<Map<String,Object>> res = ExcelUtils.readExcelFile(realPath);  
        FileUtils.delFile(realPath);
       /* if(json.isSuccess()){
        }else{
        	return JsonUtils.error(json.getMsg());
        }*/
        return JsonUtils.success("ok");
	}
}
