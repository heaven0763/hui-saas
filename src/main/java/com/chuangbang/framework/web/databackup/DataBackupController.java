package com.chuangbang.framework.web.databackup;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.service.system.SystemParameterService;
import com.chuangbang.framework.util.db.DbBackup;


@Controller
@RequestMapping(value = "/data/databackup")
public class DataBackupController {

	
	@Autowired
	private SystemParameterService systemParameterService;
	
	@RequestMapping(value = "/init", method = RequestMethod.GET)
	public String dataBackupGet() {
		return "data/dataBackupForm";
	}
	
	@RequestMapping(value = "/backup", method = RequestMethod.POST)
	public String dataBackupPost(Model model) {
		
		String date = new Date().toLocaleString();
    	date = date.substring(0,date.indexOf(" "));
    	String filename = date+"("+new Date().getTime()+")";
    	
    	String connString = systemParameterService.getValueByCode("databackupconn");
    	
    	String fileDir = systemParameterService.getValueByCode("databackupdir");
		
    	boolean rs = DbBackup.exp(connString, fileDir+"\\"+filename);
    	
		model.addAttribute("successmessage", rs);
		model.addAttribute("expfilename", filename);
		return "data/dataBackupForm";
	}
	
	//下载
	@RequestMapping("/download/{filename}")
	public ModelAndView download(@PathVariable("filename")
	String filename, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;

		
		String fileDir = systemParameterService.getValueByCode("databackupdir");
		filename += ".dmp";
		String downLoadPath = fileDir +"\\"+ filename;
		
		try {
			long fileLength = new File(downLoadPath).length();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(URLEncoder.encode(filename,"UTF-8")));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
		return null;
	}
}
