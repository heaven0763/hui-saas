package com.chuangbang.js.web;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chuangbang.framework.constant.Constant;
import com.chuangbang.framework.web.BaseController;
import com.chuangbang.plugins.sms.entity.SmsRecord;
import com.chuangbang.plugins.sms.util.CallUtil;
@Controller
public class CodeController extends BaseController {
	private static final  int width = 75;//定义图片的width  
    private static final  int height = 40;//定义图片的height  
    private static final  int codeCount = 4;//定义图片上显示验证码的个数  
    private static final  int mocodeCount = 6;//定义图片上显示验证码的个数  
    private static final  int xx = 12;  
    private static final  int fontHeight = 30;  
    private static final  int codeY = 32;  
    public static final  String KEY_CAPTCHA  = "KEY_CAPTCHA";  
    public static final  String MO_KEY_CAPTCHA  = "MO_KEY_CAPTCHA"; 
    
    public static final  String MO_DRAW_KEY_CAPTCHA  = "MO_DRAW_KEY_CAPTCHA"; 
    public static final  String MO_DRAW_KEY_CAPTCHA_TIME  = "MO_DRAW_KEY_CAPTCHA_TIME"; 
    private static final char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',  
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',  
            'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }; 
    private static final char[] mocodeSequence = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }; 
  
    @RequestMapping("code")  
    public void getCode(HttpServletRequest req, HttpServletResponse resp)  
            throws IOException {  
       /* // 定义图像buffer  
        BufferedImage buffImg = new BufferedImage(width, height,  
                BufferedImage.TYPE_INT_RGB);  
    	//Graphics2D gd = buffImg.createGraphics();  
        //Graphics2D gd = (Graphics2D) buffImg.getGraphics();  
        Graphics gd = buffImg.getGraphics();  
        // 创建一个随机数生成器类  
        Random random = new Random();  
        // 将图像填充为白色  
        gd.setColor(Color.WHITE);  
        gd.fillRect(0, 0, width, height);  
        // 创建字体，字体的大小应该根据图片的高度来定。  
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);  
        // 设置字体。  
        gd.setFont(font);  
        // 画边框。  
        gd.setColor(new Color(72, 152, 205));  
        gd.drawRect(0, 0, width - 1, height - 1);  
        // 随机产生10条干扰线，使图象中的认证码不易被其它程序探测到。  
        gd.setColor(Color.BLACK);  
        for (int i = 0; i < 10; i++) {  
            int x = random.nextInt(width);  
            int y = random.nextInt(height);  
            int xl = random.nextInt(width);  
            int yl = random.nextInt(height);  
            gd.drawLine(x, y, x + xl, y + yl);  
        }  
        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。  
        StringBuffer randomCode = new StringBuffer();  
        int red = 0, green = 0, blue = 0;  
        // 随机产生codeCount数字的验证码。  
        for (int i = 0; i < codeCount; i++) {  
            // 得到随机产生的验证码数字。  
            String code = String.valueOf(codeSequence[random.nextInt(36)]);  
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。  
            red = random.nextInt(255);  
            green = random.nextInt(255);  
            blue = random.nextInt(255);  
            // 用随机产生的颜色将验证码绘制到图像中。  
            gd.setColor(new Color(red, green, blue));  
            gd.drawString(code, (i + 1) * xx, codeY);  
            //再在每个字上面画两条同样颜色的随机线
            gd.drawLine((i + 1) * xx, random.nextInt(codeY)%(codeY-3+1) + 3, (i + 2) * xx, random.nextInt(codeY)%(codeY-3+1) + 3); 	
            gd.drawLine((i + 1) * xx, random.nextInt(codeY)%(codeY-3+1) + 3, (i + 2) * xx, random.nextInt(codeY)%(codeY-3+1) + 3); 	
            // 将产生的四个随机数组合在一起。  
            randomCode.append(code);  
        }  
        // 将四位数字的验证码保存到Session中。  
        HttpSession session = req.getSession();  
        session.setAttribute(KEY_CAPTCHA, randomCode.toString());  
        // 禁止图像缓存。  
        resp.setHeader("Pragma", "no-cache");  
        resp.setHeader("Cache-Control", "no-cache");  
        resp.setDateHeader("Expires", 0);  
        resp.setContentType("image/jpeg");  
        // 将图像输出到Servlet输出流中。  
        ServletOutputStream sos = resp.getOutputStream();  
        ImageIO.write(buffImg, "jpeg", sos);  
        sos.close();  */
    	
    	
    	// 定义图像buffer  
        BufferedImage buffImg = new BufferedImage(156, 67,  
                BufferedImage.TYPE_INT_RGB);  
    	//Graphics2D gd = buffImg.createGraphics();  
        //Graphics2D gd = (Graphics2D) buffImg.getGraphics();  
        Graphics gd = buffImg.getGraphics();  
        // 创建一个随机数生成器类  
        Random random = new Random();  
        // 将图像填充为白色  
        gd.setColor(new Color(253,167,0));  
        gd.fillRect(0, 0, 156, 67);  
        // 创建字体，字体的大小应该根据图片的高度来定。  
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);  
        // 设置字体。  
        gd.setFont(font);  
        // 画边框。  
        //gd.setColor(new Color(72, 152, 205));  
        //gd.drawRect(0, 0, width - 1, height - 1);  
        // 随机产生10条干扰线，使图象中的认证码不易被其它程序探测到。  
       /* gd.setColor(Color.BLACK);  
        for (int i = 0; i < 10; i++) {  
            int x = random.nextInt(width);  
            int y = random.nextInt(height);  
            int xl = random.nextInt(width);  
            int yl = random.nextInt(height);  
            gd.drawLine(x, y, x + xl, y + yl);  
        }  */
        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。  
        StringBuffer randomCode = new StringBuffer();  
        int red = 0, green = 0, blue = 0;  
        // 随机产生codeCount数字的验证码。  
        
        gd.setColor(new Color(255, 255, 255));  
        for (int i = 0; i < codeCount; i++) {  
            // 得到随机产生的验证码数字。  
            String code = String.valueOf(codeSequence[random.nextInt(36)]);  
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。  
            red = random.nextInt(255);  
            green = random.nextInt(255);  
            blue = random.nextInt(255);  
            // 用随机产生的颜色将验证码绘制到图像中。  
            
            gd.drawString(code, (i + 1) * 28, 45);  
            //再在每个字上面画两条同样颜色的随机线
           /* gd.drawLine((i + 1) * xx, random.nextInt(codeY)%(codeY-3+1) + 3, (i + 2) * xx, random.nextInt(codeY)%(codeY-3+1) + 3); 	
            gd.drawLine((i + 1) * xx, random.nextInt(codeY)%(codeY-3+1) + 3, (i + 2) * xx, random.nextInt(codeY)%(codeY-3+1) + 3); 	*/
            // 将产生的四个随机数组合在一起。  
            randomCode.append(code);  
        }  
        // 将四位数字的验证码保存到Session中。  
        HttpSession session = req.getSession();  
        session.setAttribute(KEY_CAPTCHA, randomCode.toString());  
        // 禁止图像缓存。  
        resp.setHeader("Pragma", "no-cache");  
        resp.setHeader("Cache-Control", "no-cache");  
        resp.setDateHeader("Expires", 0);  
        resp.setContentType("image/jpeg");  
        // 将图像输出到Servlet输出流中。  
        ServletOutputStream sos = resp.getOutputStream();  
        ImageIO.write(buffImg, "jpeg", sos);  
        sos.close();  
    }  
    
    
    @RequestMapping("trip/mobile/mobilecode")  
    @ResponseBody
    public ModelAndView getMoCode(String phone,HttpServletRequest req, HttpServletResponse resp)  
            throws IOException {  
    	// 创建一个随机数生成器类  
        Random random = new Random();  
        StringBuffer randomCode = new StringBuffer();  
        // 随机产生mocodeCount数字的验证码。  
        for (int i = 0; i < mocodeCount; i++) {  
            // 得到随机产生的验证码数字。  
            String code = String.valueOf(mocodeSequence[random.nextInt(10)]);  
            
            randomCode.append(code);  
        }  
        // 将6位数字的验证码保存到Session中。  
        HttpSession session = req.getSession();  
        session.setAttribute(MO_KEY_CAPTCHA+"_"+phone, randomCode.toString()); 
        session.setAttribute(MO_KEY_CAPTCHA+"_TIME_"+phone, new Date().getTime());
        
       if(StringUtils.isBlank(phone) || phone.indexOf(",") != -1){
    	   return ajaxDoneSuccess("手机号码有误！");
       }
       String content = "【通天下】您好，您本次注册的验证码是：{CODE}。如非本人操作，请忽略此短信";
       content = content.replace("{CODE}", randomCode.toString());
       /*if(CallUtil.sendmsg(content, phone).contains(phone+"#@#0#@#")){
    	   return ajaxDoneSuccess("手机验证码发送成功！");
       }*/
       
       return ajaxDoneError("手机验证码发送失败！");
    } 
    
    
    @RequestMapping("/anon/mobile/mobiledrawcode")  
    @ResponseBody
    public ModelAndView getMoDrawCode(String phone,HttpServletRequest req, HttpServletResponse resp) {  
    	if(StringUtils.isBlank(phone) || phone.indexOf(",") != -1){
    		return ajaxDoneSuccess("手机号码有误！");
    	}
    	// 创建一个随机数生成器类  
    	Random random = new Random();  
    	StringBuffer randomCode = new StringBuffer();  
    	// 随机产生mocodeCount数字的验证码。  
    	for (int i = 0; i < mocodeCount; i++) {  
    		// 得到随机产生的验证码数字。  
    		String code = String.valueOf(mocodeSequence[random.nextInt(10)]);  
    		randomCode.append(code);  
    	}  
    	// 将6位数字的验证码保存到Session中。  
    	HttpSession session = req.getSession();  
    	session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA+"_"+phone, randomCode.toString()); 
    	session.setAttribute(Constant.MO_DRAW_KEY_CAPTCHA_TIME+"_"+phone, new Date().getTime());

    	String content = "您的验证码为{CODE}；十分钟内有效!";//【会掌柜】
    	content = content.replace("{CODE}", randomCode.toString());
    	String returnSms = CallUtil.sendmsg(content, phone);
    	if(null!=returnSms&&"SUCCESS".equals(returnSms)){
    		//smsRecordService.saveSmsRecord(new SmsRecord(phone, "验证码", content, "", "PHONE_CAPTCHA", "", "", new Date()));
    		return ajaxDoneSuccess("手机验证码发送成功！");
    	}

    	return  ajaxDoneError("手机验证码发送失败！");
    } 
}
