package com.chuangbang.framework.util.file.pdf;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.xhtmlrenderer.pdf.ITextRenderer;

import com.chuangbang.framework.util.common.DateTimeUtils;
import com.itextpdf.text.Document;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.lowagie.text.DocumentException;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPageEvent;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
 
/**
 * PDF生成工具类
 * @author Goofy <a href="http://www.xdemo.org">http://www.xdemo.org</a>
 *
 */
public class PdfUtils {
 
    public static void main(String[] args) {
        try {
 
           /* Map<Object, Object> o=new HashMap<Object, Object>();
            //存入一个集合
            List<String> list = new ArrayList<String>();
            list.add("小明");
            list.add("张三");
            list.add("李四");
            list.add("老王");
            o.put("name", "http://www.xdemo.org/");
            o.put("nameList", list);
             
            String path=PdfHelper.getPath();
            System.out.println("path>>>>"+path);
            String tplPath = System.getProperty("user.dir") +"/src/main/webapp/static/pdf";
            System.out.println("tplPath>>>>"+tplPath.replace("\\", "/"));
            String html=PdfHelper.getPdfContent(tplPath, "tpl/tpl.ftl", o);
            generateToFile(tplPath, "tpl/tpl.ftl",tplPath+"img/", o, "D:\\xdemo5.pdf");
            
           MailInfo mailInfo = SimpleMailSender.getMailInfo("haiwen007@qq.com", "测试邮件", html);
           boolean bol = SimpleMailSender.sendAttachMail(mailInfo, "D:\\xdemo5.pdf");
           System.out.println(bol);  */
        	String pdFileName = "D:/order_"+new Date().getTime()+".pdf";
        	String url ="http://192.168.199.167:8081/hui/base/order/pdf/detail/114";
        	PdfUtils.convertHtmlToPdf(url,pdFileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
 
    }
     
    /**
     * 生成PDF到文件
     * @param ftlPath 模板文件路径（不含文件名）
     * @param ftlName 模板文件吗（不含路径）
     * @param imageDiskPath 图片的磁盘路径
     * @param data 数据
     * @param outputFile 目标文件（全路径名称）
     * @throws Exception
     */
    public static void generateToFile(String html,String imageDiskPath,String outputFile) throws Exception {
        OutputStream out = null;
        ITextRenderer render = null;
        System.out.println(outputFile.substring(0,outputFile.indexOf("order_")));
    	File dir = new File(outputFile.substring(0,outputFile.indexOf("order_")));
    	System.out.println("time1>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
    	if(!dir.exists()){
    		dir.mkdirs();
    	}
    	System.out.println("time2>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        out = new FileOutputStream(outputFile);
        System.out.println("time3>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        render = PdfHelper.getRender();
        render.setDocumentFromString(html);
        System.out.println("time4>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        if(imageDiskPath!=null&&!imageDiskPath.equals("")){
            //html中如果有图片，图片的路径则使用这里设置的路径的相对路径，这个是作为根路径
            render.getSharedContext().setBaseURL("file:/"+imageDiskPath);
        }
        render.layout();
        System.out.println("time5>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        render.createPDF(out,false,0);
        System.out.println("time6>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        render.finishPDF();
        System.out.println("time7>>>>>>>>>>>>>>>>>>>>>>"+DateTimeUtils.getCurrentTimeStamp());
        render = null;
        out.flush();
        out.close();
    }
    
    /**
     * 生成PDF到文件
     * @param ftlPath 模板文件路径（不含文件名）
     * @param ftlName 模板文件吗（不含路径）
     * @param imageDiskPath 图片的磁盘路径
     * @param data 数据
     * @param outputFile 目标文件（全路径名称）
     * @throws Exception
     */
    public static void generateToFile(String ftlPath,String ftlName,String imageDiskPath,Object data,String outputFile) throws Exception {
        String html=PdfHelper.getPdfContent(ftlPath, ftlName, data);
        OutputStream out = null;
        ITextRenderer render = null;
        out = new FileOutputStream(outputFile);
        render = PdfHelper.getRender();
        render.setDocumentFromString(html);
        if(imageDiskPath!=null&&!imageDiskPath.equals("")){
            //html中如果有图片，图片的路径则使用这里设置的路径的相对路径，这个是作为根路径
            render.getSharedContext().setBaseURL("file:/"+imageDiskPath);
        }
        render.layout();
        render.createPDF(out);
        render.finishPDF();
        //	render = null;
        out.close();
    }
     
    /**
     * 生成PDF到输出流中（ServletOutputStream用于下载PDF）
     * @param ftlPath ftl模板文件的路径（不含文件名）
     * @param ftlName ftl模板文件的名称（不含路径）
     * @param imageDiskPath 如果PDF中要求图片，那么需要传入图片所在位置的磁盘路径
     * @param data 输入到FTL中的数据
     * @param response HttpServletResponse
     * @return
     * @throws TemplateNotFoundException
     * @throws MalformedTemplateNameException
     * @throws ParseException
     * @throws IOException
     * @throws TemplateException
     * @throws DocumentException
     */
    public static OutputStream generateToServletOutputStream(String ftlPath,String ftlName,String imageDiskPath,Object data,HttpServletResponse response) throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException, TemplateException, DocumentException{
        String html=PdfHelper.getPdfContent(ftlPath, ftlName, data);
        OutputStream out = null;
        ITextRenderer render = null;
        out = response.getOutputStream();
        render = PdfHelper.getRender();
        render.setDocumentFromString(html);
        if(imageDiskPath!=null&&!imageDiskPath.equals("")){
            //html中如果有图片，图片的路径则使用这里设置的路径的相对路径，这个是作为根路径
            render.getSharedContext().setBaseURL("file:/"+imageDiskPath);
        }
        render.layout();
        render.createPDF(out);
        render.finishPDF();
        render = null;
        return out;
    }
    
    
    public static boolean convertHtmlToPdf(String inputFile, String outputFile) throws Exception {

        OutputStream os = new FileOutputStream(outputFile);     
        ITextRenderer renderer = new ITextRenderer();     
        String url = new File(inputFile).toURI().toURL().toString(); 

        renderer.setDocument(url);   

        // 解决中文支持问题     
        //ITextFontResolver fontResolver = renderer.getFontResolver();    
        renderer.getFontResolver().addFont("C:/Windows/Fonts/SIMSUN.TTC", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);     
        //解决图片的相对路径问题
        renderer.getSharedContext().setBaseURL("file:/D:/");
        renderer.layout();    
        renderer.createPDF(os);  

        os.flush();
        os.close();
        return true;
    }
    
}
