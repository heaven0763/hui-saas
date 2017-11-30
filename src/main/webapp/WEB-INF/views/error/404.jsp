<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%
	response.setStatus(200);
%>
{
	"statusCode":"300", 
	"message":"页面不存在", 
	"navTabId":"${navTabId}", 
	"rel":"${rel}",
	"callbackType":"closeCurrent",
	"forwardUrl":"${forwardUrl}"
}
