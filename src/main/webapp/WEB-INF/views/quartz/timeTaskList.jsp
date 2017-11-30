<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>定时任务管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/quartz/create" target="dialog" class="btn btn-primary" title="添加用户" data-permission="user:create"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div> 
	<form class="form-inline" id="timeTask_searchForm">
	    <div class="form-group">
		    <label for="clazz">任务类</label>
		    <input type="text" class="form-control" id="clazz" name="search_LIKE_clazz" placeholder="请输入任务类">
	    </div>
	    <button type="button" class="btn btn-primary" onclick="timeTask_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	</form>
	<br>
	<table id="timeTask_table" data-toggle="table" data-height="600" data-query-params="timeTask_queryParams"
	data-pagination="true" data-url="${ctx}/base/quartz/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="clazz">任务类</th>
				<th data-field="taskDescribe">任务描述</th>
				<!-- <th data-field="cronExpression">cron表达式</th> 
				<th data-field="isStart">是否运行</th>
				<th data-field="isEffect">是否启用</th>-->
				<th data-field="isStart" data-formatter="fm_timeTask_state">状态</th>
				<th data-formatter="fm_timeTask_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#timeTask_table").bootstrapTable();
})
function timeTask_queryParams(params){
	return $.extend({},params,util.serializeObject($('#timeTask_searchForm')));
}
function timeTask_search(){
	$("#timeTask_table").bootstrapTable("refresh");
}
function fm_timeTask_operate(value,row, index){
	var str ='';
	
	//str +='&nbsp;&nbsp;<a href="${ctx}/base/quartz/updateJob/'+row.id+'" class="btn btn-primary"  title="更新任务"><span class="glyphicon glyphicon-refresh"> </span> 更新</a>';
	if(row.isStart=="stop"){
		str +='&nbsp;&nbsp;<a href="javascript:;"onclick="timeTask_startJob_fun(\''+row.id+'\')" class="btn btn-primary"title="启动任务"><span class="glyphicon glyphicon-play"> </span> 启动</a>';
	}else if(row.isStart=="run"){
		str +='&nbsp;&nbsp;<a href="javascript:;"onclick="timeTask_pauseJob_fun(\''+row.id+'\')" class="btn btn-primary"   title="暂停任务"><span class="glyphicon glyphicon-pause"> </span> 暂停</a>';
		str +='&nbsp;&nbsp;<a href="javascript:;"onclick="timeTask_stopJob_fun(\''+row.id+'\')" class="btn btn-primary"   title="停止任务"><span class="glyphicon glyphicon-stop"> </span> 停止</a>';
		str +='&nbsp;&nbsp;<a href="javascript:;"onclick="timeTask_triggerJob_fun(\''+row.id+'\')" class="btn btn-primary"   title="停止任务"><span class="glyphicon glyphicon-play"> </span> 执行一次</a>';
	}else if(row.isStart=="pause"){
		str +='&nbsp;&nbsp;<a href="javascript:;"onclick="timeTask_resumeJob_fun(\''+row.id+'\')" class="btn btn-primary"   title="恢复任务"><span class="glyphicon glyphicon-play"> </span> 恢复</a>';
	}
	str +='&nbsp;&nbsp;<a href="${ctx}/base/quartz/update/'+row.id+'" target="dialog" class="btn btn-primary"  title="修改定时任务信息"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
	if(row.isStart=="stop"){
		str +='&nbsp;&nbsp;<button type="button" onclick="timeTask_del_fun(\''+row.id+'\')" class="btn btn-primary" title="删除定时任务信息"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	}
	return  str;
			
}
function fm_timeTask_state(value,row, index){
	if(row.isStart=="stop"){
		return "已停止";
	}else if(row.isStart=="pause"){
		return "已暂停";
	}else{
		return "运行中";
	}
}
function timeTask_startJob_fun(id){
	var url='${ctx}/base/quartz/startJob/'+id;
	var title = "您确定要启动该定时任务吗？";
	var text= "";
	var ctype="启动";
	dopost(title,text,ctype,url)
} 
function timeTask_stopJob_fun(id){
	var url='${ctx}/base/quartz/deleteJob/'+id;
	var title = "您确定要停止该定时任务吗？";
	var text= "";
	var ctype="停止";
	dopost(title,text,ctype,url)
}
function timeTask_pauseJob_fun(id){
	var url='${ctx}/base/quartz/pauseJob/'+id;
	var title = "您确定要暂停该定时任务吗？";
	var text= "";
	var ctype="暂停";
	dopost(title,text,ctype,url)
}
function timeTask_resumeJob_fun(id){
	var url='${ctx}/base/quartz/resumeJob/'+id;
	var title = "您确定要恢复该定时任务吗？";
	var text= "";
	var ctype="恢复";
	dopost(title,text,ctype,url)
}
function timeTask_triggerJob_fun(id){
	var url='${ctx}/base/quartz/triggerJob/'+id;
	var title = "您确定要执行一次该任务吗？";
	var text= "";
	var ctype="确定";
	dopost(title,text,ctype,url)
}
function dopost(title,text,ctype,url){
	swal({
        title: title,
        text: text,
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: ctype,
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post(url, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "success");
   	     			timeTask_search();
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了"+ctype+"操作！", "error");
		}
    });
}
function timeTask_del_fun(id){
	var url = '${ctx}/base/quartz/delete/'+id;
	var title = "您确定要删除该定时任务吗？";
	var text= "删除后将无法恢复，请谨慎操作！";
	var ctype="删除";
	dopost(title,text,ctype,url)
}
</script>
