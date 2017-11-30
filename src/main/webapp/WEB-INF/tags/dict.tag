<%@tag pageEncoding="UTF-8"%>

<%-- 字典类型 --%>
<%@ attribute name="kind" type="java.lang.String" required="false"%>
<%-- 字典supercode,有kind的情况下使用 --%>
<%@ attribute name="supercode" type="java.lang.String" required="false"%>
<%-- 选取字典的sql，如果kind为空，则sql起作用 --%>
<%@ attribute name="sql" type="java.lang.String" required="false"%>
<%@ attribute name="ruleDetailList" type="java.util.List" required="false"%>
<%-- 选中的选项 --%>
<%@ attribute name="selectedValue" type="java.lang.String" required="false"%>
<%-- 是否显示【请选择...】选项，默认为是 --%>
<%@ attribute name="showPleaseSelect" type="java.lang.Boolean" required="false"%>
<%-- 在字典前加入的选项，格式为字符串,用","和";"分割，如"01,沙湾镇;02,石楼镇" --%>
<%@ attribute name="addBefore" type="java.lang.String" required="false"%>
<%-- 需要过滤的字典选项,格式为字符串,用";"分割--%>
<%@ attribute name="exclude" type="java.lang.String" required="false"%>
<%-- 在字典后加入的选项,格式为字符串,用","和";"分割，如"40,计划生育家庭特别扶助金"--%>
<%@ attribute name="addAfter" type="java.lang.String" required="false"%>
<%-- 地址标签--%>
<%@ attribute name="address" type="java.lang.String" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	//获取字典的服务实例
	com.chuangbang.framework.service.dictionary.DictionaryService dictSer = 
	(com.chuangbang.framework.service.dictionary.DictionaryService)org.springframework.web.context.support.WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext()).getBean("dictionaryService");
	String excludes[] = {};
	if( showPleaseSelect == null || showPleaseSelect == true){
%>
		<option value="" >请选择...</option>
<% 
	}
	if(addBefore != null && !"".equals(addBefore)){
		String[] strings = addBefore.split(";");
		for(String ab:strings){
			String[] abs = ab.split(",");
			if(abs.length != 2){
				throw new RuntimeException("加在字典前的参数传入错误！");
			}
%>
			<option value="<%=abs[0] %>" <%=abs[0].equals(selectedValue)?"selected='selected'":"" %>><%=abs[1] %></option>
<% 
		}
	}
	if(kind != null && !"".equals(kind)){
		java.util.List<com.chuangbang.framework.entity.dictionary.Dictionary> dicts = null;
		if(supercode != null && !"".equals(supercode)){
			//dicts = dictSer.findByKindAndSupercode(kind, supercode);
		}else{
			//dicts = dictSer.findByKind(kind);
			java.lang.System.out.println("dicts size:"+dicts.size());
			}
		if(exclude!=null){
			excludes = exclude.split(";");
		}
		java.util.List<com.chuangbang.framework.entity.dictionary.Dictionary> excludeList = new java.util.ArrayList<com.chuangbang.framework.entity.dictionary.Dictionary>();
		for(com.chuangbang.framework.entity.dictionary.Dictionary dict:dicts){
			for(int i=0;i<excludes.length;i++){
				if(dict.getCode().equals(excludes[i])){
					excludeList.add(dict);
				}
			}
		}
		dicts.removeAll(excludeList);
		if(addAfter!=null && !"".equals(addAfter)){
			String addAfters[] = addAfter.split(";");
			for(String str:addAfters){
				String strs[] = str.split(",");
				if(strs.length!=2){
					throw new RuntimeException("加在字典后的参数传入错误！");
				}else{
					com.chuangbang.framework.entity.dictionary.Dictionary dict = new com.chuangbang.framework.entity.dictionary.Dictionary();
					dict.setCode(strs[0]);
					dict.setDetail(strs[1]);
					dicts.add(dict);
				}
			}
		}
		if(kind.equals("1")){	//如果是类型是民族
			for(com.chuangbang.framework.entity.dictionary.Dictionary dict:dicts){
			%>
				<option value="<%=dict.getDetail()%>" <%=dict.getCode().equals(selectedValue)?"selected='selected'":"" %> ><%=dict.getDetail()%></option>
			<% 
			}
		}else{
			for(com.chuangbang.framework.entity.dictionary.Dictionary dict:dicts){
			%>
				<option value="<%=dict.getCode()%>" <%=dict.getCode().equals(selectedValue)?"selected='selected'":"" %> ><%=dict.getDetail()%></option>
			<% 
			}
		}
	}
		
	if(kind == null && sql != null ){
		out.println(sql);
		java.util.List<String[]> dicts = dictSer.findBySqlToList(sql);
		
		if(address != null && address.equals("1"))
		{
			for(String[] dict:dicts){
				%>
				<option value="<%=dict[0]%>" <%=dict[1].equals(selectedValue)?"selected='selected'":"" %>><%=dict[1]%></option>
				<% 
			}
		}else{
			for(String[] dict:dicts){
				%>
				<option value="<%=dict[0]%>" <%=dict[0].equals(selectedValue)?"selected='selected'":"" %>><%=dict[1]%></option>
				<% 
			}
		}
		
	}
%>
