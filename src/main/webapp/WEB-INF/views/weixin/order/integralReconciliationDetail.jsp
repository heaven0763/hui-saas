<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>对账详情</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <style>
    .bgimg{height: 7rem;width: 7rem;background-size: cover;background-position: center;}
    i.ic{background-image:url(${ctx}/static/weixin/css/icon/main/jfcons.png);background-repeat: no-repeat;background-size:14px;    background-position: center; }
    </style>
</head>

<body class="">
	
	<div style="width:96%;margin:0 auto;">
		<div  style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:3rem;">
			订单号：${integralOrder.orderNo}  
		</div>
		<div>
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.2rem 1.5rem;font-size: 1.0rem;">基本信息</div>
		</div>
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 1rem;padding: 2% 0;">
			<div  style="padding-top: 0.5rem;">
				<div class="bgimg" style="float:left;background-image: url('${ctx}/${integralCommodity.img }');"></div>
				<div  style="float:left;margin-left: 10px;width: 60%;">
					<div class="one-list-ct-title" style="margin: 3% 0;min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">${integralCommodity.name }</div>
					<div style="margin: 3% 0;font-size: 0.9rem;widht:100%;">
						<div style="float: left;">场地原价：<fmt:formatNumber type="currency" value="${integralCommodity.price }" /></div>
						<div style="float: right;">
						<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">${integralCommodity.integral }分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.9rem;">会掌柜价：<fmt:formatNumber type="currency" value="${integralCommodity.zgprice }" /></div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div style="padding: 2% 0;">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.2rem 1.5rem;font-size: 1.0rem;">兑换信息</div>
		</div>
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.9rem;">
			<div style="margin:0.5rem 0;">
				<div>兑换人：<span >${integralOrder.clientName}&nbsp;&nbsp;${integralOrder.clientMobile}&nbsp;&nbsp;${integralOrder.area}</span></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div>兑换时间：<span >${dUs.toSecond(integralOrder.createDate)}</span></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div>兑换积分：<span style="color: red;font-weight: bold;"><fmt:formatNumber type="number" value="${integralOrder.points }" minIntegerDigits="0" />分</span></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div>财务对账：<span id="settlement_state" style="color: #019FEA;font-weight: bold; ">${integralOrder.settlementStatus eq '0'?'未对账':integralOrder.settlementStatus eq '1'?'已申请':'已对账'}</span></div>
			</div>
		</div>
		
	</div>
	<div style="position: fixed;bottom: 0;width:100%;">
		<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0;">
			<div style="float: left;margin-left: 2%;">应结：
				<fmt:formatNumber type="currency" value="${integralOrder.jdamount }" />
			</div>
			<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:red;font-weight: bold;">实结：
				<fmt:formatNumber type="currency" value="${integralOrder.zgamount }" />
			</div>
			<div style="clear: both;"></div>
		</div>
		<c:if test="${issettlement }">
			<div id="settlement_div" style="padding: 1% 2%;">
				<div id="btn_settlement" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;">确认结账</div>
			</div>
		</c:if>
		<c:if test="${!issettlement }">
			<div id="settlement_div" style="padding: 1% 2%;">
				<div id="btn_settlement" class="btn btn-lg bg-type-03" style="width:100%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;background-color:#999999;border-color:#999999;">
					${integralOrder.settlementStatus eq '0'?'未对账':integralOrder.settlementStatus eq '1'?'已申请':'已对账'}
				</div>
			</div>
		</c:if>
	</div>
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
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
	$("#btn_settlement").click(function(){
		show();
		var orderNo = '${integralOrder.orderNo}';
		var itemId = '${integralOrderDetail.itemId}';
		$.post('${ctx}/weixin/hotel/integral/reconciliation/settlement',{orderNo:orderNo,itemId:itemId},function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				$("#settlement_div").hide();
				$("#settlement_state").text('已对账');
			}else{
				
			}
			hide();
		})
	});
});
function hide(){
	$('#mask_full_screen').hide();
	$('body').removeClass("mbody");
	$('html').removeClass("mhtml");
}
function show(){
	$('#mask_full_screen').show();
	$('body').addClass("mbody");
	$('html').addClass("mhtml");
}
</script>

</html>
