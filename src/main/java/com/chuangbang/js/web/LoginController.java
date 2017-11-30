package com.chuangbang.js.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.hotel.HotelGroup;
import com.chuangbang.base.entity.user.UserPermission;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.UserPermissionService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.file.pdf.PdfHelper;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.Permission;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.PermissionService;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.js.shiro.CaptchaException;
import com.chuangbang.js.shiro.UnValidationException;
import com.chuangbang.js.shiro.UsernamePasswordCaptchaToken;
import com.google.common.collect.Lists;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，

 * 真正登录的POST请求由Filter完成,
 * 
 * @author calvin
 */
@Controller
public class LoginController extends BaseController {
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private GroupService groupService;
	@Autowired
	private UserPermissionService userPermissionService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private PermissionService permissionService;
	@Autowired
	private UserService userService;
	@Autowired
	private HotelGroupService hotelGroupService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model,HttpServletRequest request) {
		String ua = request.getHeader("User-Agent");
		System.out.println(System.getProperty("user.dir").replace("bin", "webapps")+"/hui/static/pdf/");
		if(BrowseTool.isWeixin(ua)){
			return "/weixin/login";
		}else{
			return "/login";
		}
	}

	/*@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginForPost(HttpServletRequest request,@RequestParam String username,
			@RequestParam String password,@RequestParam String captcha,Model model,HttpSession session) {
		Subject currentUser = SecurityUtils.getSubject();  
		if (!currentUser.isAuthenticated()) { 
			UsernamePasswordCaptchaToken userToken = new UsernamePasswordCaptchaToken(username,password.toCharArray(),captcha);
			try{  
				SecurityUtils.getSubject().login(userToken);
		       }catch(CaptchaException ex){
		    	   request.setAttribute("loginError", "验证码错误！");
		    		return "login";
		       }catch(UnknownAccountException ex){  
		    	   request.setAttribute("loginError", "帐号或密码错误！");
		    		return "login";
		        }catch(IncorrectCredentialsException ex){
		        	request.setAttribute("loginError", "帐号或密码错误！");
		        	return "login";
		       }catch(LockedAccountException ex){  
		    	   request.setAttribute("loginError", "账号已被锁定，请与系统管理员联系！");
		    		return "login";
		       }catch(DisabledAccountException ex){  
		    	   request.setAttribute("loginError", "已离职用户，不能登录！");
		    	   return "login";
		       }catch(AuthenticationException ex){ 
		    	   request.setAttribute("loginError", "帐号或密码错误！");
		    	   return "login";
		       } 
			return "redirect:/main";
		}else{
			return "redirect:/main";
	    }
	}*/
	@RequestMapping(value = "/zgui/login", method = RequestMethod.POST)
	@ResponseBody
	public Json zgLoginForPost(HttpServletRequest request,@RequestParam String username,
			@RequestParam String password,@RequestParam String captcha,Model model,HttpSession session) {
		Json json = new Json();
		Subject currentUser = SecurityUtils.getSubject();  
		if (!currentUser.isAuthenticated()) { 
			UsernamePasswordCaptchaToken userToken = new UsernamePasswordCaptchaToken(username,password.toCharArray(),captcha);
			try{  
				SecurityUtils.getSubject().login(userToken);
				}catch(UnValidationException ex){
		    	   request.setAttribute("loginError", "手机号码尚未验证，不能登录；请重新注册验证！");
		    	   json.setJson(false, "手机号码尚未验证，不能登录；请重新注册验证！");
		    	   return json;
		       }catch(CaptchaException ex){
		    	   request.setAttribute("loginError", "验证码错误！");
		    	   json.setJson(false, "验证码错误！");
		    	   return json;
		       }catch(UnknownAccountException ex){  
		    	   request.setAttribute("loginError", "帐号或密码错误！");
		    	   json.setJson(false, "帐号或密码错误！");
		    	   return json;
		        }catch(IncorrectCredentialsException ex){
		        	request.setAttribute("loginError", "帐号或密码错误！");
		        	json.setJson(false, "帐号或密码错误！");
		        	return json;
		       }catch(LockedAccountException ex){  
		    	   request.setAttribute("loginError", "账号已被锁定，请与系统管理员联系！");
		    	   json.setJson(false, "账号已被锁定，请与系统管理员联系！");
		    	   return json;
		       }catch(DisabledAccountException ex){  
		    	   request.setAttribute("loginError", "已离职用户，不能登录！");
		    	   json.setJson(false, "已离职用户，不能登录！");
		    	   return json;
		       }catch(AuthenticationException ex){ 
		    	   request.setAttribute("loginError", "帐号或密码错误！");
		    	   json.setJson(false, "帐号或密码错误！");
		    	   return json;
		       } 
			json.setJson(true, "登录成功！");
    	    return json;
		}else{
			json.setJson(true, "登录成功！");
			return json;
	    }
	}
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainMapping(Model model,HttpServletRequest request) {
		//换成另外的方式取得用户菜单
		System.out.println("main>>>>");
		
		List<Long> menuIds = Lists.newArrayList();
		if(AccountUtils.getCurrentUser().getGroupId() != null){	//为了注册用户在未分配角色时能登录
			Group group = groupService.getEntity(AccountUtils.getCurrentUser().getGroupId());
			if(StringUtils.isNotBlank(AccountUtils.getCurrentUserId())){
				User user = this.userService.getEntity(AccountUtils.getCurrentUserId());
				model.addAttribute("user",user);
			}else{
				return "redirect:/logout";
			}
			//model.addAttribute("permissions",group.getPermissionNames());
			List<UserPermission> userPermissions = this.userPermissionService.findByUserId(AccountUtils.getCurrentUserId(), "1");
			List<UserPermission> tmpuserPermissions = this.userPermissionService.findByUserId(AccountUtils.getCurrentUserId(), "0");
			List<String> permissionNameList = Lists.newArrayList();
			
			for (UserPermission userPermission : userPermissions) {
				System.out.println(userPermission.getPermissions());
				permissionNameList.add(userPermission.getPermissions());
				Permission permission = this.permissionService.getEntity(Long.valueOf(userPermission.getPermissionId()));
				System.out.println(">>>menuId>>>>>"+permission.getMenuId());
				if(!menuIds.contains(permission.getMenuId())){
					menuIds.add(permission.getMenuId());
				}
			}
			for (UserPermission userPermission : tmpuserPermissions) {
				if(!permissionNameList.contains(userPermission.getPermissions())){
					permissionNameList.add(userPermission.getPermissions());
					Permission permission = this.permissionService.getEntity(Long.valueOf(userPermission.getPermissionId()));
					System.out.println(">>>menuId>>>>>"+permission.getMenuId());
					if(!menuIds.contains(permission.getMenuId())){
						menuIds.add(permission.getMenuId());
					}
				}
			}
			String permissions = StringUtils.join(permissionNameList, ",");
			model.addAttribute("permissions",permissions);
			request.setAttribute("permissions",permissions);
			model.addAttribute("group",group);
			
			AccountUtils.getCurrentUser().setGroup(group);
		}
		
		try {
			this.getCity(request);
		} catch (Exception e) {
		}
		String logo ="";
		String cname ="";
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
				Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
				model.addAttribute("hotel",hotel);
				logo = hotel.getLogo();
				cname = hotel.getHotelName();
				WebUtils.setSessionAttribute(request, "myhotel", hotel);
			}else if(AccountUtils.getCurrentUserGroupId().startsWith("group")){
				HotelGroup hotelGroup = this.hotelGroupService.getEntity(Long.valueOf(AccountUtils.getCurrentUserhotelPId()));
				logo = hotelGroup.getLogo();
				cname = hotelGroup.getName();
				model.addAttribute("hotelGroup",hotelGroup);
				WebUtils.setSessionAttribute(request, "mhotelGroup", hotelGroup);
			}else{
				if(StringUtils.isNotBlank(AccountUtils.getCurrentUserHotelId())){
					Hotel hotel = this.hotelService.getEntity(Long.valueOf(AccountUtils.getCurrentUserHotelId()));
					model.addAttribute("hotel",hotel);
					logo = hotel.getLogo();
					cname = hotel.getHotelName();
					WebUtils.setSessionAttribute(request, "myhotel", hotel);
				}else if(null!=AccountUtils.getCurrentUserhotelPId()){
					HotelGroup hotelGroup = this.hotelGroupService.getEntity(Long.valueOf(AccountUtils.getCurrentUserhotelPId()));
					logo = hotelGroup.getLogo();
					cname = hotelGroup.getName();
					model.addAttribute("hotelGroup",hotelGroup);
					WebUtils.setSessionAttribute(request, "mhotelGroup", hotelGroup);
				}
			}
			model.addAttribute("logo",logo);
			model.addAttribute("cname",cname);
			//return "/weixin/hotel/main";
		}else{
			//return "/weixin/client/main";
		}
		
		String ua = request.getHeader("User-Agent");
		if(BrowseTool.isWeixin(ua)){
			model.addAttribute("userRootMenus",menuService.getSysAuthRootMenus(7L,null));
			model.addAttribute("main","1");
			return "/weixin/hui/main";	//使用统一首页
		}else{
			model.addAttribute("userRootMenus",menuService.getSysAuthRootMenus(6L,menuIds));
			return "/newmain";
		}
	}
	
	@RequestMapping(value = "/secondmenu/{parentMenuId}", method = RequestMethod.GET)
	public String secondmenu(Model model,HttpServletRequest request,@PathVariable("parentMenuId")Long parentMenuId) {
		//换成另外的方式取得用户菜单
		System.out.println("secondmenu>>>>"+parentMenuId);
		Menu parentMenu = menuService.getEntity(parentMenuId);
		
		String ua = request.getHeader("User-Agent");
		if(BrowseTool.isWeixin(ua)){
			List<Long> menuIds = Lists.newArrayList();
			List<UserPermission> userPermissions = this.userPermissionService.findByUserId(AccountUtils.getCurrentUserId(), "1");
			List<UserPermission> tmpuserPermissions = this.userPermissionService.findByUserId(AccountUtils.getCurrentUserId(), "0");
			List<String> permissionNameList = Lists.newArrayList();
			
			for (UserPermission userPermission : userPermissions) {
				System.out.println(userPermission.getPermissions());
				permissionNameList.add(userPermission.getPermissions());
				Permission permission = this.permissionService.getEntity(Long.valueOf(userPermission.getPermissionId()));
				System.out.println(">>>menuId>>>>>"+permission.getMenuId());
				if(!menuIds.contains(permission.getMenuId())){
					menuIds.add(permission.getMenuId());
				}
			}
			for (UserPermission userPermission : tmpuserPermissions) {
				if(!permissionNameList.contains(userPermission.getPermissions())){
					permissionNameList.add(userPermission.getPermissions());
					Permission permission = this.permissionService.getEntity(Long.valueOf(userPermission.getPermissionId()));
					System.out.println(">>>menuId>>>>>"+permission.getMenuId());
					if(!menuIds.contains(permission.getMenuId())){
						menuIds.add(permission.getMenuId());
					}
				}
			}
			model.addAttribute("parentMenu",parentMenu);
			model.addAttribute("userRootMenus",menuService.getSysAuthRootMenus("1",parentMenuId,menuIds));
			
			/*if("HUI".equals(AccountUtils.getCurrentUserType())){
				
			}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
				return "/weixin/hotel/main";
			}else{
				return "/weixin/client/main";
			}*/
			return "/weixin/hui/main";
		}else{
			return "/newmain";
		}
	}
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for"); 
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP"); }
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP"); } 
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr(); 
		}
		return ip; 
	}


}
