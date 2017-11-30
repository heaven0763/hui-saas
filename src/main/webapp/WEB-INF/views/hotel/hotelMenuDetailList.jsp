<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
 function fm_hotelMenuDetail_operate(value,row, index){
	
	return '<a href="${ctx}/hotel/hotelMenuDetail/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="hotelMenuDetail_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
	
function hotelMenuDetail_del_fun(id){
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
   	     	$.post('${ctx}/hotel/hotelMenuDetail/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelMenuDetail_search();
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
<div class="wrapper wrapper-content">
	<div class="form-group">
		<a href="${ctx}/hotel/hotelMenuDetail/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotelMenuDetail_searchForm">
  <div class="form-group">
		<label for="menuId">菜单编号</label>
   		<input type="text" class="form-control" id="menuId" name="search_EQ_menuId" placeholder="请输入菜单编号">
		<label for="name">菜名</label>
   		<input type="text" class="form-control" id="name" name="search_EQ_name" placeholder="请输入菜名">
		<label for="price">价格</label>
   		<input type="text" class="form-control" id="price" name="search_EQ_price" placeholder="请输入价格">
		<label for="introduction">介绍</label>
   		<input type="text" class="form-control" id="introduction" name="search_EQ_introduction" placeholder="请输入介绍">
		<label for="img">图片</label>
   		<input type="text" class="form-control" id="img" name="search_EQ_img" placeholder="请输入图片">
		<label for="createDate">创建时间</label>
   		<input type="text" class="form-control" id="createDate" name="search_EQ_createDate" placeholder="请输入创建时间">
		<label for="memo">备注</label>
   		<input type="text" class="form-control" id="memo" name="search_EQ_memo" placeholder="请输入备注">
  </div>
  <button type="button" class="btn btn-info" onclick="hotelMenuDetail_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="hotelMenuDetail_table" data-toggle="table" data-height="660" data-query-params="hotelMenuDetail_queryParams"
	data-pagination="true" data-url="${ctx}/hotel/hotelMenuDetail/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
					<th data-field="menuId">菜单编号</th>
					<th data-field="name">菜名</th>
					<th data-field="price">价格</th>
					<th data-field="introduction">介绍</th>
					<th data-field="img">图片</th>
					<th data-field="createDate">创建时间</th>
					<th data-field="memo">备注</th>
				<th data-formatter="fm_hotelMenuDetail_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function hotelMenuDetail_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelMenuDetail_searchForm')));
}

function hotelMenuDetail_search(){
	$("#hotelMenuDetail_table").bootstrapTable("refresh");
}

</script>