<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>登录</title>
    <meta name="description" content="会掌柜（hui-china.com)是中国最全面的会议活动场所和服务供应商资源网站，允许专业人士和会议活动举办人员找到适合会议和活动的空间场所和服务供应商如：主持人，活动策划公司，摄影摄像师，活动搭建物料，舞台灯光音响设备等，协助他们顺利展开未来的会议活动。实现用户“好办会、办好会”，做办会议搞活动必备一站式资源搜索工具。">
    <meta name="Keywords" content="会掌柜,会议活动场地,公关会议活动策划执行公司,会展会议活动物料出租,演出演艺公司主持策划舞美设计,灯光音响LED摄影摄像设备,展览舞美制作工厂">
    <link href="${ctx}/public/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/public/hplus/css/animate.min.css" rel="stylesheet">
    <%-- <link href="${ctx}/public/hplus/css/style.min.css" rel="stylesheet"> --%>
    <link href="${ctx}/public/hplus/css/login.min.css" rel="stylesheet">
    <link href="${ctx}/public/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link href="${ctx}/public/bootstrap/validator/css/bootstrapValidator.min.css" rel="stylesheet">
    <!-- sweetalert -->
	<link href="${ctx}/public/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
	
	<style type="text/css">
		body{font: 12px/25px Microsoft YaHei, Arial, Helvetica, sans-serif;margin: 0; }
		.form-control{  height: 50px;padding: 12px 12px;border-radius: 5px;}
		.btn{  height: 50px;padding: 12px 12px;border-radius: 5px;}
		a {color: #ffffff;text-decoration: underline;}
		.checkbox label::before{top:4px;}
	</style>
    <script src="${ctx}/public/hplus/js/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/public/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
  	<script src="${ctx}/public/hplus/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx}/public/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>
        if(window.top!==window.self){window.top.location=window.location};
    </script>
	<script type="text/javascript">
		if (typeof e_u_i != 'undefined') {
			//alert();
			swal("由于您长时间没有操作，请重新登录！", "error");
			top.location.href = "${ctx}/main";
		}
		function salert(msg,type){
			swal(msg, type);
		}
		
		//alert('${not empty loginError}'=='false');
		if('${not empty loginError}'=='true'){
			alert("${loginError}");
		}
		
	</script>
	<script>
		if (typeof easyUi != 'undefined') {
			alert("由于您长时间没有操作，请重新登录！");
			top.location.href = "${ctx}/main";
		}
	</script>
</head>

<body class="signin">
    <div class="signinpanel" style="margin: 12% auto 0;">
        <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-6" style="position: relative;">
                <form id="loginForm" method="post" action="${ctx}/zgui/login" >
                    <h1 style="text-align: center;letter-spacing:5px">场地管理SAAS系统</h1>
                    <input type="text" id="username" name="username" class="form-control" placeholder="用户名" onblur="GetPwdAndChk();"/>
                    <input type="password" id="password" name="password" class="form-control m-b" placeholder="密码" />
                    <div class="row">
	           	  		<div class="col-sm-8" style="padding-right: 0;height: 50px;line-height: 50px;">
	                    	<input type="text"  name="captcha" class="form-control m-b" placeholder="验证码"  style="display: inline-block;width: 100%;"/>
	                    </div>
	           	  		<div class="col-sm-4" >
	                    <span style="display: inline-block;width: 100%;margin-top: 15px;"><img id="img_captcha" src="${ctx}/code" style="height: 50px;border: none;width: 100%;border-radius: 5px;" onclick="refreshCaptcha()" title="看不清，点击换一张！" ></span>
	                    </div>
                    </div>
                    <div class="row">
	           	  		<div class="col-sm-3" style="padding-right: 0;margin-top: 15px;">
	           	  			<div class="checkbox">
                                 <input id="rempwd" type="checkbox">
                                 <label for="rempwd">
                                     	记住密码
                                 </label>
                             </div>
                             </div>
		           	  <div class="col-sm-5" style="padding-right: 0;line-height: 50px;margin-top: 15px;">
		           	  		<a href="${ctx}/anon/iforgot/password/reset">忘记密码？</a>
		           	  		&nbsp;&nbsp;
		           	  		<a href="${ctx}/anon/register">注册</a>
	           	  		</div>
	           	  		<div class="col-sm-4" >
		                    <button class="btn btn-primary btn-block" style="display: inline-block;margin-top: 15px;width: 100%;font-size: 18px;font-weight: 300;" type="submit">登 录</button>
		           	  	</div>
	           	  </div>
                </form>
            </div>
        </div>
    </div>
    <div class="signup-footer" style="margin: 15% auto 0;">
         <div class="row" style="margin: 0;">
         	  <div class="col-sm-12" style="position: relative;text-align: center;font-size: 16px;">
         	  	<img class="gerenBnLfLo" src="${ctx}/public/hplus/img/loginlogo.png" style="height: 45px;">
              &copy;2012-2017会掌柜  版权左右  ALL Right Reserved(粤ICP备15048082号-1)
             </div>
          </div>
    </div>
    <script id="ddd" type="text/javascript">
    	var key = "2531123456963258"
    </script>
    
<script type="text/javascript" src="${ctx}/static/plugins/CryptoJS/rollups/aes.js"></script>
<script type="text/javascript" src="${ctx}/static/plugins/CryptoJS/components/mode-ecb-min.js"></script>
<script type="text/javascript" src="${ctx}/static/plugins/CryptoJS/components/pad-nopadding-min.js"></script>
<script type="text/javascript">
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
	function show(){
	   $("#marks").show();
	}
	function hide(){
		$("#marks").hide();
	}
	var mykey = CryptoJS.enc.Utf8.parse(key);
	$().ready(function() {
	   	var $maskDiv=  $('<div id="marks" class="modal-backdrop fade in" style="z-index:9986;display:none;">'+ff+'</div>').appendTo('body');
	    var e = "<i class='fa fa-times-circle'></i> ";
		$("#loginForm").validate({
	        rules: {
	        	username: "required",
	        	password: "required",
	        	captcha: "required"
	        },
	        messages: {
	        	username: e + "请输入用户名！",
	        	password: e + "请输入密码！",
	        	captcha: e + "请输入验证码！"       
	        },
	        submitHandler: function(form) {
	        	//show();
	            var url = $(form).attr("action");
	            var data = $(form).serialize();
	       　		$.post(url, data, function (res, status) { 
	       　			if(res.success){
	       　				SetPwdAndChk();
	                	location.href="${ctx}/main";
	               	}else{
	               		ResetCookie();
	               		swal(res.msg, "error");
	               	}
	       　		}, 'json');  
	         }  
	    });
		
	    $("#ddd").remove();
	});
	function refreshCaptcha(){  
	    document.getElementById("img_captcha").src="${ctx }/code?t=" + Math.random();  
	}
	function SetPwdAndChk() {  
	    var usr = document.getElementById('username').value;  
	    var checked = document.getElementById('rempwd').checked;  
	    if (checked == true) {  
	        var pwd = document.getElementById('password').value;  
	        var encrypted = aesEncrypt(pwd, mykey);
	        var expdate = new Date();  
	        expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));  
	        SetCookie(usr, encrypted, expdate);  
	    } else {  
	        ResetCookie();  
	    }  
	};  
	
	function GetPwdAndChk() {  
	    var usr = document.getElementById('username').value;  
	    var pwd = GetCookie(usr);  
	    if (pwd != null) {  
	    	var decrypt = aesDecrypt(pwd.toString(), mykey);
	        document.getElementById('rempwd').checked = true;  
	        document.getElementById('password').value = decrypt;  
	    } else {  
	        document.getElementById('rempwd').checked = false;  
	        document.getElementById('password').value = "";  
	    }  
	};  
	function GetCookie(name) {  
	    var arg = name + "=";  
	    var alen = arg.length;  
	    var clen = document.cookie.length;  
	    var i = 0;  
	    while (i < clen) {  
	        var j = i + alen;  
	        //alert(j);   
	        if (document.cookie.substring(i, j) == arg)  
	            return getCookieVal(j);  
	        i = document.cookie.indexOf(" ", i) + 1;  
	        if (i == 0)  
	            break;  
	    }  
	    return null;  
	};  
	
	function getCookieVal(offset) {  
	    var endstr = document.cookie.indexOf(";", offset);  
	    if (endstr == -1)  
	        endstr = document.cookie.length;  
	    return unescape(document.cookie.substring(offset, endstr));  
	};  
	function SetCookie(name, value, expires) {  
	    var argv = SetCookie.arguments;  
	    var argc = SetCookie.arguments.length;  
	    var expires = (argc > 2) ? argv[2] : null;  
	    var path = (argc > 3) ? argv[3] : null;  
	    var domain = (argc > 4) ? argv[4] : null;  
	    var secure = (argc > 5) ? argv[5] : false;  
	    document.cookie = name  
	            + "="  
	            + escape(value)  
	            + ((expires == null) ? "" : ("; expires=" + expires  
	                    .toGMTString()))  
	            + ((path == null) ? "" : ("; path=" + path))  
	            + ((domain == null) ? "" : ("; domain=" + domain))  
	            + ((secure == true) ? "; secure" : "");  
	};  
	function ResetCookie() {  
	    var usr = document.getElementById('username').value;  
	    var expdate = new Date();  
	    SetCookie(usr, null, expdate);  
	}
	function aesEncrypt(data, key) {
	    var encrypted = CryptoJS.AES.encrypt(data, key, {
	        mode: CryptoJS.mode.ECB,
	        padding: CryptoJS.pad.Pkcs7
	    });
	    return encrypted.toString();
	}
	
	function aesDecrypt(encrypted, key) {
	    var decrypted = CryptoJS.AES.decrypt(encrypted, key, {
	        mode: CryptoJS.mode.ECB,
	        padding: CryptoJS.pad.Pkcs7
	    });
	    decrypted = CryptoJS.enc.Utf8.stringify(decrypted);// 转换为 utf8 字符串
	    return decrypted;
	}
</script>
</body>
</html>
