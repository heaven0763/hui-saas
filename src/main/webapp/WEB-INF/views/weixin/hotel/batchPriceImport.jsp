<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>批量导入场地价格</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   
    
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div style="padding: 20px;">
		<div id="btn_submit" class="btn btn-lg bg-type-01" style="margin:0 auto;border-radius:3px;" onclick="choseFile();">点击选择文件</div>
	</div>
	<div style="padding: 10px 20px;">
		<p>PS:请选择Execl文件！</p>
	</div>
	<form id= "uploadForm">  
	      <p style="display: none;">上传文件： <input id="file" type="file" name="excel"  onchange="choseFileChange(this.value);"/></ p>  
	      <input type="button" value="上传" onclick="doUpload()" />  
	</form>  
	<div id="filedetail" style="padding: 0 20px;display: none;">
		<div style="border: 1px solid #f5f5f5;padding: 10px 0;">
			<img src="${ctx}/static/css/images/excel.gif" style="width: 32px;float: left;margin-left: 5px;"/>
			<div id="filename" style="float: left;margin-left: 5px;line-height: 32px;">销售人员表.xls</div>
			<div style="clear: both;">
			</div>
		</div>
	</div>
	<div id="uploadBtn" style="padding: 20px;display: none;">
		<div  class="btn btn-lg bg-type-01" style="margin:0 auto;border-radius:3px;"  onclick="doUpload()">上传</div>
	</div>
	<div id="uploadmsg" style="padding: 20px;display: none;word-wrap: break-word;word-break: break-all;">
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>

<script>
$(function(){
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
});
function choseFile(){
	$("#file").click();
}
function choseFileChange(filename){
	var extName = filename.substring(filename.lastIndexOf(".")+1);
	if(extName==="xls"||extName==="xlsx"){
		$("#filename").text(filename.substring(filename.lastIndexOf("\\")+1));
		$("#uploadBtn").show();
		$("#filedetail").show();
		$("#uploadmsg").hide();
	}else{
		common.toast('请选择Excel文件上传！');
		return;
	}
}
function doUpload(){  
    var formData = new FormData($( "#uploadForm" )[0]);  
    $.ajax({  
         url: '${ctx}/weixin/hotel/price/upload' ,  
         type: 'POST',  
         data: formData,  
         async: false,  
         cache: false,  
         contentType: false,  
         processData: false,  
         success: function (res) {  
       	 	if(res.statusCode=='200'){
     			common.toast('上传成功！');
     			//location.href="${ctx}/weixin/user/invitation/index"
     			$("#filename").text('');
     			$("#uploadBtn").hide();
     			$("#filedetail").hide();
     			$("#uploadmsg").text(res.message);
     			$("#uploadmsg").show();
     		}else{
     			common.toast(res.message);
     		}
         },  
         error: function (res) {  
        	 common.toast('上传失败！');
         }  
    });  
}

function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}
</script>
</html>
