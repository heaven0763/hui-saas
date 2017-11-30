<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>邀请确认</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    
</head>

<body class="" style="text-align: center;">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div style="padding: 30px;padding-top:90px; ">
		<h3 style="color: #019FEA">SAAS系统人员邀请</h3>
		<div id="msg">
			<c:if test="${error }">
			<p>${msg }</p><!--入本公司端的  -->
			</c:if>
			<c:if test="${!error}">
			<p>您好,${userName}！${tName}的HR邀请您加入SAAS系统，就任${group.name}一职。</p><!--入本公司端的  -->
			</c:if>
		</div>
		
	</div>
	<c:if test="${!error}">
		<div id="" style="color: #ffffff;position:fixed;left:5%;bottom:40px;;width:90%;text-align: center;">
			<div id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;" onclick="confirmSubmit();">确认邀请</div>
			<input id="userId" name="userId" type="hidden" value="${userId }">
			<input id="gid" name="gid" type="hidden" value="${gid }">
			<input id="hotelId" name="hotelId" type="hidden" value="${hotelId }">
			<input id="time" name="time" type="hidden" value="${time }">
		</div>
	</c:if>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>

<script>
	$(function(){
		$('#mask-full-screen').click(function(){
			$('.icon-arrow-active').click();
		});
		
		//showMaskDiv();
	});

	var flag=1;
	
	function confirmSubmit(){
		var userId="${userId }";
		var gid="${gid }";
		var hotelId="${hotelId }";
		var time ="${time }";
		var invitationCode ="${invitationCode }";
		var type ="${type }";
		var url = "${ctx}/confirm/verification/complete";
		showMaskDiv();
		if(flag===1){
			flag = 0;
			$.post(url,{userId:userId,gid:gid,hotelId:hotelId,time:time,invitationCode:invitationCode,type:type},function(res){
				if(res.success){
					$("#msg").text("确认成功！");
					$("#btn_submit").hide();
				}else{
					flag = 1;
				}
				hideMaskDiv();
			},"json");
		}else{
			hideMaskDiv();
		}
	}
	function showMaskDiv(){
		$('#mask-full-screen').show();
		$('body').css('overflow','hidden');
	}
	function hideMaskDiv(){
		$('body').css('overflow-y','auto');
		$('#mask-full-screen').hide();
	}
</script>
</html>
