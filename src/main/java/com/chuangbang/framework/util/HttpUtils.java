package com.chuangbang.framework.util;

import java.io.BufferedReader;  
import java.io.ByteArrayOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.InputStreamReader;  
import java.io.PrintWriter;  
import java.net.HttpURLConnection;  
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;

import com.alibaba.fastjson.JSONObject;

//Http请求的工具类  
public class HttpUtils{  
  
    private static final int TIMEOUT_IN_MILLIONS = 30000;  
  
    public interface CallBack  
    {  
        void onRequestComplete(String result);  
    }  
  
    /** 
     * 异步的Get请求 
     *  
     * @param urlStr 
     * @param callBack 
     */  
    public static void doGetAsyn(final String urlStr, final CallBack callBack)  
    {  
        new Thread()  
        {  
            public void run()  
            {  
                try  
                {  
                    String result = doGet(urlStr);  
                    if (callBack != null)  
                    {  
                        callBack.onRequestComplete(result);  
                    }  
                } catch (Exception e)  
                {  
                    e.printStackTrace();  
                }  
  
            };  
        }.start();  
    }  
  
    /** 
     * 异步的Post请求 
     * @param urlStr 
     * @param params 
     * @param callBack 
     * @throws Exception 
     */  
    public static void doPostAsyn(final String urlStr, final String params,  
            final CallBack callBack) throws Exception  
    {  
        new Thread()  
        {  
            public void run()  
            {  
                try  
                {  
                    String result = doPost(urlStr, params);  
                    if (callBack != null)  
                    {  
                        callBack.onRequestComplete(result);  
                    }  
                } catch (Exception e)  
                {  
                    e.printStackTrace();  
                }  
  
            };  
        }.start();  
  
    }  
  
