<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>类型管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/category/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="category_searchForm">
	  <input type="hidden" class="form-control"  name="sort" value="id">
	  <input type="hidden" class="form-control"  name="order" value="desc">
	  <div class="form-group">
	  		<label for="parentId">父类型</label>
	  		<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="parentId" name="search_EQ_parentId" style="width: 180px;">
				<tags:dict sql="select id , name ,'' from hui_category where parent_id=0  "  showPleaseSelect="false" addBefore=",全部;0,根类型"/>
			</select>
			<label for="kind">种类</label>
	   		<select class="form-control" name="search_EQ_kind" style="width: 180px;">
	     		<tags:dict sql="select val , name ,'' from hui_category where kind='0'" showPleaseSelect="false" addBefore=",全部" />
	   		</select>
			<label for="name">名称</label>
	   		<input type="text" class="form-control" id="name" name="search_LIKE_name" placeholder="请输入名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="category_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="category_table" data-toggle="table" data-height="660" data-query-params="category_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/category/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="kind">种类</th>
				<th data-field="name">名称</th>
				<th data-field="val">详细值</th>
				<!-- <th data-field="addTime">添加时间</th> -->
				<th data-formatter="fm_category_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#category_table").bootstrapTable();
})
function fm_category_operate(value,row, index){
	return '<a href="${ctx}/base/hotel/category/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="category_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_category_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function category_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/category/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			category_search();
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
function category_queryParams(params){
	return $.extend({},params,util.serializeObject($('#category_searchForm')));
}

function category_search(){
	$("#category_table").bootstrapTable("refresh");
}

</script>