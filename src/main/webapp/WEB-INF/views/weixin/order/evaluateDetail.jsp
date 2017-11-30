<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>评论详情</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <style>
    </style>
</head>

<body class="">
	
	<div style="width:96%;margin:0 auto;">
		<div style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:3rem;">
		<c:if test="${evaluate.evaluateType eq 'SITE' }">
			<c:if test="${evaluate.itemType eq 'HOTEL' }">${evaluate.itemName}</c:if>
			<c:if test="${evaluate.itemType ne 'HOTEL' }">${evaluate.hotelName}——${evaluate.itemName}</c:if>
		</c:if>
		 <c:if test="${evaluate.evaluateType eq 'PLATFORM' }">
		 	会掌柜场地SAAS平台
		 </c:if>
		  <c:if test="${evaluate.evaluateType eq 'SALE' }">
		 	所在场地：${evaluate.hotelName}
		 </c:if>
		</div>
		<div style="">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.3rem 1rem;">基本信息</div>
		</div>
		<c:if test="${evaluate.evaluateType eq 'SITE' }">
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					商品评价：
					<div class="icon-start-02 icon-start-size-${evaluate.goodsEvaluation }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;" >
					响应速度：
					<div class="icon-start-02 icon-start-size-${evaluate.responseSpeed }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					服务态度：
					<div class="icon-start-02 icon-start-size-${evaluate.attitude }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;" >
					设施评价：
					<div class="icon-start-02 icon-start-size-${evaluate.facilities }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					卫生评价：
					<div class="icon-start-02 icon-start-size-${evaluate.hygiene }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;" >
					位置评价：
					<div class="icon-start-02 icon-start-size-${evaluate.location }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					服务评价：
					<div class="icon-start-02 icon-start-size-${evaluate.service }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
		</div>
		</c:if>
		<c:if test="${evaluate.evaluateType eq 'PLATFORM' }">
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					平台体验感：
					<div class="icon-start-02 icon-start-size-${evaluate.goodsEvaluation }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;" >
					公司跟进服务：
					<div class="icon-start-02 icon-start-size-${evaluate.responseSpeed }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="">
				<div class="eva-star-parent" style="float: none;"  >
					获取优惠：
					<div class="icon-start-02 icon-start-size-${evaluate.attitude }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
		</div>
		</c:if>
		<c:if test="${evaluate.evaluateType eq 'SALE' }">
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;padding: 0.8rem 0;">
			<div style="width: 60%;display: flex;justify-content:space-between;">
				<div  style="font-size: 1rem;font-weight: bold;">${evaluate.saleName }</div>
				<div>${evaluate.salePosition }</div>
				<div>${evaluate.saleMobile }</div>
			</div>
		</div>
		</c:if>
		<div style="margin-top: 1rem;">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.3rem 1rem;">综合评价</div>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;border-bottom: 1px solid #cccccc;padding-bottom: 0.5rem;">
			<div class="one-list-ct-sett" style="color: #5f5f5f;">
				<div class="sett-left" style="font-size: 1rem;">${evaluate.userName }</div>
				<div class="eva-star-parent"  >
					星评：
					<div class="icon-start-02 icon-start-size-${evaluate.comprehensive }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
				<div style="display: none;"></div>
			</div>
			<div class="one-list-ct-sett" style="display: flex;justify-content:space-between;font-size: 0.8rem;color: #999999;">
				<div>${dUs.toDay(evaluate.evaluateDate)}</div>
				<c:if test="${empty evaluate.replyContent}">
				<div id="reply-btn">回复</div>
				</c:if>
			</div>
			<div class="one-list-ct-sett" style="font-size: 0.95rem;color: #5f5f5f;">
				${evaluate.econtent}
			</div>
			<c:if test="${not empty evaluate.replyContent}">
				<div class="one-list-ct-sett" style="font-size: 0.95rem;color: red;">
					回复：“${evaluate.replyContent}”
				</div>
			</c:if>
		</div>
	</div>
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="evaluate_reply_div" class="div-tips-dialog" style="top:30%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;">评论回复</div>
 			<div id="btn_evaluate_reply_close" class="icon-close"  style="position: absolute;right: 0;top: 0;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
		<div style="padding: 2%;">
			<form id="evaluate_reply_form"  action="${ctx}/weixin/order/evaluate/reply/save">
			<input type="hidden" id="id" name="id" value="${evaluate.id }">
			<div style="padding: 2% 0;">
				<div>回复内容</div>
				<div style="width: 96%;padding: 2% 0;">
					<textarea type="text" id="replyContent" name="replyContent" rows="5" style="width: 100%;"></textarea>
				</div>
			</div>
			</form>
		</div>
		<div style="display: flex;justify-content: space-between;">
			<div id="btn_cancel" class="btn btn-lg bg-type-02" style="margin:0 auto;border-radius:3px;width: 40%;" >取消</div>
			<div id="btn_sure" class="btn btn-lg bg-type-01" style="margin:0 auto;border-radius:3px;width: 40%;" >确认回复</div>
		</div>
		
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
	$("#reply-btn").click(function(){
		$("#mask-full-screen").show();
		$("#evaluate_reply_div").show();
	});
	$("#btn_evaluate_reply_close").click(function(){
		$("#mask-full-screen").hide();
		$("#evaluate_reply_div").hide();
		$("#replyContent").text('');
	});
	
	$("#btn_cancel").click(function(){
		$("#mask-full-screen").hide();
		$("#evaluate_reply_div").hide();
		$("#replyContent").text('');
	});
	
	var $form = $('#evaluate_reply_form');
	$form.validate({
		rules:{
			replyContent:"required"
		},
		messages:{
			replyContent:"请输入回复内容"
		}
	});
	$('#btn_sure').click(function(){
		 common.submitForm($form,function(res){
			 common.toast(res.message);
			 setTimeout(function(){
				 location = location;
			 },1500);
			 
         },function(res){
			 common.toast(res.message);
 		});
	});
});
</script>

</html>
