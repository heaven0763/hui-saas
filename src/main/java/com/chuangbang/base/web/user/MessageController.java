package com.chuangbang.base.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.chuangbang.base.entity.user.Message;
import com.chuangbang.base.service.user.MessageService;
import com.chuangbang.framework.util.account.AccountUtils;
import com.chuangbang.framework.util.easyui.DataGrid;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

/**
 * 留言Controller
 * @author mabelxiao	
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "base/uesr/message")
public class MessageController extends BaseController {

	@Autowired
	private MessageService messageService;
	
	@ModelAttribute("message")
	public Message getMessage(@RequestParam(value = "id", required = false) Long id) {
		if (null!=id) {
			return messageService.getEntity(id);
		}
		return new Message();
	}
	
	@RequestMapping(value = "index")
	public String index(Model model) {
		return "user/messageList";
	}
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		return "user/messageForm";
	}
	
	@RequestMapping(value = "save")
	public ModelAndView save(Message message) {
		messageService.saveMessage(message);
		return  ajaxDoneSuccess("操作成功！", "closeCurrent", "refreshDatagrid");
	}
	
	@RequestMapping(value ="list")
	@ResponseBody
	public DataGrid list(PageBean<Message> pageBean,HttpServletRequest request) {
		Map<String, Object> searchParams = this.getSearchParams(request);
		
		if(AccountUtils.getHotelUserType().equals("HOTEL")){
			searchParams.put("EQ_h.id", AccountUtils.getCurrentUserHotelId());
		}else if(AccountUtils.getHotelUserType().equals("GROUP")){
			searchParams.put("EQ_h.pid", AccountUtils.getCurrentUserhotelPId());
		}else if(AccountUtils.getCurrentUserType().equals("HUI")){
			
		}else if("PARTNER".equals(AccountUtils.getCurrentUserType().toUpperCase())){
			searchParams.put("EQ_h.company_id", AccountUtils.getCurrentUserCompanyId());
		}else{
			
		}
		pageBean.set_filterParams(searchParams);
		List<Message> page = messageService.getPageMessageList(pageBean);
		return getDataGrid(pageBean, page);
	}
	
	@RequestMapping(value = "update/{id}")
	public ModelAndView update(@PathVariable("id") Long id, Model model) {
		Message message = messageService.getOneMessage(id);
		model.addAttribute("message", message);
		return new ModelAndView("user/messageForm");
	}
	@RequestMapping(value = "detail/{id}")
	public ModelAndView detail(@PathVariable("id") Long id, Model model) {
		Message message = messageService.getOneMessage(id);
		model.addAttribute("msg", message);
		return new ModelAndView("user/messageDetail");
	}
	@RequestMapping(value = "delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id) {
		messageService.delete(id);
		return ajaxDoneSuccess("操作成功！");
	}
	
}
