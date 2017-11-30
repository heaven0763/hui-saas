<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<title>验证账号</title>
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/common.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/newmain.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/sk.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/sweetalert/sweetalert.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
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
		i{font-style: normal;color: red;}
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
                   		<a href="${ctx}/login" style="border: 1px solid #ffffff;height: 40px;line-height:40px;border-radius: 5px;cursor: pointer;color: #ffffff;padding: 0 20px;">欢迎注册</a>
                    </div>
                     <div style="height: 60px;float: right;margin-right: 20%;;margin-top: 10px;">
                     <a href="${ctx}/login" style="color: #ffffff;cursor: pointer;">已有账号？请登录</a>
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
			<div></div>
			<div class="row" style="padding:15px 50px;">
				<div class="col-sm-12 step2">
				
				</div>
			</div>
			<div class="row" style="padding: 10px 50px;text-align: center;">
				<div class="col-sm-3 step-txt step-active" style="">
					填写个人信息 &nbsp;&nbsp;
				</div>
				<div class="col-sm-2">
					<div></div>
				</div>
				<div class="col-sm-2 step-txt step-active">验证账号</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-3 step-txt" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加入团队</div>
			</div>
			
			<div class="row" style="padding:10px 0;">
				<div class="col-sm-12">
				<hr style="border-top: 4px solid #eee;"/>
				</div>
			</div>
			
			<form id="form" action="${ctx}/anon/dovalid" method="post" class="" style="">
				
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">手机号码：</span>
					</div>
					<div class="col-sm-8 step-txt" style="padding:15px 25px;color:#333;">
						${reguser.mobile}
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">验证码：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="text" maxlength="6" id="captcha" name="captcha" class="form-control m-b" placeholder=""  style="display: inline-block;width: 30%;height: 34px;padding: 20px 12px;"/>
						<div id="btn_send_sms" class="btn btn-warning" style="display:inline-block;padding: 6px 12px;width: 19%;font-size: 20px;">获取验证码</div>
					</div>
				</div>
				
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4" style="text-align: right;">
					</div>
					<div class="col-sm-8 step-txt">
						 <button id="btn_submit" class="btn btn-primary" style="display: inline-block;width: 120px;font-size: 20px;font-weight: 300;padding: 8px 12px;" type="button">提交验证</button>
					</div>
				</div>
				</form>
				<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
				<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
				<script type="text/javascript">
					var flag = 0;
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
						   	
						
						$('#btn_submit').click(function(){
							var captcha = $("#captcha").val();
							if(captcha==null||captcha===""){
								swal("请输入验证码！","error");
								return;
							}
							if(flag==0){
								flag = 1;
								$maskDiv.show();
								$.post('${ctx}/anon/dovalid',{captcha:captcha},function(res){
									if(res.statusCode==="200"){
										swal(res.message,"success");
										setTimeout(function(){
											location.href="${ctx}/anon/jointeam";
										},3000);
									}else{
										swal(res.message,"error");
										flag = 0;
										$maskDiv.hide();
									}
								},"json");
							}
							
						});
						$('#btn_send_sms').click(function(){
							var $this = $(this);
							if($this.hasClass('captcha-disable')){
								return;
							}
							$.post('${ctx}/anon/sendcode?type=MOBILE','',function(res){
								if(res.statusCode==="200"){
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
								}else{
									swal("获取失败，请重新获取！","error");
								}
								
							},"json");
						});
					});
				</script>
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