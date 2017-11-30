package com.chuangbang.framework.util.xml;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StringXMLTransformer  {
	
	private static final String	DICT_KEY			= "DICTXML";

	
	public void transformToxml(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		String dicts = (String)model.get(DICT_KEY);
		
		response.getWriter().print(dicts);
	}

}
