<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
<!--
 function fm_huiLog_operate(value,row, index){
	
	return '<a href="${ctx}/log/huiLog/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="huiLog_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function chktable(value,row, index){
	return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
}

function fm_huiLog_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
}
function huiLog_del_fun(id){
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
   	     	$.post('${ctx}/log/huiLog/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			huiLog_search();
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
		<a href="${ctx}/log/huiLog/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="huiLog_searchForm">
  <div class="form-group">
		<label for="opuid">操作人员编号</label>
   		<input type="text" class="form-control" id="opuid" name="search_EQ_opuid" placeholder="请输入操作人员编号">
		<label for="opuname">操作人员姓名</label>
   		<input type="text" class="form-control" id="opuname" name="search_EQ_opuname" placeholder="请输入操作人员姓名">
		<label for="opitemtype">操作对象类型</label>
   		<input type="text" class="form-control" id="opitemtype" name="search_EQ_opitemtype" placeholder="请输入操作对象类型">
		<label for="opitemid">操作对象编号</label>
   		<input type="text" class="form-control" id="opitemid" name="search_EQ_opitemid" placeholder="请输入操作对象编号">
		<label for="optype">操作动作类型</label>
   		<input type="text" class="form-control" id="optype" name="search_EQ_optype" placeholder="请输入操作动作类型">
		<label for="optime">操作时间</label>
   		<input type="text" class="form-control" id="optime" name="search_EQ_optime" placeholder="请输入操作时间">
		<label for="optitle">操作主题</label>
   		<input type="text" class="form-control" id="optitle" name="search_EQ_optitle" placeholder="请输入操作主题">
		<label for="opcontent">操作内容</label>
   		<input type="text" class="form-control" id="opcontent" name="search_EQ_opcontent" placeholder="请输入操作内容">
		<label for="ophost">IP地址</label>
   		<input type="text" class="form-control" id="ophost" name="search_EQ_ophost" placeholder="请输入IP地址">
		<label for="memo">备注</label>
   		<input type="text" class="form-control" id="memo" name="search_EQ_memo" placeholder="请输入备注">
  </div>
  <button type="button" class="btn btn-info" onclick="huiLog_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="huiLog_table" data-toggle="table" data-height="660" data-query-params="huiLog_queryParams"
	data-pagination="true" data-url="${ctx}/log/huiLog/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
					<th data-field="opuid">操作人员编号</th>
					<th data-field="opuname">操作人员姓名</th>
					<th data-field="opitemtype">操作对象类型</th>
					<th data-field="opitemid">操作对象编号</th>
					<th data-field="optype">操作动作类型</th>
					<th data-field="optime">操作时间</th>
					<th data-field="optitle">操作主题</th>
					<th data-field="opcontent">操作内容</th>
					<th data-field="ophost">IP地址</th>
					<th data-field="memo">备注</th>
				<th data-formatter="fm_huiLog_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function huiLog_queryParams(params){
	return $.extend({},params,util.serializeObject($('#huiLog_searchForm')));
}

function huiLog_search(){
	$("#huiLog_table").bootstrapTable("refresh");
}

</script>