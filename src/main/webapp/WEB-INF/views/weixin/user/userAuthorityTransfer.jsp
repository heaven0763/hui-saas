<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>权限转移</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		.per-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
   		.down-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
    </style>
    
</head>

<body class="" style="height:100%;">
	
	<form id="form_register" action="${ctx }/weixin/user/author/transfer/save" method="post" class="form-control" style="">
		<input type="hidden" name="userId" value="${tuser.id }">
		<input type="hidden" name="fromuserId" value="${fromuserId}">
		<input type="hidden" name="type" value="${flag ?'HR':'OTHER'}">
		<div class="form-group" style="">
			<div style="">
			<c:if test=""></c:if>
				${flag ?'HR姓名':'接受移交人'}：
			</div>
			<div class="input-parent per-div" style=" " rdurl="${ctx }/weixin/user/author/transfer/users?fromuserId=${fromuserId}&gid=${gid}&type=${type}">
				<input class="input-form required" name="rname" type="text" style="" value="${tuser.rname }" readonly="readonly"/>
			</div>
		
		</div>
		
		<div class="form-group" style="">
			<div style="">邮箱：</div>
			<div class="input-parent" style=" ">
				<input class="input-form email" name="email" type="text" style="" value="${tuser.email }"/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">手机号：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required cellPhone" id="input_mobile" name="mobile" type="text" style="" value="${tuser.mobile }"/>
			</div>
		</div>
		<c:choose>
			<c:when test="${flag }">
				<input type="hidden" name="gid" value="${gid}">
			</c:when>
			<c:otherwise>
				<div class="form-group" style="">
					<div style="">角色权限：</div>
					<div class="input-parent" style=" ">
						<%-- <input class="input-form required cellPhone" name="gid" type="text" style="" value="${gid }"/> --%>
						<c:if test="${empty gid}">
							<c:if test="${isgroup eq '0' }">
								<select class="input-form required" id="gid" name="gid" style="width:100%;background-color: #274082;color: #ffffff;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } and group_id LIKE \'hotel%\' " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
							<c:if test="${isgroup ne '0' }">
								<select class="input-form required" id="gid" name="gid" style="width:100%;background-color: #274082;color: #ffffff;">
									<tags:dict sql="select id , name  from hui_group where 1=1 and pid=${gtype } " selectedValue="${gid}"  showPleaseSelect="true" />
								</select>
							</c:if>
						</c:if>
						<c:if test="${not empty gid}">
							<input type="hidden" name="gid" value="${gid}">
							<input class="input-form" name="gname" type="text" style="" value="${group.name }" readonly="readonly"/>
						</c:if>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="form-group" style="margin-bottom: 4rem;">
			<div style="">验证码：</div>
			<div class="input-parent" style="position:relative;">
				<input type="text" class="input-form required" name="captcha" style="" />
				<div id="btn_send_sms" class="btn btn-xs bg-type-02" style="display:inline-block;position:absolute;right:0;line-height:150%;">获取</div>
			</div>
		</div>
	</form>
	<c:if test="${empty fromuserId}">
		<div  style="width:90%;position:fixed;left:5%;bottom:0;background-color: #274082;padding: 5% 0;">
			<div id="btn_transfer" class="btn btn-lg bg-type-01" style="border-radius:3px;">确定${flag ?'授权':'转移'}</div>
		</div>
	</c:if>
	<c:if test="${not empty fromuserId}">
		<div class="flex-justify" style="width:90%;position:fixed;left:5%;bottom:0;background-color: #274082;padding: 5% 0;">
			<div class="btn btn-lg bg-type-01" style="border-radius:3px;width: 43%;float: left;" rdurl="${ctx}/${ rdurl}">稍后移交</div>
			<div id="btn_transfer" class="btn btn-lg bg-type-02" style="border-radius:3px;width: 43%;float: right;">确定转移</div>
		</div>
	</c:if>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>

<script>

$(function(){
	common.ctx =  '${ctx}';
	
	var $form = $('#form_register');
	$form.validate();
	
	$('#btn_transfer').click(function(){
		 common.submitForm($form,function(res){
			 common.toast(res.message);
			 var url = "${flag?'/weixin/user/hr/index':'/weixin/user/author/transfer'}";
			 if(url==='OTHER'){
			 }else{
				 setTimeout(function(){
					 common.rdUrl('${ctx}'+url);
				 },1500);  
			 }
         });
	});
	
	$('#btn_send_sms').click(function(){
		var $this = $(this);
		if($this.hasClass('captcha-disable')){
			return;
		}
		var mobile = $('#input_mobile').val();
	    var tel = /^(13|15|18)\d{9}$/; 
	    if(!tel.test(mobile)){
	    	common.toast('请输入正确的手机号码');
			return;
		}
	    /* common.toast('手机验证码已发送，请注意查收！');
		$this.addClass('captcha-disable');
		var timeSecond = 60;
		smsIntervalId = setInterval(function(){
			$this.text(--timeSecond);
			if(timeSecond == 0){
				clearInterval(smsIntervalId);
				$this.removeClass('captcha-disable');
				$this.text('获取');
			}
		},1000); */
		common.ajaxjson({
			url : '${ctx}/anon/mobile/mobiledrawcode?phone='+mobile,
			success : function(){
				common.toast('手机验证码已发送，请注意查收！');
				$this.addClass('captcha-disable');
				var timeSecond = 60;
				smsIntervalId = setInterval(function(){
					$this.text(--timeSecond);
					if(timeSecond == 0){
						clearInterval(smsIntervalId);
						$this.removeClass('captcha-disable');
						$this.text('获取');
					}
				},1000);
			}
		}); 
	});
});
</script>
</html>
