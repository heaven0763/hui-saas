package com.chuangbang.app.api;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chuangbang.app.message.Message;
import com.chuangbang.framework.web.BaseController;

@Controller
@RequestMapping(value = "/app")
public class ErrorController extends BaseController {
	private Message message = new Message();
	
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	@ResponseBody
	public  ResponseEntity<Message> error(HttpServletRequest request,HttpServletResponse response,String key,String errorCode,String errorMsg) throws MalformedURLException, UnsupportedEncodingException {
		System.out.println(errorCode+"  "+errorMsg);
		errorMsg = new String(errorMsg.getBytes("ISO-8859-1"), "UTF-8");
		message.setMsg(errorCode, errorMsg);
		return new ResponseEntity<Message>(message, HttpStatus.OK);
	}
}
