<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
<script type="text/javascript">
 function fm_hotelGroup_operate(value,row, index){
	
	return '<a qx="hotelgroup:update" href="${ctx}/base/hotel/group/update/'+row.id+'" target="dialog" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button qx="hotelgroup:delete" type="button" onclick="hotelGroup_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>'
	+'&nbsp;&nbsp;<a qx="hotelgroup:update" href="javascript:;" onclick="loadContent(this,\'${ctx}/base/user/guser/index?hgId='+row.id+'\',\'\')" class="btn btn-primary btn-sm" ><span class="glyphicon glyphicon-pencil"> </span> 职员管理</a>';
}
function fm_hotelGroup_logo(value,row, index){
	return '<img class="gerenBnLfLo" src="'+value+'" style="height:45px;">';
}
function hotelGroup_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/group/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelGroup_search();
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
	<h3>集团管理</h3>
	<hr>
	<div class="form-group">
		<a qx="hotelgroup:add" href="${ctx}/base/hotel/group/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotelGroup_searchForm">
	  <div class="form-group">
			<label for="name">集团名称</label>
	   		<input type="text" class="form-control" id="name" name="search_LIKE_name" placeholder="请输入集团名称">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="hotelGroup_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="hotelGroup_table" data-toggle="table" data-height="660" data-query-params="hotelGroup_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/group/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="logo" data-formatter="fm_hotelGroup_logo">集团logo</th>
				<th data-field="name">集团名称</th>
				<!-- <th data-field="introduction">集团介绍</th> -->
				<th data-field="linkman">联系人</th>
				<th data-field="tel">联系电话</th>
				<th data-field="email">邮箱</th>
				<!-- <th data-field="createUserId">创建人员</th>
				<th data-field="createUserName">创建日期</th> 
				<th data-field="memo">备注</th>-->
				<th data-formatter="fm_hotelGroup_operate">操作</th> 
	        </tr>
	    </thead>
	</table>

<script>
$(function(){
    common.pms.init();
    $("#hotelGroup_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
});
function hotelGroup_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelGroup_searchForm')));
}

function hotelGroup_search(){
	$("#hotelGroup_table").bootstrapTable("refresh");
}

</script>
</div>