<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>场地报价调整审核</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   	<style type="text/css">
   		.priceAdjusts{
   			border-bottom: 1px solid #cccccc;
   		}
   		.priceAdjusts:last-child{
   			border: 0;
   		}
   	</style>
</head>

<body class="" onhashchange="func();">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div style="">
		<input type="hidden" id="id" name="id" value="${priceTrial.id }">
		<input type="hidden" id="placeId" name="placeId" value="${priceTrial.placeId }">
		<input type="hidden" id="hotelId" name="hotelId" value="${priceTrial.hotelId }">
		<input type="hidden" id="adjustSdate" name="adjustSdate" value="${priceTrial.applyDate }">
		<input type="hidden" id="state" name="state" value="${priceTrial.state }">
		<input type="hidden" id="checktype" name="checktype" value="${checktype }">
		<div style="border-bottom: 1px solid #cccccc;padding:3%;">
			<div style="float: left;font-size: 1.0rem;font-weight: bold;">申请日期：${dUs.toDay(priceTrial.applyDate) }</div>
			<div style="float:right;"><div id="next_date" class="btn btn-xs bg-type-02" style="padding: 0.2rem;">下一日期段</div></div>
			<div style="clear: both;"></div>
		</div>
		<div style="border-bottom: 1px solid #cccccc;padding:3%;">
			<div style="font-size: 1.0rem;font-weight: bold;">审核状态：
			<c:choose>
				<c:when test="${priceTrial.state eq '0' }">
					等待会掌柜销售初审
				</c:when>
				<c:when test="${priceTrial.state eq '1' }">
					等待会掌柜终审
				</c:when>
				<c:when test="${priceTrial.state eq '2' }">
					审核通过
				</c:when>
				<c:when test="${priceTrial.state eq '3' }">
					会掌柜销售不通过！
				</c:when>
				<c:when test="${priceTrial.state eq '4' }">
					会掌柜终审不通过！
				</c:when>
				</c:choose>
			</div>
		</div>
		
		
		<div>
		<c:forEach items="${priceAdjusts}" var="priceAdjust">
			<div class="priceAdjusts" style="padding:0 3%;">
				<div style="text-align: center;margin-top:1.0rem;">
					<div class="btn btn-xs" style="padding: 0.2rem 0.8rem;font-size: 1.0rem;font-weight: bold;color:#019FEA;border: 1px solid #019FEA; ">${priceAdjust.placeName }</div>
				</div>
				<div>
					<div style="font-size: 0.85rem;font-weight: bold;margin: 0.5rem 0;">日期：${priceAdjust.adjustSdate }</div>
				</div>
				<div style="font-size: 0.75rem;">
					<div style="font-size: 0.85rem;font-weight: bold;margin: 0.5rem 0;">线上价格</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="currency" value="${priceAdjust.onlinePriceBefore }" /></div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="currency" value="${priceAdjust.onlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: #FFB42B;"><fmt:formatNumber type="number" value="${priceAdjust.onlinePriceRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div style="font-size: 0.75rem;">
					<div style="font-size: 0.85rem;font-weight: bold;margin: 0.5rem 0;">线下价格</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="currency" value="${priceAdjust.offlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="currency" value="${priceAdjust.offlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: #FFB42B;"><fmt:formatNumber type="number" value="${priceAdjust.offlinePriceRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div style="font-size: 0.75rem;">
					<div style="font-size: 0.85rem;font-weight: bold;margin: 0.5rem 0;">线上、线下调整比</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="number" value="${priceAdjust.priceBeforeRate }"  maxFractionDigits="2"/>%</div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="number" value="${priceAdjust.priceAfterRate }"  maxFractionDigits="2"/>%</div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: red;"><fmt:formatNumber type="number" value="${priceAdjust.adjustRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		<c:if test="${priceTrial.state ne '0' }">
		<div style="background-color: #f5f5f5;padding:3%;">审核情况</div>
		</c:if>
		<c:if test="${priceTrial.state ne '0' }">
			<div style="font-size: 0.8rem;">
				<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
					<div>初审日期：${priceTrial.trialDate }</div>
				</div>
				<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
					<div>初审人员：${priceTrial.trialUserName }</div>
				</div>
				<c:if test="${priceTrial.state eq '3' }">
					<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
						<div>初审不通过原因：${priceTrial.trialReason }</div>
					</div>
				</c:if>
			</div>
		</c:if>
		<c:if test="${priceTrial.state gt '1' }">
			<div style="font-size: 0.8rem;">
				<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
					<div>复审日期：${priceTrial.finalDate }</div>
				</div>
				<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
					<div>复审人员：${priceTrial.finalUserName }</div>
				</div>
				<c:if test="${priceTrial.state eq '4' }">
					<div style="border-bottom: 1px solid #f5f5f5;padding:3%;">
						<div>复审不通过原因：${priceTrial.finalReason }</div>
					</div>
				</c:if>
			</div>
		</c:if>
		<div style="margin-bottom: 70px;"></div>
		<c:if test="${checktype ne 'NONE' }">
			<div style="position: fixed;bottom: 0;padding: 0.5rem 0;text-align: center;width: 100%;background-color: #ffffff;">
				<div id="nopass_btn" class="btn btn-xs" style="padding: 0.6rem;font-size: 0.8rem;font-weight: bold;color:#019FEA;border: 1px solid #019FEA;width: 40%; ">审核不通过</div>
				<div id="pass_btn" class="btn btn-xs bg-type-01" style="padding: 0.6rem;font-size: 0.8rem;font-weight: bold;width: 40%;">审核通过</div>
			</div>
			<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
				<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
					<div style="color: #000000;">不通过原因</div>
					<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
					<input id="tostate" name="tostate" type="hidden" value="">
		 		</div>
				<div style="padding:0 2%;" >
					<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
				</div>
				
				<div class="display-flex" style="padding: 1rem 0;">
					<div id="btn_offline_check_no_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" >再考虑</div>
					<div id="btn_offline_check_no_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;" > 确定</div>
				</div>
			</div>	
		</c:if>
		<c:if test="${checktype eq 'NONE' && priceTrial.state ne '2' }">
		<div style="position: fixed;bottom: 0;padding: 0.5rem 0;text-align: center;width: 100%;background-color: #ffffff;">
				<div class="btn btn-xs" style="padding: 0.6rem;font-size: 0.8rem;font-weight: bold;color:#ffffff;background-color:#cccccc;width: 90%; ">
				<c:choose>
				<c:when test="${priceTrial.state eq '0' }">
					等待会掌柜销售初审
				</c:when>
				<c:when test="${priceTrial.state eq '1' }">
					等待会掌柜终审
				</c:when>
				<c:when test="${priceTrial.state eq '3' }">
					会掌柜销售初审不通过！
				</c:when>
				<c:when test="${priceTrial.state eq '4' }">
					会掌柜终审不通过！
				</c:when>
				</c:choose>
				
				</div>
			</div>
		</c:if>
		<c:if test="${checktype eq 'NONE' && priceTrial.state eq '2' }">
			<div style="position: fixed;bottom: 0;padding: 0.5rem 0;text-align: center;width: 100%;background-color: #ffffff;">
				<div class="btn btn-xs" style="padding: 0.6rem;font-size: 0.8rem;font-weight: bold;color:#ffffff;background-color:#019FEA;width: 90%; ">
					审核完成
				</div>
			</div>
		
		</c:if>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>

<script>
$(function(){
	//alert(window.location.hash);
	//window.addEventListener("hashchange", func, false);
	$("#nopass_btn").click(function(){
		showMaskDiv();
		$("#offline_check_no_div").show();
	});
	
	$("#offline_check_no_ic_close").click(function(){
		hideMaskDiv();
		$("#offline_check_no_div").hide();
	});
	
	$("#btn_offline_check_no_cansel").click(function(){
		hideMaskDiv();
		$("#offline_check_no_div").hide();
	});
	
	$("#btn_offline_check_no_sure").click(function(){
		showMaskDiv();
		var checkType = $("#checktype").val();
		var reason = $("#reason").val();
		showMaskDiv();
		$.post('${ctx}/weixin/hotel/price/adjust/nopasscheck/${priceTrial.id }',{checkType:checkType,reason:reason},function(res){
			toastFn(res.message);
			if(res.statusCode=="200"){
				location=location;
			}
			hideMaskDiv();
		},"json");
	});
	$("#pass_btn").click(function(){
		var checkType = $("#checktype").val();
		showMaskDiv();
		$.post('${ctx}/weixin/hotel/price/adjust/passcheck/${priceTrial.id }',{checkType:checkType},function(res){
			toastFn(res.message);
			if(res.statusCode=="200"){
				location=location;
			}
			hideMaskDiv();
		},"json");
	});
	$("#next_date").click(function(){
		var idx = '${idx}'*1+1;
		$.get('${ctx}/weixin/hotel/price/adjust/getone',{idx:idx},function(res){
			//toastFn(res.message);
			if(res.statusCode=="200"){
				location.href='${ctx}/weixin/hotel/price/adjust/detail/'+res.object.id+'?idx='+idx;
			}
			hideMaskDiv();
		},"json");
	});
});
function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

function disabledScroll(event){
	 event.preventDefault();
};

</script>

</html>
