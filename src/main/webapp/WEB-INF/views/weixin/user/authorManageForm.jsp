<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>临时授权</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		.per-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
   		.down-div{
	   		background-image: url(${ctx}/static/weixin/css/icon/common/arrow-right.png);
		    background-size: 20px;
		    background-repeat: no-repeat;
		    background-position: right;
   		}
   		.bg-none-01{border: 1px solid #ffffff;color: #ffffff;}
   		.bg-item-checked{border: 1px solid #FFB42B;color: #ffffff;background-color: #FFB42B;}
    </style>
    
</head>

<body class="" style="height:100%;">
	
	<form id="form_tmppms" action="${ctx }/weixin/user/author/tmp/save" method="post" class="form-control" style="">
		<input type="hidden" name="userId" value="${tuser.id }">
		<input type="hidden" name="pmsids" id="pmsids" value="">
		<div class="form-group" style="">
			<div style="">接受人：</div>
			<div class="input-parent per-div" style=" " rdurl="${ctx }/weixin/user/author/tmp/users?fromuserId=${fromuserId}">
				<input class="input-form required" name="rname" type="text" style="" value="${tuser.rname }" readonly="readonly"/>
			</div>
		
		</div>
		
		<div class="form-group" style="">
			<div style="">邮箱：</div>
			<div class="input-parent" style=" ">
				<input class="input-form email" name="email" type="text" style="" value="${tuser.email }"/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">手机号：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required cellPhone" id="input_mobile" name="mobile" type="text" style="" value="${tuser.mobile }"/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">开始日期：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" id="input_sdate" name="sdate" type="date" style="" value=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">结束日期：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" id="input_edate" name="edate" type="date" style="" value=""/>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">验证码：</div>
			<div class="input-parent" style="position:relative;">
				<input type="text" class="input-form required" name="captcha" style="" />
				<div id="btn_send_sms" class="btn btn-xs bg-type-02" style="display:inline-block;position:absolute;right:0;line-height:150%;">获取</div>
			</div>
		</div>
		
		<div class="form-group" style="">
			<div style="">授予权限：</div>
			<div class="" style="width: 80%;" >
				<div class="btn btn-xs bg-none-02" id="pms_sel_all" style="padding:0.2rem 0;width:20%;margin: 0.5rem 0.3rem;display: inline-block;">全选</div>
				<div class="btn btn-xs bg-none-01" id="pms_unsel_all" style="padding:0.2rem 0;width:20%;margin: 0.5rem 0.3rem;display: inline-block;">全不选</div>
			</div>
		</div>
		
		<div id="pms_list_div" class="pms-list-parent" style="width:100%;font-size:0;margin-bottom: 4rem;padding 0.5rem 0;">
			<c:forEach items="${userPermissions }" var="up">
				<div class="btn btn-xs btn-item bg-none-01" pid="${up.permissionId }" has="0" style="padding:0.2rem 0;width:46%;margin: 0.5rem 0.3rem;">${up.permissionName }</div>
			</c:forEach>
		</div>
	</form>
	
	<div  style="width:90%;position:fixed;left:5%;bottom:0;background-color: #274082;padding: 2% 0;">
		<div id="btn_transfer" class="btn btn-lg bg-type-01" style="border-radius:3px;">提交保存</div>
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
	
	var $form = $('#form_tmppms');
	$form.validate();
	
	$('#btn_transfer').click(function(){
		var arr = [];
		$(".bg-item-checked").each(function(){
			arr.push($(this).attr('pid'));
		});
		if(!arr){
			common.toast('请选择权限！');
			return;
		}
		$("#pmsids").val(arr.join(','));
		common.submitForm($form,function(){	//提交表单
			toastFn('保存成功！');
			setTimeout(function(){
				//history.go(-2);
			},1500);
		},function(){
			toastFn('保存失败！');
		});
	});
	
	$('#btn_send_sms').click(function(){
		var $this = $(this);
		if($this.hasClass('captcha-disable')){
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
	$(".btn-item").click(function(){
		$this = $(this);
		if($this.hasClass('bg-none-01')){
			$this.removeClass("bg-none-01").addClass("bg-item-checked");
		}else{
			$this.removeClass("bg-item-checked").addClass("bg-none-01");
		}
	})
	
	$("#pms_sel_all").click(function(){
		$(".btn-item").removeClass("bg-none-01").addClass("bg-item-checked");
	});
	
	$("#pms_unsel_all").click(function(){
		$(".btn-item").removeClass("bg-item-checked").addClass("bg-none-01");
	});
});
</script>
</html>
