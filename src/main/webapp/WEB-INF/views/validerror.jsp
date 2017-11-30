<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<title>验证错误</title>
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
			
		</div>
	</div> 
	 <div class="footer" style="height: 85px;width: 100%;position: absolute;bottom: 0;">
		 <hr style="border-top: 4px solid #eee;padding:0;"/>
	    <div style="background: #fcfdff;">
	        <div class="width1000" style="color: #c8c8c9;text-align: center;vertical-align: middle;">
	             &copy;2012-2017会掌柜  版权左右  ALL Right Reserved(粤ICP备15048082号-1)
	        </div>
	    </div>
	</div> 

</body>
</html>