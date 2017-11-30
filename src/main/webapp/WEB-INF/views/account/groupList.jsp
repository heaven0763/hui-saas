<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>角色管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/account/group/create" target="dialog" class="btn btn-primary" width="900" id="mdlg" title="添加角色"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="group_searchForm">
	  <div class="form-group">
	    <label for="exampleInputName2">角色名称</label>
	    <input type="text" class="form-control" id="mname" name="search_LIKE_name" placeholder="请输入角色名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br/>
	<table id="group_table" data-toggle="table" data-height="660" data-query-params="group_queryParams" data-pagination="true" 
		data-url="${ctx}/account/group/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="groupId">角色代码</th>
				<th data-field="name">角色名称</th>
				<th data-field="memo">备注</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
	$(function(){
		$("#group_table").bootstrapTable();
	})
	function group_queryParams(params){
		return $.extend({},params,util.serializeObject($('#group_searchForm')));
	}
	
	function search(){
		$("#group_table").bootstrapTable("refresh");
	}
	
	
	function operate(value,row, index){
		return '<a href="${ctx}/account/group/update/'+row.id+'" target="dialog" width="900" class="btn btn-primary" id="mdlg" title="修改角色"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
		+'&nbsp;&nbsp;<button type="button" onclick="group_del_fun('+row.id+')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	}
	function group_del_fun(id){
		
		swal({
	        title: "您确定要删除这条信息吗",
	        text: "删除后将无法恢复，请谨慎操作！",
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "删除",
	        cancelButtonText: "取消",
	        closeOnConfirm: false,
	        showLoaderOnConfirm: true
	    }, function (isConfirm)  {
	    	if (isConfirm) {
	    		parent.show();
	   	     	$.post('${ctx}/account/group/delete/'+id, "", function (res, status) { 
	   	     		if(status=="success"&&res.statusCode=="200"){
	   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
	   	     			search();
	   	     		}else{
	   	     			swal(res.message, "error");
	   	     		}
	   	     		parent.hide();
	   	     	}, 'json');
			} else {
				swal("已取消", "您取消了删除操作！", "error")
			}
	    });
		
	}
	
</script>