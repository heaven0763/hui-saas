<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>商圈管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/district/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="district_searchForm">
	  <div class="form-group">
			<label for="regionId">所属地区	</label>
	   		<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="regionId" name="search_EQ_regionId">
				<tags:dict sql="select id , region_name ,'' from hui_region where region_type=2 " addBefore=",全部" showPleaseSelect="false" />
			</select>
			<label for="district">商圈名称</label>
	   		<input type="text" class="form-control" id="district" name="search_EQ_district" placeholder="请输入商圈名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="district_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="district_table" data-toggle="table" data-height="660" data-query-params="district_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/district/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="regionName">地区名称</th>
				<th data-field="district">商圈名称</th>
				<!-- <th data-field="addTime">添加时间	</th>
				<th data-field="sortOrder">排序编号</th> -->
				<th data-formatter="fm_district_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#district_table").bootstrapTable();
});
function district_queryParams(params){
	return $.extend({},params,util.serializeObject($('#district_searchForm')));
}
function district_search(){
	$("#district_table").bootstrapTable("refresh");
}
function fm_district_operate(value,row, index){
	
	return '<a href="${ctx}/base/hotel/district/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="district_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_district_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function district_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/district/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			district_search();
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