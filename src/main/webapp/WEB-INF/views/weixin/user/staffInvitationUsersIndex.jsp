<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>邀请人员列表</title>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
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
			margin-top: 13px;
		}
		.unselected {
			width: 15px;
			height: 15px;
			background-color: #ffffff;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
		    border: 1.0px solid #999999; 
			margin-top: 13px;
		}
		.pl{margin-left:0.1rem;float: left;}
		.pr{float: right;}
		.user-list{width:auto;margin: 1rem 0.5rem;border-bottom: 1px solid #f5f5f5;}
		.check-label{display:inline-block;width:100%;height: 100%}
    </style>
</head>

<body class="" style="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	
	<div id="top_toolbar" style="height:1.6rem;width:100%;padding: 1.0rem 0;">
		<div style="width:100%;height: 100%;">
			<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="搜索用户名/手机号" />
			<div id="btn_user_search" class="icon-search-02" style="width:20%;height:100%;background-color:rgb(255,178,38);float:right;background-size: 30%;background-position:center center;"></div>
		</div>
	</div>
	
	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;overflow-y:scroll;margin-top: 0;margin-bottom: 60px;">
		<!-- <div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">
			A-G
		</div>
		 <div style="color: #019FEA;width:auto;margin: 1rem 0.5rem;border-bottom: 1px solid #f5f5f5;">
			
				<label class="check-one-label" style="display:inline-block;width:100%;height: 100%" for="userId02">
				<div style="margin-left:0.1rem;float: left;">
					<div style="padding-bottom: 5px;">张三</div>
					<div style="padding-bottom: 5px;">13632332694</div>
				</div>
				<i class="unselected"></i>
				<input  type="checkbox" name="userId" id="userId02" onchange="userChange();" value="tenpay" style="display:none;">
			</label>
		</div>  -->
		
	</div>
	<div style="color: #ffffff;position:fixed;left:5%;bottom:1%;width:90%;text-align: center;">
		<div id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;" onclick="invitation();">确认邀请</div>
		<input id="userIds" name="userIds" type="hidden" value="">
		<input id="gid" name="gid" type="hidden" value="${gid}">
	</div>
	<form action="" id="form_list_params" style="">
		<input id="search_EQ_userType" type="hidden" name="search_EQ_userType" value="CLIENT"  />
		<input id="sort" type="hidden" name="sort" value="zimu"  />
		<input id="order" type="hidden" name="order" value="asc"  />
		<input id="search_EQ_mobile" type="hidden" name="search_EQ_mobile" />
		<input id="search_LIKE_rname" type="hidden" name="search_LIKE_rname" />
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
	
	 initUser();
	 
	 $('#btn_user_search').click(function(){
		 var tel = /^(13|15|18)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 if(searchVal===""){
			 $('#search_EQ_mobile').val("");
			 $('#search_LIKE_rname').val("");
		 }
		 $('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_mobile').val(searchVal);
		 }else{
			 $('#search_LIKE_rname').val(searchVal);
		 }
		 initUser();
		 
	});
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
});

function initUser(){
	common.ajaxjson({
		url  : '${ctx}/weixin/user/invitation/users/list',
		type : 'post',
		data : {
			search_EQ_mobile : $('#search_EQ_mobile').val(),
			search_LIKE_rname : $('#search_LIKE_rname').val(),
			search_EQ_userType : 'CLIENT',
			sort : 'zimu',
			order : 'asc'
		},
		success : function(res){
			var html = new Array();
			var list = res.object.rows;
			var a = 0;
			var h = 0;
			var o = 0;
			var v = 0;
			for(var i in list){
				var str =$("#temp_script_user_administrator").text();
				if(a===0&&list[i].zimu<='G'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">A-G</div>'+str;
					a = 1;
				}else if(h===0&&list[i].zimu>'G'&&list[i].zimu<'O'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">H-N</div>'+str;
					h = 1;
				}else if(o===0&&list[i].zimu>='O'&&list[i].zimu<'V'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">O-U</div>'+str;
					o = 1;
				}else if(v===0&&list[i].zimu>='V'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">V-Z</div>'+str;
					v = 1;
				}
				str = str.replace('{{item.id}}',list[i].id).replace('{{item.rname}}',list[i].rname).replace('{{item.mobile}}',list[i].mobile).replace('{{item.id}}',list[i].id).replace('{{item.id}}',list[i].id);
				html.push(str);
			}
			$('#div_list_parent').html(html.join(''));
		}
	});
}
function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}
function userChange(){
	var userIds = new Array();
	$("input[name='userId']:checkbox").each(function(i){
	    if($(this).attr("checked")) {
	    	$(this).parent().find("i").removeClass("unselected");
	    	$(this).parent().find("i").addClass("selected");
	    	$(this).parent().find("div").css("color","#019FEA");
	    	userIds.push($(this).val());
	   }else{
		   $(this).parent().find("i").removeClass("selected");
		   $(this).parent().find("i").addClass("unselected");
		   $(this).parent().find("div").css("color","");
	   }
	});
	$("#userIds").val(userIds.join(","));
}
function invitation(){
	var userIds = $("#userIds").val();
	var gid = $("#gid").val();
	if(userIds+""===""){
		common.toast('请先选择邀请用户！');
		return;
	}
	showMaskDiv();
	 var url = '${ctx}/weixin/user/invitation/send';
	$.post(url,{userIds:userIds,gid:gid},function(res){
		if(res.statusCode=='200'){
			common.toast('发送邀请成功！');
			location.href="${ctx}/weixin/user/invitation/index"
		}else{
			common.toast(res.message);
		}
		hideMaskDiv();
	},"JSON");
}
</script>

<script id="temp_script_user_administrator" type="text/html">
	<div class="user-list" style="">
			<label style="display:inline-block;width:100%;height: 100%" for="userId{{item.id}}">
				<div class="pl">
					<div style="padding-bottom: 5px;">{{item.rname}}</div>
					<div style="padding-bottom: 5px;">{{item.mobile}}</div>
				</div>
				<i class="unselected"></i>
				<input type="checkbox" name="userId" id="userId{{item.id}}" onchange="userChange();" value="{{item.id}}" style="display:none;">
			</label>
		<div style="clear:both"></div>
	</div>
</script>
</html>
