<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>站内消息</h3>
	<hr>
	<c:if test="${groupMap.isgroupadministrator || groupMap.ishoteladministrator || groupMap.iscompanyadministrator || groupMap.isadministrator}">
	<div class="form-group">
		<a qx="msg:send"  href="${ctx}/base/user/msg/create" target="dialog" class="btn btn-primary" title="发送消息" ><span class="glyphicon glyphicon-plus"></span> 发送消息</a>
	</div>
	</c:if> 
	<form class="form-inline" id="chatmsg_searchForm">
	  <div class="form-group">
			<%-- <label for="msgType">留言类型</label>
	   		<select class="form-control"  id="msgType" name="search_EQ_msgType">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='MSGTYPE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select> --%>
			<label for="title">消息标题</label>
	   		<input type="text" class="form-control" id="title" name="search_LIKE_title" placeholder="模糊查询消息标题">
			<label for="ptext">消息内容</label>
	   		<input type="text" class="form-control" id="ptext" name="search_LIKE_ptext" placeholder="模糊消息内容">
	   		<br>
	   		<br>
			<label for="createdAt">消息日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="screatedAt" name="search_GTE_createdAt" placeholder="请输入消息日期">
	   		~
	   		<input type="text" class="form-control layer-date laydate-icon" id="ecreatedAt" name="search_LTE_createdAt" placeholder="请输入消息日期">
		  <button type="button" class="btn btn-primary" onclick="chatmsg_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="chatmsg_table" data-toggle="table" data-height="600" data-query-params="chatmsg_queryParams"
	data-pagination="true" data-url="${ctx}/base/user/msg/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="msgType" data-formatter="fm_msg_msgType">消息类型</th> -->
				<th data-field="title">消息标题</th>
				<th data-field="ptext" data-formatter="fm_msg_ptext">消息内容</th>
				<th data-field="createdAt">消息日期</th>
				<th data-field="state" data-formatter="fm_msg_msgState">状态</th>
				<th data-formatter="fm_chatmsg_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_chatmsg_operate(value,row, index){
	return '<button type="button" href="${ctx}/base/user/msg/detail/'+row.id+'" target="dialog" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-eye-open"> </span> 详情</button>';
}

function fm_msg_msgState(value,row, index){
	return value ==='1'?'<span class="label label-danger">未读</span>':'<span class="label label-default">已读</span>';
}
function fm_msg_ptext(value,row, index){
	if(value.length>50){
		return 	value.substring(0,50)+"...";
	}else{
		return 	value;
	}
}
$(function(){
	common.pms.init();
	 var smsgDate={elem:"#screatedAt",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(smsgDate);
    var emsgDate={elem:"#ecreatedAt",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(emsgDate); 
    $("#chatmsg_table").bootstrapTable();
    //{onClickRow:function(row, $element){ console.log(field); chatmsg_search() }}
});
function chatmsg_queryParams(params){
	return $.extend({},params,util.serializeObject($('#chatmsg_searchForm')));
}

function chatmsg_search(){
	$("#chatmsg_table").bootstrapTable("refresh");
}

</script>