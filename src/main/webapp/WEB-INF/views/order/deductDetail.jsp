<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:loadContent(this,'${ctx}/weixin/order/deduct/index','')" class="btn btn-warning" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>提成统计信息</h3>
				<hr>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12" style="">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   	<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
    <style>
    	.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:-15px;left: 0;}
		.hui{background-color: #048dd3;color: #ffffff;}
		.hotel{background-color: #f0ad4e;color: #ffffff;}
		.col-sm-2{padding-right: 15px;padding-left: 0px;}
    </style>
	<div style="width:96%;margin:0 auto;">
		<div class="" style="position: relative;">
			<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
				${order.sourceAppId eq '1'?'会':'內'}
			</div>
			<h3 style="margin-left: 55px;">
				订单号：${order.orderNo}
			</h3>  
		</div>
		<div style="border-top:1px solid #cccccc;position: relative;">
			<div style="margin:1.2rem 0;color:#019FEA;font-weight: bold;">场地活动名称：${order.hotelName}——${order.activityTitle}</div>
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">基本信息</div>
			<div style="text-align: right;position:absolute;top: 5px;right: 0;">
				<%-- <span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 80px;line-height:80px; border-radius:50%;display: inline-block;text-align: center;">${dSv.trsltDict('05',order.state)}</span>
				&nbsp;&nbsp;
				<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 80px;line-height:80px; border-radius:50%;display: inline-block;text-align: center;">${dSv.trsltDict('07',order.settlementStatus)}</span>
				 --%>
				 <c:if test="${order.commissionStatus ne '00' }">
					&nbsp;&nbsp;
					<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 80px;line-height:80px; border-radius:50%;display: inline-block;text-align: center;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
				</c:if>
			</div>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.85rem;">
		<div style="width: 50%;border-bottom:1px solid #cccccc;">
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
				<div style="float:left;">跟进销售：${order.hotelSaleName}&nbsp;&nbsp;&nbsp;&nbsp;${order.hotelSaleMobile}</div>
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
				<div style="float:left;">联系方式：${order.linkman}&nbsp;&nbsp;&nbsp;&nbsp;${order.contactNumber}&nbsp;&nbsp;&nbsp;&nbsp;${order.email}</div>
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
			<div style="width: 50%;border-bottom:1px solid #cccccc;">
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开具发票号码：<span style="color: red;">${order.invoiceNo }</div>
				<div style="float:right;text-align: right;">开票人：${order.invoiceUname }</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">开具日期：${order.invoiceDate }</div>
				<div style="float:right;">领票日期：${order.receiveDate }</div>
				<div style="clear:both;"></div>
			</div>
			
		</div>
		<c:if test="${not empty comissionRecord }">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">返佣情况</div>
		<div style="margin:0.5rem 0;border-top: 1px solid #cccccc;border-bottom: 1px solid #f5f5f5;padding: 0.2rem 0;width: 50%;">
			<div style="float:left;">返佣类型：</div>
			<div style="float:right;text-align: right;">${comissionRecord.type eq '1'?'全单返佣':'分项返佣'}</div>
			<div style="clear:both;"></div>
		</div>
		<c:if test="${comissionRecord.type eq '1' }">
			<div id="cmsn_detail" style="width: 50%;">
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
			
		</c:if>
		
		<c:if test="${comissionRecord.type ne '1' }">
			<div id="cmsn_detail" style="width: 50%;">
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
		</c:if>
		
				</c:if>
		</div>
	</div>
<script>
$(function(){
	
});
</script>
</div></div></div>
