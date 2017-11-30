package com.chuangbang.wechat.hui.web.hotel;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.chuangbang.base.dao.hotel.HotelPlaceDao;
import com.chuangbang.base.entity.hotel.PlacePrice;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.excel.ExcelUtils;
import com.chuangbang.framework.util.file.FileUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.google.common.collect.Lists;

/**
 * 场地价格Controller
 * @author mabelxiao
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "weixin/hotel/price")
public class WxPlacePriceController extends BaseController {

	@Autowired
	private PlacePriceService placePriceService;
	
	@Autowired
	private CusQueryService cusQueryService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelPlaceDao hotelPlaceDao;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	
	@ModelAttribute("placePrice")
	public PlacePrice getPlacePrice(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return placePriceService.getEntity(id);
		}
		return new PlacePrice();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model,HttpServletRequest request) {
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/hotel/placePriceIndex";
		}else{
			return "hotel/placePriceIndex";
		}
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "hotel/placePriceForm";
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<PlacePrice> pageBean,HttpServletRequest request,String[] searchDates,String onOrOff,Long hotelId,Long placeId,Long city) {
		StringBuilder sbd =  new StringBuilder();
		List<Object> params = Lists.newArrayList();
		
		sbd.append("select place.hotel_id,place.id id,place.place_name placeName");
		String price_col = "off".equals(onOrOff)? "offline_price" : "online_price";
		if(searchDates != null){
			for(int i = 0; i < searchDates.length ; i++){
				sbd.append(",max(case price.place_schedule when '"+searchDates[i] +"' then   price."+price_col+" else '0' end)  price_" + i);
				sbd.append(",max(case price.place_schedule when '"+searchDates[i] +"' then   price.update_date else '' end) update_date_"+i);
			}
		}
		
		sbd.append(" from  hzg_saas.hui_hotel_place place left join hui_hotel h on h.id = place.hotel_id");
		sbd.append(" left join hzg_saas.hui_place_price price on place.id=price.place_id where 1=1 ");
		if(AccountUtils.getCurrentUserType().equals("HOTEL")){
			if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				if(hotelId!=null){
					sbd.append(" and place.hotel_id ="+hotelId);
				}else{
					String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
					sbd.append(" and place.hotel_id in ("+hotelIds+")");
				}
				if(city!=null){
					sbd.append(" and h.city ="+city);
				}
			}else{
				sbd.append(" and place.hotel_id ="+AccountUtils.getCurrentUserHotelId());
			}
		}else if(AccountUtils.getCurrentUserType().equals("HUI")){
			if(hotelId!=null){
				sbd.append(" and place.hotel_id ="+hotelId);
			}
			if(city!=null){
				sbd.append(" and h.city ="+city);
			}
		}else{
			if(hotelId!=null){
				sbd.append(" and place.hotel_id ="+hotelId);
			}
			if(city!=null){
				sbd.append(" and h.city ="+city);
			}
		}
		
		if(placeId!=null){
			sbd.append(" and place.id ="+placeId);
		}
		sbd.append(" group by place.id  ");
		pageBean.setOrder("asc,asc");
		pageBean.setSort("place.hotel_id,place.id");
		Long total = this.hotelPlaceDao.count();
		List<Map<String,Object>> mapList = cusQueryService.pageAsMap(pageBean, sbd.toString(), params);
		pageBean.setTotalCount(total);
		return getDataGrid(pageBean, mapList);
	}
	
	@RequestMapping(value ="list/detail")
	@ResponseBody
	public JsonVo listDetail(PageBean<PlacePrice> pageBean,HttpServletRequest request) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		List<PlacePrice> placePrices = placePriceService.getEntities(searchparas);
		return JsonUtils.success("",placePrices);
	}
	
	@RequestMapping(value ="adjust/save")
	@ResponseBody
	public JsonVo adjustSave(PageBean<PlacePrice> pageBean,HttpServletRequest request,Double adjust_price,String price_type
			,Double sun,Double mon,Double tue,Double wed,Double thu,Double fri,Double sat) {
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		List<PlacePrice> placePrices = placePriceService.batchSavePrice(searchparas,adjust_price,price_type,sun,mon,tue,wed,thu,fri,sat);
		return JsonUtils.success("",placePrices);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		PlacePrice placePrice = placePriceService.getEntity(id);
		model.addAttribute("placePrice", placePrice);
		return new ModelAndView("hotel/placePriceForm");
	}
	
	@RequestMapping("/batch/upload/index")
	public String uploadindex(HttpServletRequest request,Model model){
		return "weixin/hotel/batchPriceImport";
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
