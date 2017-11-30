package com.chuangbang.app.api;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.chuangbang.app.message.Message;
import com.chuangbang.app.message.MsgItem;
import com.chuangbang.app.model.CommentModel;
import com.chuangbang.app.model.CommentSumModel;
import com.chuangbang.app.model.HallModel;
import com.chuangbang.app.model.HotelModel;
import com.chuangbang.app.model.MessageModel;
import com.chuangbang.app.model.OrderModel;
import com.chuangbang.app.model.RecommendedHotel;
import com.chuangbang.app.model.RegionModel;
import com.chuangbang.app.model.RoomModel;
import com.chuangbang.app.model.SalerModel;
import com.chuangbang.app.model.ScheduleModel;
import com.chuangbang.app.model.SupportingModel;
import com.chuangbang.base.entity.app.Api;
import com.chuangbang.base.entity.app.Application;
import com.chuangbang.base.entity.app.Log;
import com.chuangbang.base.entity.hotel.Category;
import com.chuangbang.base.entity.hotel.District;
import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelCooperationInfo;
import com.chuangbang.base.entity.hotel.HotelDynamic;
import com.chuangbang.base.entity.hotel.HotelMenu;
import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.entity.hotel.SiteImg;
import com.chuangbang.base.entity.hotel.SiteStype;
import com.chuangbang.base.entity.hotel.SupportingServices;
import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.base.entity.order.Order;
import com.chuangbang.base.service.app.ApiService;
import com.chuangbang.base.service.app.ApplicationService;
import com.chuangbang.base.service.app.LogService;
import com.chuangbang.base.service.hotel.CategoryService;
import com.chuangbang.base.service.hotel.DistrictService;
import com.chuangbang.base.service.hotel.HotelCooperationInfoService;
import com.chuangbang.base.service.hotel.HotelDynamicService;
import com.chuangbang.base.service.hotel.HotelMenuDetailService;
import com.chuangbang.base.service.hotel.HotelMenuService;
import com.chuangbang.base.service.hotel.HotelPlaceService;
import com.chuangbang.base.service.hotel.HotelScheduleService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.PlacePriceService;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.base.service.hotel.SiteImgService;
import com.chuangbang.base.service.hotel.SiteStypeService;
import com.chuangbang.base.service.hotel.SupportingServicesService;
import com.chuangbang.base.service.order.EvaluateService;
import com.chuangbang.base.service.order.OrderDetailService;
import com.chuangbang.base.service.order.OrderService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.MessageService;
import com.chuangbang.framework.util.AESUtil;
import com.chuangbang.framework.util.common.DateTimeUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.plugins.baidu.yun.map.model.BaiduMapResult;
import com.chuangbang.plugins.baidu.yun.util.BaiduMapUtil;
import com.chuangbang.plugins.sms.util.CallUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
@Controller
@RequestMapping(value = "/api")
public class APIController extends BaseController {
	private Message message = new Message();
	@Autowired
	private SiteStypeService siteStypeService;
	@Autowired
	private ApplicationService applicationService;
	@Autowired
	private LogService logService;
	@Autowired
	private ApiService apiService;
	@Autowired
	private SupportingServicesService supportingServicesService;
	@Autowired
	private RegionService regionService;
	@Autowired
	private DistrictService districtService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private HotelPlaceService hotelPlaceService;
	@Autowired
	private HotelMenuService hotelMenuService;
	@Autowired
	private HotelMenuDetailService hotelMenuDetailService;
	@Autowired
	private SiteImgService siteImgService;
	
	@Autowired
	private HotelScheduleService hotelScheduleService;
	@Autowired
	private EvaluateService evaluateService;
	@Autowired
	private HotelDynamicService hotelDynamicService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private PlacePriceService placePriceService;
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private HotelCooperationInfoService hotelCooperationInfoService;
	@Autowired
	private ChatRecordService chatRecordService;
	
