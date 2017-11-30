package com.chuangbang.app.filter;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.chuangbang.app.service.SaasAPIService;
import com.google.common.collect.Maps;
public class ApiUrlFilter implements Filter {

	private SaasAPIService saasAPIService;
	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse) res;
		String deparams = URLDecoder.decode(request.getParameter("params"));
		Map<String, Object> result = Maps.newHashMap();
		result = saasAPIService.isApplication(deparams);
		if(!result.get("error_code").toString().equals("200")){
			response.sendRedirect("/hui/app/error?errorCode="+result.get("error_code")+"&errorMsg="+result.get("error_msg"));
			return;
		}
		
		chain.doFilter(request, response);
	}

	 @Override  
	    public void init(FilterConfig config) throws ServletException {  
	  
	        ServletContext context = config.getServletContext();  
	        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(context);  
	        saasAPIService = (SaasAPIService) ctx.getBean("saasAPIService");
	          
	    }  

}
