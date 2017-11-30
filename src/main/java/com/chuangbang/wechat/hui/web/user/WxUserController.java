package com.chuangbang.wechat.hui.web.user;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;
import org.springside.modules.mapper.JsonMapper;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.entity.order.Evaluate;
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.base.service.order.EvaluateService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.constant.Constant;
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
import com.chuangbang.js.entity.account.Department;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.DepartmentService;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.wechat.hui.model.HotelUserModel;
import com.chuangbang.wechat.hui.model.UserEvaluateModel;
import com.chuangbang.wechat.hui.service.user.WxUserService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value = "/weixin/user")
public class WxUserController extends BaseController{

	private static JsonMapper mapper = JsonMapper.nonDefaultMapper();
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private WxUserService wxUserService;
	
	@Autowired
	private CusQueryService cusQueryService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private EvaluateService evaluateService;
	
	@Autowired
	private UserPermissionService userPermissionService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private RegionService regionService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private HotelGroupService hotelGroupService;
	
	@ModelAttribute("user")
	public User getUser(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return userService.getEntity(id);
		}
		return new User();
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model,String memberType){
		this.groupSetting(model);
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				return "weixin/user/userIndex";
			}else{
				return "redirect:/weixin/user/hoteldetail?hotelId="+AccountUtils.getCurrentUserHotelId();
			}
		}else{
			Map<String, Object> filterParams = Maps.newHashMap();
			filterParams.put("EQ_districtCode", 0);
			List<Department> departments = this.departmentService.getEntities(filterParams, new Sort(Direction.ASC, "id"));
			model.addAttribute("departments", departments);
			return "weixin/user/staffIndex";
		}
	}
	
	@RequestMapping(value ="staff/list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Model model,PageBean<User> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_userType", "HUI");
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_companyId",AccountUtils.getCurrentUser().getCompanyId());
		}
		
		//searchParams.put("NE_id", AccountUtils.getCurrentUserId());
		pageBean.set_filterParams(searchParams);
		Page<User> p = userService.getEntities(pageBean);
		for (User user : p.getContent()) {
			if(user.getGroupId() != null){
				user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
			}
			user.setUserPermissions(this.userPermissionService.findByUserId(user.getId(), "1"));
		}
		return getDataGrid(pageBean,p.getContent());
	}
	
	@RequestMapping("/staff/detail/{id}")
	public String staffDetail(HttpServletRequest request,Model model,@PathVariable("id")String id,String TYPE){
		this.groupSetting(model);
		User user = userService.getEntity(id);
		String sql = "select id,avg(comprehensive) comprehensive from hui_evaluate h where h.sale_id = ? ";
		List<Object> paras = Lists.newArrayList();
		paras.add(id);
		UserEvaluateModel uerEvaluateModel = cusQueryService.getOne(sql, UserEvaluateModel.class, paras);
		if(user != null && user.getGroupId() != null){
			user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
		}
		System.out.println(user+">>>>>>>>>");
		if(StringUtils.isNotBlank(user.getUserType())&&"PARTNER".equals(user.getUserType())){
			Company company = this.companyService.getEntity(user.getCompanyId());
			Region region = this.regionService.getEntity(Long.valueOf(company.getCity()+""));
			User partner = this.userService.getEntity(company.getAuthUserId());
			if(user.getId().equals(company.getAuthUserId())){
				List<User> users = this.userService.findByCompanyId(company.getId());
				model.addAttribute("users", users);
			}
			model.addAttribute("ispartner", true);
			model.addAttribute("company", company);
			model.addAttribute("region", region);
			model.addAttribute("partner", partner);
		}else{
			model.addAttribute("ispartner", false);
		}
		
		
		
		model.addAttribute("comprehensive", uerEvaluateModel.getComprehensive());
		model.addAttribute("user", user);
		
		model.addAttribute("TYPE", TYPE);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/staffDetail";
		}else{
			return "user/staffDetail";
		}
		
	}
	
	@RequestMapping("/staff/pms/update/{id}")
	public String pmsUpdate(HttpServletRequest request,Model model,@PathVariable("id")String id){
		this.groupSetting(model);
		User user = userService.getEntity(id);
		String sql = "select id,avg(comprehensive) comprehensive from hui_evaluate h where h.sale_id = ? ";
		List<Object> paras = Lists.newArrayList();
		paras.add(id);
		UserEvaluateModel uerEvaluateModel = cusQueryService.getOne(sql, UserEvaluateModel.class, paras);
		
		if(user != null && user.getGroupId() != null){
			user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
		}
		model.addAttribute("comprehensive", uerEvaluateModel.getComprehensive());
		model.addAttribute("user", user);
		return "weixin/user/staffPmsUpdate";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public JsonVo list(PageBean<HotelUserModel> pageBean,HttpServletRequest request,Model model,String groupId){
		Map<String, Object> filterParams = this.getSearchParams(request);
		String sql = "select id,hotelName from hui_hotel h where 1=1";
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				sql+=" and h.pid="+AccountUtils.getCurrentUser().getPhtlid();
			}else{
				sql+=" and h.id="+AccountUtils.getCurrentUserHotelId();
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			sql+=" and h.company_id="+AccountUtils.getCurrentUser().getCompanyId();
		}
		pageBean.set_filterParams(filterParams);
		List<Object> paras = Lists.newArrayList();
		List<HotelUserModel> hotelUserModels = cusQueryService.page(pageBean, sql, HotelUserModel.class, paras);
		PageBean userEvPageBean = new PageBean();
		userEvPageBean.setRows(4);
		List<Object> userEvParas = Lists.newArrayList();
		for(HotelUserModel h : hotelUserModels){
			userEvParas.clear();
			String columstr = "u.id id,u.rname rname,u.position position,u.star star,(select avg(comprehensive) from hui_evaluate h where h.sale_id = u.id) comprehensive";
			String fromWhere = "from hui_user u where hotel_id = ?";
			if(StringUtils.isNotBlank(groupId)){
				fromWhere+=" and u.state='"+groupId+"'";
			}
			userEvParas.add(h.getId());
			h.setUserEvaluateModels(cusQueryService.page(userEvPageBean, columstr,fromWhere, UserEvaluateModel.class, userEvParas));
		}
		
		//Page<User> page = wxUserService.page(pageBean, request, model);
		return JsonUtils.success("ok",getDataGrid(hotelUserModels));
	}
	
	@RequestMapping("/hoteldetail")
	public String hoteldetail(HttpServletRequest request,Model model,Long hotelId){
		this.groupSetting(model);
		Hotel hotel = hotelService.getEntity(hotelId);
		model.addAttribute("hotel", hotel);
		return "weixin/user/userHotelDetail";
	}
	
	@RequestMapping("/hoteldetail/list")
	@ResponseBody
	public JsonVo hoteldetailList(PageBean pageBean,HttpServletRequest request,Model model,Long hotelId){
		List<Object> paras = Lists.newArrayList();
		String columstr = "u.id id,u.rname rname,u.position position,(select avg(comprehensive) from hui_evaluate h where h.sale_id = u.id) comprehensive";
		String fromWhere = "from hui_user u where hotel_id = ?";
		paras.add(hotelId);
		pageBean.setOrder("desc,desc,desc");
		pageBean.setSort("group_id,state,id");
		List<UserEvaluateModel> userEvaluateModels = cusQueryService.page(pageBean, columstr,fromWhere, UserEvaluateModel.class, paras);
		//Page<User> page = wxUserService.page(pageBean, request, model);
		return JsonUtils.success("ok",getDataGrid(pageBean,userEvaluateModels));
	}
	
	@RequestMapping("/moredetail")
	public String moredetail(HttpServletRequest request,Model model,Long hotelId,String userId,String TYPE,String from,String furl){
		this.groupSetting(model);
		User user = userService.getEntity(userId);
		if(user != null && user.getGroupId() != null){
			user.setGroup(groupService.getEntity(user.getGroupId()));
			user.setGroupName(user.getGroup().getName());
		}
		if(!"HOTEL".equals(user.getUserType())){
			return "redirect:/weixin/user/staff/detail/"+userId;
		}
	
		if(user.getGroup().getGroupId().startsWith("hotel") && StringUtils.isNotBlank(user.getHotelId())){
			Hotel hotel = hotelService.getEntity(Long.valueOf(user.getHotelId()));
			model.addAttribute("hotel", hotel);
			model.addAttribute("utype", "HOTEL");
		}else if(user.getGroup().getGroupId().startsWith("group") && null!=user.getPhtlid()){
			HotelGroup hotelGroup = hotelGroupService.getEntity(user.getPhtlid());
			model.addAttribute("hotelGroup", hotelGroup);
			model.addAttribute("utype", "GROUP");
		}
		
		
//		else if(user.getGroup().getGroupId().startsWith("customer") && null!=user.getPhtlid()){
//			HotelGroup hotelGroup = hotelGroupService.getEntity(user.getPhtlid());
//			model.addAttribute("hotelGroup", hotelGroup);
//			model.addAttribute("utype", "GROUP");
//		}else if(user.getGroup().getGroupId().startsWith("customer") && StringUtils.isNotBlank(user.getHotelId())){
//			Hotel hotel = hotelService.getEntity(Long.valueOf(user.getHotelId()));
//			model.addAttribute("hotel", hotel);
//			model.addAttribute("utype", "HOTEL");
//		}
		
		String sql = "select id,avg(comprehensive) comprehensive from hui_evaluate h where h.sale_id = ? ";
		List<Object> paras = Lists.newArrayList();
		paras.add(userId);
		UserEvaluateModel uerEvaluateModel = cusQueryService.getOne(sql, UserEvaluateModel.class, paras);
		
		
		
		model.addAttribute("comprehensive", uerEvaluateModel.getComprehensive());
		/**/
		model.addAttribute("user", user);
		
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/userMoreDetail";
		}else{
			if(StringUtils.isBlank(from)){
				from = "loadContent";
			}
			model.addAttribute("from", from);
			model.addAttribute("TYPE", TYPE);
			model.addAttribute("furl", furl);
			return "user/hoteluserDetail";
		}
		
	}
	
	@RequestMapping("/evaluate/list")
	@ResponseBody
	public JsonVo evaluatelist(PageBean pageBean,HttpServletRequest request,Model model,Long hotelId,String userId){
		Map<String, Object> searchparas = this.getSearchParams(request);
		pageBean.set_filterParams(searchparas);
		Page<Evaluate> page = evaluateService.getEntities(pageBean);
		return JsonUtils.success("ok",getDataGrid(page.getContent()));
	}
	
	@RequestMapping("pms/update")
	public String pmsUpdate(HttpServletRequest request,Model model,Long hotelId,String userId,String TYPE){
		this.groupSetting(model);
		User user = userService.getEntity(userId);
		if(StringUtils.isNotBlank(user.getHotelId())){
			Hotel hotel = hotelService.getEntity(Long.valueOf(user.getHotelId()));
			model.addAttribute("hotel", hotel);
			model.addAttribute("utype", "HOTEL");
		}
		if(null!=user.getPhtlid()){
			HotelGroup hotelGroup = hotelGroupService.getEntity(user.getPhtlid());
			model.addAttribute("hotelGroup", hotelGroup);
			model.addAttribute("utype", "GROUP");
		}
		//Hotel hotel = hotelService.getEntity(hotelId);
		//model.addAttribute("hotel", hotel);
		String sql = "select id,avg(comprehensive) comprehensive from hui_evaluate h where h.sale_id = ? ";
		List<Object> paras = Lists.newArrayList();
		paras.add(userId);
		UserEvaluateModel uerEvaluateModel = cusQueryService.getOne(sql, UserEvaluateModel.class, paras);
		
		if(user != null && user.getGroupId() != null){
			user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
		}
		model.addAttribute("comprehensive", uerEvaluateModel.getComprehensive());
		
		model.addAttribute("user", user);
		
		if(BrowseTool.isWeixin(request.getHeader("User-agent"))){
			return "weixin/user/userPmsUpdate";
		}else{
			model.addAttribute("TYPE", TYPE);
			return "user/hoteluserUpdate";
		}
	}
	
	@RequestMapping("/update/{userid}")
	public String update(HttpServletRequest request,Model model,@PathVariable("userid")String userid){
		System.out.println("userid>>>"+userid);
		this.groupSetting(model);
		User user = userService.getEntity(userid);
		if(user != null && user.getGroupId() != null){
			user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
		}
		model.addAttribute("user", user);
		return "weixin/user/userUpdateIndex";
	}
	
	@RequestMapping("/savePermission")
	@ResponseBody
	public JsonVo savePermission(String user_id,String permission_ids){
		userPermissionService.updatePermission(user_id, permission_ids);
		return JsonUtils.success("ok");
	}
	
	@RequestMapping("/pwd/reset/{userid}")
	public String resetpwd(HttpServletRequest request,Model model,@PathVariable("userid")String userid){
		this.groupSetting(model);
		model.addAttribute("userid",userid);
		return "weixin/anon/resetpwd";
	}
	
	@RequestMapping("/pwd/save")
	@ResponseBody
	public JsonVo saveresetpwd(HttpServletRequest request,Model model,String userid,String password,String mobile,String captcha){
		if(StringUtils.isBlank(userid)){
			HttpSession session = request.getSession();
			String code = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+mobile)?"":session.getAttribute("MO_DRAW_KEY_CAPTCHA_"+mobile).toString();
			long cpthtime = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile)?0:(long)session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile);
			if(cpthtime==0){
				return JsonUtils.error("验证码已失效，请重新获取！");
			}else{
				long nowd = new Date().getTime();
				long res = nowd - cpthtime;
				if(res>600000){
					return JsonUtils.error("验证码已失效，请重新获取！");
				}
			}
			if(!code.equals(captcha)){
				return JsonUtils.error("验证码错误！");
			}
			return wxUserService.saveresetpwd(mobile,password );
		}else{
			return wxUserService.saveresetpwd(userid, mobile, password);
		}
		
	}
	
	@RequestMapping("/batch/upload/index")
	public String uploadindex(HttpServletRequest request,Model model,String crtusrty){
		this.groupSetting(model);
		model.addAttribute("crtusrty", crtusrty);
		if(BrowseTool.isWeixin(request.getHeader("User-agent"))){
			return "weixin/user/batchUserImport";
		}else{
			return "account/batchUserImport";
		}
	}
	
	@RequestMapping("/upload")
	@ResponseBody
	public JsonVo upload(HttpServletRequest request,Model model,String crtusrty,String hotelId,String userType){
		
		if(StringUtils.isNotBlank(crtusrty)&&"SITE".equals(crtusrty)){
			
		}else{
			userType = AccountUtils.getCurrentUserType();
			Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
			if(hotel!=null){
				hotelId = hotel.getId()+"";
			}	
		}
		
		Long groupId = 13l;
		
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
        List<Map<String,Object>> res = ExcelUtils.readExcelFile(realPath);  
        Json json = userService.batchSave(res,groupId,userType,hotelId);
        FileUtils.delFile(realPath);
        if(json.isSuccess()){
        	return JsonUtils.success(json.getMsg());
        }else{
        	return JsonUtils.error(json.getMsg());
        }
	}
	
	
	@RequestMapping("/author/manage/index")
	public String authorManageIndex(HttpServletRequest request,Model model){
		this.groupSetting(model);
		return "weixin/user/authorManageIndex";
	}
	
	@RequestMapping("/author/tmp")
	public String authorManageTmp(HttpServletRequest request,Model model,String userId){
		this.groupSetting(model);
		User user = null;
		if(StringUtils.isNotBlank(userId)){
			user = this.userService.getEntity(userId);
			model.addAttribute("tuser", user);
		}
		/*Group group = this.groupService.getEntity(AccountUtils.getCurrentUser().getGroupId());
		List<Permission> permissions = group.getPermissionEntityList();
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2222222222222222");
		for (Permission permission : permissions) {
			UserPermission up = new UserPermission(AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), permission.getId()+"", permission.getDisplayname()
					, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date(),permission.getPermission(),permission.getType());
			this.userPermissionService.saveUserPermission(up);
		}
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>3333333333333333");
		*/
		List<UserPermission> userPermissions = userPermissionService.findByUserId(AccountUtils.getCurrentUserId(),"1");
		model.addAttribute("userPermissions", userPermissions);
		return "weixin/user/authorManageForm";
	}
	
	
	
	@RequestMapping("/author/transfer")
	public String authorityTransfer(HttpServletRequest request,Model model,String userId,String fromuserId,Long gid,String type){
		this.groupSetting(model);
		User user = null;
		if(StringUtils.isNotBlank(userId)){
			user = this.userService.getEntity(userId);
			model.addAttribute("tuser", user);
		}
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			String rdurl="weixin/user/staff/detail/"+fromuserId;
			model.addAttribute("gtype", 11);
			model.addAttribute("rdurl", rdurl);
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(StringUtils.isNotBlank(fromuserId)){
				User fuser = this.userService.getEntity(fromuserId);
				String rdurl="weixin/user/moredetail?hotelId="+fuser.getHotelId()+"&userId="+fuser.getId();
				model.addAttribute("rdurl", rdurl);
			}
			model.addAttribute("gtype", 12);
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
				model.addAttribute("isgroup", "0");
			}
		}else if("application".equals(AccountUtils.getCurrentUserType())){
			model.addAttribute("gtype", 15);
		}else if("partner".equals(AccountUtils.getCurrentUserType())){
			model.addAttribute("gtype", 14);
		}else{
			model.addAttribute("gtype", 13);
		}
		
		//model.addAttribute("gtype", 12);
		boolean flag =false;
		if("16".equals(type)||"17".equals(type)||"19".equals(type)){
			flag = true;
		}
		if(gid!=null){
			Group group = this.groupService.getEntity(gid);
			model.addAttribute("group", group);
		}
		model.addAttribute("fromuserId", fromuserId);
		model.addAttribute("gid", gid);
		model.addAttribute("flag", flag);
		model.addAttribute("type", type);
		return "weixin/user/userAuthorityTransfer";
	}
	
	
	@RequestMapping("/author/tmp/users")
	public String tmpUsers(HttpServletRequest request,Model model){
		model.addAttribute("tmp", "tmp");
		model.addAttribute("url", "user/author/tmp");
		return "weixin/user/authorTransferUsersIndex";
	}
	

	@RequestMapping("/author/tmp/save")
	@ResponseBody
	public JsonVo tmpSave(Long id,HttpServletRequest request,String userId,String pmsids,String rname,String email,String mobile,String sdate,String edate,String captcha){
		
		HttpSession session = request.getSession();
		String code = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+mobile)?"":session.getAttribute("MO_DRAW_KEY_CAPTCHA_"+mobile).toString();
		long cpthtime = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile)?0:(long)session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile);
		if(cpthtime==0){
			return JsonUtils.error("验证码已失效，请重新获取！");
		}else{
			long nowd = new Date().getTime();
			long res = nowd - cpthtime;
			if(res>600000){
				return JsonUtils.error("验证码已失效，请重新获取！");
			}
		}
		if(!code.equals(captcha)){
			return JsonUtils.error("验证码错误！");
		}
		return this.userPermissionService.saveUserPermission(userId,pmsids,rname,email,mobile,sdate,edate);
	}
	
	
	@RequestMapping("/author/transfer/users")
	public String users(HttpServletRequest request,Model model,String fromuserId,Long gid,String type){
		this.groupSetting(model);
		model.addAttribute("fromuserId",fromuserId);
		model.addAttribute("gid",gid);
		model.addAttribute("tmp", "transfer");
		model.addAttribute("type", type);
		model.addAttribute("url", "user/author/transfer");
		return "weixin/user/authorTransferUsersIndex";
	}
	
	
	@RequestMapping("/author/tmp/list")
	@ResponseBody
	public JsonVo tmpList(PageBean<UserPermission> pageBean,HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_type", "0");
		filterParams.put("EQ_adjustUid", AccountUtils.getCurrentUserId());
		pageBean.set_filterParams(filterParams);
		Page<UserPermission> page = userPermissionService.getEntities(pageBean);
		return JsonUtils.success("ok",getDataGrid(pageBean,page.getContent()));
	}
	
	@RequestMapping("/author/tmp/takeback/{id}")
	@ResponseBody
	public JsonVo tmpList(HttpServletRequest request,@PathVariable("id") Long id){
		this.userPermissionService.delete(id);
		return JsonUtils.success("回收成功！");
	}
	
	
	@RequestMapping("/author/transfer/users/list")
	@ResponseBody
	public JsonVo usersList(PageBean pageBean,HttpServletRequest request,Model model,String type){
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("16".equals(type)){
			filterParams.put("OR_EQ;userType", AccountUtils.getCurrentUserType()+",CLIENT");
		}else if("17".equals(type)){
			filterParams.put("OR_EQ;userType", AccountUtils.getCurrentUserType()+",CLIENT");
		}else{
			filterParams.put("EQ_state", "1");
			filterParams.put("EQ_userType", AccountUtils.getCurrentUserType());
			if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
					filterParams.put("EQ_phtlid", AccountUtils.getCurrentUser().getPhtlid());
				}else{
					filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
				}
			}
		}
		List<User> page = userService.getEntities(filterParams,new Sort(Direction.ASC, "zimu"));
		
		return JsonUtils.success("ok",getDataGrid(page));
	}
	
	@RequestMapping("/quit/{id}")
	@ResponseBody
	public JsonVo quit(@PathVariable("id") String id,HttpServletRequest request){
		userService.quit(id);
		return JsonUtils.success("ok");
	}
	
	@RequestMapping("/recovery/{hotelId}/{userId}")
	@ResponseBody
	public JsonVo recovery(@PathVariable("hotelId") Long hotelId,@PathVariable("userId") String userId,HttpServletRequest request){
		try{
			userService.recovery(hotelId,userId);
		}catch(Exception e){
			return JsonUtils.error("恢复失败！");
		}
		return JsonUtils.success("恢复成功！");
	}
	@RequestMapping("/relieve/{hotelId}/{userId}")
	@ResponseBody
	public JsonVo relieve(@PathVariable("hotelId") Long hotelId,@PathVariable("userId") String userId,HttpServletRequest request){
		try{
			userService.relieve(hotelId,userId);
		}catch(Exception e){
			return JsonUtils.error("解除失败！");
		}
		return JsonUtils.success("解除成功！");
	}
	
	@RequestMapping("/author/transfer/save")
	@ResponseBody
	public JsonVo transferSave(HttpServletRequest request,Model model,String fromuserId,String userId,String email,String mobile,String captcha,Long gid,String type,String crtusrty,String transferType){
		HttpSession session = request.getSession();
		String code = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+mobile)?"":session.getAttribute("MO_DRAW_KEY_CAPTCHA_"+mobile).toString();
		long cpthtime = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile)?0:(long)session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+mobile);
		/*if(cpthtime==0){
			return JsonUtils.error("验证码已失效，请重新获取！");
		}else{
			long nowd = new Date().getTime();
			long res = nowd - cpthtime;
			if(res>600000){
				return JsonUtils.error("验证码已失效，请重新获取！");
			}
		}
		if(!code.equals(captcha)){
			return JsonUtils.error("验证码错误！");
		}*/
		if(StringUtils.isNotBlank(type)&&"HR".equals(type)){
			return wxUserService.authorHR(fromuserId,userId,email,mobile,gid );
		}else{
			return wxUserService.transferSave(fromuserId,userId,email,mobile,gid,crtusrty,transferType);
		}
	}
	
	
	@RequestMapping("/partner/effectivedate/save")
	@ResponseBody
	public JsonVo partnerEffectiveDate(HttpServletRequest request,Long companyId,Date seffectivedate,Date eeffectivedate){
		return this.companyService.updateEffectiveDate(companyId,seffectivedate,eeffectivedate);
	}
	
	
	@RequestMapping("/hr/index")
	public String hrIndex(HttpServletRequest request,Model model,String memberType){
		this.groupSetting(model);
		if("HOTEL".equals(AccountUtils.getHotelUserType())){
			model.addAttribute("url", "weixin/user/moredetail?hotelId="+AccountUtils.getCurrentUserHotelId()+"&userId=");
			model.addAttribute("type", "16");
		
		}else if("GROUP".equals(AccountUtils.getHotelUserType())){
			model.addAttribute("url", "weixin/user/moredetail?hotelId="+AccountUtils.getCurrentUserHotelId()+"&userId=");
			model.addAttribute("type", "19");
		
		}else{
			model.addAttribute("url", "weixin/user/staff/detail/");
			Map<String, Object> filterParams = Maps.newHashMap();
			filterParams.put("EQ_districtCode", 0);
			List<Department> departments = this.departmentService.getEntities(filterParams, new Sort(Direction.ASC, "id"));
			model.addAttribute("departments", departments);
			model.addAttribute("type", "17");
			
		}
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/hrIndex";
		}else{
			List<Menu> menus = this.menuService.getSysAuthRootMenus(90L);
			model.addAttribute("menus",menus);
			return "user/hruserList";
		}
	}
	
	@RequestMapping(value ="hr/list")
	@ResponseBody
	public DataGrid hrList(HttpServletRequest request,Model model,PageBean<User> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			searchParams.put("EQ_u.user_type", "HUI");
			searchParams.put("EQ_u.group_id", "17");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			searchParams.put("EQ_u.user_type", "HOTEL");
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				searchParams.put("EQ_u.group_id", "19");
				searchParams.put("EQ_u.phtlid", AccountUtils.getCurrentUser().getPhtlid());
			}else{
				searchParams.put("EQ_u.group_id", "16");
				searchParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
			}
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_u.company_id",AccountUtils.getCurrentUser().getCompanyId());
			searchParams.put("EQ_u.group_id", "17");
		}else{
			
		}
		//searchParams.put("NE_u.id", AccountUtils.getCurrentUserId());
		searchParams.put("EQ_u.state", "1");
		pageBean.set_filterParams(searchParams);
		List<User> p = userService.getPageList(pageBean);
		for (User user : p) {
			user.setUserPermissions(this.userPermissionService.findByUserId(user.getId(), "1"));
		}
		return getDataGrid(pageBean,p);
	}
}
