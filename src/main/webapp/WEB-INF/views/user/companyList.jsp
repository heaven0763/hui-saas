<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<style>
	.table td{word-break:break-all; word-wrap:break-all; white-space: nowrap;}
	div.a{float:left;}
</style>
<div class="wrapper wrapper-content">
	<h3>企业信息</h3>
	<hr>
	<div class="form-group">
		<a qx="company:add" href="javascript:;" onclick="loadContent(this,'${ctx}/user/company/create','');"class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="company_searchForm">
	  <div class="form-group">
			<label for="companyName">公司名称</label>
	   		<input type="text" class="form-control" id="companyName" name="search_LIKE_companyName" placeholder="请输入公司名称">
			<label for="linkmen">联系人姓名</label>
	   		<input type="text" class="form-control" id="linkmen" name="search_LIKE_linkmen" placeholder="请输入联系人姓名">
			<label for="linkMobile">联系人电话</label>
	   		<input type="text" class="form-control" id="linkMobile" name="search_EQ_linkMobile" placeholder="请输入联系人电话">
			<label for="state">状态</label>
	   		<select class="form-control" name="search_EQ_state">
	   			<option value="0" selected="selected">待认证</option>
	   			<option value="1">已认证</option>
	   		</select>
	  </div>
	  <button type="button" class="btn btn-primary" onclick="company_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="company_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="company_queryParams" data-row-style="orderRowStyle"
	data-pagination="true" data-url="${ctx}/user/company/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th data-formatter="fm_company_operate">操作</th> 
				<th data-field="companyName">公司名称</th>
				<th data-field="companyArea">公司区域</th>
				<th data-field="companyAddress">详细地址</th>
				<th data-field="linkmen">联系人姓名</th>
				<th data-field="linkMobile">联系人电话</th>
				<th data-field="applyDate">提交时间</th>
				<th data-field="state" data-formatter="fm_company_state">状态</th>
				<th data-field="authDate">认证时间</th>
				<th data-field="authUserName">认证人员姓名</th>
				<th data-field="authReason">认证备注</th>
				<th data-field="createDate">创建时间</th>
	        </tr>
	    </thead>
	</table>
</div>
<script>
 function fm_company_operate(value,row, index){
	return '<a qx="company:update"  href="javascript:;" onclick="loadContent(this,\'${ctx}/user/company/update/'+row.id+'\',\'\');" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
}

function fm_company_state(value,row, index){
	if(value=="0"){
		return "待认证";
	}else{
		return "已认证";
	}
}
function company_del_fun(id){
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
   	     	$.post('${ctx}/user/company/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			company_search();
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
	$("#company_table").bootstrapTable({onLoadSuccess:function(){
		common.pms.init();
	}});
});
function company_queryParams(params){
	return $.extend({},params,util.serializeObject($('#company_searchForm')));
}

function company_search(){
	$("#company_table").bootstrapTable("refresh");
}

</script>