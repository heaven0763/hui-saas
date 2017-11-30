<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
<!--
 function fm_orderPayedRecord_operate(value,row, index){
	
	return '<a href="${ctx}/order/orderPayedRecord/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="orderPayedRecord_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function chktable(value,row, index){
	return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
}

function fm_orderPayedRecord_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
}
function orderPayedRecord_del_fun(id){
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
   	     	$.post('${ctx}/order/orderPayedRecord/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			orderPayedRecord_search();
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
		<a href="${ctx}/order/orderPayedRecord/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="orderPayedRecord_searchForm">
  <div class="form-group">
		<label for="hotelId">所属场地</label>
   		<input type="text" class="form-control" id="hotelId" name="search_EQ_hotelId" placeholder="请输入所属场地">
		<label for="orderId">订单编号</label>
   		<input type="text" class="form-control" id="orderId" name="search_EQ_orderId" placeholder="请输入订单编号">
		<label for="type">付款类型</label>
   		<input type="text" class="form-control" id="type" name="search_EQ_type" placeholder="请输入付款类型">
		<label for="amount">订单金额</label>
   		<input type="text" class="form-control" id="amount" name="search_EQ_amount" placeholder="请输入订单金额">
		<label for="payAmount">付款金额</label>
   		<input type="text" class="form-control" id="payAmount" name="search_EQ_payAmount" placeholder="请输入付款金额">
		<label for="unpayAmount">未付款金额</label>
   		<input type="text" class="form-control" id="unpayAmount" name="search_EQ_unpayAmount" placeholder="请输入未付款金额">
		<label for="payedAmount">已付款金额</label>
   		<input type="text" class="form-control" id="payedAmount" name="search_EQ_payedAmount" placeholder="请输入已付款金额">
		<label for="payDate">付款时间</label>
   		<input type="text" class="form-control" id="payDate" name="search_EQ_payDate" placeholder="请输入付款时间">
		<label for="payedUserId">创建人员编号</label>
   		<input type="text" class="form-control" id="payedUserId" name="search_EQ_payedUserId" placeholder="请输入创建人员编号">
		<label for="createDate">创建日期</label>
   		<input type="text" class="form-control" id="createDate" name="search_EQ_createDate" placeholder="请输入创建日期">
		<label for="memo">创建日期</label>
   		<input type="text" class="form-control" id="memo" name="search_EQ_memo" placeholder="请输入创建日期">
  </div>
  <button type="button" class="btn btn-info" onclick="orderPayedRecord_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="orderPayedRecord_table" data-toggle="table" data-height="660" data-query-params="orderPayedRecord_queryParams"
	data-pagination="true" data-url="${ctx}/order/orderPayedRecord/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
					<th data-field="hotelId">所属场地</th>
					<th data-field="orderId">订单编号</th>
					<th data-field="type">付款类型</th>
					<th data-field="amount">订单金额</th>
					<th data-field="payAmount">付款金额</th>
					<th data-field="unpayAmount">未付款金额</th>
					<th data-field="payedAmount">已付款金额</th>
					<th data-field="payDate">付款时间</th>
					<th data-field="payedUserId">创建人员编号</th>
					<th data-field="createDate">创建日期</th>
					<th data-field="memo">创建日期</th>
				<th data-formatter="fm_orderPayedRecord_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function orderPayedRecord_queryParams(params){
	return $.extend({},params,util.serializeObject($('#orderPayedRecord_searchForm')));
}

function orderPayedRecord_search(){
	$("#orderPayedRecord_table").bootstrapTable("refresh");
}

</script>