package com.chuangbang.app.web.${moduleName};

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.app.message.Message;
import com.chuangbang.app.message.MsgItem;
import com.chuangbang.base.entity.admin.Log;
import com.chuangbang.base.service.admin.LogService;
import com.chuangbang.framework.util.page.PageBean;
import com.chuangbang.framework.web.BaseController;

import ${packageName}.entity.${moduleName}.${ClassName};
import ${packageName}.service.${moduleName}.${ClassName}Service;
/**
 * ${functionName}Controller
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Controller
@RequestMapping("/api")
public class ${ClassName}APIController extends BaseController {
	private static final Logger LOGGER = LoggerFactory .getLogger(${ClassName}APIController.class);
	@Autowired
	private ${ClassName}Service ${className}Service;
	
	private Message message = new Message();


	@ModelAttribute("${className}")
	public ${ClassName} get${ClassName}(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return ${className}Service.getEntity(id);
		}
		return new ${ClassName}();
	}
	
	/**
	 * 创建${functionName}
	 * @param form
	 * @return
	 */
	@RequestMapping(value = "/auth/${className}/create", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> createForm(${ClassName} ${className}){
		try {
			${className}Service.save${ClassName}(${className});
		} catch (DataIntegrityViolationException e) {
			 message.setMsg("CREATE_ERROR", "创建${functionName}错误！");
		}
		message.setMsg("CREATE_SUCCESS", "创建${functionName}成功！");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 创建${functionName}
	 * @param form
	 * @return
	 */
	@RequestMapping(value = "/auth/${className}/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> updateForm(@PathVariable("id") Long id,${ClassName} ${className}){
		try {
			${className}Service.save${ClassName}(${className});
		} catch (DataIntegrityViolationException e) {
			 message.setMsg("CREATE_ERROR", "创建${functionName}错误！");
		}
		message.setMsg("CREATE_SUCCESS", "创建${functionName}成功！");
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}

	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@RequestMapping(value = "/auth/${className}/info/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> findBy${ClassName}Id(@PathVariable Long id) {
		${ClassName} ${className} = ${className}Service.getEntity(id);
		if (${className} == null) {
			message.setMsg("NOT_FOUND", "${functionName}不存在！");
			return new ResponseEntity<Message>(message, HttpStatus.NOT_FOUND);
		}
		message.setMsg("200", "Get ${className} info", ${className});
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	

	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/auth/${className}/pagelist", method = RequestMethod.GET)
	public ResponseEntity<Message> authPagelist(PageBean<${ClassName}> pageBean) {
		Page<${ClassName}> page =${className}Service.getEntities(pageBean);
		message.setMsg("200", "List ${ClassName}s", new MsgItem("page", page));
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/${className}/pagelist", method = RequestMethod.GET)
	public ResponseEntity<Message> pagelist(PageBean<${ClassName}> pageBean) {
		Page<${ClassName}> page =${className}Service.getEntities(pageBean);
		message.setMsg("200", "List ${ClassName}s", new MsgItem("page", page));
		return new ResponseEntity<Message>(message, HttpStatus.OK);

	}
	
	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/auth/${className}/list", method = RequestMethod.GET)
	public ResponseEntity<Message> ${className}list() {
		List<${ClassName}> page =${className}Service.getAllEntities();
		message.setMsg("200", "List ${ClassName}s", new MsgItem("${className}s", page));
		return new ResponseEntity<Message>(message, HttpStatus.OK);

	}
	
	
	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@RequestMapping(value = "/${className}/info/{id}", method = RequestMethod.GET)
	public ResponseEntity<?> findBy${ClassName}IdNoAuth(@PathVariable Long id) {
		${ClassName} ${className} = ${className}Service.getEntity(id);
		if (${className} == null) {
			message.setMsg("NOT_FOUND", "${functionName}不存在！");
			return new ResponseEntity<Message>(message, HttpStatus.NOT_FOUND);
		}
		message.setMsg("200", "Get ${className} info", ${className});
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
	
	/**
	 * 使用 ResponseEntity 返回自定义错误结果
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/${className}/list", method = RequestMethod.GET)
	public ResponseEntity<Message> ${className}listNoAuth() {
		List<${ClassName}> page =${className}Service.getAllEntities();
		message.setMsg("200", "List ${ClassName}s", new MsgItem("${className}s", page));
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
}
