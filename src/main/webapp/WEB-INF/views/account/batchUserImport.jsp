<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">	<div style="padding: 20px;">
		<div id="btn_submit" class="btn btn-primary" style="margin:0 auto;border-radius:3px;" onclick="choseFile();">点击选择文件</div>
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
			<img src="${ctx}/static/resource/css/images/excel.jpg" style="width: 32px;float: left;margin-left: 5px;"/>
			<div id="filename" style="float: left;margin-left: 5px;line-height: 32px;">销售人员表.xls</div>
			<div style="clear: both;">
			</div>
		</div>
	</div>
	<div id="uploadBtn" style="padding: 20px;display: none;">
		<div  class="btn btn-primary" style="margin:0 auto;border-radius:3px;"  onclick="doUpload()">上传</div>
	</div>
	<div id="uploadmsg" style="padding: 20px;display: none;word-wrap: break-word;word-break: break-all;">
	</div>


<%-- <script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script> --%>

<script>
$(function(){
	
	/* $('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	 */
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
         url: '${ctx}/weixin/user/upload?crtusrty=${crtusrty}' ,  
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
     			user_search();
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
</div>
