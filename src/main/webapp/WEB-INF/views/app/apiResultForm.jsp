<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#apiResultSubForm").validate({
        rules: {
        	apid: "required",
        	name: "required",
        	type: "required",
        	description: "required",
        },
        messages: {
        	apid: e + "请输入接口编号",
        	name: e + "请输入名称",
        	type: e + "请输入类型",
        	description: e + "请输入说明",
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				apiResult_search();
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
  
<form id="apiResultSubForm" method="post" action="${ctx}/app/apiResult/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${apiResult.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">接口编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="apid" data-options="required:true" value="${apiResult.apid}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">名称</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="name" data-options="required:true" value="${apiResult.name}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="type" data-options="required:true" value="${apiResult.type}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">说明</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="description" data-options="required:true" value="${apiResult.description}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>
