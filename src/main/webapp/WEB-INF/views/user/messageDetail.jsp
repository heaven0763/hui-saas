<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
<!--
.display-flex{display: -webkit-flex;display: flex;justify-content: space-between;}
-->
</style>
<div class="modal-body"> 
  
 	<div class="display-flex" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;">
		<span style="font-weight:bold;">场地名称:${msg.hName }</span>
		<span style="font-size:0.8rem;margin-left:1rem;">留言类型:${msg.msgType}</span>
	</div>
	<div class="display-flex" style="margin: 0.5rem 0;border-bottom: 1px solid #f5f5f5;">
		<span style="font-weight:bold;">会员账号:${msg.userName }</span>
		<span style="font-size:0.8rem;margin-left:1rem;">留言日期:${dUs.toSecond(msg.msgDate)}</span>
	</div>
	<div class="display-flex" style="padding:10px; margin: 0.8rem 0;font-size:0.95rem;background-color: #f5f5f5;">
		${msg.msg }
	</div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
</div>
</div>

