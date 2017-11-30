<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>场地风格管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/sitestype/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="siteStype_searchForm">
	  <div class="form-group">
			<label for="name">风格名称</label>
	   		<input type="text" class="form-control" id="name" name="search_EQ_name" placeholder="请输入风格名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="siteStype_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="siteStype_table" data-toggle="table" data-height="660" data-query-params="siteStype_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/sitestype/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="name">风格名称</th>
				<th data-field="code">风格代码</th>
				<th data-field="logo" data-formatter="fm_supportingServices_logo">风格图标</th>
				<th data-formatter="fm_siteStype_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#siteStype_table").bootstrapTable();
});
function siteStype_queryParams(params){
	return $.extend({},params,util.serializeObject($('#siteStype_searchForm')));
}

function siteStype_search(){
	$("#siteStype_table").bootstrapTable("refresh");
}

function fm_siteStype_operate(value,row, index){
	return '<a href="${ctx}/base/hotel/sitestype/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="siteStype_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}


function fm_supportingServices_logo(value,row, index){
	return '<img   class="img-circle" src="'+value+'" style="width: 62px;height: 62px;" onerror="nofind()">'
}

function siteStype_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/sitestype/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			siteStype_search();
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