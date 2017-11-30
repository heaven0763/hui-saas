<%@page import="com.chuangbang.framework.util.account.AccountUtils"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://www.springside.org.cn/tags/shiro" prefix="sshiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page import= "org.springframework.web.context.support.WebApplicationContextUtils"%> 
<%@ page import= "com.chuangbang.framework.util.common.DateTimeUtils"%> 
<%@ page import= "com.chuangbang.framework.util.common.MobileUtil"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="staticPath" value="${pageContext.request.contextPath}" />
<c:set var="mypermissions" value="" />
<%
	pageContext.setAttribute("dSv",WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext()).getBean("dictionaryService"));
	pageContext.setAttribute("sPSv",WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext()).getBean("systemParameterService"));
	/* pageContext.setAttribute("disSv",WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext()).getBean("districtService")); */
	pageContext.setAttribute("dUs",new DateTimeUtils());
	pageContext.setAttribute("aUs", new AccountUtils());
	pageContext.setAttribute("sUt", new StringUtils());
	pageContext.setAttribute("mOu", new MobileUtil());
%>
<c:set var="_firstDayOfMonth" value="${dUs.getFirstDayOfMonth()}" />
<c:set var="_currDayOfMonth" value="${dUs.getCurrentDate()}" />

