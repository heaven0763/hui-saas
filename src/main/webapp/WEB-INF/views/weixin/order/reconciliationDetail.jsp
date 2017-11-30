<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>返佣详情</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <style>
   		.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:5px;left: 0;}
		.hui{background-color: #048dd3;color: #ffffff;}
		.hotel{background-color: #f0ad4e;color: #ffffff;}
		.row{width: 100%;}
		.col-sm-2{width: 49%;position: relative;min-height: 1px;display: inline-block;} /* width: 16.66666667%; */
		.col-sm-2 input{ margin: 0.2rem 0; padding: 0.2rem 0;}
		.col-sm-3{width: 24%;position: relative;min-height: 1px;display: inline-block;}
		
		.row .btn{padding: 0.3rem 0.6rem;border-radius: 3px;}
    </style>
    <script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
	<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
	<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
	<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
	<script src="${ctx}/static/weixin/myjs/tools.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
</head>

<body class="">
	
	<div style="width:96%;margin:0 auto;">
		<div style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:4rem;position: relative;">
			<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
				${order.sourceAppId eq '1'?'会':'內'}
			</div>
			<h3 style="margin-left: 55px;">
				订单号：${order.orderNo}  
			</h3>
		</div>
		<div style="border-top:1px solid #cccccc;position: relative;">
			<div style="margin:1.2rem 0;color:#019FEA;font-weight: bold;">场地名称：${order.hotelName}——${order.activityTitle}</div>
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">基本信息</div>
			<div style="text-align: right;position:absolute;bottom: 5px;right: 0;">
				<%-- <span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 80px;line-height:80px; border-radius:50%;display: inline-block;text-align: center;">${dSv.trsltDict('05',order.state)}</span>
				&nbsp;&nbsp;
				<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 80px;line-height:80px; border-radius:50%;display: inline-block;text-align: center;">${dSv.trsltDict('07',order.settlementStatus)}</span>
				 --%>
				 <c:if test="${order.commissionStatus ne '00' }">
					&nbsp;&nbsp;
					<span style="color: #019FEA;border: 1px solid #019FEA;width: 50px;height: 50px;line-height:50px; border-radius:50%;display: inline-block;text-align: center;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
				</c:if>
			</div>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
			<div style="margin:0.5rem 0;">
				<div style="float:left;">地区：${order.area}</div>
				<%-- <div style="font-weight:bold;color:#019FEA; border: 1px solid #019FEA;padding:0 15px;margin:0 5px;float:right;">${dSv.trsltDict('05',order.state)}</div>
				<div style="font-weight:bold;color:#019FEA; border: 1px solid #019FEA;padding:0 15px;margin:0 5px;float:right;">${dSv.trsltDict('07',order.settlementStatus)}</div>
				<div style="font-weight:bold;color:#019FEA; border: 1px solid #019FEA;padding:0 15px;margin:0 5px;float:right;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</div> --%>
				<div style="clear:both;"></div>
			</div>
			<c:if test="${hotel.hotelNature eq '2' }">
			<div style="margin:0.5rem 0;">
				<div style="float:left;">场地所属集团：${order.ownedGroup}</div>
				<div style="float:right;text-align: right;">返佣权限归属：${order.commissionRights eq '1'?'场地':'集团'}</div>
				<div style="clear:both;"></div>
			</div>
			</c:if>
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 70%;">跟进销售：${order.hotelSaleName}&nbsp;&nbsp;&nbsp;&nbsp;${order.hotelSaleMobile}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">活动名称：${order.activityTitle}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">活动时间：${order.activityDate}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">活动主办单位：${order.organizer}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 70%;">联系方式：${order.linkman}&nbsp;&nbsp;&nbsp;&nbsp;${order.contactNumber}</div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开拓场地销售：${hotel.reclaimUserName}</div>
				<div style="clear:both;"></div>
			</div>
			<c:if test="${not empty order.remindDate}">
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开始提醒客户时间：${order.remindDate}</div>
				<div style="float:right;text-align: right;">系统已提醒客户次数：<span style="color:red;">${empty order.remindTimes?0:order.remindTimes}次</span></div>
				<div style="clear:both;"></div>
			</div>
			</c:if>
			
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.80rem;color: #0f0f0f;">
				<input type="hidden" value="${order.id }" id="id" name="orderId">
				<div style="margin:0.5rem 0;padding: 0.5rem 0;width:100%;">
					<div style="float:left;">返佣情况：</div>
					<div style="float:right;text-align: right;">
						<span style="color: #019FEA;border: 1px solid #019FEA;padding-left: 20px;padding-right : 20px;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
					</div>
					<div style="clear:both;"></div>
				</div>
				<c:if test="${not empty comissionRecord }">
				<div style="width:100%;">
				<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
					<div style="float:left;">返佣类型：</div>
					<div style="float:right;text-align: right;">${comissionRecord.type eq '1'?'全单返佣':'分项返佣'}</div>
					<div style="clear:both;"></div>
				</div>
				<c:if test="${comissionRecord.type eq '1' }">
					<c:choose>
						<c:when test="${comissionRecord.isupdate eq '1' and not empty comissionCheckRecord}">
							<div id="cmsn_detail">
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">订单金额：</div>
									<div style="float:right;text-align: right;"><fmt:formatNumber type="currency" value="${order.amount }" /></div>
									<div style="clear:both;"></div>
								</div>
								<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改前待返佣金额：</div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.originAmount }" /></div>
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改后待返佣金额：</div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.amount }" /></div>
								</div>
								<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改前待返佣比例：</div>
									<div class="col-sm-3" style="text-align: right;">${comissionRecord.allCommissionRate}%</div>
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改后待返佣比例：</div>
									<div class="col-sm-3" style="text-align: right;">${comissionCheckRecord.allCommissionRate}%</div>
								</div>
								<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改前佣金：</div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.allCommission }" /></div>
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改后佣金：</div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.allCommission }" /></div>
								</div>
								<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-3" style="text-align: left;padding: 0;">返佣总额：</div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount }" /></div>
									<div class="col-sm-3" style="text-align: left;padding: 0;"></div>
									<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.commissionAmount }" /></div>
								</div>
								<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-2" style="text-align: left;padding: 0;">修改日期：</div>
									<div class="col-sm-2" style="text-align: right;">${comissionCheckRecord.createDate }</div>
									<div class="col-sm-2" style="text-align: left;padding: 0;">修改人：</div>
									<div class="col-sm-2" style="text-align: right;">${comissionCheckRecord.createUserName }</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div id="cmsn_detail">
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">订单金额：</div>
									<div style="float:right;text-align: right;"><fmt:formatNumber type="currency" value="${order.amount }" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">待返佣金额：</div>
									<div style="float:right;text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.amount }" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">返佣比例：</div>
									<div style="float:right;text-align: right;">${comissionRecord.allCommissionRate}%</div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">全单返佣：</div>
									<div style="float:right;text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.allCommission }" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">返佣总额：</div>
									<div style="float:right;text-align: right;color:#cb2b29;font-weight: bold;"><fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount }" /></div>
									<div style="clear:both;"></div>
								</div>
							</div>
							<div id="cmsn_edit" style="display: none;" >
								<form id="cmsn_form">
								<input type="hidden" id="cmsn_type" name="cmsn_type" value="${comissionRecord.type }"/>
								<input type="hidden" id="cmsn_id" name="cmsn_id" value="${comissionRecord.id }" />
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">订单金额：</div>
									<div style="float:right;text-align: right;"><fmt:formatNumber type="currency" value="${order.amount}" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">待返佣金额：</div>
									<div style="float:right;text-align: right;"><input type="number" id="cmsn_amount" name="cmsn_amount" value="${comissionRecord.amount }" min="0" style="width: 100px;text-align: right;" onkeyup="cmsnChangeAmount(this);" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">返佣比例：</div>
									<div style="float:right;text-align: right;"><input type="number" id="cmsn_all_rate" name="allCommissionRate" value="${comissionRecord.allCommissionRate }" style="width: 80px;text-align: right;" readonly="readonly" />%</div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
									<div style="float:left;">全单返佣：</div>
									<div style="float:right;text-align: right;"><input type="number" name="allCommission" value="${comissionRecord.allCommission }" readonly="readonly" style="width: 100px;text-align: right;" /></div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;color:#cb2b29;font-weight: bold;">
									<div style="float:left;">返佣总额：</div>
									<div style="float:right;text-align: right;"><input type="number" name="commissionAmount" value="${comissionRecord.commissionAmount }" style="width: 100px;text-align: right;" readonly="readonly" /></div>
									<div style="clear:both;"></div>
								</div>
								
								</form>
							</div>
						</c:otherwise>
					</c:choose>
					
				</c:if>
					<c:if test="${comissionRecord.type ne '1' }">
						<c:choose>
							<c:when test="${comissionRecord.isupdate eq '1' and not empty comissionCheckRecord}">
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
										<div class="col-sm-3" style="text-align: center;"></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">会场费用</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">返佣比例</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">会场返佣</div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改前</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.meetingAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionRecord.mettingRoomCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.mettingRoomCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改后</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.meetingAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionCheckRecord.mettingRoomCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.mettingRoomCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;"><fmt:formatNumber type="currency" value="${comissionRecord.houseAmount }" /></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">住房费用</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">返佣比例</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">住房返佣</div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改前</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.houseAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionRecord.housingCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.housingCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改后</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.houseAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionCheckRecord.housingCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.housingCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: right;"></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">用餐费用</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">返佣比例</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">用餐返佣</div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改前</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.dinnerAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionRecord.dinnerCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.dinnerCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改后</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.dinnerAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionCheckRecord.dinnerCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.dinnerCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: right;"></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">其他费用</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">返佣比例</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">其他返佣</div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改前</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.otherAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionRecord.ortherCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.ortherCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-3" style="text-align: center;padding: 0;">修改后</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.otherAmount }" /></div>
										<div class="col-sm-3" style="text-align: right;">${comissionCheckRecord.ortherCommissionRate }%</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.ortherCommission }" /></div>
									</div>
									
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;color:#cb2b29;font-weight: bold;">
										<div class="col-sm-3" style="text-align: center;"></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">费用合计</div>
										<div class="col-sm-3" style="text-align: center;padding: 0;"></div>
										<div class="col-sm-3" style="text-align: center;padding: 0;">佣金合计</div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;color:#cb2b29;font-weight: bold;">
										<div class="col-sm-3" style="text-align: center;">修改前</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.amount }" /></div>
										<div class="col-sm-3" style="text-align: right;"></div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;color:#cb2b29;font-weight: bold;">
										<div class="col-sm-3" style="text-align: center;">修改后</div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.amount }" /></div>
										<div class="col-sm-3" style="text-align: right;"></div>
										<div class="col-sm-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionCheckRecord.commissionAmount }" /></div>
									</div>
									
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改日期：</div>
									<div class="col-sm-2" style="text-align: left;width: 60%;">${comissionCheckRecord.createDate }</div>
									<div class="col-sm-3" style="text-align: left;padding: 0;">修改人：</div>
									<div class="col-sm-2" style="text-align: left;">${comissionCheckRecord.createUserName }</div>
								</div>
							</c:when>
							<c:otherwise>
								<div id="cmsn_detail">
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
											<div class="col-sm-2" style="text-align: left;padding: 0;">会场费用：</div>
											<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.meetingAmount }" /></div>
											<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
											<div class="col-sm-2" style="text-align: right;">${comissionRecord.mettingRoomCommissionRate }%</div>
											<div class="col-sm-2" style="text-align: left;padding: 0;">会场返佣：</div>
											<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.mettingRoomCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">住房费用：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.houseAmount }" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;">${comissionRecord.housingCommissionRate }%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">住房返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.housingCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">用餐费用：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.dinnerAmount }" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;">${comissionRecord.dinnerCommissionRate }%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">用餐返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.dinnerCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">其他费用：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.otherAmount }" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;">${comissionRecord.ortherCommissionRate }%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">其他返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.ortherCommission }" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;color:#cb2b29;font-weight: bold;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">费用合计：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.amount }" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;"></div>
										<div class="col-sm-2" style="text-align: right;"></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">佣金合计：</div>
										<div class="col-sm-2" style="text-align: right;"><fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount }" /></div>
									</div>
								</div>
								<div id="cmsn_edit"  style="display: none;">
									<form id="cmsn_form">
									<input type="hidden" id="cmsn_type" name="cmsn_type" value="${comissionRecord.type }"/>
									<input type="hidden" id="cmsn_id" name="cmsn_id" value="${comissionRecord.id }" />
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;"> <!-- style="float:left;width: 33%;" -->
										<div class="col-sm-2" style="text-align: left;padding: 0;">会场费用：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="amount" id="meeting_amount" name="meeting_amount" min="0"  value="${empty comissionRecord.meetingAmount?0:comissionRecord.meetingAmount }" style="text-align: right;width:100%;" onkeyup="meetingAmountChange(this);" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" id="meeting_cmsn_rate" name="meeting_cmsn_rate"  value="${empty comissionRecord.mettingRoomCommissionRate?0:comissionRecord.mettingRoomCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">会场返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="cmsnamount" id="meeting_cmsn_amount" name="meeting_cmsn_amount"  value="${empty comissionRecord.mettingRoomCommission?0:comissionRecord.mettingRoomCommission}" readonly="readonly" style="text-align: right;width:100%;" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">住房费用：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="amount" id="house_amount" name="house_amount" min="0"  value="${empty comissionRecord.houseAmount?0:comissionRecord.houseAmount }" style="text-align: right;width:100%;" onkeyup="houseAmountChange(this);" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" id="house_cmsn_rate" name="house_cmsn_rate"  value="${empty comissionRecord.housingCommissionRate?0:comissionRecord.housingCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">住房返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="cmsnamount" id="house_cmsn_amount" name="house_cmsn_amount" value="${empty comissionRecord.housingCommission?0:comissionRecord.housingCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">用餐费用：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="amount" id="dinner_amount" name="dinner_amount" min="0"  value="${empty comissionRecord.dinnerAmount?0:comissionRecord.dinnerAmount }" style="text-align: right;width:100%;"  onkeyup="dinnerAmountChange(this);"/></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" id="dinner_cmsn_rate" name="dinner_cmsn_rate"  value="${empty comissionRecord.dinnerCommissionRate?0:comissionRecord.dinnerCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">用餐返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="cmsnamount" id="dinner_cmsn_amount" name="dinner_cmsn_amount"  value="${empty comissionRecord.dinnerCommission?0:comissionRecord.dinnerCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">其他费用：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="amount" id="other_amount" name="other_amount" min="0"  value="${empty comissionRecord.otherAmount?0:comissionRecord.otherAmount }" style="text-align: right;width:100%;"  onkeyup="otherAmountChange(this);"/></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">返佣比例：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" id="other_amount_rate" name="other_amount_rate"  value="${empty comissionRecord.ortherCommissionRate?0:comissionRecord.ortherCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">其他返佣：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" class="cmsnamount" id="other_cmsn_amount" name="other_cmsn_amount"  value="${empty comissionRecord.ortherCommission?0:comissionRecord.ortherCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
									</div>
									<div class="row" style="margin:0.5rem 0;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;">
										<div class="col-sm-2" style="text-align: left;padding: 0;">费用合计：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number"  id="cmsn_amount" name="cmsn_amount"  value="${comissionRecord.amount }" readonly="readonly" style="text-align: right;width:100%;border: none;" /></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;"></div>
										<div class="col-sm-2" style="text-align: right;"></div>
										<div class="col-sm-2" style="text-align: left;padding: 0;">佣金合计：</div>
										<div class="col-sm-2" style="text-align: right;"><input type="number" id="cmsn_amount_cc" name="cmsn_amount_cc"  value="${comissionRecord.commissionAmount }" readonly="readonly" style="text-align: right;width:100%;border: none;" /></div>
									</div>
									</form>
								</div>
							</c:otherwise>
						</c:choose>
						
					</c:if>
					<div class="row" style="margin:0.5rem 0;text-align: right;">
						<c:if test="${((groupMap.ishotelsales and guserId eq order.hotelSaleId) or groupMap.ishotelsalesdirector) and order.commissionStatus eq '01' }">
							<c:if test="${empty order.iscommissionupdate or  order.iscommissionupdate eq '0'}">
								<button id="btn_update_cmsn" class="btn bg-type-01" > 修改佣金 </button>
								<button id="btn_cfm_cmsn" class="btn bg-type-02" > 确认佣金 </button>
								<button id="btn_cmsn_save" class="btn bg-type-01" style="display: none;" > 提交佣金 </button>
								<button id="btn_cmsn_cancel" class="btn bg-type-02" style="display: none;" > 取消 </button>
							</c:if>
							<c:if test="${ order.iscommissionupdate eq '1'}">
								佣金已修改，等待会掌柜审核!
							</c:if>
							<c:if test="${ order.iscommissionupdate eq '9'}">
								佣金已确认，等待财务确认金额!
							</c:if>
						</c:if>
						<c:if test="${groupMap.iscompanysales and order.iscommissionupdate eq '1' and order.commissionStatus eq '01'}">
									<button id="btn_cfm_cmsn_update" class="btn bg-type-01" > 确认修改通过 </button>
									<button id="btn_cfm_cmsn_unupdate" class="btn bg-type-02" > 确认修改不通过 </button>
									<script>
										$(function(){
											$("#btn_cfm_cmsn_update").click(function(){
												confirmFn("你确认该笔佣金修改通过?",function(){
													var orderId = '${order.id}';
													var cmsnId = '${comissionRecord.id}';
													var cmsnchkId = '${comissionCheckRecord.id}';
													$.post('${ctx}/base/order/commission/cmsn/update/pass',{orderId:orderId,cmsnId:cmsnId,cmsnchkId:cmsnchkId},function(res){
														if(res.statusCode==='200'){
															common.toast(res.message);
															location = location;
														}else{
															common.toast(res.message);
														}
													},'json');
												});
											});
											
											$("#btn_cfm_cmsn_unupdate").click(function(){
												confirmFn("你确认该笔佣金修改通过?",function(){
													var orderId = '${order.id}';
													var cmsnId = '${comissionRecord.id}';
													var cmsnchkId = '${comissionCheckRecord.id}';
													$.post('${ctx}/base/order/commission/cmsn/update/unpass',{orderId:orderId,cmsnId:cmsnId,cmsnchkId:cmsnchkId},function(res){
														if(res.statusCode==='200'){
															common.toast(res.message);
															location = location;
														}else{
															common.toast(res.message);
														}
													},'json');
												});
											});
										});
									</script>
								</c:if>
					</div>
				</div>
			</c:if>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.80rem;color: #666666;">
			<form id="invoicefrom" action="${ctx}/weixin/order/comission/invoice/save" method="post">
			<input type="hidden" value="${order.id}" id="id" name="orderId">
			<div style="margin:0.5rem 0;padding: 0.5rem 0;">
				<div style="float:left;">发票情况：</div>
				<div style="clear:both;"></div>
			</div>
			<c:if test="${order.isinvoice eq '1' }">
				<div style="margin:0.5rem 0;">
					<div style="float:left;">开具发票号码：${order.invoiceNo }</div>
					<div style="float:right;text-align: right;">开票人：${order.invoiceUname }</div>
					<div style="clear:both;"></div>
				</div>
				<div style="margin:0.5rem 0;">
					<div style="float:left;">开具日期：${order.invoiceDate }</div>
					<div style="clear:both;"></div>
				</div>
				<c:if test="${(order.commissionStatus eq '03' or order.commissionStatus eq '04') and order.isinvoice eq '1' and (groupMap.ishotelfinance or groupMap.isgroupfinance)}">
					<div class="row" style="padding: 0.5rem 0;">
						<button type="button" qx="reconciliation:update" id="btn_hotel_invoice" class="btn bg-type-01">确认领票 </button>
					</div>
				</c:if>
			</c:if>
			<c:if test="${order.commissionStatus eq '02' and order.isinvoice ne '1' && groupMap.iscompanyfinance}">
				<div class="form-group" style="padding: 0.5rem 0;">
					<div style="">开具发票号码</div>
					<div class="input-parent" style="margin-left: 5px;">
						<input class="input-form required" name="invoiceNo" type="text" style="color:#019FEA;width: 200px;font-size:0.8rem;-webkit-box-flex: 1;border-bottom: 0.1rem solid #999999;" placeholder="请填写发票号码"/>
					</div>
				</div>
				<div class="form-group" style="padding: 0.5rem 0;">
					<div style="">开票人</div>
					<div class="input-parent" style="margin-left: 5px;">
						<input class="input-form required" name="invoiceUname" type="text" style="color:#019FEA;width: 240px;font-size:0.8rem;-webkit-box-flex: 1;border-bottom: 0.1rem solid #999999;" placeholder="请输入姓名"/>
					</div>
				</div>
				<div class="form-group" style="padding: 0.5rem 0;">
					<div style="">开具日期</div>
					<div class="input-parent" style="margin-left: 5px; ">
						<input type="date" class="input-form required" name="invoiceDate"   style="color:#019FEA;-webkit-box-flex: 1;border-bottom: 0.1rem solid #999999;"/>
					</div>
				</div>
				<div class="row" style="padding: 0.5rem 0;">
					<button qx="reconciliation:update" type="button" id="btn_submit" class="btn bg-type-01">
						确认提交
					</button>
					
				</div>
			</c:if>
			
			</form>
		</div>
		
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.80rem;color: #666666;width: 100%;margin-bottom: 50px;">
			<c:if test="${order.commissionStatus gt '05' }">
				<div style="margin:0.5rem 0;padding: 0.5rem 0;">
					<div>转账情况 ：</div>
				</div>
				<div style="margin:0.5rem 0;padding: 0.5rem 0;">
					${comissionRecord.memo }
				</div>
			</c:if>
		</div>
	</div>
	
	
	<c:if test="${order.commissionStatus eq '05' and (groupMap.ishotelfinance or groupMap.isgroupfinance)}">
		<div qx="reconciliation:update" type="button" id="btn_hotel_transfer" class="btn-blue" style="width:100%;position: fixed;bottom: 0;">
			确认转账
		</div>
	</c:if>
	<c:if test="${order.commissionStatus eq '06' and groupMap.iscompanyfinance}">
		<button qx="reconciliation:update" type="button" id="btn_company_transfer" class="btn-blue" style="width:100%;position: fixed;bottom: 0;">
			确认到账
		</button>
	</c:if>
	<c:if test="${iscomission }">
		<div id="commission_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:commissiom"  id="btn_commission" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;">确认返佣</div>
		</div>
	</c:if>
	
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	<div id="reconciliation_div" class="div-tips-dialog" style="top:35%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">是否已领取发票</div>
 			<div id="btn_reconciliation_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
		<div style="padding: 1rem 0;"><!-- qx="reconciliation:update"  -->
				<div id="btn-noget-invoice" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">否</div>
				<div id="btn-get-invoice" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">有</div>
				<div style="clear: both;"></div>
		</div>
	</div>	
	
	<div id="hotel_invoice" class="div-tips-dialog" style="top:35%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">确认领取发票</div>
 			<div id="btn_hotel_invoice_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="padding: 1rem 0;">
 		<input id="hotelInvoiceNo" name="hotelInvoiceNo" type="text" style="width:100%;height: 40px;" placeholder="请输入发票号码"/>
 		</div>
		<div style="padding: 1rem 0;">
				<div qx="reconciliation:update" id="btn_hotel_invoice_cancel" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">取消</div>
				<div qx="reconciliation:update" id="btn_hotel_invoice_submit" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">确认领取</div>
				<div style="clear: both;"></div>
		</div>
	</div>	
	
	<div id="hotel_transfer" class="div-tips-dialog" style="top:35%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">确认转账</div>
 			<div id="btn_hotel_transfer_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="padding: 1rem 0;">
 		<textarea id="tranferMemo" name="tranferMemo" style="width:100%;height: 80px;" placeholder="请输入转账情况"></textarea>
 		</div>
		<div style="padding: 1rem 0;">
				<div qx="reconciliation:update" id="btn_hotel_transfer_cancel" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">取消</div>
				<div qx="reconciliation:update" id="btn_hotel_transfer_submit" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">确认转账</div>
				<div style="clear: both;"></div>
		</div>
	</div>	
</body>


<script>
$(function(){
	common.pms.init();
	
	$("#btn_cmsn_cancel").click(function(){
		$(this).hide();
		$("#btn_cmsn_save").hide();
		$("#cmsn_edit").hide();
		$('#cmsn_form')[0].reset();
		$("#cmsn_detail").show();
		$("#btn_update_cmsn").show();
		$("#btn_cfm_cmsn").show();
	});
	$("#btn_update_cmsn").click(function(){
		$(this).hide();
		$("#btn_cmsn_save").show();
		$("#btn_cmsn_cancel").show();
		$("#cmsn_edit").show();
		$("#cmsn_detail").hide();
		$("#btn_cfm_cmsn").hide();
	});
	$("#btn_cfm_cmsn").click(function(){
		show();
		var orderId = '${order.id}';
		var cmsnId = '${comissionRecord.id}';
		$.post('${ctx}/base/order/commission/cmsn/cfm',{orderId:orderId,cmsnId:cmsnId},function(res){
			if(res.statusCode==='200'){
				common.toast(res.message);
				location = location;
			}else{
				common.toast(res.message);
			}
			hide();
		},'json');
	});
	$("#btn_cmsn_save").click(function(){
		var cmsn_type = $('#cmsn_type').val();
		if(cmsn_type==='1'){
			var cmsn_amount = $('#cmsn_amount').val();
			if(cmsn_amount==null || cmsn_amount=='' ||cmsn_amount<=0){
				common.toast('订单金额不能为空，且不能小于零！');
				return;
			}
		}else{
			
		}
		var $cmsn_form = $('#cmsn_form')
		show();
		$.post('${ctx}/weixin/order/comission/update',$cmsn_form.serialize(),function(res){
			if(res.statusCode==='200'){
				common.toast(res.message);
				setTimeout(function(){
					location = location;
				},1500);
			}else{
				common.toast(res.message);
				hide();
			}
		});
	});
	
	$("#btn-noget-invoice").click(function(){
		history.back(-1);
	});
	$("#btn-get-invoice").click(function(){
		$("#reconciliation_div").hide();
		$.post('${ctx}/weixin/order/invoice/get/${order.id }',function(res){
			toastFn(res.message);
			if(res.statusCode=="200"){
				 setTimeout(function(){
					 location = location;
				 },1500);
			}else{
				$("#reconciliation_div").show();
			}
		},"json");
	});
	
	$("#btn_reconciliation_close").click(function(){
		history.back(-1);
	});
	<c:if test="${iscomission }">
		$('#btn_commission').click(function(){
			show();
			var orderId = '${order.id}';
			$.post('${ctx}/weixin/order/comission/create',{orderId:orderId},function(res){
				toastFn(res.message);
				if(res.statusCode==='200'){
					$('#commission_div').hide();
					location = location;
				}else{
				}
				hide();
			},'json');
		});
	</c:if>
	<c:if test="${isgetinvoice }">
	
	$("#mask_full_screen").show();
	$("#reconciliation_div").show();
	</c:if>
	<c:if test="${order.isinvoice ne '1' }">
		var $form = $('#invoicefrom');
		$form.validate();
		$('#btn_submit').click(function(){
			if($form.valid && !$form.valid()){
				return;
			}
			show();
			$.post($form.attr('action'),$form.serialize(),function(res){
				if(res.statusCode==='200'){
					common.toast('提交成功！');
					 setTimeout(function(){
						 location = location;
					 },1500);
				}else{
					 common.toast(res.message);
					 hide();
				}
			});
		});
	</c:if>
	$("#btn_hotel_invoice").click(function(){
		$('#mask_full_screen').show();
		$("#hotel_invoice").show();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_close").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_invoice").hide();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_cancel").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_invoice").hide();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_submit").click(function(){
		var hotelInvoiceNo = $("#hotelInvoiceNo").val();
		if(hotelInvoiceNo===null || hotelInvoiceNo===''){
			common.toast('请输入发票号码！');
			return;
		}
		
		$("#hotel_invoice").hide();
		$.post('${ctx}/weixin/order/invoice/received/${order.id }',{invoiceNo:hotelInvoiceNo},function(res){
			common.toast(res.message);
			if(res.statusCode=="200"){
				 setTimeout(function(){
					 location = location;
				 },1500);
			}else{
				$("#hotel_invoice").show();
			}
		},"json");
	});
	
	
	
	$("#btn_hotel_transfer").click(function(){
		$('#mask_full_screen').show();
		$("#hotel_transfer").show();
		$("#tranferMemo").val('');
	});
	$("#btn_hotel_transfer_close").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_transfer").hide();
		$("#tranferMemo").val('');
	});
	$("#btn_hotel_transfer_cancel").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_transfer").hide();
		$("#tranferMemo").val('');
	});
	
	$("#btn_hotel_transfer_submit").click(function(){
		var tranferMemo = $("#tranferMemo").val();
		if(tranferMemo===null || tranferMemo===''){
			common.toast('请输入转账情况！');
			return;
		}
		//hotelInvoiceNo
		
		$("#hotel_transfer").hide();
		$.post('${ctx}/weixin/order/reconciliation/transfer/accounts/${order.id }',{memo:tranferMemo},function(res){
			common.toast(res.message);
			if(res.statusCode=="200"){
				 setTimeout(function(){
					 location = location;
				 },1500);
			}else{
				$("#hotel_transfer").show();
			}
		},"json");
	});
	
	 $("#btn_company_transfer").click(function(){
		 confirmFn("你确认已收到该笔佣金?",function(){
			 $.post('${ctx}/weixin/order/reconciliation/transfer/accounts/confirmed/${order.id }',{memo:'确认到账'},function(res){
					common.toast(res.message);
					if(res.statusCode=="200"){
						 setTimeout(function(){
							 location = location;
						 },1500);
					}else{
						$("#hotel_transfer").show();
					}
				},"json");
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
function meetingAmountChange(self){
	var $this = $(self);
	var rate =  $("#meeting_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#meeting_cmsn_amount").val(amount);
	sumALL();
}
function houseAmountChange(self){
	var $this = $(self);
	var rate =  $("#house_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#house_cmsn_amount").val(amount);
	sumALL();
}
function dinnerAmountChange(self){
	var $this = $(self);
	var rate =  $("#dinner_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#dinner_cmsn_amount").val(amount);
	sumALL();
}
function otherAmountChange(self){
	var $this = $(self);
	var rate =  $("#other_amount_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#other_cmsn_amount").val(amount);
	sumALL();
}
function sumALL(){
	var amount = 0;
	var cmsnamount = 0
	$(".amount").each(function(){
		amount+=$(this).val()*1;
	});
	$(".cmsnamount").each(function(){
		cmsnamount+=$(this).val()*1;
	});
	$("#cmsn_amount").val(amount);
	$("#cmsn_amount_cc").val(cmsnamount);
}
</script>

</html>
