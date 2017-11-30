<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%
	response.setStatus(200);
%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request
				.getAttribute("javax.servlet.error.exception");
	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>
{
	"statusCode":"300", 
	"message":"<%=ex.getMessage() %>", 
	"navTabId":"${navTabId}", 
	"rel":"${rel}",
	"callbackType":"closeCurrent",
	"forwardUrl":"${forwardUrl}"
}