	/**
	 * 测试接口
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws MalformedURLException
	 */
	@RequestMapping(value = "/test")//, method = RequestMethod.POST
	@ResponseBody
	public ResponseEntity<Message> test(HttpServletRequest request,HttpServletResponse response,String params) throws MalformedURLException {
		/*List<Hotel> hotels = this.hotelService.getAllEntities();
		for (Hotel hotel : hotels) {
			Category star = this.categoryService.getEntity(Long.valueOf(hotel.getHotelStar()));
			Region city = this.regionService.getEntity(Long.valueOf(hotel.getCity()+""));
			Region dis = this.regionService.getEntity(Long.valueOf(hotel.getDistrict()+""));
			int i = (int)(Math.random()*10)+30;
			for (int j = 0; j < i; j++) {
				Evaluate evaluate = new Evaluate("SITE", "1", RandomStringUtil.getOrderNo(8), city.getRegionName(), star.getName(), hotel.getId(), hotel.getHotelName(), "HOTEL",  hotel.getId()+"", hotel.getHotelName(), 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, "不错", "好评！真不错！", "CLIENT", (int)(Math.random()*100+100)+"", RandomStringUtil.nextString(10), "0", new Date(), new Date(), "测试数据！");
				this.evaluateService.saveEntity(evaluate);
			}
			
			List<HallModel> hallModels = this.hotelPlaceService.getHotelHallPageList(hotel.getId(), 1000);
			
			for (HallModel hallModel : hallModels) {
				int k = (int)(Math.random()*10)+20;
				for (int j = 0; j < k; j++) {
					Evaluate evaluate = new Evaluate("SITE", "1", RandomStringUtil.getOrderNo(8), city.getRegionName(), star.getName(), hotel.getId(), hotel.getHotelName(), "HALL",  hallModel.getId()+"", hallModel.getPlaceName(), 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, "不错", "好评！真不错！", "CLIENT", (int)(Math.random()*100+100)+"", RandomStringUtil.nextString(10), "0", new Date(), new Date(), "测试数据！");
					this.evaluateService.saveEntity(evaluate);
				}
			}
			
			List<RoomModel> roomModels = this.hotelPlaceService.getHotelRoomPageList(hotel.getId(), 1000);
			for (RoomModel roomModel : roomModels) {
				int k = (int)(Math.random()*10)+20;
				for (int j = 0; j < k; j++) {
					Evaluate evaluate = new Evaluate("SITE", "1", RandomStringUtil.getOrderNo(8), city.getRegionName(), star.getName(), hotel.getId(), hotel.getHotelName(), "ROOM",  roomModel.getId()+"",roomModel.getPlaceName(), 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, "不错", "好评！真不错！", "CLIENT", (int)(Math.random()*100+100)+"", RandomStringUtil.nextString(10), "0", new Date(), new Date(), "测试数据！");
					evaluate.setArea(dis.getRegionName());
					this.evaluateService.saveEntity(evaluate);
				}
			}
		}*/
		message.setMsg("10000", "处理成功","test");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 场所风格
	 * @param pageBean
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value ="/style/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> styleList(PageBean<SiteStype> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		Application application = this.getApplication(resParams.get("key").toString());
		List<SiteStype> list = siteStypeService.getEntities(filterParams,new Sort(Direction.ASC, "id"));
		
		String str = JSONObject.toJSONString(list);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str.trim(), application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","场所风格查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	/**
	 * 推荐城市
	 * @param pageBean
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value ="/tj/cities", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> cityList(PageBean<RegionModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		Application application = this.getApplication(resParams.get("key").toString());
		
		filterParams.put("EQ_r.region_type", "2");
		filterParams.put("EQ_r.is_tui", "1");
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("r.sort_order");
		pageBean.setOrder("asc");
		List<RegionModel> list = regionService.getAllRegionModel(pageBean);
		
		String str = JSONObject.toJSONString(list);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str.trim(), application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","推荐城市");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/support/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> suportList(PageBean<SupportingServices> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("kind")&&StringUtils.isNotBlank(resParams.get("kind").toString())){
			filterParams.put("EQ_kind", resParams.get("kind"));
		}else{
			return returnError("10003", "参数错误");
		}
		Application application = this.getApplication(resParams.get("key").toString());
		System.out.println(filterParams.toString());
		List<SupportingServices> list = supportingServicesService.getEntities(filterParams,new Sort(Direction.ASC, "id"));
		
		String str = JSONObject.toJSONString(list);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		
		message.setMsg("10000", "查询成功", result);
		JSONObject jsonObject = (JSONObject) JSONObject.toJSON(message);
		System.out.println("jsonObject>>>"+jsonObject);
		
		this.log(application,request,"query","配套服务查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	@RequestMapping(value ="/regions/list")//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> regionsList(PageBean<RegionModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		
		String rows = resParams.get("rows")==null?"0":resParams.get("rows").toString();
		String page = resParams.get("page")==null?"":resParams.get("page").toString();
		String regionType = resParams.get("regionType")==null?"":resParams.get("regionType").toString();
		
		
		Application application = this.getApplication(resParams.get("key").toString());
		
		Map<String, Object> filterParams = Maps.newHashMap();
		if(StringUtils.isNotBlank(regionType)){
			if("PROVINCE".equals(regionType)){
				filterParams.put("EQ_r.region_type", "1");
			}else if("CITY".equals(regionType)){
				filterParams.put("EQ_r.region_type", "2");
			}else if("DISTRICT".equals(regionType)){
				filterParams.put("EQ_r.region_type", "3");
			}else{
				return returnError("10003", "参数错误");
			}
		}else{
			return returnError("10003", "参数错误t");
		}
		
		if(StringUtils.isNotBlank(rows)){
			try {
				pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
			} catch (Exception e) {
				return returnError("10003", "参数错误");
			}
		}else{
			return returnError("10003", "参数错误r");
		}
		
		if(StringUtils.isNotBlank(page)){
			try {
				pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
			} catch (Exception e) {
				return returnError("10003", "参数错误");
			}
		}else{
			return returnError("10003", "参数错误p");
		}
		pageBean.set_filterParams(filterParams);
	
		
		pageBean.setOrder("asc");
		List<RegionModel> regions = regionService.getPageRegionModel(pageBean);
		pageBean.setList(regions);
		pageBean.set_filterParams(null);
		pageBean.setOrder("");
		pageBean.setSort("");
		
		String str = JSONObject.toJSONString(regions);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","查询组合条件查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/search/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> searchList(PageBean<SupportingServices> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Application application = this.getApplication(resParams.get("key").toString());
		List<MsgItem> items = Lists.newArrayList();
		
		/*城市*/
		Map<String, Object> filterParams = Maps.newHashMap();
		/*List<Region> regions = regionService.getCitys(filterParams);
		MsgItem region = new MsgItem("city", regions);
		items.add(region);*/
		
		/*区域*/
		/*filterParams.clear();
		filterParams.put("EQ_regionType", "3");
		List<Region> dregions = regionService.getRegions(filterParams);
		MsgItem dregion = new MsgItem("region", dregions);
		items.add(dregion);*/
		
		/*商圈*/
		/*Map<String, Object> districtsParams = Maps.newHashMap();
		List<District> districts = districtService.getEntities(districtsParams,new Sort(Direction.ASC, "sortOrder"));
		MsgItem district = new MsgItem("district", districts);
		items.add(district);*/
		
		/*星级*/
		Map<String, Object> categoryParams = Maps.newHashMap();
		List<Category> stars = categoryService.getCategories("STAR");
		MsgItem star = new MsgItem("star", stars);
		items.add(star);
		
		/*面积*/
		categoryParams.clear();
		List<Category> areas = categoryService.getCategories("AREA");
		MsgItem area = new MsgItem("area", areas);
		items.add(area);
		
		/*人数*/
		categoryParams.clear();
		List<Category> persons = categoryService.getCategories("PERSON");
		MsgItem person = new MsgItem("person", persons);
		items.add(person);
		
		/*价格*/
		categoryParams.clear();
		List<Category> prices = categoryService.getCategories("PRICE");
		MsgItem price = new MsgItem("price", prices);
		items.add(price);
		
		/*目的*/
		categoryParams.clear();
		List<Category> purposes = categoryService.getCategories("PURPOSE");
		MsgItem purpose = new MsgItem("purpose", purposes);
		items.add(purpose);
		
		String str = JSONObject.toJSONString(items);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","查询组合条件查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 成交数：dealNum
	 * 、是否推荐:istui
	 * 、装修时间升降序:decorationTime
	 * 、是否有实地认证标签:isauth
	 * 、酒店名称模糊关键字:hotelName
	 * 、所属城市:city
	 * 、所属区域:region
	 * 、所属商圈:district
	 * 、星级:star
	 * 、面积范围:area
	 * 、可容纳人数范围:person
	 * 、价格范围:price;
	 * 、价格排序:priceSort;
	 * 、可多选的风格标签:style
	 * 、可多选的配套服务:support
	 * 、是否精品推荐:istui
	 * @param pageBean
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value ="/hotel/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> hotelList(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		try{
			Map<String, Object> resParams = this.getSearchFilterParams(params);
			String dealNum = resParams.get("dealNum")==null?"":resParams.get("dealNum").toString();
			String istui = resParams.get("istui")==null?"":resParams.get("istui").toString();
			String decorationTime = resParams.get("decorationTime")==null?"":resParams.get("decorationTime").toString();
			String priceSort = resParams.get("priceSort")==null?"":resParams.get("priceSort").toString();
			
			String isHot = resParams.get("isHot")==null?"":resParams.get("isHot").toString();
			
			String isauth = resParams.get("isauth")==null?"":resParams.get("isauth").toString();
			String hotelName = resParams.get("hotelName")==null?"":resParams.get("hotelName").toString();
			String city = resParams.get("city")==null?"":resParams.get("city").toString();
			String region = resParams.get("region")==null?"":resParams.get("region").toString();
			String district = resParams.get("district")==null?"":resParams.get("district").toString();
			String star = resParams.get("star")==null?"":resParams.get("star").toString();
			String area = resParams.get("area")==null?"":resParams.get("area").toString();
			String person = resParams.get("person")==null?"":resParams.get("person").toString();
			String price = resParams.get("price")==null?"":resParams.get("price").toString();
			
			String style = resParams.get("style")==null?"":resParams.get("style").toString();
			String support = resParams.get("support")==null?"":resParams.get("support").toString();
			
			String purpose = resParams.get("purpose")==null?"":resParams.get("purpose").toString();
			Integer venuenum = resParams.get("venuenum")==null?null:Integer.valueOf(resParams.get("venuenum").toString());
			Integer qsbednum = resParams.get("qsbednum")==null?null:Integer.valueOf(resParams.get("qsbednum").toString());
			Integer dualbednum = resParams.get("dualbednum")==null?null:Integer.valueOf(resParams.get("dualbednum").toString());
			
			
			String sort = resParams.get("sort")==null?"":resParams.get("sort").toString();
			String order =resParams.get("order")==null?"":resParams.get("order").toString();
			
			Double longitude=resParams.get("longitude")==null||StringUtils.isBlank(resParams.get("longitude").toString())?null:Double.valueOf(resParams.get("longitude").toString());
			Double latitude=resParams.get("latitude")==null||StringUtils.isBlank(resParams.get("latitude").toString())?null:Double.valueOf(resParams.get("latitude").toString());
			
			String quyu =resParams.get("quyu")==null?"":resParams.get("quyu").toString();
			Map<String, Object> filterParams = Maps.newHashMap();
			System.out.println(quyu);
			if(null!=longitude&&null!=latitude){
				order=splitStr(order,"asc");
				sort=splitStr(sort,"distance");
			}else{
				if(StringUtils.isNotBlank(quyu)){
					Region rgon =this.regionService.findByRegionName(quyu);
					if(rgon!=null){
						longitude = rgon.getLongitude();
						latitude = rgon.getLatitude();
						order=splitStr(order,"asc");
						sort=splitStr(sort,"distance");
						if(rgon.getRegionType().equals("1")){
							filterParams.put("EQ_h.provice", rgon.getId());
						}else if(rgon.getRegionType().equals("2")){
							filterParams.put("EQ_h.city", rgon.getId());
						}
					}else{
						try {
							BaiduMapResult baiduMapResult = BaiduMapUtil.getGeocoding(quyu);
							System.out.println("level"+baiduMapResult.getLevel());
							longitude = Double.valueOf(baiduMapResult.getLocation().getLng());
							latitude = Double.valueOf(baiduMapResult.getLocation().getLat());
							order=splitStr(order,"asc");
							sort=splitStr(sort,"distance");
							/*if(baiduMapResult.getLevel().equals("省")){
								filterParams.put("EQ_h.provice", rgon.getId());
							}else if(baiduMapResult.getLevel().equals("城市")){
								filterParams.put("EQ_h.city", rgon.getId());
							}*/
						} catch (UnsupportedEncodingException e) {
						}
					}
				}
			}
			
		
			if(StringUtils.isNotBlank(dealNum)){
				if(dealNum.equalsIgnoreCase("desc")||dealNum.equalsIgnoreCase("asc")){
					sort=splitStr(sort,"dealNum");
					order=splitStr(order,dealNum);
				}else{
					//filterParams.put("", dealNum);
				}
			}
			if(StringUtils.isNotBlank(istui)){
				if(istui.equalsIgnoreCase("desc")||istui.equalsIgnoreCase("asc")){
					sort=splitStr(sort,"h.is_tui");
					order=splitStr(order,istui);
				}else{
					//filterParams.put("", istui);
				}
			}
			
			if(StringUtils.isNotBlank(isHot)){
				if(istui.equalsIgnoreCase("desc")||istui.equalsIgnoreCase("asc")){
					sort=splitStr(sort,"h.is_hot");
					order=splitStr(order,isHot);
				}else{
					//filterParams.put("", isHot);
				}
			}
			if(StringUtils.isNotBlank(decorationTime)){
				if(decorationTime.equalsIgnoreCase("desc")||decorationTime.equalsIgnoreCase("asc")){
					order=splitStr(order,decorationTime);
					sort=splitStr(sort,"h.decoration_time");
				}else{
					filterParams.put("GTE_h.decoration_time", decorationTime);
					filterParams.put("LTE_h.decoration_time", decorationTime);
				}
			}
			
			if(StringUtils.isNotBlank(priceSort)){
				if(priceSort.equalsIgnoreCase("desc")||priceSort.equalsIgnoreCase("asc")){
					order=splitStr(order,priceSort);
					sort=splitStr(sort,"h.average_price");
				}
			}
			
			/*if(StringUtils.isNotBlank(dealNum)){
				if(dealNum.equalsIgnoreCase("desc")||dealNum.equalsIgnoreCase("asc")){
					order=splitStr(order,"dealNum");
					sort=splitStr(sort,dealNum);
				}else{
					filterParams.put("", dealNum);
				}
			}*/
			
			if(StringUtils.isNotBlank(isauth)){
					filterParams.put("EQ_h.verify", isauth);
			}
			
			if(StringUtils.isNotBlank(hotelName)){
					filterParams.put("LIKE_h.hotel_name", hotelName);
			}
			
			if(StringUtils.isNotBlank(city)){
				filterParams.put("EQ_h.city", city);
			}
			if(StringUtils.isNotBlank(region)){
				filterParams.put("EQ_h.district", region);
			}
			if(StringUtils.isNotBlank(district)){
				filterParams.put("EQ_h.trade_area", district);
			}
			if(StringUtils.isNotBlank(star)){
				filterParams.put("EQ_h.hotel_star", star);
			}
			String sorts = "";
			String descs = "";
			int n = 0;
			
			List<Map<String, Object>> hallParams = Lists.newArrayList();
			if(StringUtils.isNotBlank(area)){
				String []areas = area.split(",");
				filterParams.put("GTE_h.hall_max_area", Integer.valueOf(areas[0]));
				filterParams.put("LTE_h.hall_max_area", Integer.valueOf(areas[1]));
				
				sorts =splitStr(sorts,"h.hall_area");
				descs =splitStr(descs,"desc");
				
				Map<String, Object> hmap = Maps.newHashMap();
				hmap.put("key", "hall_max_area");
				hmap.put("val1", Integer.valueOf(areas[0]));
				hmap.put("val2", Integer.valueOf(areas[1]));
				hallParams.add(hmap);
				n++;
			}
			
			if(StringUtils.isNotBlank(person)){
				String []persons = person.split(",");
				filterParams.put("GTE_h.max_people_num", Integer.valueOf(persons[0]));
				filterParams.put("LTE_h.max_people_num", Integer.valueOf( persons[1]));
				
				sorts =splitStr(sorts,"h.people_num");
				descs =splitStr(descs,"desc");
				
				Map<String, Object> hmap = Maps.newHashMap();
				hmap.put("key", "max_people_num");
				hmap.put("val1", Integer.valueOf(persons[0]));
				hmap.put("val2", Integer.valueOf(persons[1]));
				hallParams.add(hmap);
				n++;
			}
			
			if(StringUtils.isNotBlank(price)){
				String []prices = price.split(",");
				filterParams.put("GTE_h.average_price", Double.valueOf(prices[0]));
				filterParams.put("LTE_h.average_price", Double.valueOf(prices[1]));
				
				sorts =splitStr(sorts,"h.hotel_price");
				descs =splitStr(descs,"desc");
				
				Map<String, Object> hmap = Maps.newHashMap();
				hmap.put("key", "average_price");
				hmap.put("val1", Double.valueOf(prices[0]));
				hmap.put("val2", Double.valueOf(prices[1]));
				hallParams.add(hmap);
				n++;
			}
			
			if(StringUtils.isNotBlank(style)){
				filterParams.put("EQ_style", style);
			}
			if(StringUtils.isNotBlank(purpose)){
				filterParams.put("EQ_purpose", purpose);
			}
			
			if(venuenum!=null){
				filterParams.put("GTE_h.hall_num", venuenum+1);
			}
			if(qsbednum!=null){
				filterParams.put("LTE_qsbednum", qsbednum);
			}
			if(dualbednum!=null){
				filterParams.put("LTE_dualbednum", dualbednum);
			}
			
			System.out.println(">>>>"+filterParams.toString());
			Application application = this.getApplication(resParams.get("key").toString());
			PageBean<Map<String, Object>> pageBean = new PageBean<>();
			pageBean.set_filterParams(filterParams);
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
			
			if(StringUtils.isNotBlank(order)){
				order = ",asc,desc";
			}else{
				order += "asc,desc";
			}
			if(StringUtils.isNotBlank(sort)){
				sort = ",h.sort_order,h.id";
			}else{
				sort += "h.sort_order,h.id";
			}
			pageBean.setOrder(order);
			pageBean.setSort(sort);
			Date sdate = new Date();
			List<Map<String, Object>> list = hotelService.getHotelPageListForApi(pageBean, longitude, latitude);
			Date edate = new Date();
			System.out.println("查询耗时>>>>>>"+(edate.getTime()-sdate.getTime())/1000+"s");
			
			for (Map<String, Object> hotelModel : list) {
				List<Map<String, Object>> hallModels = this.hotelPlaceService.getHotelHallPageListForApi(Long.valueOf(hotelModel.get("id")+""), 3,sorts,descs);
				
				for (Map<String, Object> hallModel : hallModels) {
					hallModel.put("inLineWith","0");
					if(n>0){
						int k=0;
						for (Map<String, Object> hmap : hallParams) {
							if(hmap.get("key").toString().equals("hall_max_area")){
								if(Double.valueOf(hallModel.get("hallArea")+"")>=Double.valueOf(hmap.get("val1").toString())
										&&Double.valueOf(hallModel.get("hallArea")+"")<=Double.valueOf(hmap.get("val2").toString())){
									k++;
									continue;
								}
							}
							if(hmap.get("key").toString().equals("max_people_num")){
								if(Double.valueOf(hallModel.get("peopleNum")+"")>=Double.valueOf(hmap.get("val1").toString())
										&&Double.valueOf(hallModel.get("peopleNum")+"")<=Double.valueOf(hmap.get("val2").toString())){
									k++;
									continue;
								}
							}
							if(hmap.get("key").toString().equals("average_price")){
								if(Double.valueOf(hallModel.get("hotelPrice")+"")>=Double.valueOf(hmap.get("val1").toString())
										&&Double.valueOf(hallModel.get("hotelPrice")+"")<=Double.valueOf(hmap.get("val2").toString())){
									k++;
									continue;
								}
							}
						}
						if(k==n){
							hallModel.put("inLineWith","1");
						}
					}
				}
				hotelModel.put("halls", hallModels);
			}
			pageBean.setList(list);
			pageBean.set_filterParams(null);
			pageBean.setOrder("");
			pageBean.setSort("");
			String str = JSONObject.toJSONString(pageBean);
			System.out.println(str);
			String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
			message.setMsg("10000", "查询成功", result);
			
			this.log(application,request,"query","酒店列表查询");
			return new ResponseEntity<Message>(message, HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			message.setMsg("10009", "系统错误");
			return new ResponseEntity<Message>(message, HttpStatus.OK);
		}
		
	}
	
