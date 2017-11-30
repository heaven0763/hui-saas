<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>积分记录</h3>
	<hr>
	<form class="form-inline" id="pointsRecord_searchForm">
	  <div class="form-group">
			<label for="clientId">客户姓名</label>
	   		<input type="text" class="form-control" id="clientId" name="search_EQ_clientId" placeholder="请输入客户编号">
	   		<label for="clientId">场地名称</label>
	   		<input type="text" class="form-control" id="clientId" name="search_EQ_clientId" placeholder="请输入客户编号">
	  </div>
	  <button type="button" class="btn btn-info" onclick="pointsRecord_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="pointsRecord_table" data-toggle="table" data-height="660" data-query-params="pointsRecord_queryParams"
	data-pagination="true" data-url="${ctx}/user/pointsRecord/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="orderNo">订单流水号</th>
				<th data-field="clientType">客户类型</th>
				<th data-field="clientId">客户编号</th>
				<th data-field="clientArea">所属区域</th>
				<th data-field="amount">消费金额</th>
				<th data-field="points">获得积分</th>
				<th data-field="pointsDate">获得日期</th>
				<th data-field="actionType">动作类型</th>
				<th data-field="createDate">创建时间</th>
				<th data-field="memo">备注</th>
				<th data-formatter="fm_pointsRecord_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#pointsRecord_table").bootstrapTable();
});
function pointsRecord_queryParams(params){
	return $.extend({},params,util.serializeObject($('#pointsRecord_searchForm')));
}

function pointsRecord_search(){
	$("#pointsRecord_table").bootstrapTable("refresh");
}
function fm_pointsRecord_operate(value,row, index){
	
	return '<a href="${ctx}/user/pointsRecord/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="pointsRecord_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function pointsRecord_del_fun(id){
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
   	     	$.post('${ctx}/user/pointsRecord/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			pointsRecord_search();
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