<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">


	
//-->
</script>
<div class="wrapper wrapper-content">
	<h3>权限管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/account/permission/create" target="dialog" class="btn btn-primary" id="mdlg" title="添加权限"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="permission_searchForm">
	  <div class="form-group">
	    <label for="exampleInputName2">权限名称</label>
	    <input type="text" class="form-control" id="mname" name="search_LIKE_displayname" placeholder="请输入权限名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="permission_table" data-toggle="table" data-height="660" data-query-params="permission_queryParams"
	data-pagination="true" data-url="${ctx}/account/permission/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th data-field="menuName">菜单名称</th>
				<th data-field="parentId">父权限</th>
				<th data-field="displayname">权限名称</th>
				<th data-field="permission">权限代码</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function permission_queryParams(params){
	return $.extend({},params,util.serializeObject($('#permission_searchForm')));
}

function search(){
	$("#permission_table").bootstrapTable("refresh");
}
$(function(){
	$("#permission_table").bootstrapTable();
})
function operate(value,row, index){
	return '<a href="${ctx}/account/permission/update/'+row.id+'" target="dialog" class="btn btn-primary" id="mdlg" title="修改权限"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="permission_del_fun('+row.id+')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function permission_del_fun(id){
	
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        cancelButtonText: "取消",
        closeOnConfirm: false
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/account/permission/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.success){
   	     			swal(res.msg, "您已经永久删除了这条信息。", "success");
   	     			search();
   	     		}else{
   	     			swal(res.msg, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了删除操作！", "error")
		}
    });
	
}

</script>