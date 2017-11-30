package com.chuangbang.wechat.hui.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import org.springside.modules.mapper.JsonMapper;

import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.framework.util.BrowseTool;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.Menu;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.MenuService;
import com.chuangbang.js.service.account.UserService;
import com.chuangbang.wechat.hui.service.user.WxUserService;

@Controller
@RequestMapping(value = "/weixin/user/invitation")
public class WxStaffInvitationController extends BaseController{

	private static JsonMapper mapper = JsonMapper.nonDefaultMapper();
	
	@Autowired
	private UserService userService;
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private WxUserService wxUserService;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private MenuService menuService;
	@ModelAttribute("mdattribute")
	public User getUser(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return userService.getEntity(id);
		}
		return new User();
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model,String memberType,String crtusrty){
		String ua = request.getHeader("User-Agent");
		System.out.println(ua);
		if(BrowseTool.isWeixin(request.getHeader("User-Agent"))){
			return "weixin/user/staffInvitationIndex";
		}else{
			List<Menu> menus = this.menuService.getSysAuthRootMenus(90L);
			model.addAttribute("menus",menus);
			model.addAttribute("crtusrty",crtusrty);
			return "user/invitationList";
		}
	}
	
	@RequestMapping("/create")
	public String create(HttpServletRequest request,Model model,String memberType,String crtusrty){
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getHotelUserType())){
			filterParams.put("EQ_pid", "11");
			model.addAttribute("type", "HUI");
			
		}else if("HOTEL".equals(AccountUtils.getHotelUserType())){
			filterParams.put("EQ_pid", "12");
			filterParams.put("LLIKE_groupId", "hotel");
			model.addAttribute("hotelId", AccountUtils.getCurrentUserHotelId());
			model.addAttribute("type", "HOTEL");
		}else if("GROUP".equals(AccountUtils.getHotelUserType())){
			filterParams.put("EQ_pid", "12");
			filterParams.put("LLIKE_groupId", "group");
			model.addAttribute("hgId",  AccountUtils.getCurrentUserhotelPId());
			model.addAttribute("type", "GROUP");
		}
		List<Group> page = groupService.getEntities(filterParams);
		model.addAttribute("groups", page);
		if(StringUtils.isNotBlank(crtusrty)){
			return "user/staffInvitationSiteForm";
		}else{
			return "user/staffInvitationForm";
		}
	}
	@RequestMapping("/hotel/admin/{hotelId}")
	public String invitationAdmin(@PathVariable("hotelId")Long hotelId,HttpServletRequest request,Model model,String memberType){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_pid", "12");
		filterParams.put("LLIKE_groupId", "hotel");
		List<Group> groups = groupService.getEntities(filterParams);
		model.addAttribute("groups", groups);
		model.addAttribute("hotelId", hotelId);
		model.addAttribute("flag", "HUI");
		return "user/staffInvitationForm";
	}
	
	@RequestMapping("/hg/admin/{hgId}")
	public String invitationHgAdmin(@PathVariable("hgId")Long hgId,HttpServletRequest request,Model model,String memberType){
		Map<String, Object> filterParams = this.getSearchParams(request);
		filterParams.put("EQ_pid", "12");
		filterParams.put("LLIKE_groupId", "group");
		List<Group> groups = groupService.getEntities(filterParams);
		model.addAttribute("groups", groups);
		model.addAttribute("hgId", hgId);
		model.addAttribute("flag", "HUI");
		model.addAttribute("type", "GROUP");
		return "user/staffInvitationForm";
	}
	@RequestMapping("/rd/list")
	@ResponseBody
	public DataGrid rdlist(PageBean<ChatRecord> pageBean,HttpServletRequest request,Model model,String crtusrty ){
		Map<String, Object> filterParams = this.getSearchParams(request);
		System.out.println(">>>>"+AccountUtils.getCurrentUserType());
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			if(StringUtils.isNotBlank(crtusrty)){
				//filterParams.put("EQ_hotelId", 0);
				filterParams.put("NE_itemType", "HUI");
				filterParams.put("EQ_formUserID", AccountUtils.getCurrentUserId());
			}else{
				filterParams.put("EQ_hotelId", 0);
				filterParams.put("EQ_itemType", "HUI");
			}
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
				filterParams.put("EQ_itemType", "HOTEL");
			}else{
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserhotelPId());
				filterParams.put("EQ_itemType", "GROUP");
			}
		}
		pageBean.set_filterParams(filterParams);
		pageBean.setOrder("desc");
		Page<ChatRecord> page = chatRecordService.getEntities(pageBean);
		return getDataGrid(pageBean,page.getContent());
	}
	@RequestMapping("/list")
	@ResponseBody
	public JsonVo list(PageBean<Group> pageBean,HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_pid", "11");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			filterParams.put("EQ_pid", "12");
			if(AccountUtils.getCurrentUserGroupId().startsWith("hotel")){
				filterParams.put("LLIKE_groupId", "hotel");
			}
		}
		pageBean.set_filterParams(filterParams);
		Page<Group> page = groupService.getEntities(pageBean);
		return JsonUtils.success("ok",getDataGrid(page.getContent()));
	}
	
	@RequestMapping("/users/{gid}")
	public String users(@PathVariable("gid") Long gid,HttpServletRequest request,Model model,String memberType){
		model.addAttribute("gid",gid);
		return "weixin/user/staffInvitationUsersIndex";
	}
	
	@RequestMapping("/users/list")
	@ResponseBody
	public JsonVo usersList(PageBean pageBean,HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		List<User> page = userService.getEntities(filterParams,new Sort(Direction.ASC, "zimu"));
		return JsonUtils.success("ok",getDataGrid(page));
	}
	
	@RequestMapping("/send")
	@ResponseBody
	public JsonVo send(HttpServletRequest request,String userIds,Long gid,Long hotelId,String flag,Long hgId,String type){
		System.out.println(">>>>>>>>>>>"+gid);
		System.out.println(">>>>>>>>>>>"+userIds);
		return wxUserService.invitationSend(userIds,gid,hotelId,flag,hgId,type);
	}

	
}
