<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
<!--
 function fm_log_operate(value,row, index){
	
	return '<a href="${ctx}/app/log/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="log_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function chktable(value,row, index){
	return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
}

function fm_log_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
}
function log_del_fun(id){
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
   	     	$.post('${ctx}/app/log/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			log_search();
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
		<a href="${ctx}/app/log/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="log_searchForm">
  <div class="form-group">
		<label for="logType">日志类型</label>
   		<input type="text" class="form-control" id="logType" name="search_EQ_logType" placeholder="请输入日志类型">
		<label for="actionType">操作类型</label>
   		<input type="text" class="form-control" id="actionType" name="search_EQ_actionType" placeholder="请输入操作类型">
		<label for="userId">操作人员编号</label>
   		<input type="text" class="form-control" id="userId" name="search_EQ_userId" placeholder="请输入操作人员编号">
		<label for="userName">操作人员姓名</label>
   		<input type="text" class="form-control" id="userName" name="search_EQ_userName" placeholder="请输入操作人员姓名">
		<label for="operateType">操作事项类型</label>
   		<input type="text" class="form-control" id="operateType" name="search_EQ_operateType" placeholder="请输入操作事项类型">
		<label for="operateId">操作事项编号</label>
   		<input type="text" class="form-control" id="operateId" name="search_EQ_operateId" placeholder="请输入操作事项编号">
		<label for="operateContent">操作类型</label>
   		<input type="text" class="form-control" id="operateContent" name="search_EQ_operateContent" placeholder="请输入操作类型">
		<label for="operateTime">操作时间</label>
   		<input type="text" class="form-control" id="operateTime" name="search_EQ_operateTime" placeholder="请输入操作时间">
		<label for="host">客户端IP</label>
   		<input type="text" class="form-control" id="host" name="search_EQ_host" placeholder="请输入客户端IP">
  </div>
  <button type="button" class="btn btn-info" onclick="log_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="log_table" data-toggle="table" data-height="660" data-query-params="log_queryParams"
	data-pagination="true" data-url="${ctx}/app/log/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
					<th data-field="logType">日志类型</th>
					<th data-field="actionType">操作类型</th>
					<th data-field="userId">操作人员编号</th>
					<th data-field="userName">操作人员姓名</th>
					<th data-field="operateType">操作事项类型</th>
					<th data-field="operateId">操作事项编号</th>
					<th data-field="operateContent">操作类型</th>
					<th data-field="operateTime">操作时间</th>
					<th data-field="host">客户端IP</th>
				<th data-formatter="fm_log_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function log_queryParams(params){
	return $.extend({},params,util.serializeObject($('#log_searchForm')));
}

function log_search(){
	$("#log_table").bootstrapTable("refresh");
}

</script>