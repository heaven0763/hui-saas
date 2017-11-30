<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>${title}</h3>
	<hr>
	<form class="form-inline" id="pointsAccount_searchForm">
	  <input type="hidden" value="${type}" name="search_EQ_clientType">
	  <div class="form-group">
			<label for="clientName">${fname}名称</label>
	   		<input type="text" class="form-control" id="clientName" name="search_EQ_clientName" placeholder="请输入${fname}名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="pointsAccount_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="pointsAccount_table" data-toggle="table" data-height="660" data-query-params="pointsAccount_queryParams"
	data-pagination="true" data-url="${ctx}/base/user/points/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="clientType">客户类型</th>
				<th data-field="clientId">客户编号</th> -->
				<th data-field="clientName">${fname}名称</th>
				<th data-field="clientArea">所属区域</th>
				<!-- <th data-field="totalAmount">累计消费金额</th> -->
				<th data-field="totalPoints" data-align="right">累计积分</th>
				<th data-field="cashPoints" data-align="right">已兑现积分</th>
				<th data-field="balancePoints" data-align="right">结余积分</th>
				<th data-field="pointStandard">积分计算标准</th>
				<!-- <th data-field="pointsRate">积分计算比例</th>
				<th data-field="createDate">创建时间</th>
				<th data-field="memo">备注</th> 
				<th data-formatter="fm_pointsAccount_operate">操作</th> -->
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#pointsAccount_table").bootstrapTable();
});
function pointsAccount_queryParams(params){
	return $.extend({},params,util.serializeObject($('#pointsAccount_searchForm')));
}

function pointsAccount_search(){
	$("#pointsAccount_table").bootstrapTable("refresh");
}

function fm_pointsAccount_operate(value,row, index){
	
	return '<a href="${ctx}/base/user/points/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="pointsAccount_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function pointsAccount_del_fun(id){
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
   	     	$.post('${ctx}/base/user/points/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			pointsAccount_search();
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