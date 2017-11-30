package com.chuangbang.framework.util.xml;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;


public class XMLView  extends AbstractView {
	

	public static final String	DEFAULT_CONTENT_TYPE	= "application/xml;charset=UTF-8";
	
	private StringXMLTransformer	stringXMLTransformer;

	public XMLView() {

		setContentType(DEFAULT_CONTENT_TYPE);
		
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		response.setContentType(getContentType());
		stringXMLTransformer = new StringXMLTransformer();
		stringXMLTransformer.transformToxml(model, request, response);
	}

	
	
}
