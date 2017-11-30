<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
<!--
 function fm_apiParams_operate(value,row, index){
	
	return '<a href="${ctx}/app/apiParams/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="apiParams_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function chktable(value,row, index){
	return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
}

function fm_apiParams_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
}
function apiParams_del_fun(id){
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
   	     	$.post('${ctx}/app/apiParams/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			apiParams_search();
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
//-->
</script>
<div class="wrapper wrapper-content">
	<div class="form-group">
		<a href="${ctx}/app/apiParams/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="apiParams_searchForm">
  <div class="form-group">
		<label for="apid">接口编号</label>
   		<input type="text" class="form-control" id="apid" name="search_EQ_apid" placeholder="请输入接口编号">
		<label for="name">名称</label>
   		<input type="text" class="form-control" id="name" name="search_EQ_name" placeholder="请输入名称">
		<label for="type">类型</label>
   		<input type="text" class="form-control" id="type" name="search_EQ_type" placeholder="请输入类型">
		<label for="required">必填</label>
   		<input type="text" class="form-control" id="required" name="search_EQ_required" placeholder="请输入必填">
		<label for="description">说明</label>
   		<input type="text" class="form-control" id="description" name="search_EQ_description" placeholder="请输入说明">
  </div>
  <button type="button" class="btn btn-info" onclick="apiParams_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="apiParams_table" data-toggle="table" data-height="660" data-query-params="apiParams_queryParams"
	data-pagination="true" data-url="${ctx}/app/apiParams/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
					<th data-field="apid">接口编号</th>
					<th data-field="name">名称</th>
					<th data-field="type">类型</th>
					<th data-field="required">必填</th>
					<th data-field="description">说明</th>
				<th data-formatter="fm_apiParams_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function apiParams_queryParams(params){
	return $.extend({},params,util.serializeObject($('#apiParams_searchForm')));
}

function apiParams_search(){
	$("#apiParams_table").bootstrapTable("refresh");
}

</script>