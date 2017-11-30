<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body"> 
  
<form id="messageSubForm" method="post" action="${ctx}/base/uesr/message/save"  class="form-horizontal m-t" ><!--   -->
 	<div class="display-flex" style="margin: 0.5rem 0;">
		<span style="font-weight:bold;">${msg.title }</span>
		<span style="font-size:0.8rem;margin-left:1rem;">${dUs.toSecond(msg.createdAt)}</span>
	</div>
	<div class="display-flex" style="padding:10px; margin: 0.8rem 0;font-size:0.95rem;background-color: #f5f5f5;">
		${msg.ptext }
	</div>
	<div class="display-flex" style="margin: 0.8rem 0;font-size:0.95rem;">
	<span style="">发送者:${msg.formUserName }</span>
	</div>
  <div class="modal-footer">
    <button type="button" class="btn btn-default" id="btn-cls"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal" style="display: none;"><span class="glyphicon glyphicon-off"></span> 关闭</button>
</div>
</form>
<script type="text/javascript">
	$(function(){
		$("#btn-cls").click(function(){
			chatmsg_search();
			$("#close_btn").click();
		});
	});
</script>
</div>

