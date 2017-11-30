<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>菜单管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/account/menu/create" target="dialog" class="btn btn-primary" id="mdlg" title="添加菜单"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="menu_searchForm">
	  <div class="form-group">
	   	<label for="panme">父菜单</label>
	    <select class="form-control"  id="parentId" name="search_EQ_parentId" >
			<tags:dict sql="select id , name ,'' from hui_menu "  showPleaseSelect="true" />
		</select>
	    <label for="exampleInputName2">菜单名称</label>
	    <input type="text" class="form-control" id="mname" name="search_LIKE_name" placeholder="请输入菜单名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="menu_table" data-toggle="table" data-height="660" data-query-params="menu_queryParams"
	data-pagination="true" data-url="${ctx}/account/menu/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="pname">父菜单</th>
				<th data-field="name">菜单名称</th>
				<th data-field="url">URL</th>
				<th data-field="type">类型</th>
				<th data-field="icon">图标</th>
				<th data-field="tag">目标</th>
				<th data-field="orderId">排序编号</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
<script>
	function operate(value,row, index){
		return '<a href="${ctx}/account/menu/update/'+row.id+'" target="dialog" class="btn btn-primary" id="mdlg" title="修改菜单"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
		+'&nbsp;&nbsp;<button type="button" onclick="menu_del_fun('+row.id+')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	}
	function menu_del_fun(id){
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
	    		//parent.show();
	   	     	$.post('${ctx}/account/menu/delete/'+id, "", function (res, status) { 
	   	     		if(status=="success"&&res.success){
	   	     			swal(res.msg, "您已经永久删除了这条信息。", "success");
	   	     			search();
	   	     		}else{
	   	     			swal(res.msg, "error");
	   	     		}
	   	     		//parent.hide();
	   	     	}, 'json');
			} else {
				swal("已取消", "您取消了删除操作！", "error")
			}
	    });
		
	}
	function menu_queryParams(params){
		return $.extend({},params,util.serializeObject($('#menu_searchForm')));
	}
	
	function search(){
		$("#menu_table").bootstrapTable("refresh");
	}
	$(function(){
		$("#menu_table").bootstrapTable();
	})
</script>
</div>
