package com.chuangbang.base.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.mapper.JsonMapper;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.hotel.Region;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.entity.user.Company;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.hotel.RegionService;
import com.chuangbang.base.service.order.EvaluateService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.service.CusQueryService;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.DepartmentService;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.wechat.hui.model.UserEvaluateModel;
import com.google.common.collect.Lists;

import jodd.util.StringUtil;

/**
 * Urls:
 * List   page        : GET  /user/user/
 * Create page        : GET  /user/user/create
 * Create action      : POST /user/user/save
 * Update page        : GET  /user/user/update/{id}
 * Update action      : POST /user/user/save/{id}
 * Delete action      : POST /user/user/delete/{id}
 * CheckLoginName ajax: GET  /user/user/checkLoginName?oldLoginName=a&loginName=b
 * 
 * @author Heaven
 *
 */
@Controller
@RequestMapping(value = "/base/user")
public class BaseUserController extends BaseController{

	private static JsonMapper mapper = JsonMapper.nonDefaultMapper();
	
	@Autowired
	private UserService userService;
	@Autowired
	private GroupService groupService;
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
	private ChatRecordService chatRecordService;
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
	public ModelAndView index(HttpServletRequest request,Model model,String memberType){
		this.groupSetting(model);
		/*Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("ISNN_groupId", null);
		List<User> users = this.userService.getEntities(filterParams);
		for (User user : users) {
			this.userService.updatePermission(user);
		}*/
		
		List<Menu> menus = this.menuService.getSysAuthRootMenus(90L);
		model.addAttribute("menus",menus);
		return new ModelAndView("user/staffList");
	}
	
	@RequestMapping("/guser/index")
	public ModelAndView guserindex(HttpServletRequest request,Model model,Long hgId){
		this.groupSetting(model);
		HotelGroup hotelGroup = this.hotelGroupService.getEntity(hgId);
		model.addAttribute("hotelGroup",hotelGroup);
		return new ModelAndView("user/hguserList");
	}
	
