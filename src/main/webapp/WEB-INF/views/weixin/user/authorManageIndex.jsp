<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>授权管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   
    
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="div_list_parent" style="width: 100%;margin-bottom: 60px;">
		
	</div>
	<form id="form_list_params" style="display:none;"></form>
	<div class="flex-box flex-justify" style="padding:0.5rem 2%;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
		<div class="btn btn-xs bg-type-01" style="width:100%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/user/author/tmp">临时授权</div>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script>
var pager = null;
$(function(){
	pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/user/author/tmp/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_list_pms'
	}); 
	
	template.config('escape', false);
	template.helper('dateFormat', function(date){
		return common.formatDate(date);
	});
});

function takeBackFun(id){
	$("#mask-full-screen").show();
	$.post('${ctx}/weixin/user/author/tmp/takeback/'+id,null,function(res){
		common.toast(res.message);
		if(res.statusCode==='200'){
			pager.search();
		}
		$("#mask-full-screen").hide();
	},'json');
}
</script>
<script id="temp_list_pms" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="" item-rdurl="#">
			<div class="one-list-ct-title" style="padding-top: 0.5rem;">
				<div style="display:inline-block;">{{item.permissionName}}</div>
				<div class="btn btn-xs" style="float:right;color:#019FEA;border: 1px solid #019FEA;" onclick="takeBackFun({{item.id}})">点击收回</div>
				<div style="clear:both;"></div>
			</div>
			<div class="font-size-min" style="margin-top:0.5rem;width: 100%;">
				<div style="width: 33%;text-align: left;float: left;">{{item.userName}}</div>
				<div style="width: 33%;text-align: center;float: left;">开始：{{item.startTime | dateFormat}}</div>
				<div style="width: 33%;text-align: right;float: left;">结束：{{item.endTime | dateFormat}}</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	{{/each}}
</script>
</html>
