<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#logSubForm").validate({
        rules: {
        	logType: "required",
        	actionType: "required",
        	userId: "required",
        	userName: "required",
        	operateType: "required",
        	operateId: "required",
        	operateContent: "required",
        	operateTime: "required",
        	host: "required",
        },
        messages: {
        	logType: e + "请输入日志类型",
        	actionType: e + "请输入操作类型",
        	userId: e + "请输入操作人员编号",
        	userName: e + "请输入操作人员姓名",
        	operateType: e + "请输入操作事项类型",
        	operateId: e + "请输入操作事项编号",
        	operateContent: e + "请输入操作类型",
        	operateTime: e + "请输入操作时间",
        	host: e + "请输入客户端IP",
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				log_search();
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
  
<form id="logSubForm" method="post" action="${ctx}/app/log/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${log.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">日志类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="logType" data-options="required:true" value="${log.logType}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="actionType" data-options="required:true" value="${log.actionType}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作人员编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="userId" data-options="required:true" value="${log.userId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作人员姓名</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="userName" data-options="required:true" value="${log.userName}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作事项类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="operateType" data-options="required:true" value="${log.operateType}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作事项编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="operateId" data-options="required:true" value="${log.operateId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="operateContent" data-options="required:true" value="${log.operateContent}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作时间</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="operateTime" data-options="required:true" value="${log.operateTime}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">客户端IP</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="host" data-options="required:true" value="${log.host}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

