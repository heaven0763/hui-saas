package com.chuangbang.wechat.hui.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.base.entity.user.ChatRecord;
import com.chuangbang.base.service.hotel.HotelService;
import com.chuangbang.base.service.user.ChatRecordService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.json.JsonUtils;
import com.chuangbang.framework.util.json.JsonVo;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

@Controller
@RequestMapping(value = "/weixin/message")
public class WxMessageController extends BaseController{
	
	@Autowired
	private ChatRecordService chatRecordService;
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		this.groupSetting(model);
		return "weixin/hui/messageList";
	}

	@RequestMapping("/list")
	@ResponseBody
	public JsonVo findAll(HttpServletRequest request,PageBean<ChatRecord> pageBean){
		Map<String, Object> filterParams = this.getSearchParams(request);
		this.setFilterParams(filterParams);
		pageBean.set_filterParams(filterParams);
		pageBean.setSort("state,createdAt");
		pageBean.setOrder("desc,desc");
		Page<ChatRecord> page = this.chatRecordService.getEntities(pageBean);
		return JsonUtils.success("",getDataGrid(pageBean,page.getContent()))  ;
	}
	
	
	private void setFilterParams(Map<String, Object> filterParams) {
		if("HUI".equals(AccountUtils.getCurrentUserType())){
			//filterParams.put("EQ_hotelId", 0);
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else if("HOTEL".equals(AccountUtils.getCurrentUserType())){
			/*if(AccountUtils.getCurrentUser().getGroup().getGroupId().startsWith("group")){
				String hotelIds = hotelService.findHotelIdsByPId(AccountUtils.getCurrentUser().getPhtlid());
				filterParams.put("OR_EQ;hotelId",hotelIds);
			}else{
				filterParams.put("EQ_hotelId", AccountUtils.getCurrentUserHotelId());
			}*/
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			//filterParams.put("EQ_companyId", AccountUtils.getCurrentUser().getCompanyId());
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}else{
			System.out.println(AccountUtils.getCurrentUser().toString());
			filterParams.put("OR_EQ;toUserID",AccountUtils.getCurrentUserId()+","+AccountUtils.getCurrentUser().getGroup().getGroupId()+",ALL");
		}
		
	}

	@RequestMapping("/detail/{id}")
	public String detail(HttpServletRequest request,Model model,@PathVariable("id") Long id){
		this.groupSetting(model);
		ChatRecord chatRecord = this.chatRecordService.getEntity(id);
		chatRecord.setState("0");
		this.chatRecordService.saveChatRecord(chatRecord);
		model.addAttribute("msg", chatRecord);
		return "weixin/hui/messageDetail";
	}
	
	
	@RequestMapping("/remind/count")
	@ResponseBody
	public JsonVo remindCount(HttpServletRequest request,Model model){
		Map<String, Object> filterParams = this.getSearchParams(request);
		this.setFilterParams(filterParams);
		filterParams.put("EQ_state", "1");
		filterParams.put("EQ_msgType", "SYSTEMMSG");
		List<ChatRecord> page = this.chatRecordService.getEntities(filterParams);
		return JsonUtils.success("num",page.size())  ;
	}
	
	
}
