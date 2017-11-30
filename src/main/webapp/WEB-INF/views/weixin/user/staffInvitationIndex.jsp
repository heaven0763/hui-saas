<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员邀请</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="/hui/static/weixin/css/main.css" rel="stylesheet">
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   
    <style>
    	.selected {
			width: 17px;
			height: 17px;
			background-color: rgb(255,178,38);
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
			margin-top: 18px;
		}
		
		.unselected {
			width: 15px;
			height: 15px;
			background-color: #274082;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
			border: 1px solid #666666;
			margin-top: 18px;
			border: 1.0px solid #ffffff;
		}
    </style>
</head>

<body class="bg-body-main" style="height: 100%;">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;margin: 0;overflow-y:scroll;margin-bottom: 5%;">
		
		<!-- <div style="color: #ffffff;width:auto;margin: 1rem 1rem;border-bottom: 1px solid;">
			<label class="check-one-label" style="display:inline-block;width:100%;height: 100%" for="paytype02">
				<div style="margin-left:0.1rem;margin-bottom: 0.8rem;float: left;">销售人员</div>
				<i class="unselected"></i>
				<input  type="radio" name="paytype" id="paytype02" onchange="payChange();" value="tenpay" style="display:none;">
			</label>
		</div> -->
	</div>
	<!-- <div style="color: #ffffff;text-align: center;margin: 10px;">
		<p>请先选择角色职务</p>
	</div> -->
	<div style="color: #ffffff;width:100%;text-align: center;">
		<p>请先选择角色职务</p>
		<div id="btn_submit" class="btn btn-lg bg-type-01" style="margin:0 0.5rem;border-radius:3px;" onclick="nextStep();">下一步</div>
	</div>
	
	<form action="" id="form_list_params" style="">
		<input type="hidden" id="gid" value="" name="gid">
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>

<script>
common.ctx =  '${ctx}';

	$(function(){
		dict.init();
		
		  var pager = new common.customPage({
			startnow : true,
			url :  '${ctx}/weixin/user/invitation/list',
			form : $('#form_list_params'),
			jqobj : $('#div_list_parent'),
			tmpid : 'temp_script_user_invitation'
		});  
		
		//$('#div_list_parent').append('<p>请先选择角色职务</p>');
		$('#mask-full-screen').click(function(){
			$('.icon-arrow-active').click();
		});
		
	});
	
	function showMaskDiv(){
		$('#mask-full-screen').show();
		$('body').css('overflow','hidden');
	}
	
	function hideMaskDiv(){
		$('body').css('overflow-y','auto');
		$('#mask-full-screen').hide();
	}
	
	function payChange(){
		$("input[name='paytype']:radio").each(function(i){
		    if($(this).attr("checked")) {
		    	$(this).parent().find("i").removeClass("unselected");
		    	$(this).parent().find("i").addClass("selected");
		    	$("#gid").val($(this).val());
		   }else{
			   $(this).parent().find("i").removeClass("selected");
			   $(this).parent().find("i").addClass("unselected");
		   }
		});
	}
	function nextStep(){
		var gid = $("#gid").val();
		if(gid+""===""){
			common.toast('请先选择角色职务');
			return;
		}
		showMaskDiv();
		location.href='${ctx}/weixin/user/invitation/users/'+gid;
	}
</script>

<script id="temp_script_user_invitation" type="text/html">
{{each rows as item i}}
	<div style="color: #ffffff;width:auto;margin: 1rem 1.5rem;border-bottom: 1px solid;">
		<label class="check-one-label" style="display:inline-block;width:100%;height: 100%" for="paytype{{item.id}}">
			<div style="margin-left:0.1rem; margin-top: 0.8rem; margin-bottom: 0.8rem;float: left;">{{item.name}}</div>
			<i class="unselected"></i>
			<input  type="radio" name="paytype" id="paytype{{item.id}}" onchange="payChange();" value="{{item.id}}" style="display:none;">
		</label>
	</div>
{{/each}}
</script>
</html>
