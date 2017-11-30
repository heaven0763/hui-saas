<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
	.pad-10{padding:10px;}
	.pad-10-k{padding:10px 30px;}
	.pad-5{padding:5px;}
	.pad-2-5{padding:2.5px;}
	.pad-ud-5{padding:5px 0;}
	.pad-ud-10{padding:10px 0;}
	.pad-ud2-5{padding:2.5px 0;}
	.pad-lr-5{padding:0 5px;}
	.pad-lr-10{padding:0 10px;}
	.pad-lr-20{padding:0 20px;}
	.pad-lr-25{padding:0 25px;}
	.pad-lr-30{padding:0 30px;}
	.pad-no{padding: 0;}
	.bottom-line{border-bottom: 1px solid #ddd;}
	.help-block{display: inline-block;margin: 0;color:#ff0000;.}
	.sweet-overlay{z-index: 99998;}
	.div-tips-dialog{z-index: 99997;}
	.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:10px;}
	.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
	.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}

	.col-sm-2{padding-right: 15px;padding-left: 0px;}
	.border-no-top{border-left : 1px solid #d2d2d2;border-right : 1px solid #d2d2d2;border-bottom : 1px solid #d2d2d2;}
	.border-full{border : 1px solid #d2d2d2;}
	.th-bg-gray{background-image: url('/hui/static/resource/css/images/arrow-gray.png');background-repeat: no-repeat;background-position: 100%;background-size: inherit;text-align: center; }
	.th-bg-red{background-image: url('/hui/static/resource/css/images/arrow-red.png');background-repeat: no-repeat;background-position: 100%;background-size: inherit;text-align: center;}
	
	.cms-amt-detl{margin-left: 10%;}
	.cms-amt-edit{margin-left: 10%;display: none;}
</style>
 <div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<h3>订单返佣信息</h3>
				<div style="position: absolute;right: 10px;margin-top: 5px;top: 7px;text-align: right;">
					<a href="javascript:loadContent(this,'${ctx}/base/order/reconciliation/index?type=2','')" class="btn btn-warning" ><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				</div>
			</div>
		</div>
		<hr style="margin-top: 0; margin-bottom: 0; "/>
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
				</div>
				<h3 style="margin-left: 55px;">
					订单号：${order.orderNo}
				</h3>  
			</div>
		</div>
		<div class="row" style="margin-top: 10px;">
			<div class="col-sm-12 bottom-line" style="">
				<div class="row">
					<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
				</div>
				<div class="row">
					<div class="col-sm-12 pad-10-k" style="color: #b3b3b3" >
						<div style="position: relative;">
							<span style="color: #019FEA;font-size: 16px;">预定的场地名称：${order.hotelName }</span>
							<div style="text-align: right;position:absolute;top: 10px;right:10px;"><!--  border-radius:50%; -->
								<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px; display: inline-block;text-align: center;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
							</div>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">地区：${order.area}</span>
							<c:if test="${hotel.hotelNature eq '2' }">
								<span class="pad-lr-10">-</span>
								<span style="font-weight: bold;color: #019FEA;">场地所属集团：${hotelGroup.name}</span>
							</c:if>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">跟进销售：${hotelSale.rname}</span>
							<span style="">${hotelSale.mobile}</span>
							<span class="pad-lr-5">-</span>
							<span style="">场地本次获得积分：<span style="color:#019FEA;">${empty order.hotelPoints?0:order.hotelPoints}</span></span>
						</div>
						<div class="pad-ud-5 bottom-line" style="position: relative;margin-top: 10px">
							<span style="color: #019FEA;font-size: 16px;">活动名称：${order.activityTitle }</span>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span>活动时间：${order.activityDate}</span>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">举办单位：${order.organizer}</span>
						</div>
						
						<div class="pad-ud-5 bottom-line">
							<span style="">联系方式：${order.linkman }</span>
							<span class="pad-lr-5">-</span>
							<span style="">${order.contactNumber}</span>
							<span class="pad-lr-5">-</span>
							<span style="">${order.email}</span>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">客户获得积分：<span style="color:#019FEA;">${empty order.clientPoints?0:order.clientPoints}</span></span>
						</div>
						<div class="pad-ud-5 bottom-line" style="position: relative;margin-top: 10px">
							<span style="color: #019FEA;font-size: 16px;">会掌柜联系方式</span>
							<span>：${huiSale.rname }</span>
							<span class="pad-lr-5">-</span>
							<span style="">${huiSale.mobile}</span>
							<span class="pad-lr-5">-</span>
							<span style="">${huiSale.email}</span>
						</div>
						<div class="pad-ud-5" style="position: relative;margin-top: 10px;color: #0f0f0f;">
							<div style="text-align: right;">返佣权限归属：${order.commissionRights eq '1'?'场地':'集团'}</div>
							<div style="text-align: right;margin-top: 5px;">累计获得积分：<span style="color: #019FEA;">${empty account.totalPoints?0:account.totalPoints }</span></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12" >
    			<div class="row">
					<div class="col-sm-12 pad-10-k">
						<input type="hidden" value="${order.id }" id="id" name="orderId">
						<c:if test="${not empty comissionRecord }">
							<div class="col-sm-12" style="color: #0f0f0f">
								<form id="cmsn_form">
									<input type="hidden" id="cmsn_type" name="cmsn_type" value="${comissionRecord.type }"/>
									<input type="hidden" id="cmsn_id" name="cmsn_id" value="${comissionRecord.id }" />
								<div class="row border-full">
									<div class="col-sm-1" style="padding-right: 6px;padding-left: 0;"><div class="pad-ud-5" style="color: #ffffff;width: 100%;background-color:#048dd3;text-align: center;border-right : 1px solid #d2d2d2;">返佣类型</div></div>
									<div class="col-sm-11 pad-5" style="position: relative;">
										${comissionRecord.type eq '1'?'全单返佣':'分项返佣'}
									</div>
								</div>
								
								<c:if test="${comissionRecord.type ne '1' }">
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >会场费用</div>
										<div class="col-sm-3 pad-5" style="">	
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originMeetingAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecord.originMettingRoomCommissionRate }%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">会场返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originMeetingAmount*comissionRecord.originMettingRoomCommissionRate/100 }" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >住房费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originHouseAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecord.originHousingCommissionRate }%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">住房返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originHouseAmount*comissionRecord.originHousingCommissionRate/100 }" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >用餐费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originDinnerAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecord.originDinnerCommissionRate }%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">用餐返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originDinnerAmount*comissionRecord.originDinnerCommissionRate/100 }" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >其他费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originOtherAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecord.originOrtherCommissionRate }%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">其他返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecord.originOtherAmount*comissionRecord.originOrtherCommissionRate/100 }" /></div>
										</div>
									</div>
									<div class="row border-no-top" style="" >
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">费用合计</div>
										<div class="col-sm-3 pad-5" style="border-right: 1px solid #d2d2d2;">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecord.originAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5" style=""></div>
										<div class="col-sm-3 pad-5" style=""></div>
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">佣金合计</div>
										<div class="col-sm-3 pad-5">
											<div class="cms-amt-detl" style="color: #c32424;">
											<fmt:formatNumber type="currency" value="${(comissionRecord.originMeetingAmount*comissionRecord.originMettingRoomCommissionRate/100)
											+(comissionRecord.originHouseAmount*comissionRecord.originHousingCommissionRate/100)
											+(comissionRecord.originOtherAmount*comissionRecord.originOrtherCommissionRate/100)
											+(comissionRecord.originDinnerAmount*comissionRecord.originDinnerCommissionRate/100 ) }" />
											</div>
										</div>
									</div>
								</c:if>
								<c:if test="${comissionRecord.type eq '1' }">
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >订单总额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${order.amount}" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">应扣除金额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${order.amount-comissionRecord.originAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">应计返佣金额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecord.originAmount }" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;">${comissionRecord.allCommissionRate }%</div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">返佣金额</div>
										<div class="col-sm-11 pad-5" >
											<div class="cms-amt-detl" style="margin-left: 1.16%;color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecord.originAmount*comissionRecord.allCommissionRate/100 }" /></div>
										</div>
									</div>
								</c:if>
								
								</form>
							</div>
						</c:if>
					</div>
				</div>
   			</div>
   		</div>	
	<br/>
	<br/>
	<br/>

<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script>

function reconciliationReadOrderTrajectory(){
	var reconciliationReadOrder = window.sessionStorage.getItem("reconciliationReadOrder${aUs.getCurrentUserId()}");
	var orderNo = '${order.orderNo}';
	if(reconciliationReadOrder){
		if(reconciliationReadOrder.indexOf(orderNo)<0){
			reconciliationReadOrder +=",${order.orderNo}";
		}
	}else{
		reconciliationReadOrder = "${order.orderNo}";
	}
	window.sessionStorage.setItem("reconciliationReadOrder${aUs.getCurrentUserId()}",reconciliationReadOrder);
}

$(function(){
	reconciliationReadOrderTrajectory();
	common.pms.init();

});
</script>
</div>