    /** 
     * Get请求，获得返回数据 
     *  
     * @param urlStr 
     * @return 
     * @throws Exception 
     */  
    public static String doGet(String urlStr)   
    {  
    	System.out.println("urlStr>>>>"+urlStr);
        URL url = null;  
        HttpURLConnection conn = null;  
        InputStream is = null;  
        ByteArrayOutputStream baos = null;  
        try  
        {  
            url = new URL(urlStr.trim());  
            conn = (HttpURLConnection) url.openConnection();  
            conn.setReadTimeout(TIMEOUT_IN_MILLIONS);  
            conn.setConnectTimeout(TIMEOUT_IN_MILLIONS);  
            conn.setRequestMethod("GET");  
            conn.setRequestProperty("accept", "*/*");  
            conn.setRequestProperty("connection", "Keep-Alive");  
            conn.setRequestProperty("Accept-Charset", "utf-8");
            conn.setRequestProperty("contentType", "utf-8");
            conn.setRequestProperty("charset", "utf-8"); 
            /*if (conn.getResponseCode() == 200)  
            {*/  
                is = conn.getInputStream();  
                BufferedReader br = new BufferedReader(new InputStreamReader(is,"utf-8"));  
                StringBuffer resultBuffer = new StringBuffer();  
                String tempLine = null;  
                while ((tempLine = br.readLine()) != null) {  
                    resultBuffer.append(tempLine);  
                }   
                return resultBuffer.toString();
            /*} else  
            {  
                throw new RuntimeException(" responseCode is not 200 ... ");  
            }*/  
  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally{  
        	try{  
        		if (is != null)  
        			is.close();  
        	}catch (IOException e){  
        	}  
        	try{  
        		if (baos != null)  
        			baos.close();  
        	} catch (IOException e){  
        	}
        	conn.disconnect();  
        }  
          
        return null ;  
  
    }  
  
    /**  
     * 向指定 URL 发送POST方法的请求  
     *   
     * @param url  
     *            发送请求的 URL  
     * @param param  
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。  
     * @return 所代表远程资源的响应结果  
     * @throws Exception  
     */  
    public static String doPost(String url, String param)   
    {  
        PrintWriter out = null;  
        BufferedReader in = null;  
        String result = "";  
        try  
        {  
            URL realUrl = new URL(url);  
            // 打开和URL之间的连接  
            HttpURLConnection conn = (HttpURLConnection) realUrl  
                    .openConnection();  
            // 设置通用的请求属性  
            conn.setRequestProperty("accept", "*/*");  
            conn.setRequestProperty("connection", "Keep-Alive");  
            conn.setRequestMethod("POST");  
            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");  
            conn.setRequestProperty("charset", "utf-8");  
            conn.setUseCaches(false);  
            // 发送POST请求必须设置如下两行  
            conn.setDoOutput(true);  
            conn.setDoInput(true);  
            conn.setConnectTimeout(TIMEOUT_IN_MILLIONS);  
            conn.setReadTimeout(TIMEOUT_IN_MILLIONS);  
  
            if (param != null && !param.trim().equals(""))  
            {  
                // 获取URLConnection对象对应的输出流  
                out = new PrintWriter(conn.getOutputStream());  
                // 发送请求参数  
                out.print(param);  
                // flush输出流的缓冲  
                out.flush();  
            }  
            // 定义BufferedReader输入流来读取URL的响应  
            in = new BufferedReader(  
                    new InputStreamReader(conn.getInputStream(),"utf-8"));  
            String line;  
            while ((line = in.readLine()) != null)  
            {  
                result += line;  
            }  
        } catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
        // 使用finally块来关闭输出流、输入流  
        finally  
        {  
            try  
            {  
                if (out != null)  
                {  
                    out.close();  
                }  
                if (in != null)  
                {  
                    in.close();  
                }  
            } catch (IOException ex)  
            {  
                ex.printStackTrace();  
            }  
        }  
        return result;  
    }  
    
    public static String getDWZ(String url){
    	String param = "url="+url+"&alias=&access_type=web";
    	String res = HttpUtils.doPost("http://dwz.cn/create.php", param);
    	System.out.println(res);
    	JSONObject jsonObject = JSONObject.parseObject(res);
    	if(jsonObject!=null&&jsonObject.getString("status").equals("0")){
    		System.out.println("status>>>>>>>>>>>>>"+jsonObject.getString("status"));
    		System.out.println("tinyurl>>>>>>>>>>>>>"+jsonObject.getString("tinyurl"));
    		return jsonObject.getString("tinyurl");
    	}else{
    		return "";
    	}
    }
    //&url==&site=sina
    public static String getBbestDWZ(String url){
    	String param = "l="+url;
    	String res = HttpUtils.doPost("http://a.bbest.me/short/create",param);
    	System.out.println(res);
    	JSONObject jsonObject = JSONObject.parseObject(res);
    	if(jsonObject!=null){
    		return "http://bbest.me/"+jsonObject.getString("short_url");
    	}else{
    		return "";
    	}
    }
    
    public static String getC7ggDWZ(String url){
    	url = "http://suo.im/api.php?url="+URLEncoder.encode(url);
    	String res = HttpUtils.doGet(url);
    	System.out.println(res);
    	return res;
    }
    public static void main(String[] args) {
    	
    	getC7ggDWZ("http://saas.hui-china.com/hui/confirm/verification/email/1510903666370?p1=-c5d82bf789ef44e33f9c&p2=c5c36892909e37fa5fcd&p3=30373438623636332d666531322d346363622d613735382d3036f6f45da3a0ac029c67cd&p4=&p5=3135313039303336363633f2f331d5eacb51cd1588");
    	//System.out.println(">>>"+doGet("http://t.im/?url=http%3A%2F%2Fsaas.hui-china.com%2Fhui%2Fconfirm%2Fverification%2Femail%2F1510903666370%3Fp1%3D-c5d82bf789ef44e33f9c%26p2%3Dc5c36892909e37fa5fcd%26p3%3D30373438623636332d666531322d346363622d613735382d3036f6f45da3a0ac029c67cd%26p4%3D%26p5%3D3135313039303336363633f2f331d5eacb51cd1588&keyword=&title="));
	}
    
    
    
   
}  
