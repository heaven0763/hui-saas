<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>档期查阅</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    <style>
		
		.btn-state-left,.btn-state-right{
			width:32%;
		}
	
		.btn-state-left{
			position:absolute;left:18%;
		}
	
		.btn-state-right{
			position:absolute;right:0;
		}
		
		.one-list:nth-child(0) {
			border:none;
		}
	
    </style>
    
</head>

<body class="">

	<div id="top_toolbar" class="toolbar" style="">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">地区</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">场地</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">日期</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">类别</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
		</div>
	</div>
	
	<div class="tran-list-ct conent-list" style="width:100%;padding-top:3rem;">
		
		<div style="font-size:0;margin:0.5rem auto;padding:0 2%;width:96%;">
			<div class="btn btn-md bg-type-01 btn-plain" style="width:32%;">会掌柜客户</div>
			<div class="btn btn-md bg-type-02 btn-plain" style="width:32%;margin:0 2%;">场地自有客户</div>
			<div class="btn btn-md bg-type-03 btn-plain" style="width:32%;border:0;">拓源公关</div>
		</div>
		
		
		<div class="font-gray-02" style="font-size:0.7rem;padding:0 2%;width:96%;">
			注：蓝色代表会掌柜客户，橙色代表场地自有客户。
		</div>
		
		
		<div id="schedule_booking_list">
			
		
		</div>
			
			
			
		
		
		
	</div>
	
	<form id="form_list_params" style="display:none;"></form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>

<script>

$(function(){
	var $topToolbars = $('#top_toolbar .toolbar-one');
	$topToolbars.click(function(){
		$topToolbars.removeClass('icon-arrow-active');
		var $this = $(this);
		$this.addClass('icon-arrow-active');
		var index = $(this).index();
	});
	
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/schedulebooking/list',
		form : $('#form_list_params'),
		jqobj : $('#schedule_booking_list'),
		tmpid : 'temp_list_schedulebooing'
	}); 
	
});
</script>

<script id="temp_list_schedulebooing" type="text/html">
{{each rows as item i}}
<div class="one-list" style="font-size:0.9rem;">
	<div style="position:relative;width:100%;vertical-align:bottom;">
		<div style="display:inline-block;font-weight:bold;">{{item.hotelName}}</div>
		<div style="display:inline-block;margin-left:0.8rem;">{{item.placeName}}</div>
		<div class="font-gray-01" style="display:inline-block;position:absolute;right:0;bottom:0;font-size:0.75rem;">{{item.clientFrom}}</div>
	</div>
	
	<div class="one-list-ct-sett" style="margin-top:0.6rem;">
		<div class="sett-left" style="">跟进销售：{{item.hotelSaleName}}</div>
		<div class="sett-right" style="">活动时间：{{item.placeDate}}</div>
	</div>
				
	<div style="margin:0.6rem 0;font-size:0;width:100%;position:relative;">
		<div style="display:inline-block;font-size:0.75rem;width:18%;">档期状态</div>
		<div class="btn btn-xs bg-type-02 btn-state-left">{{item.state == 1? '未预定' : '已预定'}}</div>
		<div class="btn btn-xs btn-disable btn-state-right" item-rdurl="${ctx}/weixin/schedulebooking/place/detail?placeId={{item.placeId}}" >其他档期</div>
	</div>
</div>
{{/each}}

</script>
</html>
