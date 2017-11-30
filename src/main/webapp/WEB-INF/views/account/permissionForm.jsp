<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#permissionSubForm").validate({
        rules: {
        	displayname: "required",
            parentId: "required",
            permission: "required"
        },
        messages: {
        	displayname: e + "请输入权限名称",
        	parentId: e + "请选择父权限",
        	permission: e + "请输入权限代码"            
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.success){
       　				$('#close_btn').click();
       　				swal(res.msg, "success");
       　				search();
       　			}else{
       　				swal(res.msg, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
//-->
</script>
<form id="permissionSubForm" method="post" action="${ctx}/account/permission/save"  class="form-horizontal m-t" ><!--   -->
<div class="modal-body"> 
  <input type="hidden" name="id" id="id" value="${permission.id}" />
  <div class="form-group form-inline">
    <label for="parentId" class="col-sm-3 control-label">父权限</label>
     <div class="col-sm-9">
     	<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="parentId" name="parentId" >
			<tags:dict sql="select id , displayname ,'' from hui_permission "
				selectedValue="${permission.parentId}" addBefore=",请选择" showPleaseSelect="false" />
		</select>
    </div>
  </div>
  <div class="form-group form-inline">
    <label for="displayname" class="col-sm-3 control-label">权限名称</label>
    <div class="col-sm-9">
   		 <input type="text" class="form-control" id="displayname" name="displayname" placeholder="权限名称" value="${permission.displayname}" aria-required="true" aria-invalid="false" class="valid" >
    </div>
  </div>
   <div class="form-group form-inline">
    <label for="permission" class="col-sm-3 control-label">权限代码</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="permission" name="permission" placeholder="权限代码" value="${permission.permission}" aria-required="true" aria-invalid="false" class="valid"></div>
  </div>
   <div class="form-group form-inline">
    <label for="permission" class="col-sm-3 control-label">权限代码</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="permission" name="permission" placeholder="权限代码" value="${permission.permission}" aria-required="true" aria-invalid="false" class="valid"></div>
  </div>
  
   <div class="form-group form-inline">
    <label for="memo" class="col-sm-3 control-label">备注</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="memo" name="memo" placeholder="备注" value="${permission.memo}"></div>
  </div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
