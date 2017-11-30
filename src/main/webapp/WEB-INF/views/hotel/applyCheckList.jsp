<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>申请审核列表</h3>
	<hr>
	<div class="form-group">
		<c:forEach items="${menus}" var="menu">
			<c:if test="${menu.id!=129 }">
				<a href="javascript:;" url="${menu.url}" onclick="loadContent(this,'${ctx}/${menu.url}','');"  class="btn btn-primary btn-sm" title="${menu.name }" ><span class="fa fa-${menu.icon }"> </span> ${menu.name }</a>
			</c:if>
		</c:forEach>
	</div>
	<form class="form-inline" id="check_searchForm">
		<div class="form-group">
			<label for="area">申请人姓名</label> <input class="form-control" name="search_LIKE_rame">
			<label for="area">申请人手机</label> <input class="form-control" name="search_EQ_mobile">
			<label for="area">申请人邮箱</label> <input class="form-control" name="search_EQ_email">
			<button type="button" class="btn btn-primary" onclick="check_search()">
				<span class="glyphicon glyphicon-search"> </span> 查询
			</button>
		</div>
	</form>
		<br>
	<table id="applyCheck_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="hotel_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/record/checkList" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelFaceImg">场地封面图片</th> -->
				<th data-field="rname">姓名</th>
				<th data-field="mobile">手机号</th>
				<th data-field="email">邮箱</th>
				<th data-field="applyDate">申请时间</th>
				<th data-formatter="fm_hotel_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_hotel_operate(value,row, index){
	return '<a href="${ctx}/base/hotel/record/checkForm/'+row.recordId+'" target="dialog" class="btn btn-primary" title="添加">审核并授权</a>';//<span class="glyphicon glyphicon-plus"> </span> 
	//return '<a qx="user:joincheck" href="javascript:;" onclick="hotel_check_fun('+row.recordId+',1)" class="btn btn-primary btn-sm" title="审核通过">审核通过</a>&nbsp;&nbsp;<a qx="user:joincheck" href="javascript:;" onclick="hotel_check_fun('+row.recordId+',2)" class="btn btn-primary btn-sm" title="审核不过">审核不过</a>'
}

function hotel_check_fun(id,state){
	var groupId = $("#gid").val();
	if(state==1&&!groupId){
		swal('请选择角色！', "error");
		return;
	}
	var title = "您确定不通过申请了吗";
	if(state==1){
		title = "您确定通过申请了吗";
	}
	swal({
        title: title,
        text: "请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/base/hotel/record/checkApply', {recordId:id,state:state,groupId:groupId}, function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			$("#close_btn").click();
   	     			swal(res.message, "您的操作已完成！", "success");
   	     			check_search();
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



$(function(){
    common.pms.init();
	console.log(common.pms.permissions);
    $("#applyCheck_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
});
function hotel_queryParams(params){
	return $.extend({},params,util.serializeObject($('#check_searchForm')));
}

function check_search(){
	$("#applyCheck_table").bootstrapTable("refresh");
}

</script>