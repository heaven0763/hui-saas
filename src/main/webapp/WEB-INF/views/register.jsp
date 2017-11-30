<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<title>注册会员</title>
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
		.rpd{padding:10px 25px;}
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
				<div class="col-sm-12 step1">
				
				</div>
			</div>
			<div class="row" style="padding: 15px 50px;text-align: center;">
				<div class="col-sm-3 step-txt step-active" style="">
					填写个人信息 &nbsp;&nbsp;
				</div>
				<div class="col-sm-2">
					<div></div>
				</div>
				<div class="col-sm-2 step-txt">验证账号</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-3 step-txt" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加入团队</div>
			</div>
			
			<div class="row" style="padding:10px 0;">
				<div class="col-sm-12">
				<hr style="border-top: 4px solid #eee;"/>
				</div>
			</div>
			
			<form id="form" action="${ctx}/anon/doreg" method="post" class="" style="">
				
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">账号<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="tel" maxlength="11" id="account" name="account" class="form-control m-b" placeholder="请输入手机号"  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">姓名<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="text" id="rname" name="rname" class="form-control m-b" placeholder="请输入姓名"  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">邮箱<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="email" id="email" name="email" class="form-control m-b" placeholder="请输入电子邮箱"  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span  style="line-height: 40px;color:#333;font-size: 16px;">密码<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="password"  name="password" id="password" class="form-control m-b" placeholder="请输入至少6位密码"  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span style="line-height: 40px;color:#333;font-size: 16px;">确认密码<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="password"  name="cfpassword" class="form-control m-b" placeholder="请确认密码"  style="display: inline-block;width: 50%;height: 34px;padding: 20px 12px;"/>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
						<span style="line-height: 40px;color:#333;font-size: 16px;"></span>
					</div>
					<div class="col-sm-8">
						<div class="checkbox">
                            <input id="agreement" name="agreement" type="checkbox" value="1" checked="checked">
                            <label for="agreement">
                               		 我同意<a href="${ctx}/anon/agreement" target="_blank" style="display: inline-block;">服务条款</a>
                            </label>
                        </div>
					</div>
				</div>
				<div class="row rpd">
					<div class="col-sm-4" style="text-align: right;">
					</div>
					<div class="col-sm-8 step-txt">
						 <button id="btn_submit" class="btn btn-primary" style="display: inline-block;width: 120px;font-size: 20px;font-weight: 300;padding: 8px 12px;" type="submit">下一步</button>
						 <button id="btn_reset" class="btn btn-default" style="display: inline-block;width: 120px;font-size: 20px;font-weight: 300;padding: 8px 12px;" type="reset">重置</button>
					</div>
				</div>
				</form>
				<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
				<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
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
						   	
						
						$.validator.addMethod("phone", function(value, element, param){
						    return new RegExp(/^1[3578]\d{9}$/).test(value);
						}, "手机号码不正确");
						var e = "<i class='fa fa-times-circle'></i> ";
						$("#form").validate({
					        rules: {
					        	account: {
			                        required:true,
			                        phone:true
			                    },
					        	rname: "required",
					        	email: {
			                        required:true,
			                        email:true
			                    },
					        	password: {
			                        required:true,
			                        rangelength:[6,10]
			                    },
					        	cfpassword: {
			                        equalTo:"#password"
			                    }                
					        },
					        messages: {
					        	account: {
			                        required: e + "不能为空",
			                        phone: e + "请输入正确的手机号码格式！"
			                    },
			                    rname: e + "不能为空",
			                    email: {
			                        required: e + "不能为空",
			                        email: e + "请输入正确的电子邮箱格式！"
			                    },
					        	password:{
			                        required: e + "不能为空",
			                        rangelength: $.format(e + "密码最小长度:{0}, 最大长度:{1}。")
			                    },
					        	cfpassword:{
			                        equalTo:e +"两次密码输入不一致"
			                    }              
					        },
					        submitHandler: function(form) {
					        	$maskDiv.show();
					            var url = $(form).attr("action");
					            var data = $(form).serialize();
					            if($("#agreement").prop('checked')){
					            	$.post(url, data, function (res, status) { 
						       　			if(status=="success"&&res.statusCode=="200"){
						       　				//swal(res.message, "success");
						       　				setTimeout(function(){
							       　				location.href="${ctx}/anon/registervalid";
											},3000);
						       　			}else{
						       　				swal(res.message, "error");
						       　				$maskDiv.hide();
						       　			}
						       　		}, 'json');
					            }else{
					            	swal("请选择服务条款！","error");
					            	return;
					            }
					         }  
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