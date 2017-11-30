<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#menuSubForm").validate({
        rules: {
            name: "required",
            parentId: "required",
            url: "required"
        },
        messages: {
        	name: e + "请输入菜单名称",
        	parentId: e + "请选择父菜单",
        	url: e + "请输入菜单URL"            
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
<form id="menuSubForm" method="post" action="${ctx}/account/menu/save"  class="form-horizontal m-t" ><!--   -->
<div class="modal-body"> 
	<input type="hidden" name="id" id="id" value="${menuBean.id}" />
	<input type="hidden" name="iscommon" id="iscommon" value="${menuBean.iscommon}" />
	<input type="hidden" name="isweixin" id="isweixin" value="${menuBean.isweixin}" />
	<input type="hidden" name="parallelismmenuId" id="parallelismmenuId" value="${menuBean.parallelismmenuId}" />
  <div class="form-group form-inline">
    <label for="parentId" class="col-sm-3 control-label">父菜单</label>
     <div class="col-sm-9">
     	<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="parentId" name="parentId" >
			<tags:dict sql="select id , name ,'' from hui_menu " addBefore="0,父菜单" selectedValue="${menuBean.parentId}" showPleaseSelect="true" />
		</select>
   	 <%-- <input type="text" class="form-control" id="parentId" name="parentId" placeholder="父节点" value="${menuBean.parentId}" > --%>
    </div>
  </div>
  <div class="form-group form-inline">
    <label for="name" class="col-sm-3 control-label">菜单名称</label>
    <div class="col-sm-9">
   		 <input type="text" class="form-control" id="name" name="name" placeholder="菜单名称" value="${menuBean.name}" aria-required="true" aria-invalid="false" class="valid" >
    </div>
  </div>
  <div class="form-group form-inline">
    <label for="enName" class="col-sm-3 control-label">英文名称</label>
    <div class="col-sm-9">
   		 <input type="text" class="form-control"  name="enName" placeholder="英文名称" value="${menuBean.enName}"  >
    </div>
  </div>
   <div class="form-group form-inline">
    <label for="url" class="col-sm-3 control-label">菜单访问路径</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="url" name="url" placeholder="菜单访问路径" value="${menuBean.url}" aria-required="true" aria-invalid="false" class="valid"></div>
  </div>
   <div class="form-group form-inline">
    <label for="orderId" class="col-sm-3 control-label">排序</label>
    <div class="col-sm-9">
    <input type="number" class="form-control" id="orderId" name="orderId" placeholder="排序" value="${menuBean.orderId}"></div>
  </div>
   <div class="form-group form-inline">
    <label for="tab" class="col-sm-3 control-label">目标页面</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="tab" name="tab" placeholder="目标页面" value="${menuBean.tab}"></div>
  </div>
  <div class="form-group form-inline">
    <label for="icon" class="col-sm-3 control-label">图标</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="icon" name="icon" placeholder="图标" value="${menuBean.icon}"></div>
  </div>
  <div class="form-group form-inline">
    <label for="type" class="col-sm-3 control-label">类型</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="type" name="type" placeholder="类型" value="${menuBean.type}"></div>
  </div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