	@RequestMapping(value ="/hotel/info", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> hotelInfo(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		if(null==resParams.get("hotelId")||StringUtils.isBlank(resParams.get("hotelId").toString())){
			return returnError("10003", "参数错误");
		}
		Long hotelId = Long.valueOf(resParams.get("hotelId").toString());
		HotelModel hotel = this.hotelService.getHotel(hotelId);
		
		if(hotel==null){
			message.setMsg("10101", "酒店不存在");
			return new ResponseEntity<Message>(message, HttpStatus.OK);
		}
		System.out.println("hotel>>>>"+hotel.getHallPrice());
		System.out.println("hotel>>>>"+hotel.getRoomPrice());
		
		List<Map<String, Object>> hotelImgs =Lists.newArrayList();

		hotel.setHalls(this.hotelPlaceService.getHotelHallPageListForApi(hotelId, 1000,"h.id","asc"));
		if(hotel.getHalls()!=null&&hotel.getHalls().size()>0){
			List<Map<String, Object>> himgs = Lists.newArrayList();
			for (Map<String, Object> hall : hotel.getHalls()) {
				List<SiteImg> imgs = this.siteImgService.findBySiteIdAndSiteTypeAndPicType(Long.valueOf(hall.get("id")+""), "HALL","BASEPIC");
				Map<String, Object> himg = Maps.newHashMap();
				himg.put("id", hall.get("id"));
				himg.put("name",hall.get("placeName"));
				himg.put("imgs", imgs);
				himgs.add(himg);
			}
			Map<String, Object> hallimg = Maps.newHashMap();
			hallimg.put("type", "HALL");
			hallimg.put("name", "会场");
			hallimg.put("list", himgs);
			hotelImgs.add(hallimg);
		}
		
		hotel.setRooms(this.hotelPlaceService.getHotelRoomPageList(hotelId, 1000));
		if( hotel.getRooms()!=null&& hotel.getRooms().size()>0){
			List<Map<String, Object>> rimgs = Lists.newArrayList();
			for (RoomModel room : hotel.getRooms()) {
				List<SiteImg> imgs = this.siteImgService.findBySiteIdAndSiteTypeAndPicType(room.getId(), "ROOM","BASEPIC");
				Map<String, Object> rimg = Maps.newHashMap();
				rimg.put("id", room.getId());
				rimg.put("name", room.getPlaceName());
				rimg.put("imgs", imgs);
				rimgs.add(rimg);
			}
			Map<String, Object> roomimg = Maps.newHashMap();
			roomimg.put("type", "ROOM");
			roomimg.put("name", "客房");
			roomimg.put("list", rimgs);
			hotelImgs.add(roomimg);
		}
		
		List<SiteImg> htlimgs = this.siteImgService.findBySiteIdAndSiteTypeAndPicType(hotel.getId(), "HOTEL","BASEPIC");
		Map<String, Object> hotelimg = Maps.newHashMap();
		hotelimg.put("type", "HOTEL");
		hotelimg.put("name", "场地外观图");
		hotelimg.put("list", htlimgs);
		hotelImgs.add(hotelimg);
		
		List<SiteImg> extimgs = this.siteImgService.findByHotelIdAndPicType(hotel.getId(),"EXTPIC");
		Map<String, Object> extimg = Maps.newHashMap();
		extimg.put("type", "EXT");
		extimg.put("name", "用户上传");
		extimg.put("list", extimgs);
		hotelImgs.add(extimg);
		
		
		hotel.setImgs(hotelImgs);
		hotel.setStyles(this.siteStypeService.getSiteStypes(hotel.getStyle()));
		//hotel.setSupports(this.supportingServicesService.findByKind("HOTELSUPORTING",hotel.getId()+"","HOTEL"));
		List<SupportingModel> roomservices = this.supportingServicesService.findByKind("ROOMSERVICE",hotel.getId()+"","HOTEL");
		hotel.setRoomservices(roomservices);
		List<CommentSumModel> commentSumModels =  this.evaluateService.getAvgComment(hotelId, hotelId, "HOTEL");
		CommentSumModel selfSumAvg = (commentSumModels==null||commentSumModels.size()<=0)?new CommentSumModel():commentSumModels.get(0);
		List<CommentSumModel> sumModels  = this.evaluateService.getAvgComment(null, null, "HOTEL");
		CommentSumModel allSumAvg = (sumModels==null||sumModels.size()<=0)?null:sumModels.get(0);
		Map<String, Object> commentSumAvgs = Maps.newHashMap();
		commentSumAvgs.put("selfSumAvg", selfSumAvg);
		commentSumAvgs.put("allSumAvg", allSumAvg);
		hotel.setComments(commentSumAvgs);
		
		Application application = this.getApplication(resParams.get("key").toString());
		String str = JSONObject.toJSONString(hotel);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","酒店详情查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/hall/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> hallList(PageBean<HallModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_h.hotel_id", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		filterParams.put("EQ_h.place_type", "HALL");
		pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		pageBean.set_filterParams(filterParams);
		List<HallModel> list = hotelPlaceService.getHallPageList(pageBean);
		Application application = this.getApplication(resParams.get("key").toString());
		
		pageBean.setList(list);
		pageBean.set_filterParams(null);
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","配套服务查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/hall/info", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> hallInfo(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		if(null==resParams.get("hallId")||StringUtils.isBlank(resParams.get("hallId").toString())){
			return returnError("10003", "参数错误");
		}
		Long hallId = Long.valueOf(resParams.get("hallId").toString());
		HallModel hall = this.hotelPlaceService.getHall(hallId);
		
		hall.setSupportings(this.supportingServicesService.findByKind("HALLSUPPORT",hall.getId()+"","HALL"));
		hall.setHalldisplay(this.supportingServicesService.findByKind("HALLDISPLAY",hall.getId()+"","HALL"));
		hall.setSchedules(this.hotelScheduleService.getSchedulePageList(hallId, "HALL",DateTimeUtils.getCurrentDate()));
		hall.setImgs(this.siteImgService.findBySiteIdAndSiteType(hallId, "HALL"));
		
		hall.setPrices(null);
		
		
		
		List<CommentSumModel> commentSumModels =  this.evaluateService.getAvgComment(hall.getHotelId(), hallId, "HALL");
		CommentSumModel selfSumAvg = (commentSumModels==null||commentSumModels.size()<=0)?new CommentSumModel():commentSumModels.get(0);
		List<CommentSumModel> sumModels  = this.evaluateService.getAvgComment(null, null, "HALL");
		CommentSumModel allSumAvg = (sumModels==null||sumModels.size()<=0)?new CommentSumModel():sumModels.get(0);
		
		/*CommentSumModel selfSumAvg = this.evaluateService.getAvgComment(hall.getHotelId(), hallId, "HALL").get(0);
		CommentSumModel allSumAvg = this.evaluateService.getAvgComment(null, null, "HALL").get(0);*/
		Map<String, Object> commentSumAvgs = Maps.newHashMap();
		commentSumAvgs.put("selfSumAvg", selfSumAvg);
		commentSumAvgs.put("allSumAvg", allSumAvg);
		hall.setComments(commentSumAvgs);
		
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(hall);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","大厅详情查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	
	@RequestMapping(value ="/room/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> roomList(PageBean<RoomModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_r.hotel_id", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		filterParams.put("EQ_r.place_type", "ROOM");
		pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		pageBean.set_filterParams(filterParams);
		List<RoomModel> list = hotelPlaceService.getRoomPageList(pageBean);
		Application application = this.getApplication(resParams.get("key").toString());
		
		pageBean.setList(list);
		pageBean.set_filterParams(null);

		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","配套服务查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/room/info", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> roomInfo(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		if(null==resParams.get("roomId")||StringUtils.isBlank(resParams.get("roomId").toString())){
			return returnError("10003", "参数错误");
		}
		Long roomId = Long.valueOf(resParams.get("roomId").toString());
		RoomModel room = this.hotelPlaceService.getRoom(roomId);
		if(room==null){
			return returnError("10103", "客房不存在");
		}
		List<SupportingModel> supportings = this.supportingServicesService.findByKind("FACILITIES",room.getId()+"","ROOM");
		List<SupportingModel> halldisplay = this.supportingServicesService.findByKind("MEDIA&TECH",room.getId()+"","ROOM");
		room.setFacilities(supportings);
		room.setTeshs(halldisplay);
		room.setImgs(this.siteImgService.findBySiteIdAndSiteType(roomId, "ROOM"));
		
		CommentSumModel selfSumAvg = this.evaluateService.getAvgComment(room.getHotelId(), roomId, "ROOM").get(0);
		CommentSumModel allSumAvg = this.evaluateService.getAvgComment(null, null, "ROOM").get(0);
		Map<String, Object> commentSumAvgs = Maps.newHashMap();
		commentSumAvgs.put("selfSumAvg", selfSumAvg);
		commentSumAvgs.put("allSumAvg", allSumAvg);
		room.setComments(commentSumAvgs);
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(room);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","客房详情查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/menu/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> menuList(PageBean<HotelMenu> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_hotelId", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		pageBean.set_filterParams(filterParams);
		Page<HotelMenu> page = hotelMenuService.getEntities(pageBean);
		for (HotelMenu hotelMenu : page.getContent()) {
			hotelMenu.setHotelMenuDetails(hotelMenuDetailService.findByMenuId(hotelMenu.getId()));
		}
		Application application = this.getApplication(resParams.get("key").toString());
		
		pageBean.setList(page.getContent());
		pageBean.set_filterParams(null);
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","餐饮菜单列表查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/img/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> imgList(PageBean<SiteImg> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_hotelId", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		//pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		//pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		//pageBean.set_filterParams(filterParams);
		List<SiteImg> list = siteImgService.findByHotelId(filterParams);
		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(list);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","酒店图库查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/hall/schedule/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> scheduleList(PageBean<ScheduleModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		System.out.println(resParams.toString());
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_s.hotel_id", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("scheduleDate")&&StringUtils.isNotBlank(resParams.get("scheduleDate").toString())){
			filterParams.put("GTE_s.place_date", resParams.get("scheduleDate"));
		}else{
			return returnError("10003", "参数错误");
		}
		if(null!=resParams.get("hallId")&&StringUtils.isNotBlank(resParams.get("hallId").toString())){
			filterParams.put("EQ_s.place_id", resParams.get("hallId"));
		}
		System.out.println(filterParams.toString());
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("s.place_id,s.place_date,s.place_schedule");
		pageBean.setOrder("ASC,ASC,ASC");
		List<ScheduleModel> list = hotelScheduleService.getAllSchedule(pageBean);
		Application application = this.getApplication(resParams.get("key").toString());
		
		//pageBean.setList(list);
		//pageBean.set_filterParams(null);
		String str = JSONObject.toJSONString(list);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","酒店档期查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/comment/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> commentList(PageBean<CommentModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_e.hotel_id", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		
		if(null!=resParams.get("itemId")&&StringUtils.isNotBlank(resParams.get("itemId").toString())){
			filterParams.put("EQ_e.item_id", resParams.get("itemId"));
		}
		if(null!=resParams.get("itemType")&&StringUtils.isNotBlank(resParams.get("itemType").toString())){
			filterParams.put("EQ_e.item_type", resParams.get("itemType"));
		}
		filterParams.put("EQ_e.evaluate_type", "SITE");

		pageBean.setOrder("desc");
		pageBean.setSort("e.evaluate_date");
		pageBean.set_filterParams(filterParams);
		List<CommentModel> list = evaluateService.getCommentPageList(pageBean);
		pageBean.setList(list);
		pageBean.set_filterParams(null);
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","酒店评论查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/dynamice/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> dynamiceList(PageBean<HotelDynamic> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_hotelId", resParams.get("hotelId"));
		}
		/*else{
			return returnError("10003", "参数错误");
		}*/
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}

		pageBean.setOrder("desc");
		pageBean.setSort("createDate");
		pageBean.set_filterParams(filterParams);
		Page<HotelDynamic> list = hotelDynamicService.getEntities(pageBean);
		pageBean.setList(list.getContent());
		pageBean.set_filterParams(null);
		
		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","酒店动态查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/hui/dynamices", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> huiDynamiceList(PageBean<HotelDynamic> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("keyword")&&StringUtils.isNotBlank(resParams.get("keyword").toString())){
			filterParams.put("LIKE_pcontent", resParams.get("keyword"));
		}
		/*else{
			return returnError("10003", "参数错误");
		}*/
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}

		pageBean.setOrder("desc");
		pageBean.setSort("createDate");
		pageBean.set_filterParams(filterParams);
		Page<HotelDynamic> list = hotelDynamicService.getEntities(pageBean);
		pageBean.setList(list.getContent());
		pageBean.set_filterParams(null);
		
		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","酒店动态查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	//
	@RequestMapping(value ="/dynamice/comment/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> dynamiceCommentList(PageBean<MessageModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("dynamiceId")&&StringUtils.isNotBlank(resParams.get("dynamiceId").toString())){
			filterParams.put("EQ_m.item_id", resParams.get("dynamiceId"));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		filterParams.put("EQ_m.item_type", "HOTELDYNAMICE");
		filterParams.put("EQ_m.msg_type", "MESSAGE");
		pageBean.setOrder("desc");
		pageBean.setSort("m.msg_date");
		pageBean.set_filterParams(filterParams);
		List<MessageModel> list = messageService.getMessagePageList(pageBean);
		pageBean.setList(list);
		pageBean.set_filterParams(null);
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","酒店动态评论查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/dynamice/msg", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> dynamiceMsg(HttpServletRequest request,HttpServletResponse response,String params) {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		String itemId = "";
		String userId = "";
		String userName = "";
		String userPhoto = "";
		String msg = "";
		if(null!=resParams.get("itemId")&&StringUtils.isNotBlank(resParams.get("itemId").toString())){
			itemId = resParams.get("itemId").toString();
		}else{
			return returnError("10003", "参数错误");
		}
		if(null!=resParams.get("userId")&&StringUtils.isNotBlank(resParams.get("userId").toString())){
			userId = resParams.get("userId").toString();
		}else{
			return returnError("10003", "参数错误");
		}
		if(null!=resParams.get("userName")&&StringUtils.isNotBlank(resParams.get("userName").toString())){
			userName = resParams.get("userName").toString();
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("msg")&&StringUtils.isNotBlank(resParams.get("msg").toString())){
			msg = resParams.get("msg").toString();
		}else{
			return returnError("10003", "参数错误");
		}
		com.chuangbang.base.entity.user.Message msge = new com.chuangbang.base.entity.user.Message("MESSAGE","HOTELDYNAMICE", itemId, userId, userName, userPhoto, msg,"1");
		this.messageService.saveMessage(msge);
		Application application = this.getApplication(resParams.get("key").toString());

		message.setMsg("10000", "留言成功！");

		this.log(application,request,"query","酒店动态评论提交接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	
	@RequestMapping(value ="/interact/msg", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> interactMsg(HttpServletRequest request,HttpServletResponse response,String params) {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Long hotelId = resParams.get("hotelId")==null?null:Long.valueOf(resParams.get("hotelId")+"");
		String itemId = resParams.get("itemId")==null?null:resParams.get("itemId")+"";
		String userId = resParams.get("userId")==null?null:resParams.get("userId")+"";
		String userName = resParams.get("userName")==null?null:resParams.get("userName")+"";
		String userPhoto = resParams.get("userPhoto")==null?null:resParams.get("userPhoto")+"";
		String mobile = resParams.get("mobile")==null?null:resParams.get("mobile")+"";
		String email = resParams.get("email")==null?null:resParams.get("email")+"";
		String msg = resParams.get("msg")==null?null:resParams.get("msg")+"";
		String orderNo = resParams.get("orderNo")==null?null:resParams.get("orderNo")+"";
		String msgType = resParams.get("msgType")==null?null:resParams.get("msgType")+"";
		String itemType = resParams.get("itemType")==null?null:resParams.get("itemType")+"";
		
		if(hotelId==null){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(msgType)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(userId)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(userName)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(mobile)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(msg)){
			return returnError("10003", "参数错误");
		}
		
		com.chuangbang.base.entity.user.Message msge = new com.chuangbang.base.entity.user.Message(hotelId, userId, userName, userPhoto, mobile, email, orderNo, msgType, itemType, itemId, msg, "0");
		this.messageService.saveMessage(msge);
		message.setMsg("10000", "发表成功！");
		
		Application application = this.getApplication(resParams.get("key").toString());
		this.log(application,request,"query","酒店互动信息提交接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/interact/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> interactList(PageBean<com.chuangbang.base.entity.user.Message> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_hotelId", resParams.get("hotelId"));
		}
		if(null!=resParams.get("orderNo")&&StringUtils.isNotBlank(resParams.get("orderNo").toString())){
			filterParams.put("EQ_orderNo", resParams.get("orderNo"));
		}
		if(null!=resParams.get("msgType")&&StringUtils.isNotBlank(resParams.get("msgType").toString())){
			filterParams.put("EQ_msgType", resParams.get("msgType"));
		}
		if(null!=resParams.get("userId")&&StringUtils.isNotBlank(resParams.get("userId").toString())){
			filterParams.put("EQ_userId", resParams.get("userId"));
		}else{
			return returnError("10003", "参数错误");
		}
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		filterParams.put("NE_itemType", "HOTELDYNAMICE");
		pageBean.setOrder("desc");
		pageBean.setSort("msgDate");
		pageBean.set_filterParams(filterParams);
		Page<com.chuangbang.base.entity.user.Message> list = messageService.getEntities(pageBean);
		pageBean.setList(list.getContent());
		pageBean.set_filterParams(null);
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","酒店互动信息查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	@RequestMapping(value ="/place/order", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> orderSave(HttpServletRequest request,HttpServletResponse response,String params) {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		
		String orderNo=resParams.get("orderNo")==null?null:resParams.get("orderNo")+"";
		Long hotelId = resParams.get("hotelId")==null?null:Long.valueOf(resParams.get("hotelId")+"");
		String hotelSaleId = resParams.get("hotelSaleId")==null?null:resParams.get("hotelSaleId")+"";
		
		Double amount = resParams.get("amount")==null?null:Double.valueOf(resParams.get("amount")+"");
		Double zgamount = resParams.get("zgamount")==null?null:Double.valueOf(resParams.get("zgamount")+"");
		Double zgdiscount = resParams.get("zgdiscount")==null?null:Double.valueOf(resParams.get("zgdiscount")+"");
		Double prepaid = resParams.get("prepaid")==null?null:Double.valueOf(resParams.get("prepaid")+"");
		Double finalPayment=resParams.get("finalPayment")==null?null:Double.valueOf(resParams.get("finalPayment")+"");
		Double siteAmount=resParams.get("siteAmount")==null?null:Double.valueOf(resParams.get("siteAmount")+"");
		Double siteCommissionFee=resParams.get("siteCommissionFee")==null?null:Double.valueOf(resParams.get("siteCommissionFee")+"");
		Double roomAmount=resParams.get("roomAmount")==null?null:Double.valueOf(resParams.get("roomAmount")+"");
		Double diningAmount=resParams.get("diningAmount")==null?null:Double.valueOf(resParams.get("diningAmount")+"");
		Double otherAmount=resParams.get("otherAmount")==null?null:Double.valueOf(resParams.get("otherAmount")+"");
		
		String clientId = resParams.get("clientId")==null?null:resParams.get("clientId")+"";
		String activityDate = resParams.get("activityDate")==null?null:resParams.get("activityDate")+"";
		String activityTitle = resParams.get("activityTitle")==null?null:resParams.get("activityTitle")+"";
		//String activityType = resParams.get("activityType")==null?null:resParams.get("activityType")+"";
		String organizer = resParams.get("organizer")==null?null:resParams.get("organizer")+"";
		String linkman = resParams.get("linkman")==null?null:resParams.get("linkman")+"";
		String contactNumber = resParams.get("contactNumber")==null?null:resParams.get("contactNumber")+"";
		String email = resParams.get("email")==null?null:resParams.get("email")+"";
		String state= resParams.get("state")==null?null:resParams.get("state")+"";
		String settlementStatus= resParams.get("settlementStatus")==null?null:resParams.get("settlementStatus")+"";
		
		String memo = resParams.get("settlementStatus")==null?null:resParams.get("settlementStatus")+"";
		String meetingRemark = resParams.get("meetingRemark")==null?null:resParams.get("meetingRemark")+"";
		String houseRemark = resParams.get("houseRemark")==null?null:resParams.get("houseRemark")+"";
		String dinnerRemark = resParams.get("dinnerRemark")==null?null:resParams.get("dinnerRemark")+"";
		String notifyUrl =  resParams.get("notifyUrl")==null?null:resParams.get("notifyUrl")+"";
		String sites = resParams.get("sites")==null?null:resParams.get("sites")+"";
		String rooms = resParams.get("rooms")==null?null:resParams.get("rooms")+"";
		String meals = resParams.get("meals")==null?null:resParams.get("meals")+"";
		String others = resParams.get("others")==null?null:resParams.get("others")+"";
		
		if(StringUtils.isBlank(orderNo)){
			return returnError("10003", "参数错误1");
		}
		if(hotelId==null){
			return returnError("10003", "参数错误2");
		}
		
		if(hotelSaleId==null){
			return returnError("10003", "参数错误3");
		}
		
		if(null==amount){
			return returnError("10003", "参数错误4");
		}
		if(null==zgamount){
			return returnError("10003", "参数错误5");
		}
		if(null==zgdiscount){
			return returnError("10003", "参数错误6");
		}
		if(null==prepaid){
			return returnError("10003", "参数错误7");
		}
		if(null==finalPayment){
			return returnError("10003", "参数错误8");
		}
		if(null==siteAmount){
			return returnError("10003", "参数错误9");
		}
		if(null==siteCommissionFee){
			return returnError("10003", "参数错误10");
		}
		if(null==roomAmount){
			return returnError("10003", "参数错误11");
		}
		if(null==diningAmount){
			return returnError("10003", "参数错误12");
		}
		
		if(StringUtils.isBlank(clientId)){
			return returnError("10003", "参数错误13");
		}
		if(StringUtils.isBlank(contactNumber)){
			return returnError("10003", "参数错误14");
		}
		if(StringUtils.isBlank(linkman)){
			return returnError("10003", "参数错误15");
		}
		if(StringUtils.isBlank(activityTitle)){
			return returnError("10003", "参数错误16");
		}
		if(StringUtils.isBlank(organizer)){
			return returnError("10003", "参数错误17");
		}
		if(StringUtils.isBlank(email)){
			return returnError("10003", "参数错误19");
		}
		
		if(StringUtils.isBlank(sites)&&StringUtils.isBlank(rooms)&&StringUtils.isBlank(meals)){
			return returnError("10003", "参数错误18");
		}
		
		Application application = this.getApplication(resParams.get("key").toString());
		HotelModel hotelModel = this.hotelService.getHotel(hotelId);
		Hotel hotel = this.hotelService.getEntity(hotelId);
		HotelCooperationInfo  hotelCooperationInfo = this.hotelCooperationInfoService.findByHotelId(hotelId);
		SalerModel hotelSale = null;
		if(StringUtils.isNotBlank(hotelSaleId)){
			hotelSale = this.userService.getSaler(hotelSaleId);
		}else{
			hotelSale = this.userService.getRamdomSale(hotelId);
		}
		
		String orderType="ONLINE";
		String commissionStatus="00";
		
		User companySale = this.userService.getEntity(hotel.getReclaimUserId());
		Order order = new Order(orderNo, orderType, application.getId(), application.getAppName(), hotelModel.getCityText(), hotelId, hotel.getHotelName(), hotelModel.getpName(), hotelCooperationInfo.getCommissionRights()
				, hotelSale.getId(), hotelSale.getRname(), hotelSale.getMobile(), 0.0D, amount, zgamount, prepaid, finalPayment, siteAmount, siteCommissionFee, roomAmount
				, diningAmount,otherAmount, clientId, activityDate, activityTitle, organizer, linkman, contactNumber, state, commissionStatus, new Date(), "");
		order.setEmail(email);
		order.setSettlementStatus(settlementStatus);
		order.setZgdiscount(zgdiscount);
		order.setCompanySaleId(companySale.getId());
		order.setCompanySaleName(companySale.getRname());
		order.setCompanySaleMobile(companySale.getMobile());
		order.setOfflineState("1");
		order.setNotifyUrl(notifyUrl);
		order.setMemo(memo);
		order.setMeetingRemark(meetingRemark);
		order.setHouseRemark(houseRemark);
		order.setDinnerRemark(dinnerRemark);
		
		Json json = orderService.saveOrder(order,sites,rooms,meals,others);
		if(json.isSuccess()){
			message.setMsg("10000", "提交成功！");
			String title = "订单通知";
			String ptext = "你收到新的订单【"+order.getOrderNo()+"】，请及时处理！";//【会掌柜】
			chatRecordService.send("SYSTEM", "SYSTEM", order.getHotelSaleId(), order.getHotelSaleName(), "SYSTEMMSG", title, ptext, order.getHotelId(), order.getHotelName(), "ORDER", order.getOrderNo(), "");
			try{
				CallUtil.sendmsg(ptext, hotelSale.getMobile());
				List<User> users = this.userService.findByHotelIdAndGroupId(hotelId, 20L);
				for (User user : users) {
					CallUtil.sendmsg(ptext, user.getMobile());
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}else{
			message.setMsg(json.getError(), json.getMsg());
		}
		this.log(application,request,"query","酒店订单提交接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/saler/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> salerList(PageBean<SalerModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())){
			filterParams.put("EQ_u.hotel_id", resParams.get("hotelId"));
		}else{
			return returnError("10003", "参数错误");
		}
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}

		pageBean.setOrder("desc");
		pageBean.setSort("u.create_date");
		pageBean.set_filterParams(filterParams);
		List<SalerModel> list = userService.getSalerPageList(pageBean);
		pageBean.setList(list);
		pageBean.set_filterParams(null);

		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","酒店销售查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/order/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> orderList(PageBean<OrderModel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("userId")&&StringUtils.isNotBlank(resParams.get("userId").toString())){
			filterParams.put("EQ_o.client_id", resParams.get("userId"));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}

		pageBean.setOrder("desc");
		pageBean.setSort("o.create_date");
		pageBean.set_filterParams(filterParams);
		List<OrderModel> list = orderService.getOrderPageList(pageBean);
		for (OrderModel orderModel : list) {
			orderModel.setSites(this.orderDetailService.getAllHallOrderDetail(orderModel.getOrderNo()));
			orderModel.setRooms(this.orderDetailService.getAllRoomOrderDetailModel(orderModel.getOrderNo()));
			orderModel.setMeals(this.orderDetailService.getAllMealOrderDetailModel(orderModel.getOrderNo()));
		}
		pageBean.setList(list);
		pageBean.set_filterParams(null);
		Application application = this.getApplication(resParams.get("key").toString());

		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","会员查询的订单列表查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/order/detail", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> orderDetail(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		String orderNo=resParams.get("orderNo")==null?"":resParams.get("orderNo")+"";
		String clientId = resParams.get("clientId")==null?"":resParams.get("clientId")+"";
		if(StringUtils.isNotBlank(clientId)){
			filterParams.put("EQ_o.client_id", resParams.get("userId"));
		}else{
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isNotBlank(orderNo)){
			filterParams.put("EQ_o.order_no", resParams.get("orderNo"));
		}else{
			return returnError("10003", "参数错误");
		}
		OrderModel orderModel = this.orderService.getOrder(orderNo, clientId);
		orderModel.setSites(this.orderDetailService.getAllHallOrderDetail(orderModel.getOrderNo()));
		orderModel.setRooms(this.orderDetailService.getAllRoomOrderDetailModel(orderModel.getOrderNo()));
		orderModel.setMeals(this.orderDetailService.getAllMealOrderDetailModel(orderModel.getOrderNo()));
		
		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(orderModel);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","会员查询的订单列表查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	@RequestMapping(value ="/order/state", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> changeOrderState(HttpServletRequest request,HttpServletResponse response,String params) {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		String orderNo = null!=resParams.get("orderNo")&&StringUtils.isNotBlank(resParams.get("orderNo").toString())?resParams.get("orderNo")+"":"";
		String action = null!=resParams.get("action")&&StringUtils.isNotBlank(resParams.get("action").toString())?resParams.get("action")+"":"";
		String reason = null!=resParams.get("reason")&&StringUtils.isNotBlank(resParams.get("reason").toString())?resParams.get("reason")+"":"";
		String memo = null!=resParams.get("memo")&&StringUtils.isNotBlank(resParams.get("memo").toString())?resParams.get("memo")+"":"";
		String day = null!=resParams.get("day")&&StringUtils.isNotBlank(resParams.get("day").toString())?resParams.get("day")+"":"";
		String clientId = null!=resParams.get("clientId")&&StringUtils.isNotBlank(resParams.get("clientId").toString())?resParams.get("clientId")+"":"";
		Double prepaid = null!=resParams.get("prepaid")&&StringUtils.isNotBlank(resParams.get("prepaid").toString())?Double.valueOf(resParams.get("prepaid")+""):null;
		String key = null!=resParams.get("key")&&StringUtils.isNotBlank(resParams.get("key").toString())?resParams.get("day")+"":"";
		if(StringUtils.isBlank(orderNo)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(action)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(key)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(clientId)){
			return returnError("10003", "参数错误");
		}
		if("PAY".equals(action)&&prepaid==null){
			return returnError("10003", "参数错误");
		}
		Application application = this.getApplication(key);
		try{
			Json json = this.orderService.changeOrderStateForApi(application.getId(),orderNo,clientId,action,day,reason,memo,prepaid);
			if(json.isSuccess()){
				message.setMsg("10000", "操作成功");
			}else{
				message.setMsg(json.getError(), json.getMsg());
			}
		}catch(Exception e){
			e.printStackTrace();
			message.setMsg("10009","系统错误");
		}
		
		this.log(application,request,"query","会员订单状态修改接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	/**
	 * 订单评价提交
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 */
	@RequestMapping(value ="/order/evaluate", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> orderEvaluate(HttpServletRequest request,HttpServletResponse response,String params) {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		String orderNo = null!=resParams.get("orderNo")&&StringUtils.isNotBlank(resParams.get("orderNo").toString())?resParams.get("orderNo")+"":"";
		String evaluateType = null!=resParams.get("evaluateType")&&StringUtils.isNotBlank(resParams.get("evaluateType").toString())?resParams.get("evaluateType")+"":"";
		Long hotelId = null!=resParams.get("hotelId")&&StringUtils.isNotBlank(resParams.get("hotelId").toString())?Long.valueOf(resParams.get("hotelId")+""):null;
		String hotelName = null!=resParams.get("hotelName")&&StringUtils.isNotBlank(resParams.get("hotelName").toString())?resParams.get("hotelName")+"":"";
		
		String itemType = null!=resParams.get("itemType")&&StringUtils.isNotBlank(resParams.get("itemType").toString())?resParams.get("itemType")+"":"";
		Long itemId = null!=resParams.get("itemId")&&StringUtils.isNotBlank(resParams.get("itemId").toString())?Long.valueOf(resParams.get("itemId")+""):null;
		String itemName = null!=resParams.get("itemName")&&StringUtils.isNotBlank(resParams.get("itemName").toString())?resParams.get("itemName")+"":"";
		
		Integer goodsEvaluation = null!=resParams.get("goodsEvaluation")&&StringUtils.isNotBlank(resParams.get("goodsEvaluation").toString())?Integer.valueOf(resParams.get("goodsEvaluation")+""):null;
		Integer attitude = null!=resParams.get("attitude")&&StringUtils.isNotBlank(resParams.get("attitude").toString())?Integer.valueOf(resParams.get("attitude")+""):null;
		Integer responseSpeed = null!=resParams.get("responseSpeed")&&StringUtils.isNotBlank(resParams.get("responseSpeed").toString())?Integer.valueOf(resParams.get("responseSpeed")+""):null;
		
		Integer facilities = null!=resParams.get("facilities")&&StringUtils.isNotBlank(resParams.get("facilities").toString())?Integer.valueOf(resParams.get("facilities")+""):null;
		Integer hygiene = null!=resParams.get("hygiene")&&StringUtils.isNotBlank(resParams.get("hygiene").toString())?Integer.valueOf(resParams.get("hygiene")+""):null;
		Integer service = null!=resParams.get("service")&&StringUtils.isNotBlank(resParams.get("service").toString())?Integer.valueOf(resParams.get("service")+""):null;
		Integer location = null!=resParams.get("location")&&StringUtils.isNotBlank(resParams.get("location").toString())?Integer.valueOf(resParams.get("location")+""):null;
		
		Integer comprehensive = null!=resParams.get("comprehensive")&&StringUtils.isNotBlank(resParams.get("comprehensive").toString())?Integer.valueOf(resParams.get("comprehensive")+""):null;
		
		
		String tag = null!=resParams.get("tag")&&StringUtils.isNotBlank(resParams.get("tag").toString())?resParams.get("tag")+"":"";
		String econtent = null!=resParams.get("econtent")&&StringUtils.isNotBlank(resParams.get("econtent").toString())?resParams.get("econtent")+"":"";
		
		String saleId = null!=resParams.get("saleId")&&StringUtils.isNotBlank(resParams.get("saleId").toString())?resParams.get("saleId")+"":"";
		String saleName = null!=resParams.get("saleName")&&StringUtils.isNotBlank(resParams.get("saleName").toString())?resParams.get("saleName")+"":"";
		
		String userId = null!=resParams.get("userId")&&StringUtils.isNotBlank(resParams.get("userId").toString())?resParams.get("userId")+"":"";
		String userName = null!=resParams.get("userName")&&StringUtils.isNotBlank(resParams.get("userName").toString())?resParams.get("userName")+"":"";
		String isanonymous = null!=resParams.get("isanonymous")&&StringUtils.isNotBlank(resParams.get("isanonymous").toString())?resParams.get("isanonymous")+"":"";
		
		if(hotelId==null){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(hotelName)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(evaluateType)){
			return returnError("10003", "参数错误");
		}
		if("SITE".equals(evaluateType)){
			if(StringUtils.isBlank(itemType)){
				return returnError("10003", "参数错误");
			}
			if(itemId==null){
				return returnError("10003", "参数错误");
			}
			if(StringUtils.isBlank(itemName)){
				return returnError("10003", "参数错误");
			}
			
			if(goodsEvaluation==null){
				return returnError("10003", "参数错误");
			}
			if(attitude==null){
				return returnError("10003", "参数错误");
			}
			if(responseSpeed==null){
				return returnError("10003", "参数错误");
			}
			
		}else if("SALE".equals(evaluateType)){
			if(StringUtils.isBlank(saleId)){
				return returnError("10003", "参数错误");
			}
			if(StringUtils.isBlank(saleName)){
				return returnError("10003", "参数错误");
			}
		}
		
		if(comprehensive==null){
			return returnError("10003", "参数错误");
		}
		
		if(StringUtils.isBlank(tag)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(econtent)){
			return returnError("10003", "参数错误");
		}
		
		if(StringUtils.isBlank(orderNo)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(userId)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(userName)){
			return returnError("10003", "参数错误");
		}
		if(StringUtils.isBlank(isanonymous)||(!"1".equals(isanonymous)&&!"0".equals(isanonymous))){
			return returnError("10003", "参数错误");
		}
		
		HotelModel hotel = this.hotelService.getHotel(hotelId);
		Application application = this.getApplication(resParams.get("key").toString());
		Evaluate evaluate = new Evaluate(evaluateType, "1", orderNo, hotel.getCityText(), hotel.getHotelStarText(), hotelId, hotelName, itemType, itemId+"", itemName
				, goodsEvaluation, attitude, responseSpeed, facilities, hygiene, service, location, comprehensive, 0, 0, 0, tag, econtent, "CILENT", userId, userName
				, isanonymous, new Date(), new Date(), "");
		evaluate.setArea(hotel.getDistrictText());
		try{
			Json json = this.orderService.orderEvaluate(orderNo,evaluate,application.getId());
			if(json.isSuccess()){
				message.setMsg("10000","提交成功");
			}else{
				message.setMsg(json.getError(), json.getMsg());
			}
		}catch(Exception e){
			message.setMsg("10009","系统错误");
		}
		this.log(application,request,"query","订单评价提交接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 订单进度查询
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value ="/order/schedule", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> orderSchedule(HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		String orderNo = null!=resParams.get("orderNo")&&StringUtils.isNotBlank(resParams.get("orderNo").toString())?resParams.get("orderNo")+"":"";
		
		if(StringUtils.isBlank(orderNo)){
			return returnError("10003", "参数错误");
		}
		Application application = this.getApplication(resParams.get("key").toString());
		Order order = this.orderService.findByOrderNo(orderNo,application.getId());
		Map<String, Object> res = Maps.newHashMap();
		this.orderService.getStateTxt(order,res);
		
		String str = JSONObject.toJSONString(res);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		this.log(application,request,"query","会员查询的订单进度查询接口");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 推荐酒店查询
	 * @param pageBean
	 * @param request
	 * @param response
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/recommended/hotel/list", method = RequestMethod.POST)//,method=RequestMethod.GET
	@ResponseBody
	public ResponseEntity<Message> recommendedHotels(PageBean<RecommendedHotel> pageBean,HttpServletRequest request,HttpServletResponse response,String params) throws Exception {
		Map<String, Object> resParams = this.getSearchFilterParams(params);
		Map<String, Object> filterParams = Maps.newHashMap();
		if(null!=resParams.get("city")&&StringUtils.isNotBlank(resParams.get("city").toString())){
			filterParams.put("EQ_h.city", resParams.get("city"));
		}
		/*else{
			return returnError("10003", "参数错误");
		}*/
		
		if(null!=resParams.get("page")&&StringUtils.isNotBlank(resParams.get("page").toString())){
			pageBean.setPage(Integer.valueOf(resParams.get("page").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		
		if(null!=resParams.get("rows")&&StringUtils.isNotBlank(resParams.get("rows").toString())){
			pageBean.setRows(Integer.valueOf(resParams.get("rows").toString()));
		}else{
			return returnError("10003", "参数错误");
		}
		filterParams.put("EQ_h.is_tui", "1");
		pageBean.setOrder("desc,desc");
		pageBean.setSort("h.verify,h.isbest");
		pageBean.set_filterParams(filterParams);
		List<RecommendedHotel> list = hotelService.getPageRecommendedHotel(pageBean);
		pageBean.setList(list);
		pageBean.set_filterParams(null);
		pageBean.setSort("");
		pageBean.setOrder("");
		Application application = this.getApplication(resParams.get("key").toString());
		
		String str = JSONObject.toJSONString(pageBean);
		System.out.println(str);
		String result = AESUtil.NoPaddingEncrypt(str, application.getAppKey());
		message.setMsg("10000", "查询成功", result);
		
		this.log(application,request,"query","推荐酒店查询");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	
	private String splitStr(String filed,String value){
		if(StringUtils.isNotBlank(filed)){
			return filed += ","+value;
		}else{
			return value;
		}
	}
	
	/**
	 * 返回错误结果
	 * @param errorCode
	 * @param errorMsg
	 * @return
	 */
	private ResponseEntity<Message> returnError(String errorCode,String errorMsg){
		message.setMsg(errorCode,errorMsg);
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	/**
	 * 记录接口请求日志
	 * @param application
	 * @param request
	 * @param actionType
	 * @param operateType
	 */
	private void log(Application application, HttpServletRequest request,String actionType,String operateType) {
		String url = request.getRequestURL().toString();
		String host = request.getRemoteHost();
		System.out.println("url>>>"+url);
		Api api = this.apiService.findByUrl(url);
		String apiid = api==null?"":api.getId()+"";
		Log log = new Log("SAASAPI", actionType, application.getId()+"", application.getAppName(), operateType, apiid, url.substring(url.indexOf("/hui")), new Date(), host);
		this.logService.saveLog(log);
	}
	/**
	 * 获取应用
	 * @param key
	 * @return
	 */
	private Application getApplication(String key) {
		return this.applicationService.findByAppId(key);
	}
	/**
	 * 获取参数
	 * @param params
	 * @return
	 */
	private Map<String, Object> getSearchFilterParams(String params){
		String deparams = URLDecoder.decode(params);
		JSONObject object = JSONObject.parseObject(deparams);
		Iterator it = object.keySet().iterator();
		Map<String, Object> paramsMap = new TreeMap<String, Object>();
		while(it.hasNext()){  
			 String key = it.next().toString();
			 if(!key.equals("sign")){
				if(StringUtils.isNotBlank(object.get(key).toString())){
					System.out.println(">params>>>>>"+object.get(key));
					paramsMap.put(key, object.get(key));
				}
			 }
	    }
		return paramsMap;
	}
}
