<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>接口管理</h3>
	<hr>
	<div class="form-group">
		<a href="javascript:;" onclick="loadContent(this,'${ctx}/base/app/api/create','');" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="api_searchForm">
  <div class="form-group">
		<label for="name">接口名称</label>
   		<input type="text" class="form-control" id="name" name="search_LIKE_name" placeholder="请输入接口名称">
		<label for="url">接口地址</label>
   		<input type="text" class="form-control" id="url" name="search_LIKE_url" placeholder="请输入接口地址">
		<label for="format">支持格式</label>
   		<select class="form-control" name="search_EQ_format">
   			<option value="" selected="selected">全部</option>
   			<option value="JSON">JSON</option>
   			<option value="XML">XML</option>
   		</select>
		<label for="method">请求方式</label>
		<select class="form-control" name="search_EQ_method">
   			<option value="" selected="selected">全部</option>
   			<option value="POST">POST</option>
   			<option value="GET">GETL</option>
   		</select>
  </div>
  <button type="button" class="btn btn-primary" onclick="api_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
<br/>
	<table id="api_table" data-toggle="table" data-height="660" data-query-params="api_queryParams"
	data-pagination="true" data-url="${ctx}/base/app/api/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="name">接口名称</th>
				<th data-field="url">接口地址</th>
				<th data-field="format">支持格式</th>
				<th data-field="method">请求方式</th>
				<!-- <th data-field="memo">接口备注</th> -->
				<th data-formatter="fm_api_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script>
		$(function(){
			$("#api_table").bootstrapTable();
		});
		function api_queryParams(params){
			return $.extend({},params,util.serializeObject($('#api_searchForm')));
		}
		
		function api_search(){
			$("#api_table").bootstrapTable("refresh");
		}
		
		 function fm_api_operate(value,row, index){
			
			return '<a href="javascript:;" onclick="loadContent(this,\'${ctx}/base/app/api/detail/'+row.id+'\',\'\');" class="btn btn-primary" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>'
			+'&nbsp;&nbsp;<a href="javascript:;" onclick="loadContent(this,\'${ctx}/base/app/api/update/'+row.id+'\',\'\');" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
			+'&nbsp;&nbsp;<button type="button" onclick="api_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
		}
		
		function fm_api_state(value,row, index){
			console.log(row.locked);
			if(row.locked=="0"){
				return "使用中";
			}else{
				return "已锁定";
			}
		}
		function api_del_fun(id){
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
		   	     	$.post('${ctx}/base/app/api/delete/'+id, "", function (res, status) { 
		   	     		if(status=="success"&&res.statusCode=="200"){
		   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
		   	     			api_search();
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
</div>
