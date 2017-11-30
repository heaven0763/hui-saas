<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>错误码管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/app/errorcode/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="apiErrorCode_searchForm">
	  	<div class="form-group">
			<label for="type">类型</label>
	   		<input type="text" class="form-control" id="type" name="search_EQ_type" placeholder="请输入类型">
			<label for="errorCode">错误码</label>
	   		<input type="text" class="form-control" id="errorCode" name="search_EQ_errorCode" placeholder="请输入错误码">
	  	</div>
	  	<button type="button" class="btn btn-primary" onclick="apiErrorCode_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br/>
	<table id="apiErrorCode_table" data-toggle="table" data-height="660" data-query-params="apiErrorCode_queryParams"
		data-pagination="true" data-url="${ctx}/base/app/errorcode/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="type">类型</th>
				<th data-field="errorCode">错误码</th>
				<th data-field="description">说明</th>
				<th data-formatter="fm_apiErrorCode_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script type="text/javascript">
		$(function(){
			$("#apiErrorCode_table").bootstrapTable();
		});
		 function fm_apiErrorCode_operate(value,row, index){
			
			return '<a href="${ctx}/base/app/errorcode/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
			+'&nbsp;&nbsp;<button type="button" onclick="apiErrorCode_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
		}
		
		
		function apiErrorCode_del_fun(id){
			swal({
		        title: "您确定要删除这条信息吗",
		        text: "删除后将无法恢复，请谨慎操作！",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "删除",
		        closeOnConfirm: false,
		        showLoaderOnConfirm: true
		    }, function (isConfirm)  {
		    	if (isConfirm) {
		    		parent.show();
		   	     	$.post('${ctx}/base/app/errorcode/delete/'+id, "", function (res, status) { 
		   	     		if(status=="success"&&res.statusCode=="200"){
		   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
		   	     			apiErrorCode_search();
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
		function apiErrorCode_queryParams(params){
			return $.extend({},params,util.serializeObject($('#apiErrorCode_searchForm')));
		}
		
		function apiErrorCode_search(){
			$("#apiErrorCode_table").bootstrapTable("refresh");
		}
	</script>
</div>
