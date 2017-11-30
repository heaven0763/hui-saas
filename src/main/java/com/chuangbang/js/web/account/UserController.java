package com.chuangbang.js.web.account;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;
import org.springside.modules.mapper.JsonMapper;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.util.img.NewImageUtils;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.UserService;

import jodd.util.StringUtil;

/**
 * Urls:
 * List   page        : GET  /account/user/
 * Create page        : GET  /account/user/create
 * Create action      : POST /account/user/save
 * Update page        : GET  /account/user/update/{id}
 * Update action      : POST /account/user/save/{id}
 * Delete action      : POST /account/user/delete/{id}
 * CheckLoginName ajax: GET  /account/user/checkLoginName?oldLoginName=a&loginName=b
 * 
 * @author Heaven
 *
 */
@Controller
@RequestMapping(value = "/account/user")
public class UserController extends BaseController{

	private static JsonMapper mapper = JsonMapper.nonDefaultMapper();
	
	@Autowired
	private UserService userService;
	@Autowired
	private GroupService groupService;
	
	@ModelAttribute("user")
	public User getUser(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return userService.getEntity(id);
		}
		return new User();
	}
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request,Model model,String memberType){
		
		/*Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("ISNN_groupId", null);
		List<User> users = this.userService.getEntities(filterParams);
		for (User user : users) {
			this.userService.updatePermission(user);
		}*/
		/*Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		if(hotel!=null){
			model.addAttribute("mhotel",hotel);
		}*/
		return new ModelAndView("account/userList");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(HttpServletRequest request,Model model,PageBean<User> pageBean) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		/*if(null!=searchParams.get("GTE_u.create_date")){
			searchParams.put("GTE_u.create_date", searchParams.get("GTE_u.create_date")+" 00:00:00.000");
		}
		if(null!=searchParams.get("LTF_u.create_date")){
			searchParams.put("LTF_u.create_date", searchParams.get("LTF_u.create_date")+" 23:59:59");
		}*/
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		if(hotel!=null){
			searchParams.put("EQ_hotelId", hotel.getId());
		}
		System.out.println(searchParams.toString());
		pageBean.setSort("state,groupId,createDate");
		pageBean.setOrder("desc,desc,desc");
		pageBean.set_filterParams(searchParams);
		Page<User> p = userService.getEntities(pageBean);
		for (User user : p.getContent()) {
			if(user.getGroupId() != null){
				user.setGroupName(groupService.getEntity(user.getGroupId()).getName());
			}
		}
		return getDataGrid(pageBean,p.getContent());
	}
	

	@RequestMapping(value = "create")
	public ModelAndView createForm(HttpServletRequest request,Model model,String memberType) {
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		if(hotel!=null){
			model.addAttribute("mhotel",hotel);
		}
		model.addAttribute("memberType", memberType);
		return new ModelAndView("account/userForm");
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id")String id,HttpServletRequest request,Model model) {
		model.addAttribute("upUser", userService.getEntity(id));
		Hotel hotel = (Hotel)WebUtils.getSessionAttribute(request, "mhotel");
		if(hotel!=null){
			model.addAttribute("mhotel",hotel);
		}
		return new ModelAndView("account/userForm");
		
	}
	
	
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id")String id,Model model) {
		model.addAttribute("upUser", userService.getEntity(id));		
		return new ModelAndView("account/userDetail");
		
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
	
	

	@RequestMapping("/delete/{id}")
	public ModelAndView delete(@PathVariable("id")String id) {
		userService.deleteUser(id);
		return ajaxDoneSuccess("删除成功！");
	}
	
	@RequestMapping(value = "/mypwdform")
	public String myPwdForm(Model model,String self) {
		model.addAttribute("upUser", userService.getEntity(AccountUtils.getCurrentUserId()));
		model.addAttribute("self", self);
		model.addAttribute("un", "un");
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
		String newFileName = yymd+"-"+generateString(6)+Constant.PNG;  
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
