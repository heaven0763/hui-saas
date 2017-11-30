

package com.chuangbang.js.web.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chuangbang.js.entity.account.Logininfo;
import com.chuangbang.js.service.account.LogininfoService;


@Controller
@RequestMapping(value = "/account/logininfo")
public class LogininfoController {
	@Autowired
	private LogininfoService logininfoService;
	
	@RequestMapping(value = "create")
	public String createForm(Model model) {
		model.addAttribute("logininfo", new Logininfo());
		return "account/logininfoForm";
	}
	
	@RequestMapping(value = "save")
	public String save(Logininfo logininfo, RedirectAttributes redirectAttributes) {
		logininfoService.saveLogininfo(logininfo);
		redirectAttributes.addFlashAttribute("message", " add successful ");
		return "redirect:/account/logininfo/";
	}
	
	@RequestMapping(value = "list")
	public String list(Model model) {
		//List<Logininfo> logininfos = logininfoService.getAllLogininfo();
		//model.addAttribute("logininfos", logininfos);
		return "account/logininfoList";
	}


	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		logininfoService.deleteLogininfo(id);
		redirectAttributes.addFlashAttribute("message", " delete successful ");
		return "redirect:/account/logininfo/";
	}
	
	@RequestMapping(value = "update/{id}")
	public String updateForm(@PathVariable("id") Long id,Model model) {
		model.addAttribute("logininfo", logininfoService.getLogininfo(id));
		return "account/logininfoForm";
	}
}

