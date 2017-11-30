<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<form class="form-inline" id="priceAdjust_searchForm">
	  <div class="form-group">
			<label for="auditId">审核编号</label>
	   		<input type="text" class="form-control" id="auditId" name="search_EQ_auditId" placeholder="请输入审核编号">
			<label for="hotelId">场地编号</label>
	   		<input type="text" class="form-control" id="hotelId" name="search_EQ_hotelId" placeholder="请输入场地编号">
			<label for="state">申请状态</label>
	   		<input type="text" class="form-control" id="state" name="search_EQ_state" placeholder="请输入申请状态">
	  </div>
	  <button type="button" class="btn btn-info" onclick="priceAdjust_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="priceAdjust_table" data-toggle="table" data-height="660" data-query-params="priceAdjust_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/price/adjust/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="auditId">审核编号</th>
				<th data-field="hotelId">场地编号</th>
				<th data-field="hotelName">场地名称</th>
				<th data-field="state">申请状态</th>
				<th data-field="applyUserId">提交人员编号</th>
				<th data-field="applyUserName">提交人员姓名</th>
				<th data-field="applyDate">提交时间</th>
				<th data-formatter="fm_priceAdjust_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	common.pms.init();
	$("#priceAdjust_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
});
function priceAdjust_queryParams(params){
	return $.extend({},params,util.serializeObject($('#priceAdjust_searchForm')));
}
function priceAdjust_search(){
	$("#priceAdjust_table").bootstrapTable("refresh");
}
function fm_priceAdjust_operate(value,row, index){
	
	return '<a qx="hotel-price-adjust:check" href="${ctx}/hotel/priceAdjust/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;< qx="hotel-price-adjust:check" button type="button" onclick="priceAdjust_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function priceAdjust_del_fun(id){
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
   	     	$.post('${ctx}/hotel/priceAdjust/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			priceAdjust_search();
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