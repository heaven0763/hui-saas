<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#messageSubForm").validate({
        rules: {
        	msgType: "required",
        	itemId: "required",
        	userId: "required",
        	msg: "required"
        },
        messages: {
        	msgType: e + "请输入留言类型",
        	itemId: e + "请输入留言主体",
        	userId: e + "请输入留言人员编号",
        	msg: e + "请输入留言"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				message_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
//-->
</script>
<div class="modal-body"> 
  
<form id="messageSubForm" method="post" action="${ctx}/base/uesr/message/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${message.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">留言类型</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="msgType" data-options="required:true" value="${message.msgType}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">留言主体</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="itemId" data-options="required:true" value="${message.itemId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">留言人员编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="userId" data-options="required:true" value="${message.userId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="userName" class="col-sm-3 control-label">留言人员</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="userName" data-options="required:true" value="${message.userName}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">留言</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="msg" data-options="required:true" value="${message.msg}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="memo" data-options="required:true" value="${message.memo}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

