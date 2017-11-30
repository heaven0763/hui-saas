<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>注册</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		.input-parent select{width: 100px;background-color:#274082;color: #ffffff;padding: 0.5rem 1rem;border-color: #ffffff; }
   		
    </style>
    
</head>

<body class="" style="height:100%;">
	
	<form id="form_register" action="${ctx}/weixin/city/partner/save" method="post" class="form-control" style="">
		<input type="hidden" name="parea" id="parea" value="" />
	  	<input type="hidden" name="carea" id="carea" value="" />
		<div class="form-group" style="">
			<div style="">真实姓名：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" name="rname" type="text" style=""/>
			</div>
		
		</div>
		<div class="form-group" style="">
			<div style="">昵称：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" name="username" type="text" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">手机号：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required cellPhone" id="input-mobile" name="mobile" type="text" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">邮箱：</div>
			<div class="input-parent" style=" ">
				<input class="input-form email" name="email" type="text" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">密码：</div>
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
		
		<div class="form-group" style="">
			<div style="">公司名称：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" name="companyName" type="text" style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">区域：</div>
			<div class="input-parent" style="border: none;">
				<div style="float: left;">
				<select class=""  id="province" name="province" refval="value" reftext="text" textTarget="parea" 
					refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaget(this)">
					<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' " selectedValue=""  showPleaseSelect="true"/>
				</select>
				</div>
				<div style="float: left;margin-left: 0.5rem;">
					<select class=""  id="city" name="city" refval="value" reftext="text"  textTarget="carea"> </select>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		
		<!-- <div class="form-group" style="">
			<div style="">验证码：</div>
			<div class="input-parent" style="position:relative;">
				<input type="text" class="input-form required" name="captcha" style=""/>
				<div id="btn_send_sms" class="btn btn-xs bg-type-02" style="display:inline-block;position:absolute;right:0;line-height:150%;">获取验证码</div>
			</div>
		</div> -->
	</form>
	<div  style="padding: 0.8rem 2%;">
		<div id="btn_register" class="btn btn-lg bg-type-01"  style="width:100%;margin:0 auto;margin:3rem 0;border-radius:3px;">确定注册</div>
	</div>
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
	
	$('#btn_register').click(function(){
		 common.submitForm($form,function(res){
			 common.toast('注册成功！');
			 setTimeout(function(){
				 //common.historyback();
			 },1500);
         });
	});
	
	$('#btn_send_sms').click(function(){
		var $this = $(this);
		if($this.hasClass('captcha-mobile')){
			return;
		}
		var mobile = $('#input_mobile').val();
	    var tel = /^(13|15|18)\d{9}$/; 
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
function areaget(self){
	var url = $(self).attr('refurl').replace('{value}',$(self).val());
	$.get(url,function(res){
		var arr = [];
		for(var n=0;n<res.length;n++){
			arr.push('<option value="'+res[n].value+'">'+res[n].text+'</option>');
		}
		$("#city").html(arr.join(''));
	},'json');
}
</script>
</html>
