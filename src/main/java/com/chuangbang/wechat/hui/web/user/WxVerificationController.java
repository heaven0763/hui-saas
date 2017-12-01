package com.chuangbang.wechat.hui.web.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.entity.hotel.Hotel;
import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.service.hotel.HotelGroupService;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.base.service.user.CompanyService;
import com.chuangbang.framework.util.CipherUtil;
import com.chuangbang.framework.util.easyui.Json;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.js.entity.account.Group;
import com.chuangbang.js.entity.account.User;
import com.chuangbang.js.service.account.GroupService;
import com.chuangbang.js.service.account.UserService;

import jodd.util.StringUtil;

@Controller
public class WxVerificationController  extends BaseController {
	
	@Autowired
	private HotelService hotelService;
	@Autowired
	private GroupService groupService;
	@Autowired
	private UserService userService;
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelGroupService hotelGroupService;
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping(value = "/confirm/verification/email/{time}", method = RequestMethod.GET)
	public String verificationEmail(Model model,HttpServletRequest request,@PathVariable("time")Long time,String p1,String p2,String p3,String p4,String p5,String p6) {
		System.out.println("time>>>"+time);
		String userId = CipherUtil.decrypt(p3);
		Long gid = Long.valueOf(CipherUtil.decrypt(p2));
		ChatRecord chatRecord = this.chatRecordService.findByMsgTypeAndItemIdAndToUserID("USERINVITATION",CipherUtil.decrypt(p5),userId);
		if(chatRecord.getState().equals("1")){
			model.addAttribute("error",true);
			model.addAttribute("msg","已确认");
			return "/verification/confirm";
		}
		Long  crttime = new Date().getTime();
		if((crttime-time)>48*60*60*1000){//验证链接有效期两天
			model.addAttribute("error",true);
			model.addAttribute("msg","链接已失效，请重新获取");
			return "/verification/confirm";
		}
		
		User user = this.userService.getEntity(userId);
		String hotelId = StringUtil.isNotBlank(p4)?CipherUtil.decrypt(p4):"";
		if(user!=null){
			if(StringUtil.isNotBlank(hotelId)){
				if(user.getUserType().equals("HOTEL")&&user.getHotelId().equals(hotelId)&&user.getGroupId().equals(gid)){
					model.addAttribute("error",true);
					model.addAttribute("msg","已确认");
					chatRecord.setState("1");
					chatRecordService.saveChatRecord(chatRecord);
					return "/verification/confirm";
				}else if(user.getUserType().equals("HOTEL")&&user.getPhtlid().equals(hotelId)&&user.getGroupId().equals(gid)){
					model.addAttribute("error",true);
					model.addAttribute("msg","已确认");
					chatRecord.setState("1");
					chatRecordService.saveChatRecord(chatRecord);
					return "/verification/confirm";
				}else if(user.getUserType().equalsIgnoreCase("PARTNER")&&user.getCompanyId().equals(hotelId)&&user.getGroupId().equals(gid)){
					model.addAttribute("error",true);
					model.addAttribute("msg","已确认");
					chatRecord.setState("1");
					chatRecordService.saveChatRecord(chatRecord);
					return "/verification/confirm";
				}
			}else{
				if(user.getUserType().equals("HUI")&&user.getGroupId().equals(gid)){
					model.addAttribute("error",true);
					model.addAttribute("msg","已确认");
					chatRecord.setState("1");
					chatRecordService.saveChatRecord(chatRecord);
					return "/verification/confirm";
				}
			}
		}else{
			model.addAttribute("error",true);
			model.addAttribute("msg","链接已失效，请重新获取");
			return "/verification/confirm";
		}
		System.out.println("p1>>>"+CipherUtil.decrypt(p1));
		System.out.println("p2>>>"+CipherUtil.decrypt(p2));
		System.out.println("p3>>>"+CipherUtil.decrypt(p3));
		System.out.println("p4>>>"+CipherUtil.decrypt(p4));
		System.out.println("p5>>>"+CipherUtil.decrypt(p5));
		String type= CipherUtil.decrypt(p6);
		model.addAttribute("type",type);
		if(StringUtil.isNotBlank(p4)){
			model.addAttribute("hotelId",p4);
			if(type.equals("GROUP")){
				model.addAttribute("hgroup",hotelGroupService.getEntity(Long.valueOf(CipherUtil.decrypt(p4))));
			}else if(type.equals("PARTNER")){
				model.addAttribute("hgroup",companyService.getEntity(Long.valueOf(CipherUtil.decrypt(p4))));
			}else{
				model.addAttribute("hotel",hotelService.getEntity(Long.valueOf(CipherUtil.decrypt(p4))));
			}
		}
		if(StringUtil.isNotBlank(p2)){
			model.addAttribute("gid",p2);
			model.addAttribute("group",groupService.getEntity(Long.valueOf(CipherUtil.decrypt(p2))));
		}
		model.addAttribute("tName",CipherUtil.decrypt(p1));
		model.addAttribute("userId",p3);
		model.addAttribute("userName",user.getRname());
		model.addAttribute("time",time);
		model.addAttribute("invitationCode",p5);
		return "/verification/confirm";
	}
	
	
	@RequestMapping(value = "/confirm/verification/complete", method = RequestMethod.POST)
	@ResponseBody
	public Json complete(Model model,HttpServletRequest request,Long time,String userId,String gid,String hotelId,String invitationCode,String type) {
		Json json = new Json();
		Long  crttime = new Date().getTime();
		if((crttime-time)>48*60*60*1000){//验证链接有效期两天
			json.setJson(false, "链接已失效，请重新获取！");
			return json;
		}
		System.out.println("time>>>"+time);
		//System.out.println("p1>>>"+CipherUtil.decrypt(p1));
		userId = CipherUtil.decrypt(userId);
		gid = CipherUtil.decrypt(gid);
		hotelId = StringUtil.isNotBlank(hotelId)?CipherUtil.decrypt(hotelId):"";
		
		System.out.println("before>>>>>>>>");
		json = this.userService.verificationComplete(userId,gid,hotelId,type);
		System.out.println("after>>>>>>>>");
		try{
			if(json.isSuccess()){
				User user = this.userService.getEntity(userId);
				String hotelName = "";
				if(StringUtil.isNotBlank(hotelId)&&"HOTEL".equals(type)){
					hotelName=this.hotelService.getEntity(Long.valueOf(hotelId)).getHotelName();
				}else if(StringUtil.isNotBlank(hotelId)&&"GROUP".equals(type)){
					hotelName=this.hotelGroupService.getEntity(Long.valueOf(hotelId)).getName();
				}else if(StringUtil.isNotBlank(hotelId)&&"PARTNER".equalsIgnoreCase(type)){
					hotelName=this.companyService.getEntity(Long.valueOf(hotelId)).getCompanyName();
				}else{
					hotelId = "0";
					hotelName="会掌柜";
				}
				System.out.println("dddd>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+CipherUtil.decrypt(invitationCode));
				Group group = this.groupService.getEntity(Long.valueOf(gid));
				ChatRecord chatRecord = this.chatRecordService.findByMsgTypeAndItemIdAndToUserID("USERINVITATION",CipherUtil.decrypt(invitationCode),userId);
				chatRecord.setState("1");
				chatRecordService.saveChatRecord(chatRecord);
				chatRecordService.log("GROUPVERIFICATION", "确认角色邀请操作", user.getRname()+"接受角色"+group.getName()+"操作！", Long.valueOf(hotelId), hotelName, "", "", "");
			}
		}catch(Exception e){
		}
		
		return json;
	}
}
