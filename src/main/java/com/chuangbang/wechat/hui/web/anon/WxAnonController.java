package com.chuangbang.wechat.hui.web.anon;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.base.entity.hotel.HotelApplyRecord;
import com.chuangbang.base.service.hotel.HotelApplyRecordService;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.common.MobileUtil;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.pingyin4j.Pinyin4jUtil;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.js.shiro.CaptchaException;
import com.chuangbang.js.shiro.UsernamePasswordCaptchaToken;
import com.chuangbang.plugins.mail.SimpleMailSender;
import com.chuangbang.plugins.mail.service.EmailService;
import com.chuangbang.plugins.sms.util.CallUtil;
import com.chuangbang.wechat.hui.service.user.WxUserService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import jodd.util.StringUtil;

@Controller
@RequestMapping(value = "/anon/")
public class WxAnonController extends BaseController{

	@Autowired
	private UserService userService;
	@Autowired
	private WxUserService wxUserService;
	@Autowired
	private EmailService emailService;
	private static final  int mocodeCount = 6;
	private static final char[] mocodeSequence = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
	@Autowired
	private HotelApplyRecordService hotelApplyRecordService;
	
	@RequestMapping(value = "register")
	public String index(HttpServletRequest request,Model model) {
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/anon/register";
		}else{
			return "register";
		}
	}
	
	//微信端登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public JsonVo zgLoginForPost(HttpServletRequest request,@RequestParam String username,
			@RequestParam String password,@RequestParam String captcha,Model model,HttpSession session) {
		Subject currentUser = SecurityUtils.getSubject();  
		if (!currentUser.isAuthenticated()) { 
			UsernamePasswordCaptchaToken userToken = new UsernamePasswordCaptchaToken(username,password.toCharArray(),captcha);
			try{  
				SecurityUtils.getSubject().login(userToken);
		       }catch(CaptchaException ex){
		    	   return JsonUtils.error("验证码错误！");
		       }catch(UnknownAccountException ex){  
		    	   return JsonUtils.error("帐号或密码错误！");
		        }catch(IncorrectCredentialsException ex){
		           return  JsonUtils.error("帐号或密码错误！");
		       }catch(LockedAccountException ex){  
		    	   return  JsonUtils.error("账号已被锁定，请与系统管理员联系！");
		       }catch(DisabledAccountException ex){  
		    	   return  JsonUtils.error("已离职用户，不能登录！");
		       }catch(AuthenticationException ex){ 
		    	   return  JsonUtils.error("帐号或密码错误！");
		       } 
			return JsonUtils.success("登录成功！");
		}else{
			return JsonUtils.success("登录成功！");
	    }
	}

	@RequestMapping(value ="saveRegister")
	@ResponseBody
	public JsonVo saveRegister(User user,String captcha,HttpServletRequest request,String mobile){
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
		
		if(StringUtil.isBlank(user.getId())&&userService.findUserByUsername(user.getUsername())!=null){
			//新增
			return JsonUtils.error("该昵称已被使用，请重新输入！");
		}
		if(StringUtil.isBlank(user.getId())&&userService.findUserByMobile(user.getMobile())!=null){
			//新增
			return JsonUtils.error("该手机已被使用，请重新输入！");
		}
		if(StringUtil.isNotBlank(user.getId())){
			//更新
			User oldUser = userService.getUser(user.getId());
			if (!user.getUsername().trim().equals(oldUser.getUsername().trim())
					&&userService.findUserByUsername(user.getUsername())!=null) {
				return JsonUtils.error("该昵称已被使用，请重新输入！");
			}
			user.setPassword(oldUser.getPassword());
		}
		userService.saveUser(user);
		return JsonUtils.success("注册成功！");
	}
	
	@RequestMapping("/user/pwd/reset")
	public String resetpwd(HttpServletRequest request,Model model){
		return "weixin/anon/resetpwd";
	}
	
	@RequestMapping("/agreement")
	public String agreement(HttpServletRequest request,Model model){
		return "agreement";
	}
	
	@RequestMapping("/user/pwd/save")
	@ResponseBody
	public JsonVo saveresetpwd(HttpServletRequest request,Model model,String mobile,String password,String captcha){
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
		return wxUserService.saveresetpwd(null,mobile,password );
	}
	
	
	@RequestMapping("/iforgot/password/reset")
	public String resetPcPwd(HttpServletRequest request,Model model,String action,String account, String type){
		HttpSession session = request.getSession();
		try{
			if("VerifyAccount".equals(action)){
				toSetpOne(session,model);
			}else if("VerifySuccess".equals(action)){
				boolean suc =  session.getAttribute("VerifySuccess")==null?false:((boolean) session.getAttribute("VerifySuccess"));
				User sucuser = session.getAttribute("set_pwd_user")==null?null:((User) session.getAttribute("set_pwd_user"));//(User)session.getAttribute("set_pwd_user");
				if(null!=sucuser&&suc&&resetTimeout(request)){
					model.addAttribute("step", "GetPwdType");
					model.addAttribute("isverify", true);
					model.addAttribute("clazs", "step2");
					model.addAttribute("active", 2);
					model.addAttribute("account", account);	
					model.addAttribute("user", sucuser);	
				}else{
					toSetpOne(session,model);
				}
			}else if("SelPwdType".equals(action)){
				boolean suc = (boolean) session.getAttribute("VerifySuccess");
				User sucuser = (User)session.getAttribute("set_pwd_user");
				if(null!=sucuser&&suc&&resetTimeout(request)&&StringUtils.isNotBlank(type)){
					model.addAttribute("step", "ResetPwd");
					model.addAttribute("isverify", true);
					model.addAttribute("clazs", "step3");
					model.addAttribute("active", 1);
					model.addAttribute("account", account);
					model.addAttribute("user", sucuser);
					model.addAttribute("type", type);
					model.addAttribute("email", sucuser.getEmail().replaceAll("(\\w{6})(\\w+)(@\\w+\\.[a-z]+(\\.[a-z]+)?)", "$1****$3"));
				}else{
					toSetpOne(session,model);
				}
			}else if("RESETSUCCESS".equals(action)){
				boolean suc = (boolean) session.getAttribute("RESETSUCCESS");
				if(suc){
					model.addAttribute("step", "ResetSuc");
					model.addAttribute("clazs", "step3");
					model.addAttribute("active", 1);
				}else{
					toSetpOne(session,model);
				}
			}else{
				toSetpOne(session,model);
			}
		}catch(Exception e){
			toSetpOne(session,model);
		}
		return "password";
	}
	
	private void toSetpOne(HttpSession session,Model model){
		session.removeAttribute("set_pwd_user");
		session.removeAttribute("VerifySuccess");
		session.removeAttribute("set_pwd_user_time");
		model.addAttribute("step", "VerifyAccount");
		model.addAttribute("isverify", false);
		model.addAttribute("clazs", "step1");
		model.addAttribute("active", 3);
	}
	
	@RequestMapping("/iforgot/password/verifyaccount")
	@ResponseBody
	public JsonVo verifyaccount(HttpServletRequest request,String account,String captcha){
		HttpSession session = request.getSession();
		if(StringUtils.isNotBlank(captcha)){
			String exitCode = (String) session.getAttribute("KEY_CAPTCHA");
			if(!captcha.equalsIgnoreCase(exitCode)){
				return JsonUtils.error("验证码错误！");
			}
		}else{
			return JsonUtils.error("请填写验证码！");
		}
		if(StringUtils.isNotBlank(account)){
			try{
				User user = null;
				if(MobileUtil.isMobileNO(account)){
					user =  this.userService.findUserByMobile(account);
				}else if(MobileUtil.isEmail(account)){
					user =  this.userService.findUserByEmail(account);
				}else{
					return JsonUtils.error("请填写正确的邮箱或手机格式！");
				}
				if(user==null){
					return JsonUtils.error("账号不存在！");
				}
				session.setAttribute("set_pwd_user", user);
				session.setAttribute("set_pwd_user_time", new Date().getTime());
				session.setAttribute("VerifySuccess", true);
				return JsonUtils.success("user",user);
			}catch(Exception e){
				return JsonUtils.error("系统错误！");
			}
		}else{
			return JsonUtils.error("请填写邮箱或手机！");
		}
	}
	
	private boolean resetTimeout(HttpServletRequest req){
		HttpSession session = req.getSession();
		try{
			long strTime = (long)session.getAttribute("set_pwd_user_time");
			long crtTime = new Date().getTime();
			Double overTime = (crtTime-strTime)/1000/60/60*1.0;
			System.out.println("overTime>>>>"+overTime);
			if(overTime>=1){
				return false;
			}else{
				return true;
			}
		}catch(Exception e){
			return false;
		}
	}
	
	@RequestMapping("/sendcode")  
    @ResponseBody
    public ModelAndView getMoDrawCode(String type,HttpServletRequest req, HttpServletResponse resp) {  
		HttpSession session = req.getSession();
		User sucuser = (User)session.getAttribute("set_pwd_user");
		// 创建一个随机数生成器类  
    	Random random = new Random();  
    	StringBuffer randomCode = new StringBuffer();  
    	// 随机产生mocodeCount数字的验证码。  
    	for (int i = 0; i < mocodeCount; i++) {  
    		// 得到随机产生的验证码数字。  
    		String code = String.valueOf(mocodeSequence[random.nextInt(10)]);  
    		randomCode.append(code);  
    	}  
    	// 将6位数字的验证码保存到Session中。  
    	
    	if("MOBILE".equals(type)){
    		session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+sucuser.getMobile(), randomCode.toString()); 
        	session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+sucuser.getMobile(), new Date().getTime());

        	String content = "您的验证码为{CODE}；十分钟内有效!";//【会掌柜】
        	content = content.replace("{CODE}", randomCode.toString());
        	String returnSms = CallUtil.sendmsg(content, sucuser.getMobile());
        	if(null!=returnSms&&"SUCCESS".equals(returnSms)){
        		//smsRecordService.saveSmsRecord(new SmsRecord(phone, "验证码", content, "", "PHONE_CAPTCHA", "", "", new Date()));
        		return ajaxDoneSuccess("验证码发送成功！");
        	}
    	}else{
    		session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+sucuser.getEmail(), randomCode.toString()); 
        	session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+sucuser.getEmail(), new Date().getTime());
        	String content = sucuser.getRname()+",您好！<br>为了确保是您本人操作，您已选择通过该邮件地址获取验证码验证身份。请在邮件验证码输入框输入下方验证码：<br>{CODE}<br>勿向任何人泄露您收到的验证码。验证码会在邮件发送10分钟后失效!"
        			+ "<br>此致<br>会掌柜";//【会掌柜】
        	Map<String, Object> model = Maps.newHashMap();
        	model.put("nickname", sucuser.getRname());
        	model.put("code", randomCode.toString());
        	
        	content = SimpleMailSender.getEmailContent(model, "codemail.ftl"); //content.replace("{CODE}", randomCode.toString());
        	Json json = emailService.sendeMail(sucuser.getEmail(), "会掌柜邮件验证码！", content);
        	if(json.isSuccess()){
        		return ajaxDoneSuccess("验证码发送成功！");
        	}else{
        		return  ajaxDoneError("验证码发送失败！");
        	}
    	}
    	return  ajaxDoneError("验证码发送失败！");
    } 
	
	
	@RequestMapping("/iforgot/user/pwd/save")
	@ResponseBody
	public JsonVo iforgotaResetpwd(HttpServletRequest request,Model model,String type,String password,String cfpassword,String mcaptcha){
		try{
			HttpSession session = request.getSession();
			if(resetTimeout(request)){
				User sucuser = (User)session.getAttribute("set_pwd_user");
				if(sucuser!=null&&StringUtils.isNotBlank(type)){
					String key = "MOBILE".equals(type)?sucuser.getMobile():sucuser.getEmail();
					String code = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+key)?"":session.getAttribute("MO_DRAW_KEY_CAPTCHA_"+key).toString();
					long cpthtime = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+key)?0:(long)session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+key);
					if(cpthtime==0){
						return JsonUtils.error("验证码已失效，请重新获取！");
					}else{
						long nowd = new Date().getTime();
						long res = nowd - cpthtime;
						if(res>600000){
							return JsonUtils.error("验证码已失效，请重新获取！");
						}
					}
					if(!code.equals(mcaptcha)){
						return JsonUtils.error("验证码错误！");
					}
					JsonVo jsonVo = wxUserService.saveresetpwd(sucuser.getId(),null,password);
					if(jsonVo.getStatusCode().equals("200")){
						session.setAttribute("RESETSUCCESS",true);
					}
					return jsonVo;
				}else{
					return JsonUtils.error("会话已过时！");
				}
			}else{
				return JsonUtils.error("会话已过时！");
			}
		}catch(Exception e){
			return JsonUtils.error("会话已过时！");
		}
	}
	
	@RequestMapping(value ="doreg")
	@ResponseBody
	public JsonVo registerUser(HttpServletRequest request,String account,String rname,String email,String password,String cfpassword){
		HttpSession session = request.getSession();
		User user = null;
		if(StringUtil.isBlank(account)){
			//新增
			return JsonUtils.error("手机不能为空！");
		}
		if(StringUtil.isNotBlank(account)){
			//新增
			User u = userService.findUserByMobile(account);
			if(u!=null&&"1".equals(u.getIsvalid())){
				return JsonUtils.error("该手机已被使用，请重新输入！");
			}
			
			user = u;
		}
		if(StringUtil.isBlank(rname)){
			//新增
			return JsonUtils.error("姓名不能为空！");
		}
		if(StringUtil.isBlank(email)){
			//新增
			return JsonUtils.error("邮箱不能为空！");
		}
		if(StringUtil.isNotBlank(email)){
			//新增
			User u = userService.findUserByEmail(account);
			if(u!=null&&"1".equals(u.getIsvalid())){
				return JsonUtils.error("该邮箱已被使用，请重新输入！");
			}
		}
		if(!password.equals(cfpassword)){
			return JsonUtils.error("两次输入密码错误！");
		}
		String zimu = Pinyin4jUtil.converterToSpell(rname);
		zimu = zimu.split(",")[0];
		if(user==null){
			user = new User(zimu+account.substring(7), rname, account, email, null, password, "", "", "0", "0", new Date(), null, "", "", "");
		}else{
			user.setUser(rname, account, email, null, password, "", "", zimu, 0);
		}
		userService.saveUser(user);
		/*AuthenticationToken authenticationToken = new UsernamePasswordToken(user.getUsername(), CipherUtil.generatePassword(new String(password)).toCharArray());
		Subject subject = SecurityUtils.getSubject();
		subject.login(authenticationToken);
		subject.getSession().setAttribute("user", user);*/
		
		session.setAttribute("reg_user", user);
		return JsonUtils.success("注册成功！");
	}
	
	@RequestMapping("/validerror")
	public String validerror(HttpServletRequest request,Model model){
		return "registererror";
	}
	@RequestMapping("/registervalid")
	public String registervalid(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("reg_user");
		if(user==null){
			return "redirect:/anno/validerror";
		}
		session.setAttribute("set_pwd_user",user);
		model.addAttribute("reguser", user);
		return "registervalid";
	}
	
	@RequestMapping(value ="dovalid")
	@ResponseBody
	public JsonVo dovalid(HttpServletRequest request,String captcha){
		try{
			HttpSession session = request.getSession();
			User sucuser = (User)session.getAttribute("reg_user");
			if(sucuser!=null){
				String key = sucuser.getMobile();
				String code = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+key)?"":session.getAttribute("MO_DRAW_KEY_CAPTCHA_"+key).toString();
				long cpthtime = null == session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+key)?0:(long)session.getAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+key);
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
				sucuser.setIsvalid("1");
				userService.save(sucuser);
				session.removeAttribute("set_pwd_user");
				return JsonUtils.success("认证成功！");
			}else{
				return JsonUtils.error("会话已过时！");
			}
		}catch(Exception e){
			return JsonUtils.error("会话已过时！");
		}
	}
	
	
	@RequestMapping("/jointeam")
	public String jointeam(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("reg_user");
		if(user==null){
			return "redirect:/anno/validerror";
		}
		session.setAttribute("join_team_user",user);
		model.addAttribute("reguser", user);
		return "jointeam";
	}
	
	
	@RequestMapping("/getteams")
	@ResponseBody
	public JsonVo getteams(HttpServletRequest request,String name){
		List<Map<String, Object>> res = Lists.newArrayList();
		if(StringUtils.isNotBlank(name)){
			res = this.hotelApplyRecordService.getTeams(name);
		}
		return JsonUtils.success("ok", res);
	}
	
	
	@RequestMapping(value ="dojoin")
	@ResponseBody
	public JsonVo dojoin(HttpServletRequest request,String teamid,String teamtype){
		try{
			if(StringUtils.isBlank(teamid)){
				return JsonUtils.error("请选择团队！");
			}
			HttpSession session = request.getSession();
			User reguser = (User)session.getAttribute("reg_user");
			if(reguser==null){
				return JsonUtils.error("会话已过时！");
			}
			if(teamid.equals("0")){
				HotelApplyRecord applyRecord = new HotelApplyRecord(reguser.getId(), 0L, "0", new Date(),teamtype);
				hotelApplyRecordService.saveRecord(applyRecord);
			}else{
				HotelApplyRecord applyRecord = new HotelApplyRecord(reguser.getId(), Long.valueOf(teamid), "0", new Date(),teamtype);
				hotelApplyRecordService.saveRecord(applyRecord);
			}
			
			session.removeAttribute("reg_user");
			session.removeAttribute("join_team_user");
			return JsonUtils.success("申请成功!");
		}catch(Exception e){
			return JsonUtils.error("会话已过时！");
		}
	}
}
