<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>添加商品</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		.input-file{position:absolute;opacity:0;width: 5rem;height: 2rem;z-index:99;top: 0;left: 0;}
   		.input-file-size{width: 10rem;height: 10rem;}
   		.img_integral{position:absolute;z-index:77;width: 5rem;height: 2rem;top: 0;left: 0;}
   		.img_integral-size{width: 10rem;height: 10rem;}
    </style>
    
</head>

<body class="" style="height:100%;">
	
	<form id="form_add" action="${ctx}/weixin/hotel/integral/save" method="post" class="form-control" style="">
		<input type="hidden" id="id" name="id" value=""/>
		<input type="hidden" id="base64Img" name="base64Img" value=""/>
		<input type="hidden" id="img" name="img" value="${img }"/>
		<div class="form-group" >
			<div style="">商品名称：</div>
			<div class="input-parent" style="">
				<input class="input-form required" name="name" type="text" style=""/>
			</div>
		
		</div>
		<div class="form-group" >
			<div style="">商品价格：</div>
			<div class="input-parent" style="">
				<input class="input-form required" name="price" type="number" style=""/>
			</div>
		</div>
		
		<div class="form-group" >
			<div style="">会掌柜价：</div>
			<div class="input-parent" style="">
				<input class="input-form required" name="zgprice" type="number" style=""/>
			</div>
		</div>
		
		<div class="form-group" >
			<div style="">兑换积分：</div>
			<div class="input-parent" style="">
				<input class="input-form" name="integral" type="number" style=""/>
			</div>
		</div>
		
		<div class="form-group" >
			<div style="">商品图片：</div>
			<div class="" style="margin:0 auto;position:relative;text-align: left;width: 100%;">
				<%-- <img class="" alt="" src="${ctx}/static/weixin/css/icon/icon-integral-img-add.png" style="height: 2rem;"> --%>
				<input id="input_file_photo" type="file" name="filedata" accept="image/*"  class="input-file" />
				<img id="img_integral" class="img_integral" src="${ctx}/static/weixin/css/icon/icon-integral-img-add.png" />
			</div>
		</div>
		
	</form>
	
	<div id="btn_save" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;position:fixed;left:5%;bottom:5%;">确定添加</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>

<script src="${ctx}/static/weixin/myjs/LocalResizeIMG.js"></script>
<script src="${ctx}/static/weixin/myjs/mobileBUGFix.mini.js"></script>
<script src="${ctx}/static/weixin/myjs/exif.js"></script>
<script>

$(function(){
	common.ctx =  '${ctx}';
	
	var $form = $('#form_add');
	$form.validate();
	
	$('#btn_save').click(function(){
		 common.submitForm($form,function(res){
			 common.toast('提交成功！');
			 
			 setTimeout(function(){
				 common.rdUrl('${ctx}/weixin/hotel/integral/index');
			 },1500);
         });
		
	});
	$('#input_file_photo').localResizeIMG({
	      width: 320,
	      quality: 1,
	      before:function(_this, blob, file){
	    	  
	      },
	      success: function (result) {
	    	  $('#input_file_photo').addClass('img_integral-size');
	    	  $('#img_integral').attr('src',result.base64).addClass('img_integral-size');
	    	  $('#base64Img').val(result.clearBase64);
		  }
	});
	
	/* $('.integral-img').click(function(){
		
	}); */
	
	
});
</script>
</html>
