<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<title>找回密码</title>
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/common.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/newmain.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/sk.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/sweetalert/sweetalert.css">
	<style type="text/css">
		.toBottom {
		  background-image:-webkit-linear-gradient(to bottom, #dddee0, #ffffff);
		  background-image:linear-gradient(to bottom, #dddee0, #ffffff);
		}
		.width1200 {
		    width: 1280px;
		    margin: 0 auto;
		    overflow: hidden;
		}
		.error{color: red;}
	</style>
	<script src="${ctx}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctx}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
	<script src="${ctx}/public/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
</head>
<body>
	<div class="header">
		<div style="background: #04184a;">
		    <div class="geren" style="padding: 30px;color: #ffffff;margin-left: 10%;">
                    <div style="letter-spacing: 5px;font-size: 36px;height: 60px;float: left;"> 场地管理SAAS系统</div>
                    <div style="height: 60px;float: left;margin: 10px;">
                   		<a href="${ctx}/login" style="border: 1px solid #ffffff;height: 40px;line-height:40px;border-radius: 5px;cursor: pointer;color: #ffffff;padding: 0 20px;">返回登录界面</a>
                    </div>
	                <div style="clear: both;"></div>
	        </div>
		</div>
	</div>
	<div class="sjzx">
		<div class="sjzxnav" style="height: 12px;">
		</div>
	</div>
	<div class="sjzx">
		<div class="toBottom" style="height: 24px;">
		</div>
	</div>
	<div class="content" style="background-color:#fcfdff;">
		<div id="pcontent" class="width1200 jiudianxq grdpxq sjzx" style="min-height:664px;position: relative;background-color:#fcfdff;padding: 0 10px;">
			<div style=""></div>
			<div class="row" style="padding:15px 50px;">
				<div class="col-sm-12 ${clazs}">
				
				</div>
			</div>
			<div class="row" style="padding: 15px 50px;text-align: center;">
				<div class="col-sm-3 step-txt ${active<=3?'step-active':'' }" style="">
					请输入账号 &nbsp;&nbsp;
				</div>
				<div class="col-sm-2">
					<div></div>
				</div>
				<div class="col-sm-2 step-txt ${active<=2?'step-active':'' }">选择找回密码方式</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-3 step-txt ${active<=1?'step-active':'' }" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;找回密码</div>
			</div>
			
			<div class="row" style="padding:15px 0;">
				<div class="col-sm-12">
				<hr style="border-top: 4px solid #eee;"/>
				</div>
			</div>
			<c:if test="${step eq 'VerifyAccount' }">
				<div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-2" style="text-align: right;">
	                    	<span style="line-height: 40px;font-size: 16px;">邮箱或手机：</span>
                    	</div>
						<div class="col-sm-10 step-txt">
							<input type="text" id="account" name="account" class="form-control m-b" placeholder=""  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
						</div>
					</div>
					 <div class="row" style="padding:10px 25px;">
					 	<div class="col-sm-2" style="text-align: right;">
	                    	<span  style="line-height: 40px;font-size: 16px;">验证码：</span>
                    	</div>
	           	  		<div class="col-sm-10 step-txt" style="">
	                    	<input type="text" id="captcha" name="captcha" class="form-control m-b" placeholder=""  style="display: inline-block;width: 35%;height: 34px;padding: 20px 12px;"/>
	                    	<span style="display: inline-block;width: 14%;text-align: right;"><img id="img_captcha" src="${ctx}/code" style="height: 42px;border: none;border-radius: 5px;cursor: pointer;" onclick="refreshCaptcha()" title="看不清，点击换一张！" ></span>
	                    </div>
                    </div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-2">
						</div>
						<div class="col-sm-10" style="text-align: left;">
							  <button id="nextstep" class="btn btn-primary btn-block" style="display: inline-block;margin-top: 15px;width: 120px;font-size: 20px;font-weight: 300;padding: 8px 12px;" type="button">下一步</button>
						</div>
					</div>
					<div class="row" style="padding:15px 25px;">
						<div class="col-sm-2">
						</div>
						<div class="col-sm-10">
							  <a href="${ctx}/login" style="font-size: 20px;width: 120px;">返回登录</a>
						</div>
					</div>
					<script type="text/javascript">
						$(function(){
							var ff='<div class="spiner-example" style="padding-top: 400px;"><div class="sk-spinner sk-spinner-fading-circle" style="width:64px;height:64px;">'
							   	+' <div class="sk-circle1 sk-circle"></div>'
							   	+' <div class="sk-circle2 sk-circle"></div>'
							   	+' <div class="sk-circle3 sk-circle"></div>'
							   	+' <div class="sk-circle4 sk-circle"></div>'
							   	+' <div class="sk-circle5 sk-circle"></div>'
							   	+' <div class="sk-circle6 sk-circle"></div>'
							   	+' <div class="sk-circle7 sk-circle"></div>'
							   	+' <div class="sk-circle8 sk-circle"></div>'
							   	+' <div class="sk-circle9 sk-circle"></div>'
							   	+' <div class="sk-circle10 sk-circle"></div>'
							   	+' <div class="sk-circle11 sk-circle"></div>'
							   	+' <div class="sk-circle12 sk-circle"></div></div></div>';
						   	var $maskDiv=  $('<div id="marks" class="modal-backdrop fade in" style="z-index:10000;display:none;">'+ff+'</div>').appendTo('body');
							   	
							
						   	$("#img_captcha").click(function(){
								$(this).attr('src',"${ctx }/code?t=" + Math.random());
								//document.getElementById("img_captcha").src="${ctx }/code?t=" + Math.random();  
							});
							
							$("#nextstep").click(function(){
								var account = $("#account").val();
								var captcha = $("#captcha").val();
								if(account==null||account==""){
									swal("请输入邮箱或手机！","error")
									return;
								}
								if(captcha==null||captcha==""){
									swal("请输入验证码！","error")
									return;
								}
								$.post("${ctx}/anon/iforgot/password/verifyaccount",{account:account,captcha:captcha},function(res){
									$maskDiv.show();
									if(res.statusCode==="200"){
										location.href="${ctx}/anon/iforgot/password/reset?action=VerifySuccess"
									}else{
										swal(res.message,"error");
										$maskDiv.hide();
									}
								},"json");
							});
						});
					</script>
				</div>
			</c:if>
			<c:if test="${step eq 'GetPwdType' }">
				<div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-12 step-txt">
							<span style="margin-left: 80px;font-size: 24px;font-weight: bold;color: #000000;">您正在找回${user.username}的密码
							<a href="${ctx}/anon/iforgot/password/reset?action=VerifyAccount" style="display: inline-block;width: 160px;">[换一个账号]</a>
							</span>
						</div>
					</div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-12" >
							  <a id="emailtype" href="javascript:;" style="margin-left: 80px;font-size: 20px;width: 150px;">【1.通过邮箱】</a>
						</div>
					</div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-12">
							  <a id="mobiletype"  href="javascript:;" style="margin-left: 80px;font-size: 20px;width: 150px;">【2.通过手机】</a>
						</div>
					</div>
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-12">
							 <span style="margin-left: 80px;font-size: 20px;">【3.通过客服】	请联系客服进行处理</span>
						</div>
					</div>
					<script type="text/javascript">
						$(function(){
							$("#emailtype").click(function(){
								location.href="${ctx}/anon/iforgot/password/reset?action=SelPwdType&type=EMAIL";
							});
							$("#mobiletype").click(function(){
								location.href="${ctx}/anon/iforgot/password/reset?action=SelPwdType&type=MOBILE";
							});
						});
					</script>
				</div>
			</c:if>
			
			<c:if test="${step eq 'ResetPwd' }">
			<form id="form" action="${ctx}/anon/iforgot/user/pwd/save" method="post" class="" style="">
				<input type="hidden" name="type" value="${type}">
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-12 step-txt">
						<span style="margin-left: 80px;font-size: 24px;font-weight: bold;color: #000000;">您正在找回${user.username}的密码
						<a href="${ctx}/anon/iforgot/password/reset?action=VerifySuccess" style="display: inline-block;width: 200px;">[换一个找回方式]</a>
						</span>
					</div>
				</div>
				<c:if test="${type eq 'MOBILE' }">
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;">注册手机：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<span  style="line-height: 40px;color:#333;">${fn:substring(user.mobile, 0, 3)}****${fn:substring(user.mobile, 7, 11)}</span>
					</div>
				</div>
				</c:if>
				<c:if test="${type eq 'EMAIL' }">
					<div class="row" style="padding:10px 25px;">
						<div class="col-sm-4 step-txt" style="text-align: right;">
							<span  style="line-height: 40px;color:#333;">注册邮箱：</span>
						</div>
						<div class="col-sm-8 step-txt">
							<span  style="line-height: 40px;color:#333;">${email}</span>
						</div>
					</div>
				</c:if>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;">验证码：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="text" maxlength="6" id="mcaptcha" name="mcaptcha" class="form-control m-b" placeholder=""  style="display: inline-block;width: 30%;height: 34px;padding: 20px 12px;"/>
						<div id="btn_send_sms" class="btn btn-warning" style="display:inline-block;padding: 8px 18px;width: 19%;font-size: 16px;">获取验证码</div>
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;">新密码：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="password"  name="password" id="password" class="form-control m-b" placeholder=""  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span style="line-height: 40px;color:#333;">确认密码：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="password"  name="cfpassword" class="form-control m-b" placeholder=""  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
					</div>
					<div class="col-sm-8 step-txt">
						 <button id="btn_submit" class="btn btn-primary btn-block" style="display: inline-block;width: 120px;font-size: 20px;font-weight: 300;padding: 8px 12px;" type="button">提交修改</button>
					</div>
				</div>
				</form>
				<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
				<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
				<script type="text/javascript">
					$(function(){
						var e = "<i class='fa fa-times-circle'></i> ";
						$("#form").validate({
					        rules: {
					        	mcaptcha: "required",
					        	password: {
			                        required:true,
			                        rangelength:[6,10]
			                    },
					        	cfpassword: {
			                        equalTo:"#password"
			                    }                
					        },
					        messages: {
					        	mcaptcha: e + "请输入验证码",
					        	password:{
			                        required: e + "不能为空",
			                        rangelength: $.format(e + "密码最小长度:{0}, 最大长度:{1}。")
			                    },
					        	cfpassword:{
			                        equalTo:e +"两次密码输入不一致"
			                    }              
					        },
					        submitHandler: function(form) {
					            var url = $(form).attr("action");
					            var data = $(form).serialize();
					            var id = $("#id").val();
					       　		$.post(url, data, function (res, status) { 
					       　			if(status=="success"&&res.statusCode=="200"){
					       　				swal(res.message, "success");
					       　				location.href="${ctx}/anon/iforgot/password/reset?action=RESETSUCCESS";
					       　			}else{
					       　				swal(res.message, "error");
					       　			}
					       　		}, 'json'); 
					         }  
					    });
						$('#btn_submit').click(function(){
							$("#form").submit();
						});
						$('#btn_send_sms').click(function(){
							var $this = $(this);
							if($this.hasClass('captcha-disable')){
								return;
							}
							$.post('${ctx}/anon/sendcode?type=${type}','',function(res){
								$this.addClass('captcha-disable');
								var timeSecond = 60;
								smsIntervalId = setInterval(function(){
									$this.text(--timeSecond);
									if(timeSecond == 0){
										clearInterval(smsIntervalId);
										$this.removeClass('captcha-disable');
										$this.text('获取验证码');
									}
								},1000);
							},"json");
						});
					});
					
					
				</script>
			</c:if>
			
			<c:if test="${step eq 'ResetSuc' }">
				<div class="row" style="padding:15px 25px;">
					<div class="col-sm-12 step-txt">
						<span style="margin-left: 80px;font-size: 24px;font-weight: bold;color: #000000;">您的密码找回成功！
						<a href="${ctx}/login" style="display: inline-block;width: 200px;">[前去登录]</a>
						</span>
					</div>
				</div>
			</c:if>
		</div>
	</div> 
	 <div class="footer" style="height: 85px;width: 100%;">
		 <hr style="border-top: 4px solid #eee;padding:0;"/>
	    <div style="background: #fcfdff;">
	        <div class="width1000" style="color: #c8c8c9;text-align: center;vertical-align: middle;">
	             &copy;2012-2017会掌柜  版权左右  ALL Right Reserved(粤ICP备15048082号-1)
	        </div>
	    </div>
	</div> 

</body>
</html>