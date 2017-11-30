<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>地区管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/region/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="region_searchForm">
	  <div class="form-group">
			<label for="parentId">父编号</label>
	   		<input type="text" class="form-control" id="parentId" name="search_EQ_parentId" placeholder="请输入父编号">
			<label for="regionName">区域名称</label>
	   		<input type="text" class="form-control" id="regionName" name="search_LIKE_regionName" placeholder="请输入区域名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="region_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="region_table" data-toggle="table" data-height="660" data-query-params="region_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/region/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="parentId">父区域编号</th>
				<th data-field="pName">父区域名称</th>
				<th data-field="id">区域编号</th>
				<th data-field="regionName">区域名称</th>
				<th data-field="regionType">区域类型</th>
				<th data-field="zimu">字目</th>
			<!-- 	<th data-field="agencyId">代理编号</th>
				<th data-field="isHot">热门</th>
				<th data-field="isTui">推荐</th>
				<th data-field="sortOrder">排序编号</th> -->
				<th data-formatter="fm_region_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_region_operate(value,row, index){
	
	return '<a href="${ctx}/base/hotel/region/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="region_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_region_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function region_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/region/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			region_search();
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
function region_queryParams(params){
	return $.extend({},params,util.serializeObject($('#region_searchForm')));
}

function region_search(){
	$("#region_table").bootstrapTable("refresh");
}
$(function(){
	$("#region_table").bootstrapTable();
});
</script>