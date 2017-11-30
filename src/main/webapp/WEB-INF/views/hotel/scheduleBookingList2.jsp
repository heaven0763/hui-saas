<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<div class="form-group">
		<a href="${ctx}/hotel/scheduleBooking/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="scheduleBooking_searchForm">
  <div class="form-group">
		<label for="clientFrom">客户来源</label>
   		<input type="text" class="form-control" id="clientFrom" name="search_EQ_clientFrom" placeholder="请输入客户来源">
		<label for="clientId">客户编号</label>
   		<input type="text" class="form-control" id="clientId" name="search_EQ_clientId" placeholder="请输入客户编号">
		<label for="organizer">活动主办单位</label>
   		<input type="text" class="form-control" id="organizer" name="search_EQ_organizer" placeholder="请输入活动主办单位">
		<label for="linkman">联系人</label>
   		<input type="text" class="form-control" id="linkman" name="search_EQ_linkman" placeholder="请输入联系人">
		<label for="contactNumber">联系电话</label>
   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_contactNumber" placeholder="请输入联系电话">
		<label for="companySaleId">销售人员编号</label>
   		<input type="text" class="form-control" id="companySaleId" name="search_EQ_companySaleId" placeholder="请输入销售人员编号">
		<label for="companySaleName">销售人员姓名</label>
   		<input type="text" class="form-control" id="companySaleName" name="search_EQ_companySaleName" placeholder="请输入销售人员姓名">
		<label for="isdeposit">是否已付定金</label>
   		<input type="text" class="form-control" id="isdeposit" name="search_EQ_isdeposit" placeholder="请输入是否已付定金">
		<label for="depositDate">预定日期</label>
   		<input type="text" class="form-control" id="depositDate" name="search_EQ_depositDate" placeholder="请输入预定日期">
		<label for="createDate">创建时间</label>
   		<input type="text" class="form-control" id="createDate" name="search_EQ_createDate" placeholder="请输入创建时间">
		<label for="memo">备注</label>
   		<input type="text" class="form-control" id="memo" name="search_EQ_memo" placeholder="请输入备注">
  </div>
  <button type="button" class="btn btn-info" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="scheduleBooking_table" data-toggle="table" data-height="660" data-query-params="scheduleBooking_queryParams"
	data-pagination="true" data-url="${ctx}/hotel/scheduleBooking/list" data-data-type="json">
	    <thead>
	        <tr>
					<th data-field="clientFrom">客户来源</th>
					<th data-field="clientId">客户编号</th>
					<th data-field="organizer">活动主办单位</th>
					<th data-field="linkman">联系人</th>
					<th data-field="contactNumber">联系电话</th>
					<th data-field="companySaleId">销售人员编号</th>
					<th data-field="companySaleName">销售人员姓名</th>
					<th data-field="isdeposit">是否已付定金</th>
					<th data-field="depositDate">预定日期</th>
					<th data-field="createDate">创建时间</th>
					<th data-field="memo">备注</th>
				<th data-formatter="fm_scheduleBooking_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#scheduleBooking_table").bootstrapTable();
})
function scheduleBooking_queryParams(params){
	return $.extend({},params,util.serializeObject($('#scheduleBooking_searchForm')));
}
function scheduleBooking_search(){
	$("#scheduleBooking_table").bootstrapTable("refresh");
}
 function fm_scheduleBooking_operate(value,row, index){
	return '<a href="${ctx}/hotel/scheduleBooking/update/'+row.id+'" target="dialog" class="btn btn-primary" title="其他档期"><span class="glyphicon glyphicon-pencil"> </span> 其他档期</a>';
}

</script>