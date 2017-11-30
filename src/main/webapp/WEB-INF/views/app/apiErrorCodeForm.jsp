<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#apiErrorCodeSubForm").validate({
        rules: {
        	errorCode: "required",
        	description: "required"
        },
        messages: {
        	errorCode: e + "请输入错误码",
        	description: e + "请输入说明"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				apiErrorCode_search();
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
  
<form id="apiErrorCodeSubForm" method="post" action="${ctx}/base/app/errorcode/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${apiErrorCode.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">类型</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="type" data-options="required:true" value="${apiErrorCode.type}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">错误码</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="errorCode" data-options="required:true" value="${apiErrorCode.errorCode}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">说明</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="description" data-options="required:true" value="${apiErrorCode.description}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

