<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>重置密码</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		
   		
    </style>
    
</head>

<body class="" style="height:100%;">
	<c:set var="actionurl" value="${empty userid? 'anon/user/pwd/save' : 'weixin/user/pwd/save'}"  ></c:set>
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<form id="form" action="${ctx}/${actionurl}" method="post" class="form-control" style="">
		<input type="hidden" name="userid" value="${userid}" />
		<c:if test="${empty userid}">
		<div class="form-group" style="">
			<div style="">手机号：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required cellPhone" id="input_mobile" name="mobile" type="text" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">验证码：</div>
			<div class="input-parent" style="position:relative;">
				<input type="text" class="input-form required" name="captcha" style=""/>
				<div id="btn_send_sms" class="btn btn-xs bg-type-02" style="display:inline-block;position:absolute;right:0;line-height:150%;">获取验证码</div>
			</div>
		</div>
		
		
		</c:if>
		
		<div class="form-group" style="">
			<div style="">${empty userid?'':'  新'}密码：</div>
			<div class="input-parent" style=" ">
				<input class="input-form  {required:true,minlength:5,messages:{minlength:'密码长度不能小于 {0}'}} "  id="password" name="password" type="password" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">确认密码：</div>
			<div class="input-parent" style=" ">
				<input type="password" class="input-form {equalTo:'#password',messages:{equalTo:'两次密码输入不一致'}}" name="cfpassword"   style=""/>
			</div>
		</div>
		
		
	</form>
	
	<div id="btn_submit" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;position:fixed;left:5%;bottom:5%;">确定重置</div>
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
	var $form = $('#form');
	$form.validate();
	$('#btn_submit').click(function(){
		 common.submitForm($form,function(res){
			 common.toast('重置成功！');
			 setTimeout(function(){
				 common.historyback();
			 },1500);
         },function(res){
        	 common.toast(res.message);
        	 $("#mask-full-screen").hide();
         });
		
	});
	$('#btn_send_sms').click(function(){
		var $this = $(this);
		if($this.hasClass('captcha-disable')){
			return;
		}
		var mobile = $('#input_mobile').val();
	    var tel = /^(13|15|18|17)\d{9}$/; 
	    if(!tel.test(mobile)){
	    	common.toast('请输入正确的手机号码');
			return;
		}
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
