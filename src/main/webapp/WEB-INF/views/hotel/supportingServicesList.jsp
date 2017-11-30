<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>配套服务管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/supporting/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="supportingServices_searchForm">
	  <div class="form-group">
			<label for="kind">服务类型</label>
	   		<select class="form-control" name="search_EQ_kind" style="width: 180px;">
		     		<tags:dict sql="select val , name ,'' from hui_category where kind='SUPPORT' " showPleaseSelect="false" addBefore=",全部" />
		   		</select>
			<label for="name">服务名称</label>
	   		<input type="text" class="form-control" id="name" name="search_EQ_name" placeholder="请输入服务名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="supportingServices_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="supportingServices_table" data-toggle="table" data-height="660" data-query-params="supportingServices_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/supporting/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="kind" data-formatter="fm_supportingServices_type">服务类型</th>
				<th data-field="name">服务名称</th>
				<th data-field="logo" data-formatter="fm_supportingServices_logo">服务logo</th>
				<th data-formatter="fm_supportingServices_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_supportingServices_operate(value,row, index){
	
	return '<a href="${ctx}/base/hotel/supporting/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="supportingServices_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_supportingServices_type(value,row, index){
	if(value==="ROOMSERVICE"){
		return "客房服务";
	}else if(value==="HALLSUPORT"){
		return "会场配套";
	}else if(value==="FACILITIES"){
		return "便利设施";
	}else if(value==="MEDIA&TECH"){
		return "媒体/科技列表";
	}else if(value==="HOTELSUPORTING"){
		return "场地配套";
	}else if(value==="HALLDISPLAY"){
		return "会场摆放";
	}else{
		return "其他";
	}
}
function fm_supportingServices_logo(value,row, index){
	return '<img   class="img-circle" src="'+value+'" style="width: 62px;height: 62px;" onerror="nofind()">'
}
function supportingServices_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/supporting/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			supportingServices_search();
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
function supportingServices_queryParams(params){
	return $.extend({},params,util.serializeObject($('#supportingServices_searchForm')));
}

function supportingServices_search(){
	$("#supportingServices_table").bootstrapTable("refresh");
}
$(function(){
	$("#supportingServices_table").bootstrapTable();
});
</script>