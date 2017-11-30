<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>订单详情</title>
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
    </style>
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
			
			<div style="margin:0.5rem 0;">
				<div>公司经办销售：${order.companySaleName }</div>
			</div>
		</div>
		<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">发票情况</div>
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开具发票号码：<span style="color: red;">${order.invoiceNo }</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;text-align: right;">开票人：${order.invoiceUname }</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开具日期：${order.invoiceDate }</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">领票日期：${order.receiveDate }</div>
				<div style="clear:both;"></div>
			</div>
			
		</div>
		
		<c:if test="${not empty comissionRecord }">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">返佣情况</div>
				<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
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
				</div>
			</c:if>
	</div>
			
	<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0;">
		<div style="float: left;margin-left: 2%;">实际费用：
			<c:if test="${order.zgamount>=100000 }">
				<fmt:formatNumber type="currency" value="${order.zgamount/10000 }" />万元
			</c:if>
			<c:if test="${order.zgamount<100000 }">
				<fmt:formatNumber type="currency" value="${order.zgamount }" />
			</c:if>
		</div>
		<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:#cb2b29;font-weight: bold;">佣金合计：
			<c:if test="${comissionRecord.commissionAmount>=100000 }">
				<fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount/10000 }" />万元
			</c:if>
			<c:if test="${comissionRecord.commissionAmount<100000 }">
				<fmt:formatNumber type="currency" value="${comissionRecord.commissionAmount }" />
			</c:if>
		</div>
		<div style="clear: both;"></div>
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
	
});
</script>

</html>
