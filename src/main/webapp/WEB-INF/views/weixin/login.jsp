<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <title>场地SAAS系统管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
</head>

<body>
	 
	 <div class="row">
			<div class="col-sm-12" style="text-align: center;margin-top: 4rem;">
				<img src="${ctx}/public/css/images/hui-logo.png" style="width:13rem;">
			</div>
	</div>
		
	 <form id="form_login" action="${ctx}/anon/login" method="post" class="form-control" style="">
	 <div style="position: relative;margin-bottom: 100px;">
	 	<div class="form-group" style="">
			<div style="">账号：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" name="username" type="text" style=""/>
			</div>
		
		</div>
		<div class="form-group" style="">
			<div style="">密码：</div>
			<div class="input-parent" style=" ">
				<input type="password" class="input-form required" name="password"  style=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">验证码：</div>
			<div class="input-parent" style="position:relative;">
				<input type="text" class="input-form required" name="captcha" style=""/>
				<img src="${ctx}/code" id="img_captcha" onclick="refreshCaptcha()" title="看不清，点击换一张！"   style="height:1.5rem;display:inline-block;position:absolute;right:0;">
				<!-- <div class="btn btn-xs bg-type-02" style="display:inline-block;position:absolute;right:0;line-height:150%;">获取验证码</div> -->
			</div>
		</div>
		
		<div class="col-sm-12" style="position:relative;">
           	<div style="position: absolute;left: 65px;"><a href="${ctx}/anon/register" style="font-size: 0.75rem;color: #ffffff">注册</a></div>
           	<div style="position: absolute;right:16px;">
           		<a href="${ctx}/anon/user/pwd/reset" style="font-size: 0.75rem;color: #ffffff;">忘记密码</a>
           		<img src="${ctx}/public/css/images/wenhao.png"  style="vertical-align: middle;width:1.1rem;">
           	</div>
        </div>
        </div>
		<div id="btn_sumbit" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;">确定登陆</div>
	 </form>
	 
<%-- 	<div class="wrapper wrapper-content">
		
		<div class="row" style="padding: 10px;">
	    	<div class="col-sm-12">
				<form class="form-horizontal" id="loginForm"  method="post" action="${ctx}/zgui/login">
					 <div class="row">
				    	<div class="col-sm-12">
			                <div class="row" style="padding:5px 0px;margin-top: 15px;">
			                    <div class="col-sm-12">
				                    <label class="control-label" style="font-size: 14px;">账号: </label>
			                        <input type="text" name="username" class="TextLine1"> 
			                    </div>
			                </div>
			                 <div class="row" style="padding:5px 0px;margin-top: 15px;">
			                    <div class="col-sm-12">
				                    <label class="control-label" style="font-size: 14px;">密码: </label>
				                    <input type="password" name="password" class="TextLine1"> 
				                </div>
			                </div>
			                <div class="row" style="padding:5px 0px;margin-top: 15px;">
			                    <div class="col-sm-12"  style="position:relative;">
				                    <label class="control-label" style="font-size: 14px;">验证码:</label>
				                    <input type="text" name="captcha" class="TextLine1" style="width: 83%;"> 
				                    <!-- <div style="position:absolute;right:16px;bottom:10px; background-color: #fda700;padding: 5px;">
				                    	<a style="font-size: 12px;color: #ffffff">获取验证码<a>
				                    </div> -->
				                      <div style="position:absolute;right:16px;bottom:0px;padding: 5px;">
				                    	<!-- <a style="font-size: 12px;color: #ffffff">获取验证码<a> -->
				                    	<img src="${ctx}/code" width="60px;" id="img_captcha" onclick="refreshCaptcha()" title="看不清，点击换一张！" >
				                    </div>
				                </div>
			                </div>
			                <div class="row" style="padding:5px 0px;color: #ffffff;">
			                    <div class="col-sm-12" style="position:relative;">
			                    	<div style="position: absolute;left: 65px;"><a href="${ctx}/anon/register" style="font-size: 12px;color: #ffffff">注册<a></div>
			                    	<div style="position: absolute;right:16px;"><a style="font-size: 12px;color: #ffffff">忘记密码<img src="${ctx}/public/css/images/wenhao.png" width="18px"></a></div>
				                </div>
			                </div>
				    	</div>
				    </div>
				    <div class="row" style="text-align: center;margin-top: 60px;">
						<div class="col-sm-12">
						 	<div class="form-group">
								 <div class="col-sm-12" >
									<button class="btn btn-white" type="submit" style="font-size: 14px;color: #019fea;width: 100%;padding: 10px 12px;background-color:#019fea;border:none;color:#ffffff;">确定登陆</button>
								</div>
							</div>
						</div>
					</div>
			    </form>
			</div>
		</div>
	</div> --%>
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
	
	var $form = $('#form_login');
	$form.validate();
	
	$('#btn_sumbit').click(function(){
		 common.submitForm($form,function(res){
			 common.rdUrl('${ctx}/main');
         });
		
	});
	
});

function refreshCaptcha(){  
    document.getElementById("img_captcha").src="${ctx}/code?t=" + Math.random();  
}
</script>
</body>
</html>