	@RequestMapping("/hotel/index")
	public ModelAndView hotelUindex(HttpServletRequest request,Model model,String memberType){
		return new ModelAndView("user/hoteluserList");
	}
	
	
	/**
	 * 职员列表
	 * @param request
	 * @param model
	 * @param pageBean
	 * @param position
	 * @return
	 */
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Model model,PageBean<User> pageBean,String position) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		/*if(null!=searchParams.get("GTE_u.create_date")){
			searchParams.put("GTE_u.create_date", searchParams.get("GTE_u.create_date")+" 00:00:00.000");
		}
		if(null!=searchParams.get("LTF_u.create_date")){
			searchParams.put("LTF_u.create_date", searchParams.get("LTF_u.create_date")+" 23:59:59");
		}*/
		System.out.println(searchParams.toString());
		if(AccountUtils.getHotelUserType().equals("HOTEL")){
			searchParams.put("EQ_u.user_type", "HOTEL");
			searchParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
			//searchParams.put("OR_LLIKE;g.group_id", "hotel,customer");
			searchParams.put("LLIKE_g.group_id", "hotel");
		}else if(AccountUtils.getHotelUserType().equals("GROUP")){
			searchParams.put("EQ_u.user_type", "HOTEL");
			/*String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
			searchParams.put("OR_EQ;u.hotel_id",hotelIds);*/
			searchParams.put("LLIKE_g.group_id", "group");
			searchParams.put("EQ_u.phtlid", AccountUtils.getCurrentUserhotelPId());
			//searchParams.put("OR_LLIKE;g.group_id", "group,customer");
		}else if(AccountUtils.getCurrentUserType().equals("HUI")){
			//searchParams.put("NE_id", AccountUtils.getCurrentUserId());
			if(searchParams.get("EQ_u.user_type")!=null&&searchParams.get("EQ_u.user_type").equals("HUI")){
				searchParams.remove("EQ_u.user_type");
				searchParams.put("OR_EQ;u.user_Type", "HUI,PARTNER");
			}else{
				
			}
			
			//searchParams.put("LLIKE_g.group_id", "company");
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_u.company_id", AccountUtils.getCurrentUserCompanyId());
			searchParams.remove("EQ_u.user_type");
			searchParams.put("EQ_u.user_type","PARTNER");
		}else{
		}
		
		
		if(searchParams.get("EQ_u.hotel_id")!=null&&StringUtils.isNotBlank(searchParams.get("EQ_u.hotel_id").toString())){
			searchParams.put("LLIKE_g.group_id", "hotel");
			//searchParams.put("OR_LLIKE;g.group_id", "hotel,customer");
		}
		setPositionFilter(position,searchParams);
		pageBean.set_filterParams(searchParams);
		pageBean.setSort("u.state,u.create_date");
		pageBean.setOrder("desc,desc");
		List<User> p = userService.getPageList(pageBean);
		/*
		 * 
			
		for (User user : p.getContent()) {
			if(user.getGroupId() != null){
				user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
			}
		}
		
		*
		*/
		return getDataGrid(pageBean,p);
	}
	

	private void setPositionFilter(String position, Map<String, Object> searchParams) {
		if(StringUtils.isNotBlank(position)){
			if("CLIENT".equals(position)){
				searchParams.put("EQ_u.user_type", "CLIENT");
				/*searchParams.put("EQ_u.group_id", 13);
				searchParams.remove("LLIKE_g.group_id");*/
			}else if("SITESALE".equals(position)){
				searchParams.put("EQ_u.group_id", 9);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEFINANACE".equals(position)){
				searchParams.put("EQ_u.group_id", 10);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEGROUPFINANACE".equals(position)){
				searchParams.put("EQ_u.group_id", 7);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEQUIT".equals(position)){
				searchParams.put("EQ_u.state", 0);
			}else if("SITESALEMANAGER".equals(position)){
				searchParams.put("EQ_u.group_id", 20);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEHR".equals(position)){
				searchParams.put("EQ_u.group_id", 16);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEADMIN".equals(position)){
				searchParams.put("EQ_u.group_id", 8);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEGROUPSALE".equals(position)){
				searchParams.put("EQ_u.group_id", 25);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEGROUPHR".equals(position)){
				searchParams.put("EQ_u.group_id", 19);
				searchParams.put("EQ_u.state", 1);
			}else if("SITEGROUPADMIN".equals(position)){
				searchParams.put("EQ_u.group_id", 6);
				searchParams.put("EQ_u.state", 1);
			}else if("PARTNER".equals(position)){
				searchParams.put("EQ_u.user_type", "PARTNER");
				searchParams.put("EQ_u.group_id", 2);
				searchParams.put("EQ_u.state", 1);
			}else if("PARTNERSALE".equals(position)){
				searchParams.put("EQ_u.group_id", 0);
				searchParams.put("EQ_u.state", 1);
			}else if("HUISALE".equals(position)){
				searchParams.put("EQ_u.group_id", 3);
				searchParams.put("EQ_u.state", 1);
			}else if("HUIQUIT".equals(position)){
				searchParams.put("EQ_u.state", 0);
			}else if("HUIOPERATE".equals(position)){
				searchParams.put("EQ_u.group_id",5);
				searchParams.put("EQ_u.state", 1);
			}else if("HUIDIRECTOR".equals(position)){
				searchParams.put("EQ_u.group_id", 21);
				searchParams.put("EQ_u.state", 1);
			}else if("HUIFINANACE".equals(position)){
				searchParams.put("EQ_u.group_id",4);
				searchParams.put("EQ_u.state", 1);
			}else if("HUIADMIN".equals(position)){
				searchParams.put("EQ_u.group_id", 18);
				searchParams.put("EQ_u.state", 1);
			}else if("ADMINISTRATOR".equals(position)){
				searchParams.put("EQ_u.group_id", 1);
				searchParams.put("EQ_u.state", 1);
			}else if("HUISTAFF".equals(position)){
				searchParams.put("EQ_u.group_id", 22);
				searchParams.put("EQ_u.state", 1);
			}else if("HOTELSTAFF".equals(position)){
				searchParams.put("EQ_u.group_id", 23);
				searchParams.put("EQ_u.state", 1);
			}else if("GROUPSTAFF".equals(position)){
				searchParams.put("EQ_u.group_id", 24);
				searchParams.put("EQ_u.state", 1);
			}else if("STAFF".equals(position)){
				searchParams.put("OR_EQ;u.group_id", "23,24");
				searchParams.put("EQ_u.state", 1);
			}
			
		}
		
	}
	@RequestMapping(value = "create")
	public ModelAndView createForm(Model model,String memberType,Long hotelId,String crtusrty) {
		model.addAttribute("memberType", memberType);
		model.addAttribute("crtusrty", crtusrty);
		if(hotelId!=null){
			Hotel hotel = this.hotelService.getEntity(hotelId);
			model.addAttribute("vcrthotel", hotel);
		}
		return new ModelAndView("user/userForm");
	}
	
	
	
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id")String id,Model model) {
		model.addAttribute("upUser", userService.getEntity(id));
		return new ModelAndView("user/userForm");
		
	}
	
	@RequestMapping(value = "userinfo/{id}")
	@ResponseBody
	public JsonVo userinfo(@PathVariable("id")String id,Model model) {
		//model.addAttribute("upUser", userService.getEntity(id));
		User user = userService.getEntity(id);
		user.setGroup(this.groupService.getEntity(user.getGroupId()));
		if("HOTEL".equals(user.getUserType())){
			if(StringUtils.isNotBlank(user.getHotelId())){
				Hotel hotel = this.hotelService.getEntity(Long.valueOf(user.getHotelId()));
				user.setCompanyName(hotel.getHotelName());
				user.setCompanyNature("HOTEL");
			}else if(null!=user.getPhtlid()){
				HotelGroup hotelGroup = this.hotelGroupService.getEntity(user.getPhtlid());
				user.setCompanyName(hotelGroup.getName());
				user.setCompanyNature("GROUP");
			}
		}
		
		return JsonUtils.success("ok", user);
		
	}
	@RequestMapping(value = "detail/{id}")
	public String detail(@PathVariable("id")String id,Model model,String TYPE) {
		this.groupSetting(model);
		User user = userService.getEntity(id);
		if(user.getUserType().equals("HOTEL")){
			String url = "/weixin/user/moredetail?userId="+user.getId();//hotelId="+user.getHotelId()+"&
			return "redirect:"+url;
		}
		String sql = "select id,avg(comprehensive) comprehensive from hui_evaluate h where h.sale_id = ? ";
		List<Object> paras = Lists.newArrayList();
		paras.add(id);
		UserEvaluateModel uerEvaluateModel = cusQueryService.getOne(sql, UserEvaluateModel.class, paras);
		if(user != null && user.getGroupId() != null){
			user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
		}
		if("PARTNER".equalsIgnoreCase(user.getUserType())){
			Company company = this.companyService.getEntity(user.getCompanyId());
			Region region = this.regionService.getEntity(Long.valueOf(company.getCity()+""));
			User partner = this.userService.getEntity(company.getApplyUserId());
			if(user.getId().equals(company.getApplyUserId())){
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
		return "user/staffDetail";
		
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(@Valid @ModelAttribute("user")User user, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if(StringUtil.isBlank(user.getId())&&userService.findUserByUsername(user.getUsername())!=null){
			//新增
			return ajaxDoneError("该帐号已被使用，请重新输入！");
		}
		if(StringUtil.isNotBlank(user.getId())){
			//更新
			User oldUser = userService.getUser(user.getId());
			if (!user.getUsername().trim().equals(oldUser.getUsername().trim())
					&&userService.findUserByUsername(user.getUsername())!=null) {
				return ajaxDoneError("该帐号已被使用，请重新输入！");
			}
			user.setPassword(oldUser.getPassword());
		}
		userService.saveUser(user);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value = "register")
	public ModelAndView register(User user, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if(StringUtil.isBlank(user.getId())&&userService.findUserByUsername(user.getUsername())!=null){
			//新增
			return ajaxDoneError("该帐号已被使用，请重新输入！");
		}
		if(StringUtil.isBlank(user.getId())&&userService.findUserByMobile(user.getMobile())!=null){
			//新增
			return ajaxDoneError("该手机已被使用，请重新输入！");
		}
		if(StringUtil.isBlank(user.getId())&&userService.findUserByEmail(user.getEmail())!=null){
			//新增
			return ajaxDoneError("该邮箱已被使用，请重新输入！");
		}
		userService.register(user);
		//return ajaxDoneError("该手机已被使用，请重新输入！");
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}

	@RequestMapping("/delete/{id}")
	public ModelAndView delete(@PathVariable("id")String id) {
		userService.deleteUser(id);
		return ajaxDoneSuccess("删除成功！");
	}
	
	@RequestMapping(value = "/mypwdform")
	public String myPwdForm(Model model,String self) {
		model.addAttribute("upUser", userService.getEntity(AccountUtils.getCurrentUserId()));
		model.addAttribute("self", self);
		return "account/userPwdForm";
	}
	
	@RequestMapping(value = "/pwdForm/{id}")
	public String pwdForm(@PathVariable("id")String id,Model model,String self) {
		model.addAttribute("upUser", userService.getEntity(id));
		model.addAttribute("self", self);
		return "account/userPwdForm";
	}
	@RequestMapping(value = "savePersonPwd")
	public ModelAndView savePersonPwd(String id,String oldpwd,String password,String self,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		User user = userService.getUser(id);
		if(StringUtil.isNotBlank(self)){
			if(CipherUtil.validatePassword(user.getPassword(), oldpwd)){
				user.setPassword(password);
				userService.saveUser(user,true);
				return ajaxDoneSuccess("操作成功！");
			}else{
				return ajaxDoneError("旧密码不一致！");
			}
		}else{
			user.setPassword(password);
			userService.saveUser(user,true);
			return ajaxDoneSuccess("操作成功！");
		}
	}
	@RequestMapping(value="lockedUser/{id}")
	public ModelAndView lockedUser(@PathVariable("id")String id,@RequestParam(value="pageNo",required=false) Integer pageNo,Model model){
		User user = userService.getUser(id);
		if(!"1".equals(user.getLocked())){
			user.setLocked("1");
			userService.saveUser(user);
		}
		return ajaxDoneSuccess("操作成功");
	}
	
	@RequestMapping(value="unLockedUser/{id}")
	public ModelAndView unLockedUser(@PathVariable("id")String id,@RequestParam(value="pageNo",required=false) Integer pageNo,Model model){
		User user = userService.getUser(id);
		if(!"0".equals(user.getLocked())){
			user.setLocked("0");
			userService.saveUser(user);
		}
		return ajaxDoneSuccess("操作成功");
	}
	
	@RequestMapping(value="batchUpdateStatus")
	public ModelAndView batchUpdateStatus(String[] selects,String locked,Model model){
		userService.batchUpdateStatus(selects, locked);
		return ajaxDoneSuccess("操作成功");
	}
	
	@RequestMapping(value="savePersonInfo")
	public ModelAndView savePersonInfo(String id,String phone,String email){
		User u = userService.getUser(id);
		if(StringUtil.isNotBlank(phone)){
			u.setMobile(phone);
		}
		if(StringUtil.isNotBlank(email)){
			u.setEmail(email);
		}
		userService.saveEntity(u);
		return ajaxDoneSuccess("操作成功！");
	}
	@RequestMapping(value="personInfo")
	public String personInfo(Model model){
		User user=  userService.getUser(AccountUtils.getCurrentUserId());
		model.addAttribute("upUser",user);
		return "account/personInfo";
	}
	
	
	/**
	 * 角色转换/权限转移   页面
	 * @param request
	 * @param model
	 * @param userId       接收者
	 * @param fromuserId   转出者
	 * @param gid          角色编号
	 * @param type         HR编号
	 * @param crtusrty     当前操作用户类型
	 * @return
	 */
	@RequestMapping("/author/transfer/index")
	public String authorityTransfer(HttpServletRequest request,Model model,String userId,String fromuserId,Long gid,String type,String crtusrty){
		User user = null;
		if(StringUtils.isNotBlank(userId)){
			user = this.userService.getEntity(userId);
			model.addAttribute("tuser", user);
		}
		model.addAttribute("crtusrty",crtusrty);
		if(StringUtils.isBlank(crtusrty)){
			model.addAttribute("isgroup", "1");
		}else{
			model.addAttribute("isgroup", "2");
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
		
		PageBean<User> pageBean = new PageBean<>();
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("16".equals(type)){
			filterParams.put("EQ_u.user_type", AccountUtils.getCurrentUserType());
			filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
			filterParams.put("LLIKE_g.group_id", "hotel");
			//filterParams.put("OR_LLIKE_g.group_id", "hotel,customer");
			filterParams.put("NE_u.group_id", 16);
		}else if("17".equals(type)){
			filterParams.put("EQ_u.user_type", AccountUtils.getCurrentUserType());
			filterParams.put("LLIKE_g.group_id", "company");
			//filterParams.put("OR_LLIKE_g.group_id", "company,customer");
			filterParams.put("NE_u.group_id", 17);
		}else if("19".equals(type)){
			filterParams.put("LLIKE_g.group_id", "group");
			//filterParams.put("OR_LLIKE_g.group_id", "group,customer");
			filterParams.put("EQ_u.phtlid", AccountUtils.getCurrentUser().getPhtlid());
			filterParams.put("EQ_u.user_type", AccountUtils.getCurrentUserType());
			filterParams.put("NE_u.group_id", 19);
		}else{
			if(StringUtils.isNotBlank(type))
				filterParams.put("NE_u.group_id", type);
			
			if(StringUtils.isBlank(crtusrty)){
				filterParams.put("EQ_u.user_type", AccountUtils.getCurrentUserType());
				if("HOTEL".equals(AccountUtils.getCurrentUserType())){
					if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
						filterParams.put("EQ_u.phtlid", AccountUtils.getCurrentUser().getPhtlid());
						filterParams.put("LLIKE_g.group_id", "group");
						//filterParams.put("OR_LLIKE_g.group_id", "group,customer");
					}else{
						filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
						filterParams.put("LLIKE_g.group_id", "hotel");
						//filterParams.put("OR_LLIKE;g.group_id", "hotel,customer");
					}
				}else{
					filterParams.put("LLIKE_g.group_id", "company");
				}
			}else{
				filterParams.put("EQ_u.user_type", "HOTEL");
				filterParams.put("EQ_u.state", "1");
			}
			
		}
		if(StringUtils.isNotBlank(fromuserId)){
			filterParams.put("NE_u.id", fromuserId);
		}
		pageBean.set_filterParams(filterParams);
		List<User> users = userService.getAllList(pageBean);
		
		if(gid!=null){
			Group group = this.groupService.getEntity(gid);
			model.addAttribute("group", group);
		}
		
		model.addAttribute("fromuserId", fromuserId);
		model.addAttribute("gid", gid);
		model.addAttribute("flag", flag);
		model.addAttribute("type", type);
		model.addAttribute("users", users);
		return "user/userAuthorityTransfer";
	}

	@RequestMapping("/staff/pms/update/{id}")
	public String pmsUpdate(HttpServletRequest request,Model model,@PathVariable("id")String id,String TYPE){
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
		model.addAttribute("TYPE", TYPE);
		return "user/staffPmsUpdate";
	}
	
	@RequestMapping(value = "hr/create")
	public ModelAndView hrcreateForm(Model model,String memberType) {
		if("HUI".equals(memberType)){
			model.addAttribute("groupId", "17");
		}else if("HOTEL".equals(memberType)){
			model.addAttribute("groupId", "16");
		}
		model.addAttribute("memberType", memberType);
		return new ModelAndView("user/hruserForm");
	}
	
	@RequestMapping("/author/manage/index")
	public String authorManageIndex(HttpServletRequest request,Model model){
		List<Menu> menus = this.menuService.getSysAuthRootMenus(90L);
		model.addAttribute("menus",menus);
		return "user/userPermissionList";
	}
	
	@RequestMapping("/author/tmp/list")
	@ResponseBody
	public DataGrid tmpList(PageBean<UserPermission> pageBean,HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_type", "0");
		filterParams.put("EQ_adjustUid", AccountUtils.getCurrentUserId());
		pageBean.set_filterParams(filterParams);
		Page<UserPermission> page = userPermissionService.getEntities(pageBean);
		return getDataGrid(pageBean,page.getContent());
	}
	
	
	@RequestMapping("/author/tmp")
	public String authorManageTmp(HttpServletRequest request,Model model,String userId){
		User user = null;
		if(StringUtils.isNotBlank(userId)){
			user = this.userService.getEntity(userId);
			model.addAttribute("tuser", user);
		}
		/*Group group = this.groupService.getEntity(AccountUtils.getCurrentUser().getGroupId());
		List<Permission> permissions = group.getPermissionEntityList();
		for (Permission permission : permissions) {
			UserPermission up = new UserPermission(AccountUtils.getCurrentUserId(), AccountUtils.getCurrentRName(), permission.getId()+"", permission.getDisplayname()
					, new Date(), DateUtils.addDays(new Date(), 365*10), new Date(), "","1",AccountUtils.getCurrentUserId(), new Date(),permission.getPermission(),permission.getType());
			this.userPermissionService.saveUserPermission(up);
		}
		*/
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_u.user_type", AccountUtils.getCurrentUserType());
		filterParams.put("EQ_u.state", "1");
		filterParams.put("NE_u.id", AccountUtils.getCurrentUserId());
		if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				filterParams.put("EQ_u.phtlid", AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("LLIKE_g.group_id", "group");
			}else{
				filterParams.put("EQ_u.hotel_id", AccountUtils.getCurrentUserHotelId());
				filterParams.put("LLIKE_g.group_id", "hotel");
			}
		}else{
			filterParams.put("LLIKE_g.group_id", "company");
		}
		
		PageBean<User> pageBean = new PageBean<>();
		pageBean.set_filterParams(filterParams);
		List<User> users = userService.getAllList(pageBean);
		
		
		List<UserPermission> userPermissions = userPermissionService.findByUserId(AccountUtils.getCurrentUserId(),"1");
		model.addAttribute("userPermissions", userPermissions);
		model.addAttribute("users", users);
		return "user/userPermissionForm";
	}
	
	
	
	@RequestMapping("/msg/index")
	public String index(HttpServletRequest request,Model model){
		this.groupSetting(model);
		return "user/chatmsgList";
	}

	@RequestMapping("/msg/list")
	@ResponseBody
	public DataGrid findAll(HttpServletRequest request,PageBean<ChatRecord> pageBean){
		Map<String, Object> filterParams = this.getSearchParams(request);
		this.setFilterParams(filterParams);
		pageBean.set_filterParams(filterParams);
		pageBean.setOrder("desc,desc");
		pageBean.setSort("state,createdAt");
		Page<ChatRecord> page = this.chatRecordService.getEntities(pageBean);
		return getDataGrid(pageBean,page.getContent());
	}
	
	
	private void setFilterParams(Map<String, Object> filterParams) {
		filterParams.put("EQ_msgType", "SYSTEMMSG");
		if("HUI".equals(AccountUtils.getHotelUserType())){
			//filterParams.put("EQ_hotelId", 0);
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else if("HOTEL".equals(AccountUtils.getHotelUserType())){
			/*if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("OR_EQ;hotelId",hotelIds);
			}else{
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}*/
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else if("GROUP".equals(AccountUtils.getHotelUserType())){
			/*if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("OR_EQ;hotelId",hotelIds);
			}else{
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}*/
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else if("PARTNER".equals(AccountUtils.getHotelUserType().toUpperCase())){
			//filterParams.put("EQ_companyId", AccountUtils.getCurrentUser().getCompanyId());
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else{
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}
		
	}

	@RequestMapping("/msg/detail/{id}")
	public String detail(HttpServletRequest request,Model model,@PathVariable("id") Long id){
		this.groupSetting(model);
		ChatRecord chatRecord = this.chatRecordService.getEntity(id);
		chatRecord.setState("0");
		this.chatRecordService.saveChatRecord(chatRecord);
		model.addAttribute("msg", chatRecord);
		return "user/chatmsgDetail";
	}
	
	@RequestMapping("/msg/create")
	public String msgCreate(HttpServletRequest request,Model model){
		this.groupSetting(model);
		return "user/chatmsgForm";
	}
	
	@RequestMapping(value="/msg/send")
	public ModelAndView msgSend(String msgType,String rutype,String groupId,String userId,String hotelId,String title,String msg){
		/*User u = userService.getUser(id);
		userService.saveEntity(u);*/
		this.chatRecordService.msgSend(msgType,rutype,groupId,userId,hotelId,title,msg);
		return ajaxDoneSuccess("操作成功！");
	}
	
	@RequestMapping("/msg/remind/count")
	@ResponseBody
	public JsonVo remindCount(HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		this.setFilterParams(filterParams);
		filterParams.put("EQ_state", "1");
		List<ChatRecord> page = this.chatRecordService.getEntities(filterParams);
		return JsonUtils.success("num",page.size())  ;
	}
	@RequestMapping("/author/hotel/{id}")
	public String authorUserHotel(HttpServletRequest request,Model model,@PathVariable("id") String id){
		this.groupSetting(model);
		User user = this.userService.getEntity(id);
		model.addAttribute("user", user);
		return "user/authorUserHotel";
	}
	
	@RequestMapping("/author/hotel/save")
	@ResponseBody
	public JsonVo authorUserHotelSave(HttpServletRequest request,String hotelIds,String userId){
		User user = this.userService.getEntity(userId);
		return hotelService.authorUserHotelSave(user, hotelIds);
	}
}
