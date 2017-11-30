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
    
    <link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
	<link href="${ctx}/static/resource/css/bootstrap-select.min.css" type="text/css" rel="stylesheet"/>
	
	<script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.all.min.js"></script>
	<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	<script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
<style>
	    .btn{color: #999999;border:1px solid #cccccc; }
		.display-flex {
			display: flex;
			justify-content: space-between;
		}
		
		.state-item {
			padding: 0.5rem 0;
			border-bottom: 1px solid #f5f5f5;
			text-align: center;
			color: #999999;
		}
		
		.state-item-check {
			color: #019FEA
		}
		
		.hall-schedule {
			color: #999999;
			width: 100%;
			height: 26px;
			border-radius: 4px;
		}
		
		.room-schedule {
			color: #999999;
			width: 135px;
			height: 26px;
			text-align: center;
		}
		
		.meal-schedule {
			color: #999999;
			width: 135px;
			height: 26px;
			text-align: center;
		}
		
		.hall-time {
			width: 60px;
			height: 26px;
		}
		.btn-default{height: 26px;padding: 0; }
		.btn-group-sm>.btn, .btn-sm{padding: 0;}
		.room-breakfast {
			color: #999999;
			width: 58px;
			height: 26px;
			border: none;
		}
		
		.meal-type {
			color: #999999;
			width: 58px;
			height: 26px;
			border: none;
		}
		
		.meal-cgt {
			color: #999999;
			width: 58px;
			height: 26px;
			border: none;
		}
		
		.font-size-min {
			font-size: 0.8rem;
		}
		
		
		.item-checked {
			background-color: #666666;
			color: #ffffff;
			padding: 0.2rem 0.8rem;
			font-size: 0.85rem;
			min-width: 4.2rem;
			text-align: center;
		}
		
		.item-un-checked {
			background-color: #019FEA;
			color: #ffffff;
			padding: 0.2rem 0.8rem;
			font-size: 0.85rem;
			min-width: 4.2rem;
			text-align: center;
		}
		
		.price {
			width: 60px;
			height: 26px;
		}
		
		.num {
			width: 26px;
			height: 26px;
			border: 1px solid #999999;
			background-color: #f5f5f5;
			font-style: normal;
			line-height: 26px;
			text-align: center;
		}
		
		.room-num {
			text-align: center;
			width: 50px;
			min-width: 50px;
			height: 26px;
			line-height: 26px;
		}
		
		.otherdetail{ color: #999999;width: 150px;height: 26px;}
		.otherprice{width: 80px;height: 26px;}
		
		.position-a{position:absolute;width: 36px;height: 36px;line-height:36px; border-radius:50%;text-align: center;top:10px;left: 0;}
		.hui{background-color: #048dd3;color: #ffffff;}
		.hotel{background-color: #f0ad4e;color: #ffffff;}
		.amount-item{text-align: right;margin: 8px 2%;}
		.other input{margin: 0.2rem;}
		.oquantity{width: 100px;}
	</style>
</head>

<body class="">
	<form id="orderForm" action="${ctx}/weixin/order/wxmodify">
	<input type="hidden"  name="orderNo" value="${order.orderNo}">
	<input type="hidden"  name="id" value="${order.id}">
	
	<div id="haha" class="detail_content" style="width:96%;margin:0 auto;">
		<div class="font-size-min" style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:3rem;">
			<span  style="font-size: 1rem;">订单号：${order.orderNo}</span> 
			<div class="btn btn-xs bg-type-01" style="float:right;padding:0.3rem 0.8rem;color: #ffffff;" onclick="javascript:location.href='${ctx}/weixin/order/modify/logs/${order.id}'">查看修改详情</div>
			<%-- <c:choose>
				<c:when test="${groupMap.ishotelsales&&(order.state eq '02' or order.state eq '04' )}">
					<div class="btn btn-xs bg-type-02" style="float:right;padding:0.3rem 0.8rem;" onclick="javascript:location.href='${ctx}/weixin/order/update/${order.id}'">修改价格或档期</div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose> --%>
		</div>
		<div style="border-top:1px solid #cccccc;position: relative;">
			<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
				${order.sourceAppId eq '1'?'会':'內'}
			</div>
			<div style="margin:1.2rem 2.4rem;color:#019FEA;font-weight: bold;">活动场地名称：${order.hotelName}</div>
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">基本信息</div>
			<div style="text-align: right;position:absolute;bottom: 0.2rem;right: 0;font-size: 0.70rem;">
				<span style="color: #019FEA;border: 1px solid #019FEA;width: 50px;height: 50px;line-height:50px; border-radius:50%;display: inline-block;text-align: center;margin-top: 5px;">${dSv.trsltDict('05',order.state)}</span>
				&nbsp;
				<span style="color: #019FEA;border: 1px solid #019FEA;width: 50px;height: 50px;line-height:50px; border-radius:50%;display: inline-block;text-align: center;margin-top: 5px;">${dSv.trsltDict('07',order.settlementStatus)}</span>
				<c:if test="${order.commissionStatus ne '00' and  order.sourceAppId ne '0'}">
				&nbsp;
				<span style="color: #019FEA;border: 1px solid #019FEA;width: 50px;height: 50px;line-height:50px; border-radius:50%;display: inline-block;text-align: center;margin-top: 5px;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
				</c:if>
			</div>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;">
			<div style="margin:0.5rem 0;">
				<div style="font-weight:bold;float:left;font-size: 0.85rem;">活动名称：${order.activityTitle}</div>
				<div style="float:right;">地区：${order.area}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">
					活动时间：${order.activityDate}
				</div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;">活动主办单位：${order.organizer}</div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 60%;">联系方式：<span style="width: 20%;">${order.linkman}</span><span style="float:right;">${order.contactNumber}</span></div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 60%;">跟进销售：<span style="width: 20%;">${order.hotelSaleName}</span><span style="float:right;">${order.hotelSaleMobile}</span></div>
				<div style="float:right;width: 40%;text-align: right;">积分：${order.hotelPoints}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div class="btn btn-xs bg-none-00" style="padding-left: 10px;padding-right : 10px;">活动场地选择</div>
			</div>
		</div>
		
		<div class="font-size-min hall" style="border-top:1px solid #cccccc;">
			<c:if test="${not empty main_hotelplace}">
			<c:set var="hallIds" value="#${main_hotelplace.placeId}"></c:set>
			<div>
				<input type="hidden"  name="orderDetailId" value="${main_hotelplace.id}" >
				<div class="display-flex"   style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div id="halltitle_show_${main_hotelplace.placeId}">主会厅：${main_hotelplace.placeName} </div>
					<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
					<div id="halltitle_edit_${main_hotelplace.placeId}" class="display-flex" style="font-size: 1rem;display: none; ">
						主会厅: ${main_hotelplace.placeName} 
						<input type="hidden" name="ismain" value="${main_hotelplace.placeId }"  >
					</div>
					<div class="display-flex" >
						<div  class="hall_detail_edit"  hallId="${main_hotelplace.placeId }">
							<img qx="order:update" id="hall_detail_edit_to_${main_hotelplace.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;">
							<img qx="order:update" id="hall_detail_edit_cancel_${main_hotelplace.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height:16px;display: none;">
						</div>
						&nbsp;
						&nbsp;
						<div id="hall-del" class="hall-del"  hallId="${main_hotelplace.placeId }">
							<img  qx="order:update" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
						</div>
					</div>
					</c:if>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
					<span>面积${main_hotelplace.hallArea}m²</span>
					<span>容纳人数${main_hotelplace.peopleNum}人</span>
					<span>层高${main_hotelplace.height}m</span>
					<span>楼层${main_hotelplace.floor}F</span>
					<span>立柱${main_hotelplace.pillar}</span>
				</div>
				<div id="hallscheduleDetail${main_hotelplace.placeId }">
				<c:forEach items="${main_hotelplace.bookingRecordModels}"  var="bookingRecordModel" >
					<div style="margin:0.5rem 0;">预定档期：${bookingRecordModel.placeDate}&nbsp;&nbsp;${bookingRecordModel.placeScheduleTxt }<span style="float: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span></div>
				</c:forEach>
				</div>
				
				<div id="hallscheduleUpForm${main_hotelplace.placeId }" style="display: none;">
					<c:forEach items="${main_hotelplace.bookingRecordModels}"  var="bookingRecordModel" varStatus="st" >
						<div class="display-flex" id="schedule_item_${main_hotelplace.placeId}" style="">
							<input type="hidden"  name="bookingRecordId" value="${bookingRecordModel.id}" >
							 <div style="padding:0.7rem 0;">预定档期：</div>
							 <div style="padding:0.4rem 0;"  >
								 <div class="hschedule" >
								 	<input type="hidden" id="" name="hallScheduleId_${main_hotelplace.placeId }" value="${bookingRecordModel.placeScheduleId}" >
								 	<div style="height: 30px;width: 100%;">
										<input type="date" class="hall-schedule date"  name="scheduleDate_${main_hotelplace.placeId }" hallId="${main_hotelplace.placeId }"
										value="${bookingRecordModel.placeDate}"  onchange="hallScheduleDate(this);">
									</div>
									<div style="margin: 5px 0;">
										<input type="hidden"  name="placeScheduleIds_${main_hotelplace.placeId }" value="${fn:replace(bookingRecordModel.placeScheduleIds,',', '#')}" >
										<select name="scheduleTime_${main_hotelplace.placeId }" hallId="${main_hotelplace.placeId }"   class="hall-time selectpicker"  
										data-actions-box="true" data-width="100%" data-size="10" multiple="multiple" data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选">
											<c:forEach items="${ctimes}" var="ctme">
												<option value="${ctme.id}" ${fn:contains(bookingRecordModel.placeScheduleIds, ctme.id)?'selected="selected"':''} >${ctme.name}</option>
											
											</c:forEach>
											<!-- <option value="ALL">全天</option> -->
										</select>
									</div>
								 </div>
							 </div>
							 <div style="padding:0.4rem 0;">
									 ￥<input type="number" class="price" value="${bookingRecordModel.price }" name="placePrice_${main_hotelplace.placeId }" id="" onkeyup="calculateHallSchedulePrice()">
									 <img class="order-del" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
							  </div>
						</div>
					</c:forEach>
					<div  style="">
						 <div style="float: left;width: 20%;">&nbsp;</div>
						 <div style="float: left;width: 80%;">
							 <div style="width: 100%;padding:0.4rem 0;">
								 <span  qx="order:update" class="add hall-add-schedule" style="" hallId="${main_hotelplace.placeId}">添加档期</span>
							 </div>
						 </div>
						  <div style="clear:both;"></div>
					</div>
				</div>
			
			</div>
			</c:if>
			
			<c:forEach items="${otherHalls}" var="otherHall">
				<input type="hidden"  name="orderDetailId" value="${otherHall.id}" >
				<c:set var="hallIds" value="${hallIds}#${otherHall.placeId}"></c:set>
				<div>
				<div class="display-flex"   style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div id="halltitle_show_${otherHall.placeId}">分会厅：${otherHall.placeName} </div>
					<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
					<div class="display-flex" >
						<div class="hall_detail_edit"  hallId="${otherHall.placeId }">
							<img qx="order:update" id="hall_detail_edit_to_${otherHall.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;">
							<img qx="order:update" id="hall_detail_edit_cancel_${otherHall.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height:16px;display: none;">
						</div>
						&nbsp;
						&nbsp;
						<div class="hall-del" hallId="${otherHall.placeId }">
							<img qx="order:update" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
						</div>
					</div>
					</c:if>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
					<span>面积${otherHall.hallArea}m²</span>
					<span>容纳人数${otherHall.peopleNum}人</span>
					<span>层高${otherHall.height}m</span>
					<span>楼层${otherHall.floor}F</span>
					<span>立柱${otherHall.pillar}</span>
				</div>
				<div id="hallscheduleDetail${otherHall.placeId }">
				<c:forEach items="${otherHall.bookingRecordModels}"  var="bookingRecordModel" >
					<div style="margin:0.5rem 0;">预定档期：${bookingRecordModel.placeDate}&nbsp;&nbsp;${bookingRecordModel.placeScheduleTxt }<span style="float: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span></div>
				</c:forEach>
				</div>
				
				<div id="hallscheduleUpForm${otherHall.placeId }" style="display: none;">
					<c:forEach items="${otherHall.bookingRecordModels}"  var="bookingRecordModel" varStatus="st" >
						<div class="display-flex" id="schedule_item_${otherHall.placeId}" style="">
							<input type="hidden"  name="bookingRecordId" value="${bookingRecordModel.id}" >
							 <div style="padding:0.7rem 0;">预定档期：</div>
							 <div style="padding:0.4rem 0;"  >
								 <div class="hschedule" >
								 	<input type="hidden" id="" name="hallScheduleId_${otherHall.placeId }" value="${fn:replace(bookingRecordModel.placeScheduleIds,',', '#')}" >
								 	<div style="height: 30px;width: 100%;">
										<input type="date" class="hall-schedule date"  name="scheduleDate_${otherHall.placeId }" hallId="${otherHall.placeId }"
										value="${bookingRecordModel.placeDate}"  style="float: left;" onchange="hallScheduleDate(this);">
									</div>
									<div style="margin: 5px 0">
										<input type="hidden"  name="placeScheduleIds_${otherHall.placeId }" value="${bookingRecordModel.placeScheduleIds}" >
										<select name="scheduleTime_${otherHall.placeId }" hallId="${otherHall.placeId }"   class="hall-time selectpicker"  
										data-actions-box="true" data-width="100%" data-size="10" multiple="multiple" data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选">
											<c:forEach items="${ctimes}" var="ctme">
												<option value="${ctme.id}" ${fn:contains(bookingRecordModel.placeScheduleIds, ctme.id)?'selected="selected"':''} >${ctme.name}</option>
											
											</c:forEach>
											<!-- <option value="ALL">全天</option> -->
										</select>
										<%-- <select  class="hall-time" onchange="hallScheduleTime(this)" name="scheduleTime_${otherHall.placeId }" hallId="${otherHall.placeId }" >
											<c:forEach items="${ctimes}" var="ctme">
												<option value="${ctme.id}" ${ctme.name eq bookingRecordModel.placeSchedule?'selected="selected"':''} >${ctme.name}</option>
											</c:forEach>
											<option value="ALL">全天</option>
										</select> --%>
									</div>
								 </div>
							 </div>
							 <div style="padding:0.4rem 0;">
									 ￥<input type="number" class="price" value="${bookingRecordModel.price }" name="placePrice_${otherHall.placeId }" id="" onkeyup="calculateHallSchedulePrice()">
									 <img class="order-del" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
							  </div>
						</div>
					</c:forEach>
					<div style="">
						 <div style="float: left;width: 20%;">&nbsp;</div>
						 <div style="float: left;width: 80%;">
							 <div style="width: 100%;padding:0.4rem 0;">
								 <span qx="order:update" class="add hall-add-schedule" style="" hallId="${otherHall.placeId}">添加档期</span>
							 </div>
						 </div>
						  <div style="clear:both;"></div>
					</div>
				</div>
			</div>
			</c:forEach>
			<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
			<div style="padding: 0.2rem 0;margin: 0.2rem 0;">
				 <div style="width: 100%;padding:0.2rem 0;">
					 <span qx="order:update" class="add hall-add" style="">添加场地</span>
				 </div>
			</div>
			</c:if>
			<input type="hidden" id="hallIds" name="hallIds" value="${hallIds}">
			<div style="font-weight:bold;padding-top: 0.5rem;padding-bottom: 0.5rem;">
				<input type="hidden" id="hallAmount" name="hallAmount" value="${bookPriceCount }">
				<input type="hidden" id="hallAllAmount" name="hallAllAmount" value="${bookPriceCount * (1 + bookServicePercent/100)}">
				<div style="margin:0.5rem 0;" class="display-flex">
					
					<div>
						<div id="commissionFeeRate_dtl">
							场地加收服务费:<span><fmt:formatNumber type="number" value="${bookServicePercent }"  maxFractionDigits="0"/></span>%
						</div>
						<div id="commissionFeeRate_edit" style="display: none;">
							场地加收服务费:<input type="number" id="commissionFeeRate" name="commissionFeeRate" min="0" max="100" style="width: 50px;"  value="${bookServicePercent }" onkeyup="calculateHallSchedulePrice()">%
						</div>
					</div>
					<div>场地预定价格：<span id="hallAmnout_dv"><fmt:formatNumber type="currency" value="${bookPriceCount }" /></span></div>
				</div>
				<div style="margin:0.5rem 0;text-align: right;">小计：<span id="hallAllAmnout_dv" style="color:#cb2b29;"><fmt:formatNumber type="currency" value="${bookPriceCount * (1 + bookServicePercent/100)}" /></span></div>
			</div>
			<div style="border-top:1px solid #cccccc;">
					<div style="margin:0.8rem 0;">
						<div style="font-weight:bold;font-size: 0.85rem;">
							场地预定备注：
							<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
							<img qx="order:update" onclick="meetingremarkShow('order_meetingremark')" title="修改场地预定备注" id="order_meetingremark" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;cursor: pointer;">
							<img qx="order:update" onclick="meetingremarkCancel('order_meetingremark_cancel')" title="取消修改场地预定备注" id="order_meetingremark_cancel" 
								src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height: 16px; cursor: pointer;display: none;">
							</c:if>
						</div>
					</div>
					<div id="meetingRemarkEdit" style="margin:0.8rem 0;display: none;">
						<div id="meetingRemark"  name="meetingRemark" class="edui-default" ></div>
					</div>
					<div id="meetingRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
						${empty order.meetingRemark?hotel.meetingRemark:order.meetingRemark}
					</div>
					<script type="text/javascript">
						function meetingremarkShow(id){
							$("#"+id).hide();
							$("#order_meetingremark_cancel").show();
							$("#meetingRemarkEdit").show();
							$("#meetingRemarkDetail").hide();
							$("#meetingRemarkEdit").addClass("edit");
							showEditBtn(true);
						}
						function meetingremarkCancel(id){
							$("#"+id).hide();
							$("#order_meetingremark").show();
							$("#meetingRemarkDetail").show();
							$("#meetingRemarkEdit").hide();
							$("#meetingRemarkEdit").removeClass("edit");
							showEditBtn(false);
						}
						var meeting_editor = new UE.ui.Editor({
				            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
				            toolbars:[['bold', 'italic', 'underline', 'fontborder', 'strikethrough',  'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',  
				                       'rowspacingtop', 'rowspacingbottom', 'lineheight']],
				            //focus时自动清空初始化时的内容
				            autoClearinitialContent:true,
				            //关闭字数统计
				            wordCount:false,
				            //关闭elementPath
				            elementPathEnabled:false,
				            //默认的编辑区域高度
				            initialFrameHeight:150
				        });
						meeting_editor.render("meetingRemark");
						meeting_editor.ready(function() {//编辑器初始化完成再赋值  
							meeting_editor.setContent('${empty order.meetingRemark?hotel.meetingRemark:order.meetingRemark}');  //赋值给UEditor  
				        });
				    </script>
				</div>
		</div>
		
		<div style="margin:0.5rem 0;">
			<div class="btn btn-xs bg-none-00">住房场地${not empty rooms?'':'（无）'}</div>
		</div>
		<c:set var="roomIds" value=""></c:set>
		<div class="font-size-min room" style="border-top:1px solid #cccccc;">
			<c:forEach items="${rooms}" var="room">
				<div>
					<input type="hidden"  name="orderDetailId" value="${room.id}" >
					<c:set var="roomIds" value="${roomIds}#${room.placeId}"></c:set>
					<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
						<div>${room.placeName}</div>
						<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
						<div class="display-flex">
							<div class="room_detail_edit" roomId="${room.placeId}">
								<img qx="order:update" id="room_detail_edit_to_${room.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;">
								<img qx="order:update" id="room_detail_edit_cancel_${room.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height:16px;display: none;">
							</div>
							&nbsp;
							&nbsp;
							<div class="room-del" roomId="${room.placeId}">
								<img qx="order:update" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
							</div>
						</div>
						</c:if>
					</div>
					<div id="roomViewDetail${room.placeId}">
					<c:forEach items="${room.bookingRecordModels}"  var="bookingRecordModel" >
						<div >
							<div style="margin:0.5rem 0;color: #999999;">
								<div><span style="">${room.roomType  }&nbsp;&nbsp;${room.network}
								&nbsp;&nbsp;${(empty bookingRecordModel.breakfast or bookingRecordModel.breakfast eq 0)?'无早':'有早' }
								&nbsp;&nbsp;×${bookingRecordModel.quantity }</span> </div>
							</div>
							<div style="margin:0.5rem 0;">
								入住时间：${bookingRecordModel.placeDate} 
								 <span style="float: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
							</div>
						</div>
					</c:forEach>
					</div>
					<div id="roomEditForm${room.placeId}" style="display: none;">
					<c:forEach items="${room.bookingRecordModels}"  var="bookingRecordModel" >
						<div>
							<input type="hidden"  name="bookingRecordId" value="${bookingRecordModel.id}" >
							<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
								<span style="">${room.roomType}</span>
								<span style="">${room.network}</span>
								<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
								<select class="room-breakfast" name="breakfast_${room.placeId}" roomId="${room.placeId}"  >
									<option value="0" ${(empty bookingRecordModel.breakfast or bookingRecordModel.breakfast eq 0)?'selected="selected"':'' }>无早</option>
									<option value="1" ${ bookingRecordModel.breakfast eq 1 ?'selected="selected"':'' }>有早</option>
								</select>
								</div>
								<div>
									<div style="float: left;">数量：</div>
									<div class="num minus" roomId="{{id}}"  style="float: left;">-</div>
									<div class="room-num" style="float: left;">
										<input type="number" name="rom_num_${room.placeId}" id="rom_num_${room.placeId}" style="border: none;width: 50px;text-align: center;" value="${bookingRecordModel.quantity }" onkeyup="calculateRoomSchedulePrice();">
									</div>
									<div class="num plus" roomId="${room.placeId}" style="float: left;">+</div>
									<div style="clear:both;"></div>
								</div>
							</div>
							<div style="margin:0.5rem 0;">
								 <div style="float: left;width: 20%;padding:0.3rem 0;">入住时间：</div>
								 <div style="float: left;width: 80%;">
									 <div class="display-flex" style="width: 100%;">
									 	<input type="hidden" id="roomscheduleId_${room.placeId}" name="roomscheduleId_${room.placeId}" value="${bookingRecordModel.placeScheduleId}">
									 	
										<input type="date" class="room-schedule date" id="roomscheduleDate_${room.placeId}" name="roomscheduleDate_${room.placeId}" roomId="${room.placeId}"
										  onchange="roomScheduleDate(this)" value="${bookingRecordModel.placeDate}">
										 
										 <span id="roomschedulecurrency_${room.placeId}" style="">
										 	￥<input type="number" class="price"   value="${bookingRecordModel.price}" name="roomPrice_${room.placeId}" id="roomPrice${room.placeId}" onkeyup="calculateRoomSchedulePrice();">/间
										 </span>
										  <img class="room-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;margin:0.4rem 0;">
									 </div>
								 </div>
								  <div style="clear:both;"></div>
							</div>
						</div>
					</c:forEach>
					<div style="">
						 <div style="float: left;width: 20%;">&nbsp;</div>
						 <div style="float: left;width: 80%;">
							 <div style="width: 100%;padding:0.4rem 0;">
								 <span qx="order:update" class="add room-add-schedule" style="" roomId="${room.placeId}">添加档期</span>
							 </div>
						 </div>
						  <div style="clear:both;"></div>
					</div>
				</div>
			</div>
		</c:forEach>
		<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
			<div style="padding: 0.2rem 0;">
				 <div style="width: 100%;padding:0.2rem 0;">
					 <span qx="order:update" class="add room-add" style="">添加住房</span>
				 </div>
			</div>
			</c:if>
			<input type="hidden" id="roomIds" name="roomIds" value="${roomIds}">
			<input type="hidden" id="roomAmount" name="roomAmount" value="${roomPrice}">
			<input type="hidden" id="roomAllAmount" name="roomAllAmount" value="${roomPrice}">
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;text-align: right;">住房预定价格：<span id="sumRoomSchedulePrice"><fmt:formatNumber type="currency" value="${roomPrice}"/></span></div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;text-align: right;">小计：<div id="allRoomSchedulePrice" style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="${roomPrice}"/></div></div>
			
			<div style="border-top:1px solid #cccccc;">
				<div style="margin:0.8rem 0;">
					<div style="font-weight:bold;font-size: 0.85rem;">
						住房预定备注：
						<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
						<img qx="order:update" onclick="houseRemarkShow('order_houseRemark')" title="修改住房预定备注" id="order_houseRemark" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;cursor: pointer;">
						<img qx="order:update" onclick="houseRemarkCancel('order_houseRemark_cancel')" title="取消修改住房预定备注" id="order_houseRemark_cancel" 
							src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height: 16px; cursor: pointer;display: none;">
						</c:if>
					</div>
				</div>
				<div id="houseRemarkEdit"  style="margin:0.8rem 0;display: none;">
					<div id="houseRemark" name="houseRemark" class="edui-default" ></div>
				</div>
				<div id="houseRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
					${empty order.houseRemark?hotel.houseRemark:order.houseRemark}
				</div>
				<script type="text/javascript">
					function houseRemarkShow(id){
						$("#"+id).hide();
						$("#order_houseRemark_cancel").show();
						$("#houseRemarkEdit").show();
						$("#houseRemarkDetail").hide();
						$("#houseRemarkDetail").addClass("edit");
						showEditBtn(true);
					}
					function houseRemarkCancel(id){
						$("#"+id).hide();
						$("#order_houseRemark").show();
						$("#houseRemarkDetail").show();
						$("#houseRemarkEdit").hide();
						$("#houseRemarkDetail").removeClass("edit");
						showEditBtn(false);
					}
					var house_editor = new UE.ui.Editor({
			            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
			            toolbars:[['bold', 'italic', 'underline', 'fontborder', 'strikethrough',  'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',  
			                       'rowspacingtop', 'rowspacingbottom', 'lineheight']],
			            //focus时自动清空初始化时的内容
			            autoClearinitialContent:true,
			            //关闭字数统计
			            wordCount:false,
			            //关闭elementPath
			            elementPathEnabled:false,
			            //默认的编辑区域高度
			            initialFrameHeight:150
			        });
					house_editor.render("houseRemark");
					house_editor.ready(function() {//编辑器初始化完成再赋值  
						house_editor.setContent('${empty order.houseRemark?hotel.houseRemark:order.houseRemark}');  //赋值给UEditor  
			        });
			    </script>
			</div>
			
		</div>
		<div style="margin:0.5rem 0;">
			<div class="btn btn-xs bg-none-00">用餐选择${not empty meals?'':'（无）'}</div>
		</div>
		<c:set var="mealIds" value=""></c:set>
		<div class="font-size-min meal" style="border-top:1px solid #cccccc;">
			<c:forEach items="${meals}" var="meal">
				<div>
					<input type="hidden"  name="orderDetailId" value="${meal.id}" >
					<c:set var="mealIds" value="${mealIds}#${meal.placeId}"></c:set>
					<c:set var="originalPrice" value="0"></c:set>
					<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
						<div>${meal.placeName}</div>
						<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
						<div class="display-flex">
							<div class="meal_detail_edit" mealId="${meal.placeId}">
								<img qx="order:update" id="meal_detail_edit_to_${meal.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;">
								<img qx="order:update" id="meal_detail_edit_cancel_${meal.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height:16px;display: none;">
							</div>
							&nbsp;
							&nbsp;
							<div class="meal-del" mealId="${meal.placeId}">
								<img qx="order:update" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
							</div>
						</div>
						</c:if>
					</div>
					<div id="mealViewForm${meal.placeId}">
						<c:forEach items="${meal.bookingRecordModels}"  var="bookingRecordModel" >
							<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
								<span style="">${bookingRecordModel.mealType eq '01'?'围餐':'自助餐'}&nbsp;&nbsp;${bookingRecordModel.placeSchedule }&nbsp;&nbsp;×${bookingRecordModel.quantity }${bookingRecordModel.mealType eq '01'?'围':'个'}</span>
							</div>
							<div style="margin:0.5rem 0;">
								用餐时间：${bookingRecordModel.placeDate} 
								<span style="float: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
							</div>
						</c:forEach>
					</div>
					<div id="mealEditForm${meal.placeId}" style="display: none;">
						<c:forEach items="${meal.bookingRecordModels}"  var="bookingRecordModel" >
							
							<c:set var="originalPrice" value="${bookingRecordModel.price }"></c:set>
							<div>
								<input type="hidden"  name="bookingRecordId" value="${bookingRecordModel.id}" >
								<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
									<div>
										<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;">
											<select id="mealType_${meal.placeId}" name="mealType_${meal.placeId}" idx="1" mealId="${meal.placeId}" class="meal-type">
												<option value="01" ${bookingRecordModel.mealType eq '01'?'selected="selected"':''}>围餐</option>
												<option value="02" ${bookingRecordModel.mealType eq '02'?'selected="selected"':''}>自助餐</option>
											</select>
										</div>
										<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
											<select id="mealscheduleTime_${meal.placeId}" name="mealscheduleTime_${meal.placeId}"  mealId="${meal.placeId}" class="meal-cgt">
													<option value="早餐" ${bookingRecordModel.placeSchedule eq '早餐'?'selected="selected"':'' }>早餐</option>
													<option value="午餐" ${bookingRecordModel.placeSchedule eq '午餐'?'selected="selected"':'' }>午餐</option>
													<option value="晚餐" ${bookingRecordModel.placeSchedule eq '晚餐'?'selected="selected"':'' }>晚餐</option>
											</select>
										</div>
									</div>
									<div >
										<div style="float: left;">数量：</div>
										<div class="num meal-minus" style="float: left;">-</div>
										<div class="meal-num" style="float: left;">
											<input type="number" name="meal_num_${meal.placeId}" id="meal_num_${meal.placeId}" style="border: none;width: 50px;text-align: center;" value="${bookingRecordModel.quantity }" onkeyup="calculateMealSchedulePrice();">
										</div>
										<div class="num meal-plus" style="float: left;">+</div>
										<div style="clear:both;"></div>
									</div>
								</div>
								<div style="margin:0.5rem 0;">
									 <div style="float: left;width: 20%;padding:0.3rem 0;">用餐时间：</div>
									 <div style="float: left;width: 80%;">
										 <div class="display-flex" style="width: 100%;">
										 	<input type="hidden" id="mealscheduleId_${meal.placeId}" name="mealscheduleId_${meal.placeId}" value="${bookingRecordModel.id }">
										 	
											<input type="date" class="meal-schedule date" id="mealscheduleDate_${meal.placeId}" name="mealscheduleDate_${meal.placeId}" mealId="${meal.placeId}" onchange="mealScheduleDate(this)" value="${bookingRecordModel.placeDate }">
											 
											 <span id="mealschedulecurrency_${meal.placeId}" style="">
											 	￥<input type="number" class="price" value="${bookingRecordModel.price }" name="mealPrice_${meal.placeId}" id="mealPrice${meal.placeId}" onkeyup="calculateMealSchedulePrice();">/围
											 </span>
											  <img class="meal-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;margin:0.4rem 0;">
										 </div>
									 </div>
									  <div style="clear:both;"></div>
								</div>
							</div>
						</c:forEach>
						<div  style="">
							 <div style="float: left;width: 20%;">&nbsp;</div>
							 <div style="float: left;width: 80%;">
								 <div style="width: 100%;padding:0.4rem 0;">
									 <span  qx="order:update" class="add meal-add-schedule" style="" mealId="${meal.placeId}">添加档期</span>
								 </div>
							 </div>
							  <div style="clear:both;"></div>
						</div>
					</div>
					
					<input type="hidden" id="mealOriginalPrice_${meal.placeId}" name="mealOriginalPrice_${meal.placeId}" value="${originalPrice}">
				</div>
			</c:forEach>
			<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
			<div style="padding: 0.2rem 0;">
				 <div style="width: 100%;padding:0.2rem 0;">
					 <span qx="order:update" class="add meal-add" style="">添加用餐</span>
				 </div>
			</div>
			</c:if>
			<input type="hidden" id="mealIds" name="mealIds" value="${mealIds}">
			<input type="hidden" id="mealAmount" name="mealAmount" value="${mealPrice}">
			<input type="hidden" id="mealAllAmount" name="mealAllAmount" value="${mealPrice}">
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;text-align: right;" >用餐预定价格：<span id="sumMealschedulePrice"><fmt:formatNumber type="currency" value="${mealPrice}" /></span></div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;text-align: right;">小计：<div id="allMealschedulePrice" style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="${mealPrice}" /></div></div>
			
			<div style="border-top:1px solid #cccccc;">
				<div style="margin:0.8rem 0;">
					<div style="font-weight:bold;font-size: 0.85rem;">
						用餐预定备注：
						<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
						<img qx="order:update" onclick="dinnerRemarkShow('order_dinnerRemark')" title="修改用餐预定备注" id="order_dinnerRemark"
							src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;cursor: pointer;">
						<img qx="order:update" onclick="dinnerRemarkCancel('order_dinnerRemark_cancel')" title="取消修改用餐预定备注" id="order_dinnerRemark_cancel" 
							src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height: 16px; cursor: pointer;display: none;">
						</c:if>
					</div>
				</div>
				<div id="dinnerRemarkEdit"  style="margin:0.8rem 0;display: none;">
					<div id="dinnerRemark" name="dinnerRemark" class="edui-default" ></div>
				</div>
				<div id="dinnerRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
					${empty order.dinnerRemark?hotel.dinnerRemark:order.dinnerRemark}
				</div>
				<script type="text/javascript">
					function dinnerRemarkShow(id){
						$("#"+id).hide();
						$("#order_dinnerRemark_cancel").show();
						$("#dinnerRemarkEdit").show();
						$("#dinnerRemarkEdit").addClass("edit");
						$("#dinnerRemarkDetail").hide();
						showEditBtn(true);
					}
					function dinnerRemarkCancel(id){
						$("#"+id).hide();
						$("#order_dinnerRemark").show();
						$("#dinnerRemarkDetail").show();
						$("#dinnerRemarkEdit").hide();
						$("#dinnerRemarkEdit").removeClass("edit");
						showEditBtn(false);
					}
					var dinner_editor = new UE.ui.Editor({
			            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
			            toolbars:[['bold', 'italic', 'underline', 'fontborder', 'strikethrough',  'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',  
			                       'rowspacingtop', 'rowspacingbottom', 'lineheight']],
			            //focus时自动清空初始化时的内容
			            autoClearinitialContent:true,
			            //关闭字数统计
			            wordCount:false,
			            //关闭elementPath
			            elementPathEnabled:false,
			            //默认的编辑区域高度
			            initialFrameHeight:150
			        });
					dinner_editor.render("dinnerRemark");
					dinner_editor.ready(function() {//编辑器初始化完成再赋值  
						dinner_editor.setContent('${empty order.dinnerRemark?hotel.dinnerRemark:order.dinnerRemark}');  //赋值给UEditor  
			        });
			    </script>
			</div>
		</div>
		 <div style="margin:0.5rem 0;">
			<div class="btn btn-xs bg-none-00">其他费用</div>
		</div>
		<div class="font-size-min other" style="border-top:1px solid #cccccc;">
			
			<div class="other-item">
				<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
					<div style="width: 100%;padding:0.4rem; border-bottom: 1px solid #cccccc;">
							${odtl.placeName }
							&nbsp;&nbsp;&nbsp;&nbsp;单价：<fmt:formatNumber type="currency" value="${odtl.amount/odtl.quantity }" />
							&nbsp;&nbsp;&nbsp;&nbsp;数量：<fmt:formatNumber type="number" value="${odtl.quantity }" />
							&nbsp;&nbsp;&nbsp;&nbsp;总价：<fmt:formatNumber type="currency" value="${odtl.quantity*odtl.amount }" />
							<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
								<img qx="order:update" class="other-edit" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png" style="height:16px;cursor: pointer;">
							</c:if>
					</div>
						<div class="other"	style="width: 100%; padding: 0.4rem; border-bottom: 1px solid #cccccc;display: none;">
							其他小项 
							<input type="text" id="" name="otherdetail"	placeholder="消费明细" value="${odtl.placeName }" style="width: 200px; display: inline-block;">
							<img  class="other-del" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;display: inline-block;cursor: pointer;" title="删除该项">
							<img  class="other-cancel" src="${ctx }/static/weixin/css/icon/common/icon-order-edit-cancel.png" style="height:16px;display: inline-block;cursor: pointer;" title="取消编辑" alt="">
							<br>
							单价 <input type="number" id="" name="oprice" value="${odtl.amount/odtl.quantity}"	class="oprice" placeholder="单价" min="0" style="width: 80px; display: inline-block;">元; 
							数量 <input type="number" id="" name="oquantity" value="${odtl.quantity }" class="oquantity" placeholder="数量" min="0" style="width: 60px; display: inline-block;">; 
							总计 <input type="number" id="" name="otherprice" value="${odtl.amount }" class="otherprice" placeholder="总计" min="0" style="width: 80px; display: inline-block;" readonly="readonly" onchange="calculateOtherPrice();">元
						</div>
					</c:forEach>
			</div>
			<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE' and order.state eq '02') 
							or (groupMap.ishotelsales and aUs.getCurrentUserId() eq order.hotelSaleId and order.state eq '02')
							or ((groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector) and order.state eq '02')}">
			<div style="padding: 0.2rem 0;">
				 <div style="width: 100%;padding:0.2rem 0;">
					 <span class="add other-add" style="">添加</span>
				 </div>
			</div>
			</c:if>
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;text-align: right;" >其他费用：<span id="sumOtherPrice"><fmt:formatNumber type="currency" value="${order.otherAmount}" /></span></div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;text-align: right;">小计：<div id="allOtherPrice" style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="${order.otherAmount}" /></div></div>
		</div>
		<div style="border-top:1px solid #cccccc;">
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">备注：</div>
			</div>
			<div style="margin:0.8rem 0;">
				<textarea name="memo" rows="5" style="width: 100%;border: none;background-color: #f5f5f5;">${order.memo }</textarea>
			</div>
		
		</div>
	</div>
	
	
	<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0; ">
		
		<div class="amount-item" >总合计：
			<span id="amount_dv">
				<c:if test="${order.amount>=10000 }">
					<fmt:formatNumber type="currency" value="${order.amount/10000 }" />万元
				</c:if>
				<c:if test="${order.amount<10000 }">
					<fmt:formatNumber type="currency" value="${order.amount }" />
				</c:if>
			</span>
		</div>
		<div  class="amount-item" style="color:#cb2b29;font-weight: bold;">掌柜预算：
			<span id="zgamount_dv">
				<c:if test="${order.zgamount>=10000 }">
					<fmt:formatNumber type="currency" value="${order.zgamount/10000 }" />万元
				</c:if>
				<c:if test="${order.zgamount<10000 }">
					<fmt:formatNumber type="currency" value="${order.zgamount }" />
				</c:if>
			</span>
		</div>
		<div class="amount-item">已付定金：
			<input type="hidden" id="prepaid" value="${order.prepaid}">
			<span>
				<fmt:formatNumber type="currency" value="${order.prepaid}" />
			</span>
		</div>
		<div  class="amount-item">剩余尾款：
			<span id="finalPayment">
				<fmt:formatNumber type="currency" value="${order.finalPayment}" />
			</span>
		</div>
		<c:if test="${order.settlementStatus >='04'}">
			<div  class="amount-item">结算金额：
				<span id="finalPayment">
					<fmt:formatNumber type="currency" value="${order.settlementAmount+order.prepaid}" />
				</span>
			</div>
		</c:if>
	</div>
	
	<%-- <div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0; ">
		
		<div id="amount_dv" style="float: left;margin-left: 2%;">总合计：
			<span id="amount_dv">
				<c:if test="${order.amount>=10000 }">
					<fmt:formatNumber type="currency" value="${order.amount/10000 }" />万元
				</c:if>
				<c:if test="${order.amount<10000 }">
					<fmt:formatNumber type="currency" value="${order.amount }" />
				</c:if>
			</span>
		</div>
		<div  style="float: right;text-align: right;margin-right: 2%;display:inline;color:#cb2b29;font-weight: bold;">掌柜预算：
			<span id="zgamount_dv">
				<c:if test="${order.zgamount>=10000 }">
					<fmt:formatNumber type="currency" value="${order.zgamount/10000 }" />万元
				</c:if>
				<c:if test="${order.zgamount<10000 }">
					<fmt:formatNumber type="currency" value="${order.zgamount }" />
				</c:if>
			</span>
		</div>
		<div style="clear: both;"></div>
	</div> --%>
	<c:if test="${groupMap.ishotelsales and order.state =='01' and order.hotelSaleId eq guserId }">
		<div id="order_deal_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_order_deal" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">受理</div>
		</div>
	</c:if>
	<c:if test="${groupMap.ishotelsales and (order.state =='021' or order.state =='04' or order.state =='06') and order.hotelSaleId eq guserId }">
		<div id="order_state_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_order_state" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">订单状态更改</div>
		</div>
	</c:if>
	<c:if test="${groupMap.ishotelsales and order.state =='02' and order.hotelSaleId eq guserId }">
		<!-- <div id="order_quotation_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_order_quotation" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">确认报价</div>
		</div> -->
		<div id="order_save_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:add" id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">确认提交</div>
			<input type="hidden" id="hotelId" name="hotelId">
		</div>
	</c:if>
	<c:if test="${groupMap.iscompanysales and order.orderType eq 'OFFLINE' and order.state < '06'  and order.state !='03' and order.state !='05'  }">
		<div id="order_save_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:add" id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">确认提交</div>
			<input type="hidden" id="hotelId" name="hotelId">
		</div>
	</c:if>
	</form>
	<c:if test="${iscomission }">
		<div id="commission_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:commissiom" id="btn_commission" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">确认返佣</div>
		</div>
	</c:if>
	
	
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	<div id="order_state_chg_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
			<input id="tostate" name="tostate" type="hidden" value="">
 		</div>
		<div id="state_list" >
			<div class="state-item" style="" data="2">已交订金</div>
			<div class="state-item" style="" data="3">已签约</div>
			<div class="state-item" style="" data="4">已完成</div>
			<div class="state-item" style="" data="5">已结算</div>
			<div class="state-item" style="" data="0">客户取消</div>
		</div>
		
		<div id="canceldv" style="padding:0 2%;display: none;" >
			<c:if test="${order.settlementStatus>='02' }">
				<div style="width: 100%;">
					<div style="padding: 5px 0;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
					<div style="padding: 5px 0;">已付定金：<fmt:formatNumber type="currency" value="${order.prepaid}" /></div>
				</div>
				<div style="width: 100%;">
					<div style="padding:5px 0" >退款金额：<input type="number" id="refundAmount" value="" max="${order.prepaid}" min="0" class="form-control" style="width: 50%;display: inline-block;margin: 0;color: #000000;" placeholder="请输入退款金额" ></div>
				</div>
			</c:if>
			<div>
				<textarea id="cancelReason" rows="5" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入取消原因"></textarea>
			</div>
		</div>
		<div id="payedv" style="padding:0 2%;display: none;" >
			<div style="width: 100%;">
				<div   style="padding: 5px 0;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
				<div   style="padding: 5px 0;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></div>
			</div>
			<%-- <div style="width: 100%;">
				<div style="padding:5px 0" >结算金额：<input type="number" id="payAmount" value="${order.finalPayment}" min="0" class="form-control" style="width: 50%;display: inline-block;margin: 0;color: #000000;" placeholder="请输入结算金额" ></div>
			</div> --%>
		</div>
		<div id="prepaydv" style="padding:0 2%;display: none;" >
			<input type="number" id="prepay" value="" max="${order.amount}" min="0" class="form-control" style="width: 98%;margin: 0;" placeholder="请输入订金">
		</div>
		<div class="display-flex" style="padding: 1rem 0;">
			<div id="btn-order-state-cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" > 取消</div>
			<div  qx="order:update" id="btn-order-state-sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" > 确定</div>
		</div>
	</div>	
	
	
	<c:if test="${order.orderType eq 'OFFLINE' and order.offlineState eq '0' and groupMap.iscompanyadministrator}">
		<div id="offline_check_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_offline_check_nopass" class="btn btn-lg bg-type-02" style="width:48%;margin:0 auto;border-radius:3px;border: 1px solid;color: #ffffff;">审核不通过</div>
			<div qx="order:update" id="btn_offline_check_pass" class="btn btn-lg bg-type-01" style="width:48%;margin:0 auto;border-radius:3px;color: #ffffff;">审核通过</div>
		</div>
		<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
				<div style="color: #000000;">不通过原因</div>
				<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
	 		</div>
			<div style="padding:0 2%;">
				<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
			</div>
			<div class="display-flex" style="padding: 1rem 0;">
				<div id="btn_offline_check_no_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" >再考虑</div>
				<div qx="order:update" id="btn_offline_check_no_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" > 确定</div>
			</div>
		</div>	
	</c:if>
	<c:if test="${groupMap.iscompanysales and order.state eq '03' and not empty order.companyFollowTime && empty order.companyFollowMemo}">
		<div id="company_follow_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_company_follow_pass" class="btn btn-lg bg-type-01" style="width:48%;margin:0 auto;border-radius:3px;">客服介入</div>
		</div>
		<div id="company_follow_feedback_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
				<div style="color: #000000;">客服介入反馈</div>
				<div id="company_follow_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
	 		</div>
			<div style="padding:0 2%;">
				<textarea id="companyFollowMemo" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入客服介入反馈"></textarea>
			</div>
			<div class="display-flex" style="padding: 1rem 0;">
				<div id="btn_company_follow_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" >再考虑</div>
				<div qx="order:update" id="btn_company_follow_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;color: #ffffff;" > 确定</div>
			</div>
		</div>	
	</c:if>
	
	<div id="halls_div" class="div-tips-dialog" style="top:15%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择场地</div>
 			 <div id="btn_halls_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
 		</div>
		<div id="halls_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
			<div style="clear: both;"></div>
		</div>
	</div>	
	
	
	<div id="rooms_div" class="div-tips-dialog" style="top:15%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择住房</div>
 			<div id="btn_rooms_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
 		</div>
		<div id="rooms_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
			<div style="clear: both;"></div>
		</div>
	</div>
	
	
	<div id="meals_div" class="div-tips-dialog" style="top:15%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择用餐</div>
 			<div id="btn_meals_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
 		</div>
		<div id="meals_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
			<div style="clear: both;"></div>
		</div>
	</div>	
</body>

<script src="${staticPath}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="${staticPath}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js" type="text/javascript"></script>
<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script src="${ctx}/static/resource/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>  

<script>

function sendEmail(){
	html2canvas(document.getElementById("haha"), {  
        allowTaint: true,  
        taintTest: false,  
        onrendered: function(canvas) {  
            canvas.id = "mycanvas";  
            //document.body.appendChild(canvas);  
            //生成base64图片数据  
            var dataUrl = canvas.toDataURL();  
            var newImg = document.createElement("img");  
            $.ajax({
                type: "POST",
                url: "${ctx}/weixin/order/sendEmail",
                data: {base64:dataUrl,id:"${order.id}"},
                success: function(data){
                }
            });
        }  
    });  
}

$(function(){
	<c:if test="${issend eq '1'}">
		setTimeout(sendEmail(),2000);
	</c:if>
	dict.init();
	common.pms.init();
	$(".selectpicker").selectpicker();
	$('.selectpicker').on('show.bs.select', function (e) {
		var hotelId = $("#hotelId").val();
		var $this = $(this);
		var placeId=$this.attr("hallid");
		var scheduleDate =$this.parent().parent().prev().find('input').val();
		if(!scheduleDate){
			return false;
		}
		 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
				if(res.statusCode==='200'){
					var k =0;
					for(var i=0;i<res.object.length;i++){
						var pschedule = res.object[i].placeSchedule;
						var price  = res.object[i].onlinePrice;
						var state =  res.object[i].state;
						$this.find('option').each(function(){
							var $self = $(this);
							if($self.val()==pschedule){
								$self.attr("price",price);
								if(state==='2'){
									$self.prop('disabled', true);
									k++;
								}else{
									$self.prop('disabled', false);
								}
							}
						});
						$this.attr("price",price);
					}
					$this.selectpicker("refresh"); 
				}else{
					swal(res.message,'success');
				} 
			},"json");
	});
	
	$('.selectpicker').on('changed.bs.select', function (e) {
		var $this = $(this);
		var hallId = $this.attr("hallid");
		var price = $this.attr("price");
		var schtimes = $this.val();
		var sumprice = 0;
		if(schtimes!=null){
			if(schtimes.length===4){
				sumprice  = price*3;
			}else{
				sumprice  = price*schtimes.length;
			}
			$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val(schtimes.join('#'));
		}else{
			$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val('');
		}
		$this.parent().parent().parent().parent().next().find("input").val(sumprice);
		calculateHallSchedulePrice()
	});
	
	
	
	<c:if test="${iscomission }">
		$('#btn_commission').click(function(){
			show();
			var orderId = '${order.id}';
			$.post('${ctx}/weixin/order/comission/create',{orderId:orderId},function(res){
				toastFn(res.message);
				if(res.statusCode==='200'){
					$('#commission_div').hide();
				}else{
				}
				hide();
			},'json');
		});
	</c:if>
	
	$("#order_state_div").click(function(){
		$("#order_state_chg_div").show();
		show();
		$("#tostate").val('');
		$("#cancelReason").val('');
		$('.state-item').removeClass("state-item-check");
	});
	
	//确认报价
	/* $("#btn_order_quotation").click(function(){
		confirmFn("确定确认该订单报价？",function(){
			$.post('${ctx}/weixin/order/confirm/quotation',{id:'${order.id}'},function(res){
				toastFn(res.message);
				if(res.statusCode==='200'){
					setTimeout(function(){
						location = location;
					},1500);
				}
			},'json'); 
		});
	}); */
	$("#btn_order_deal").click(function(){
		confirmFn("确定受理该订单？",function(){
			$.post('${ctx}/weixin/order/state/${order.id}',{tostate:1},function(res){
				toastFn(res.message);
				if(res.statusCode==='200'){
					setTimeout(function(){
						location = location;
					},1500);
				}
			},'json'); 
		});
	});
	$("#btn-order-state-cansel").click(function(){
		$("#order_state_chg_div").hide();
		hide();
		$("#tostate").val('');
		$("#cancelReason").val('');
		$("#prepay").val('');
		$("#canceldv").hide();
		$("#prepaydv").hide();
		$('.state-item').removeClass("state-item-check");
	});
	
	$("#btn-order-state-sure").click(function(){
		var tostate = $("#tostate").val();
		var cancelReason = $("#cancelReason").val();
		if(tostate==='0'&&cancelReason===''){
			toastFn('请输入取消原因！');
			return;
		}
		var prepay = $("#prepay").val();
		if(tostate==='2'&&(prepay===''||prepay*1<=0)){
			toastFn('请输入订金，且订金不能小于0！');
			return;
		}
		if(tostate){
			$.post('${ctx}/weixin/order/state/${order.id}',{tostate:tostate,cancelReason:cancelReason,prepay:prepay},function(res){
				toastFn(res.message);
				if(res.statusCode==='200'){
					setTimeout(function(){
						location = location;
					},1500);
				}
			},'json');
		}else{
			toastFn('请先选择要变更的状态！');
		}
	});
	
	
	$("#state_list").delegate('.state-item','click',function(){	
		$this = $(this);
		$("#tostate").val($this.attr('data'));
		$('.state-item').removeClass("state-item-check");
		$this.addClass('state-item-check');
		if($this.attr('data')==='0'){
			$("#canceldv").show();
			$("#prepaydv").hide();
			$("#payedv").hide();
			
			$("#prepay").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
			$("#cancelReason").val('');
		}else if($this.attr('data')==='2'){
			$("#canceldv").hide();
			$("#payedv").hide();
			$("#prepaydv").show();
			
			$("#prepay").val('');
			$("#cancelReason").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
		}else if($this.attr('data')==='5'){
			$("#canceldv").hide();
			$("#prepaydv").hide();
			$("#payedv").show();
			
			$("#prepay").val('');
			$("#cancelReason").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
		}else{
			$("#canceldv").hide();
			$("#prepaydv").hide();
			$("#payedv").hide();
			
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
			$("#prepay").val('');
			$("#cancelReason").val('');
		}
	});
	
	$("#btn_offline_check_nopass").click(function(){
		$("#reason").val('');
		$("#offline_check_no_div").show();
		show();
	});
	
	$("#btn_offline_check_pass").click(function(){
		show();
		$.post('${ctx}/weixin/order/offline/check/pass',{orderId:'${order.id}'},function(res){
			toastFn(res.message);
			if(res.statusCode==='200'){
				setTimeout(function(){
					location = location;
				},1500);
			}
			hide();
		},'json');
	});
	
	$("#btn_offline_check_no_cansel").click(function(){
		$("#offline_check_no_div").hide();
		hide();
		$("#reason").val('');
		
	});
	
	$("#offline_check_no_ic_close").click(function(){
		$("#offline_check_no_div").hide();
		hide();	
		$("#reason").val('');
		
	}); 
	
	$("#btn_offline_check_no_sure").click(function(){
		$("#offline_check_no_div").hide();
		var reason = $("#reason").val();
		
		$.post('${ctx}/weixin/order/offline/check/nopass',{orderId:'${order.id}',reason:reason},function(res){
			toastFn(res.message);
			if(res.statusCode==='200'){
				hide();	
				setTimeout(function(){
					location = location;
				},1500);
			}else{
				$("#offline_check_no_div").show();
			}
		},'json');
	});
	
	$(".hall_detail_edit").click(function(){
		$this = $(this);
		var placeId = $this.attr("hallId");
		if($this.hasClass('edit')){
			$this.removeClass('edit');
			$("#hall_detail_edit_to_"+placeId).show();
			$("#hall_detail_edit_cancel_"+placeId).hide();
			$("#hallscheduleDetail"+placeId).show();
			$("#hallscheduleUpForm"+placeId).hide();
			
			$("#commissionFeeRate_edit").hide();
			$("#commissionFeeRate_dtl").show();
			
			$("#halltitle_show_"+placeId).show();
			$("#halltitle_edit_"+placeId).hide();
			
			$("#hallAmount").val("${bookPriceCount}");
			 $("#hallAllAmount").val("${bookPriceCount * (1 + bookServicePercent/100)}");
			 
			 $("#hallAmnout_dv").text("￥"+common.formatCurrency("${bookPriceCount}"*1));
			 $("#hallAllAmnout_dv").text("￥"+common.formatCurrency("${bookPriceCount * (1 + bookServicePercent/100)}"*1));
			sumALLprice();
			showEditBtn(false);
		}else{
			$this.addClass('edit');
			$("#hall_detail_edit_to_"+placeId).hide();
			$("#hall_detail_edit_cancel_"+placeId).show();
			$("#hallscheduleDetail"+placeId).hide();
			$("#hallscheduleUpForm"+placeId).show();
			
			$("#commissionFeeRate_edit").show();
			$("#commissionFeeRate_dtl").hide();
			
			$("#halltitle_show_"+placeId).hide();
			$("#halltitle_edit_"+placeId).show();
			showEditBtn(true);
		}
	});
	
	$('.hall-del').click(function(){
		var hallIds = $("#hallIds").val();
		var hallId = $(this).attr('hallid');
		$("#hallIds").val(hallIds.replace("#"+hallId));
		$(this).parent().parent().parent().remove();
		calculateHallSchedulePrice()
	});
	
	$('.order-del').click(function(){
		$(this).parent().parent().remove();
		calculateHallSchedulePrice();
	});
	


	$(".detail_content").delegate('.hall-add-schedule','click',function(){	//
		var $this = $(this);
		var placeId = $this.attr("hallId");
		var schdl_item = $('#hall_schedule_item').text().split('{{hallId}}').join(placeId);
		var $hall_schedule=$(schdl_item);
		$hall_schedule.find('.order-del').click(function(){
			$hall_schedule.remove();
			calculateHallSchedulePrice();
		});
		$hall_schedule.find(".selectpicker").selectpicker();
		$hall_schedule.find('.selectpicker').on('show.bs.select', function (e) {
			var hotelId = $("#hotelId").val();
			var $this = $(this);
			var placeId=$this.attr("hallid");
			var scheduleDate =$this.parent().parent().prev().find('input').val();
			if(!scheduleDate){
				return false;
			}
			 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
					if(res.statusCode==='200'){
						var k =0;
						for(var i=0;i<res.object.length;i++){
							var pschedule = res.object[i].placeSchedule;
							var price  = res.object[i].onlinePrice;
							var state =  res.object[i].state;
							$this.find('option').each(function(){
								var $self = $(this);
								if($self.val()==pschedule){
									$self.attr("price",price);
									if(state==='2'){
										$self.prop('disabled', true);
										k++;
									}else{
										$self.prop('disabled', false);
									}
								}
							});
							$this.attr("price",price);
						}
						$this.selectpicker("refresh"); 
					}else{
						swal(res.message,'success');
					} 
				},"json");
		});
		
		$hall_schedule.find('.selectpicker').on('changed.bs.select', function (e) {
			var $this = $(this);
			var hallId = $this.attr("hallid");
			var price = $this.attr("price");
			var schtimes = $this.val();
			var sumprice = 0;
			if(schtimes!=null){
				if(schtimes.length===4){
					sumprice  = price*3;
				}else{
					sumprice  = price*schtimes.length;
				}
				$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val(schtimes.join('#'));
			}else{
				$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val('');
			}
			$this.parent().parent().parent().parent().next().find("input").val(sumprice);
			calculateHallSchedulePrice()
		});
		$this.parent().parent().parent().before($hall_schedule);
		
	});
	
	
	$(".detail_content").delegate('.room-add-schedule','click',function(){	//
		var $this = $(this);
		var placeId = $this.attr("roomId");
		var roomType = $this.parent().parent().parent().prev().find("span:first-child").text();
		var network = $this.parent().parent().parent().prev().find("span:nth-child(2)").text();
		var schdl_item = $('#room_schedule_item').text().split('{{id}}').join(placeId);
		schdl_item = schdl_item.replace('{{roomType}}',roomType).replace('{{network}}',network);
		var $room_schedule=$(schdl_item);
		$room_schedule.find(".room-schedule-del").click(function(){
			$room_schedule.remove();
			calculateRoomSchedulePrice();
		})
		$this.parent().parent().parent().before($room_schedule);
		
	});
	
	$(".detail_content").delegate('.meal-add-schedule','click',function(){	//
		var $this = $(this);
		var placeId = $this.attr("mealId");
		var price = $("#mealOriginalPrice_"+placeId).val();
		var schdl_item = $('#meal_schedule_item').text().split('{{id}}').join(placeId);
		schdl_item = schdl_item.replace("{{price}}",price);
		var $meal_schedule=$(schdl_item);
		$meal_schedule.find(".meal-schedule-del").click(function(){
			$meal_schedule.remove();
			calculateRoomSchedulePrice();
		})
		$this.parent().parent().parent().before($meal_schedule);
		
	});
	
	$(".detail_content").delegate('.hall-add','click',function(){
		var hallIds = $("#hallIds").val();
		$.get('${ctx}/weixin/hotelplace/list',{hotelId:'${order.hotelId}'},function(res){
			if(res.statusCode==200){
				var arr = [];
				for(var i=0;i<res.object.length;i++){
					var id='#'+res.object[i].id;
					if(hallIds.indexOf(id)<0){
						arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" hallId="'+res.object[i].id+'" hallName="'+res.object[i].placeName+'">'+res.object[i].placeName+'</div>');
					}
				}
				$("#halls_list").html(arr.join(''));
				show();
				$("#halls_div").show();
			}else{
				
			}
		},'json')
	});
	
	
	$("#halls_div").delegate('[hallid]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var hallId = $this.attr('hallid');
		$.get('${ctx}/weixin/hotelplace/getone',{id:hallId,type:'HALL'},function(res){
			if(res.statusCode==200){
				var shtml =	template('hall_item', res.object);
				var $shl = 	$(shtml);
				$shl.find('.hall-del').click(function(){
					var hallIds = $("#hallIds").val();
					var hallId = $this.attr('hallid');
					$("#hallIds").val(hallIds.replace("#"+hallId,''));
					$shl.remove();
					calculateHallSchedulePrice()
				});
				$shl.find(".selectpicker").selectpicker();
				$shl.find('.selectpicker').on('show.bs.select', function (e) {
					var hotelId = $("#hotelId").val();
					var $this = $(this);
					var placeId=$this.attr("hallid");
					var scheduleDate =$this.parent().parent().prev().find('input').val();
					if(!scheduleDate){
						return false;
					}
					 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
							if(res.statusCode==='200'){
								var k =0;
								for(var i=0;i<res.object.length;i++){
									var pschedule = res.object[i].placeSchedule;
									var price  = res.object[i].onlinePrice;
									var state =  res.object[i].state;
									$this.find('option').each(function(){
										var $self = $(this);
										if($self.val()==pschedule){
											$self.attr("price",price);
											if(state==='2'){
												$self.prop('disabled', true);
												k++;
											}else{
												$self.prop('disabled', false);
											}
										}
									});
									$this.attr("price",price);
								}
								$this.selectpicker("refresh"); 
							}else{
								swal(res.message,'success');
							} 
						},"json");
				});
				
				$shl.find('.selectpicker').on('changed.bs.select', function (e) {
					var $this = $(this);
					var hallId = $this.attr("hallid");
					var price = $this.attr("price");
					var schtimes = $this.val();
					var sumprice = 0;
					if(schtimes!=null){
						if(schtimes.length===4){
							sumprice  = price*3;
						}else{
							sumprice  = price*schtimes.length;
						}
						$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val(schtimes.join('#'));
					}else{
						$this.parent().parent().find('input[name="placeScheduleIds_'+hallId+'"]').val('');
					}
					$this.parent().parent().parent().parent().next().find("input").val(sumprice);
					calculateHallSchedulePrice()
				});
				$(".hall-add").parent().parent().before($shl);
				var hallIds = $("#hallIds").val();
				$("#hallIds").val(hallIds+"#"+hallId);
				$("#halls_div").hide();
				hide();
				$("#commissionFeeRate_edit").show();
				$("#commissionFeeRate_dtl").hide();
				showEditBtn(true);
			}
		},'json')
		
	});
	
	
	$(".detail_content").delegate('.room-add','click',function(){
		var roomIds = $("#roomIds").val();
		$.get('${ctx}/weixin/hotelplace/room/list',{hotelId:'${order.hotelId}'},function(res){
			if(res.statusCode==200){
				var arr = [];
				for(var i=0;i<res.object.length;i++){
					var id='#'+res.object[i].id;
					if(roomIds.indexOf(id)<0){
						arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" roomId="'+res.object[i].id+'" roomName="'+res.object[i].placeName+'">'+res.object[i].placeName+'</div>');
					}
				}
				$("#rooms_list").html(arr.join(''));
				show();
				$("#rooms_div").show();
			}else{
				
			}
		},'json')
	});
	
	$("#rooms_div").delegate('[roomId]','click',function(){	//住房列表点击事件
		var $this = $(this);
		var roomId = $this.attr('roomId');
		$.get('${ctx}/weixin/hotelplace/getone',{id:roomId,type:'ROOM'},function(res){
			if(res.statusCode==200){
				var shtml =	template('room_item', res.object);
				var $shl = 	$(shtml);
				$shl.find('.room-del').click(function(){
					var roomIds = $("#roomIds").val();
					var roomId = $this.attr('roomId');
					$("#roomIds").val(roomIds.replace("#"+roomId,''));
					$shl.remove();
					calculateRoomSchedulePrice();
				});
				
				$(".room-add").parent().parent().before($shl);
				var roomIds = $("#roomIds").val();
				$("#roomIds").val(roomIds+"#"+roomId);
				$("#rooms_div").hide();
				hide();
				showEditBtn(true);
			}
		},'json')
		
	});
	
	$(".room_detail_edit").click(function(){
		$this = $(this);
		var placeId = $this.attr("roomId");
		if($this.hasClass('edit')){
			$this.removeClass('edit');
			$("#room_detail_edit_to_"+placeId).show();
			$("#room_detail_edit_cancel_"+placeId).hide();
			$("#roomViewDetail"+placeId).show();
			$("#roomEditForm"+placeId).hide();
			
			showEditBtn(false);
		}else{
			$this.addClass('edit');
			$("#room_detail_edit_to_"+placeId).hide();
			$("#room_detail_edit_cancel_"+placeId).show();
			$("#roomViewDetail"+placeId).hide();
			$("#roomEditForm"+placeId).show();
			showEditBtn(true);
		}
	});
	
	$('.room-del').click(function(){
		var roomIds = $("#roomIds").val();
		var roomId = $(this).attr('roomId');
		$("#roomIds").val(roomIds.replace("#"+roomId).replace(',,',','));
		$(this).parent().parent().parent().remove();
		calculateRoomSchedulePrice();
	});
	
	$("#btn_halls_close").click(function(){
		$("#halls_div").hide();
		hide();
	});
	
	$("#btn_rooms_close").click(function(){
		$("#rooms_div").hide();
		hide();
	});
	
	$("#btn_meals_close").click(function(){
		$("#meals_div").hide();
		hide();
	});
	
	$(".detail_content").delegate('.minus','click',function(){	
		$this = $(this);
		var num = $this.next().find('input').val()*1;
		if(num*1>0){
			var cnum = num-1;
			$this.next().find('input').val(cnum);
		}else{
			
		}
		calculateRoomSchedulePrice();
	});
	
	$(".detail_content").delegate('.plus','click',function(){	
		$this = $(this);
		var num = $this.prev().find('input').val()*1;
		var cnum = num+1;
		$this.prev().find('input').val(cnum);
		calculateRoomSchedulePrice();
		
	});
	
	$(".detail_content").delegate('.meal-minus','click',function(){	
		$this = $(this);
		var num = $this.next().find('input').val()*1;
		if(num*1>0){
			var cnum = num-1;
			$this.next().find('input').val(cnum);
		}else{
			
		}
		calculateMealSchedulePrice();
	});
	
	$(".detail_content").delegate('.meal-plus','click',function(){	
		$this = $(this);
		var num = $this.prev().find('input').val()*1;
		var cnum = num+1;
		$this.prev().find('input').val(cnum);
		calculateMealSchedulePrice();
		
	});
	
	$(".room-schedule-del").click(function(){
		$(this).parent().parent().parent().parent().remove();
		calculateRoomSchedulePrice();
	});
	
	
	$(".detail_content").delegate('.meal-add','click',function(){
		var mealIds = $("#mealIds").val();
		$.get('${ctx}/weixin/hotelplace/meal/list',{hotelId:'${order.hotelId}'},function(res){
			if(res.statusCode==200){
				var arr = [];
				for(var i=0;i<res.object.length;i++){
					var id='#'+res.object[i].id;
					if(mealIds.indexOf(id)<0){
						arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" mealId="'+res.object[i].id+'" mealName="'+res.object[i].name+'">'+res.object[i].name+'</div>');
					}
				}
				$("#meals_list").html(arr.join(''));
				show();
				$("#meals_div").show();
			}else{
				
			}
		},'json')
	});
	
	$("#meals_div").delegate('[mealId]','click',function(){	//住房列表点击事件
		var $this = $(this);
		var mealId = $this.attr('mealId');
		$.get('${ctx}/weixin/hotelplace/getone',{id:mealId,type:'MEAL'},function(res){
			if(res.statusCode==200){
				var shtml =	template('meal_item', res.object);
				var $shl = 	$(shtml);
				$shl.find('.meal-del').click(function(){
					var mealIds = $("#mealIds").val();
					var mlId = $this.attr('mealId');
					$("#mealIds").val(mealIds.replace("#"+mlId,''));
					$shl.remove();
					calculateMealSchedulePrice();
				});
				
				$shl.find(".meal-schedule-del").click(function(){
					$(this).parent().parent().parent().parent().remove();
					calculateMealSchedulePrice();
				});
				
				$(".meal-add").parent().parent().before($shl);
				var mealIds = $("#mealIds").val();
				$("#mealIds").val(mealIds+"#"+mealId);
				$("#meals_div").hide();
				hide();
				showEditBtn(true);
			}
		},'json')
		
	});
	
	$(".meal_detail_edit").click(function(){
		$this = $(this);
		var placeId = $this.attr("mealId");
		if($this.hasClass('edit')){
			$this.removeClass('edit');
			$("#meal_detail_edit_to_"+placeId).show();
			$("#meal_detail_edit_cancel_"+placeId).hide();
			$("#mealViewForm"+placeId).show();
			$("#mealEditForm"+placeId).hide();
			showEditBtn(false);
		}else{
			$this.addClass('edit');
			$("#meal_detail_edit_to_"+placeId).hide();
			$("#meal_detail_edit_cancel_"+placeId).show();
			$("#mealViewForm"+placeId).hide();
			$("#mealEditForm"+placeId).show();
			showEditBtn(true);
		}
	});
	
	$('.meal-del').click(function(){
		var mealIds = $("#mealIds").val();
		var mealId = $(this).attr('mealId');
		$("#mealIds").val(mealIds.replace("#"+mealId).replace(',,',','));
		$(this).parent().parent().parent().remove();
		calculateMealSchedulePrice();
	});
	
	$(".meal-schedule-del").click(function(){
		$(this).parent().parent().parent().parent().remove();
		calculateMealSchedulePrice();
	});
	
	var $form = $("#orderForm");
	$("#btn_submit").click(function(){
	    if($form.valid && !$form.valid()){
			return;
		}
		var data = $form.serialize();
		
		show();
		$.post($form.attr('action'),data,function(res){
			 if(res.statusCode==='200'){
				
				common.toast('提交成功！');
				 setTimeout(function(){
					location.href=location.href+"?issend=1";
				 },1500);
			}else{
				common.toast(res.message);
			} 
			hide();
		},'json');
		
	});
	
	
	$("#btn_company_follow_pass").click(function(){
		show();
		$("#company_follow_feedback_div").show();
		$("#companyFollowMemo").val('');
	});
	
	$("#btn_company_follow_cansel").click(function(){
		$("#company_follow_feedback_div").hide();
		hide();
		$("#companyFollowMemo").val('');
		
	});
	
	$("#company_follow_ic_close").click(function(){
		$("#company_follow_feedback_div").hide();
		hide();	
		$("#companyFollowMemo").val('');
		
	}); 
	
	$("#btn_company_follow_sure").click(function(){
		
		var companyFollowMemo = $("#companyFollowMemo").val();
		if(companyFollowMemo===''){
			toastFn('请输入反馈信息！');
			return;
		}
		$("#company_follow_feedback_div").hide();
		$.post('${ctx}/weixin/order/company/follow',{orderId:'${order.id}',companyFollowMemo:companyFollowMemo},function(res){
			toastFn(res.message);
			if(res.statusCode==='200'){
				hide();	
				setTimeout(function(){
					location = location;
				},1500);
			}else{
				$("#company_follow_feedback_div").show();
			}
		},'json');
	});
	
	$(".other-edit").click(function(){
		$this = $(this);
		$this.parent().hide();
		$this.parent().next().show();
		$this.parent().parent().addClass('edit');
		showEditBtn(true);
	});
	
	$(".other-cancel").click(function(){
		$this = $(this);
		$this.parent().hide();
		$this.parent().prev().show();
		$this.parent().parent().removeClass('edit');
		showEditBtn(false);
	});
	
	$(".other-del").click(function(){
		$this = $(this);
		$this.parent().parent().removeClass('edit');
		$this.parent().remove();
		showEditBtn(false);
		calculateOtherPrice();
	});
	
	$('.other-add').click(function(){
		var oitem = '<div class="other" style="width: 100%;padding:0.4rem;border-bottom:1px solid #cccccc;">其他小项 <input type="text"  id="" name="otherdetail"  placeholder="消费明细" style="width: 200px;display: inline-block;">'
			 +'<img class="other-del" id="" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;cursor:pointer;display: inline-block;"><br/>'
			 +' 单价 <input type="number" id="" name="oprice" value="0" class="oprice" placeholder="单价" min="0" style="width: 80px;display: inline-block;" >元;'
			 +' 数量 <input type="number" id="" name="oquantity" value="1" class="oquantity" placeholder="数量" min="0" style="width: 60px;display: inline-block;">;'
			 +' 总计 <input type="number" id="" name="otherprice" value="0" class="otherprice" placeholder="总计" min="0" style="width: 80px;display: inline-block;" readonly="readonly" onchange="calculateOtherPrice();">元</div>';
		var $otherItem = $(oitem);
		$otherItem.delegate('.other-del','click',function(){	
			$otherItem.removeClass('edit');
			$otherItem.remove();
			showEditBtn(false);
		});
		$otherItem.delegate('.oprice','keyup',function(){	
			var oprice = $(this).val()*1;
			var oquantity = $otherItem.find('.oquantity').val()*1;
			$otherItem.find('.otherprice').val(oprice*oquantity);
			calculateOtherPrice();
		});
		$otherItem.delegate('.oquantity','keyup',function(){	
			var oquantity =$(this).val()*1;
			var oprice = $otherItem.find('.oprice').val()*1;
			$otherItem.find('.otherprice').val(oprice*oquantity);
			calculateOtherPrice();
		});
		$otherItem.addClass('edit');
		$(".other-item").append($otherItem);
		showEditBtn(true);
	})
});
function calculateOtherPrice(){
	 var allOtherPrice =0.00;
	 var sumOtherPrice =0.00;
	 $('.otherprice').each(function(){
		 if($(this).val()){
			 sumOtherPrice+=$(this).val()*1;
		 }
	 });
	 allOtherPrice = sumOtherPrice;
	 $("#sumOtherPrice").text("￥"+common.formatCurrency(sumOtherPrice));
	 $("#allOtherPrice").text("￥"+common.formatCurrency(allOtherPrice));
	 
	 sumALLprice();
}
function mealScheduleDate(self){
	 var $this = $(self);
	 calculateMealSchedulePrice();
}

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

function hallScheduleDate(self){
	 var $this = $(self);
	 var placeId=$this.attr("hallId");
	 var scheduleDate = $this.val();
	 $this.parent().parent().find('.selectpicker').selectpicker('deselectAll');
	 $this.parent().parent().find('input[name="placeScheduleIds_'+placeId+'"]').val('');
	 //var scheduleTime = $this.parent().next().find('select').val();
	 //getHallSchedule(placeId,scheduleDate,scheduleTime,$this);
}
function hallScheduleTime(self){
	 var $this = $(self);
	 var placeId=$this.attr("hallId");
	 var scheduleDate =$this.parent().prev().find('input').val();
	 var scheduleTime = $this.val();
	 getHallSchedule(placeId,scheduleDate,scheduleTime,$this)
}
function getHallSchedule(placeId,scheduleDate,scheduleTime,$this){
	var hotelId = "${order.hotelId}";
	$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate,scheduleTime:scheduleTime},function(res){
		if(res.statusCode==='200'){
			$this.parent().parent().find("input[name='hallScheduleId_"+placeId+"']").val(res.object.id);
			if(scheduleTime==='ALL'){
				$this.parent().parent().parent().next().find("input").val(res.object.onlinePrice*3);
			}else{
				$this.parent().parent().parent().next().find("input").val(res.object.onlinePrice);
			}
			
			calculateHallSchedulePrice();
		}else{
			//alert(res.message);
		} 
	},"json");
}

function calculateHallSchedulePrice(){
	 var sumHallSchedulePrice =0.00;
	 var serviceFee = $("#commissionFeeRate").val()*1;
	 
	 var allHallSchedulePrice =0.00;
	 $('.hall .price').each(function(){
		 if($(this).val()){
			 sumHallSchedulePrice+=$(this).val()*1;
		 }
	 });
	 allHallSchedulePrice = sumHallSchedulePrice*(1+serviceFee/100);
	 
	 $("#hallAmount").val(sumHallSchedulePrice);
	 $("#hallAllAmount").val(allHallSchedulePrice);
	 
	 $("#hallAmnout_dv").text("￥"+common.formatCurrency(sumHallSchedulePrice));
	 $("#hallAllAmnout_dv").text("￥"+common.formatCurrency(allHallSchedulePrice));
	 
	sumALLprice();
}

function calculateRoomSchedulePrice(){
	 var sumRoomSchedulePrice =0.00;
	 var allRoomSchedulePrice =0.00;
	 $('.room .price').each(function(){
		 if($(this).val()){
			 var arr = $(this).attr('id').split('_');
			 var placeId = arr[1];
			 var idx = arr[2];
			 var num = $(this).parent().parent().parent().parent().prev().find('input[type="number"]').val()*1;
			 sumRoomSchedulePrice+=$(this).val()*1*num;
		 }
	 });
	 allRoomSchedulePrice = sumRoomSchedulePrice;
	 $("#roomAmount").val(sumRoomSchedulePrice);
	 $("#roomAllAmount").val(allRoomSchedulePrice);
	 $("#sumRoomSchedulePrice").text("￥"+common.formatCurrency(sumRoomSchedulePrice));
	 $("#allRoomSchedulePrice").text("￥"+common.formatCurrency(allRoomSchedulePrice));
	 
	 sumALLprice();
}

function calculateMealSchedulePrice(){
	 var sumMealSchedulePrice =0.00;
	 var allMealSchedulePrice =0.00;
	 $('.meal .price').each(function(){
		 if($(this).val()){
			 var arr = $(this).attr('id').split('_');
			 var placeId = arr[1];
			 var idx = arr[2];
			 var num = $(this).parent().parent().parent().parent().prev().find('input[type="number"]').val()*1;
			 console.log(num);
			 sumMealSchedulePrice+=$(this).val()*1*num;
		 }
	 });
	 allMealSchedulePrice = sumMealSchedulePrice;
	 $("#mealAmount").val(sumMealSchedulePrice);
	 $("#mealAllAmount").val(allMealSchedulePrice);
	 $("#sumMealschedulePrice").text("￥"+common.formatCurrency(sumMealSchedulePrice));
	 $("#allMealschedulePrice").text("￥"+common.formatCurrency(allMealSchedulePrice));
	 
	 sumALLprice();
}
function sumALLprice(){
	  
	var sumRoomSchedulePrice = $("#roomAmount").val()*1;
	var allRoomSchedulePrice = $("#roomAllAmount").val()*1;
	
	var sumHallSchedulePrice = $("#hallAmount").val()*1;
	var allHallSchedulePrice = $("#hallAllAmount").val()*1;
	 
	var allMealSchedulePrice = $("#mealAllAmount").val()*1;;
	
	var sumOtherPrice =0.00;
	 $('.otherprice').each(function(){
		 if($(this).val()){
			 sumOtherPrice+=$(this).val()*1;
		 }
	 });
	
	var amount = allHallSchedulePrice + allRoomSchedulePrice +allMealSchedulePrice+sumOtherPrice;
	var zgamount = amount;
	
	
	$("#amount_dv").text("￥"+common.formatCurrency(amount));
	$("#zgamount_dv").text("￥"+common.formatCurrency(zgamount));
}


function roomScheduleDate(self){
	 var $this = $(self);
	 var roomId=$this.attr("roomId");
	 var scheduleDate = $this.val();
	 
	 getRoomSchedule(roomId,scheduleDate, $this)
}
function getRoomSchedule(placeId,scheduleDate, $this){
	var hotelId = $("#hotelId").val();
	$.get('${ctx}/weixin/order/room/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
		if(res.statusCode==='200'){
			$this.prev().val(res.object.id);
			$this.next().find('input').val(res.object.onlinePrice*1);
			calculateRoomSchedulePrice();
		}else{
			alert(res.message);
		}
	},"json");
}
function showEditBtn(edit){
	if(edit){
		$("#order_quotation_div").hide();
		$("#order_save_div").show();
	}else{
		var edititems = $.find(".edit");
		if(edititems.length===0){
			$("#order_quotation_div").show();
			$("#order_save_div").hide();
		}
		
	}
}
</script>


<script id="hall_schedule_item" type="text/html">
<div class="display-flex" id="schedule_item_{{hallId}}" style="">
	<input type="hidden"  name="bookingRecordId" value="" >
	 <div style="padding:0.7rem 0;">预定档期：</div>
	 <div style="padding:0.4rem 0;">
		 <div class="hschedule ">
		 	<input type="hidden" id="" name="hallScheduleId_{{hallId}}" value="">
		 	<div style="height: 30px;width: 100%;">
				<input type="date" class="hall-schedule date" name="scheduleDate_{{hallId}}" hallid="{{hallId}}" value="" style="float: left;" onchange="hallScheduleDate(this);">
			</div>
			<div style="">
				<input type="hidden"  name="placeScheduleIds_{{hallId}}" value="" >
				<select name="scheduleTime_{{hallId}}" hallid="{{hallId}}"  class="hall-time selectpicker"  
					data-actions-box="true" data-width="100%" data-size="10" multiple="multiple" data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选">
					<c:forEach items="${ctimes}" var="ctme">
						<option value="${ctme.id}">${ctme.name}</option>
					</c:forEach>
				</select>
			</div>
		 </div>
	 </div>
	 <div style="padding:0.4rem 0;">
		 ￥<input type="number" class="price" style="width: 60px;height: 26px;" value="" name="placePrice_{{hallId}}" id="" onkeyup="calculateHallSchedulePrice()">
		 <img class="order-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
	 </div>
</div>
</script>


<script id="hall_item" type="text/html">
<div>
	<input type="hidden"  name="orderDetailId" value="" >
	<div class="display-flex"   style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
		<div id="halltitle_edit_{{id}}" class="display-flex">
			分会厅:{{placeName}}
		</div>
		<div  class="hall-del"  hallId="{{id}}">
			<img src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
		</div>
	</div>
	<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
		<span>面积{{hallArea}}m²</span>
		<span>容纳人数{{peopleNum}}人</span>
		<span>层高{{height}}m</span>
		<span>楼层{{floor}}F</span>
		<span>立柱{{pillar}}</span>
	</div>
	
	<div id="hallscheduleUpForm{{id}}">
		<div class="display-flex" id="schedule_item_{{id}}" style="">
			<input type="hidden"  name="bookingRecordId" value="" >
			 <div style="padding:0.7rem 0;">预定档期：</div>
			 <div style="padding:0.4rem 0;"  >
				 <div class="hschedule " >
				 	<input type="hidden" id="" name="hallScheduleId_{{id}}" value="" >
				 	<div style="height: 30px;width: 100%;">
						<input type="date" class="hall-schedule date"  name="scheduleDate_{{id}}" hallId="{{id}}"
						value=""  style="float: left;" onchange="hallScheduleDate(this);">
					</div>
					<div style="">
						<input type="hidden"  name="placeScheduleIds_{{id}}" value="" >
						<select  name="scheduleTime_{{id}}" hallId="{{id}}"  class="hall-time selectpicker"  
					data-actions-box="true" data-width="100%" data-size="10" multiple="multiple" data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选">
							<c:forEach items="${ctimes}" var="ctme">
								<option value="${ctme.id}">${ctme.name}</option>
							</c:forEach>
						</select>
					</div>
				 </div>
			 </div>
			 <div style="padding:0.4rem 0;">
					 ￥<input type="number" class="price" style="width: 60px;height: 26px;" value="" name="placePrice_{{id}}" id="" onkeyup="calculateHallSchedulePrice()">
					 <img class="order-del" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
			  </div>
		</div>
		<div style="">
			 <div style="float: left;width: 20%;">&nbsp;</div>
			 <div style="float: left;width: 80%;">
				 <div style="width: 100%;padding:0.4rem 0;">
					 <span class="add hall-add-schedule" style="" hallId="{{id}}">添加档期</span>
				 </div>
			 </div>
			  <div style="clear:both;"></div>
		</div>
	</div>
</div>
</script>
<script id="room_item" type="text/html">
	<div>
		<input type="hidden"  name="orderDetailId" value="" >
		<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
			<div>{{placeName}}</div>
			<div class="display-flex">
				<div class="room-del" roomId="$id}">
					<img src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
				</div>
			</div>
		</div>
		<div id="roomEditForm${id}">
			<div>
				<input type="hidden"  name="bookingRecordId" value="" >
				<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
					<span style="">{{roomType}}</span>
					<span style="">{{network}}</span>
					<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
					<select class="room-breakfast" name="breakfast_{{id}}" roomId="{{id}}"  >
						<option value="0">无早</option>
						<option value="1">有早</option>
					</select>
					</div>
					<div>
						<div style="float: left;">数量：</div>
						<div class="num minus" roomId="{{id}}"  style="float: left;">-</div>
						<div class="room-num" style="float: left;">
							<input type="number" name="rom_num_{{id}}" id="rom_num_{{id}}" style="border: none;width: 50px;text-align: center;" value="0" onkeyup="calculateRoomSchedulePrice()">
						</div>
						<div class="num plus" roomId="{{id}}" style="float: left;">+</div>
						<div style="clear:both;"></div>
					</div>
				</div>
				<div style="margin:0.5rem 0;">
					 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：</div>
					 <div style="float: left;width: 80%;">
						 <div class="display-flex" style="width: 100%;">
						 	<input type="hidden" id="roomscheduleId_{{id}}" name="roomscheduleId_{{id}}" value="">
						 	
							<input type="date" class="room-schedule date" id="roomscheduleDate_{{id}}" name="roomscheduleDate_{{id}}" roomId="{{id}}"
							  onchange="roomScheduleDate(this)" value="">
							 
							 <span id="roomschedulecurrency_{{id}}" style="">
							 	￥<input type="number" class="price"   value="" name="roomPrice_{{id}}" id="roomPrice{{id}}" onkeyup="calculateRoomSchedulePrice()">/间
							 </span>

							 <img class="room-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
						 </div>
					 </div>
					  <div style="clear:both;"></div>
				</div>
			</div>
			<div style="">
				<div style="float: left;width: 20%;">&nbsp;</div>
				<div style="float: left;width: 80%;">
					<div style="width: 100%;padding:0.4rem 0;">
						<span class="add room-add-schedule" style="" roomId="{{id}}">添加档期</span>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
</script>
<script id="room_schedule_item" type="text/html">
	<div>
		<input type="hidden"  name="bookingRecordId" value="" >
		<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
			<span style="">{{roomType}}</span>
			<span style="">{{network}}</span>
			<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
			<select class="room-breakfast" name="breakfast_{{id}}" roomId="{{id}}"  >
				<option value="0">无早</option>
				<option value="1">有早</option>
			</select>
			</div>
			<div>
				<div style="float: left;">数量：</div>
				<div class="num minus" roomId="{{id}}"  style="float: left;">-</div>
				<div class="room-num" style="float: left;">
					<input type="number" name="rom_num_{{id}}" id="rom_num_{{id}}" style="border: none;width: 50px;text-align: center;" value="0" onkeyup="calculateRoomSchedulePrice()">
				</div>
				<div class="num plus" roomId="{{id}}" style="float: left;">+</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div style="margin:0.5rem 0;">
			 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：</div>
			 <div style="float: left;width: 80%;">
				 <div class="display-flex" style="width: 100%;">
				 	<input type="hidden" id="roomscheduleId_{{id}}" name="roomscheduleId_{{id}}" value="">
				 	
					<input type="date" class="room-schedule date" id="roomscheduleDate_{{id}}" name="roomscheduleDate_{{id}}" roomId="{{id}}"
					  onchange="roomScheduleDate(this)" value="">
					 
					 <span id="roomschedulecurrency_{{id}}" style="">
					 	￥<input type="number" class="price"   value="" name="roomPrice_{{id}}" id="roomPrice{{id}}" onkeyup="calculateRoomSchedulePrice()">/间
					 </span>

					 <img class="room-schedule-del" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
				 </div>
			 </div>
			  <div style="clear:both;"></div>
		</div>
	</div>
</script>
<script id="meal_item" type="text/html">	
	<div>
		<input type="hidden"  name="orderDetailId" value="" >
		<input type="hidden" id="mealOriginalPrice_{{id}}" name="mealOriginalPrice_{{id}}" value="{{price}}">
		<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
			<div>{{name}}</div>
			<div class="display-flex">
				<div> </div>
				&nbsp;
				&nbsp;
				<div class="meal-del" mealid="{{id}}">
					<img src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;">
				</div>
			</div>
		</div>
		<div id="mealEditForm{{id}}">
			<div>
				<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
					<div>
						<input type="hidden"  name="bookingRecordId" value="" >
						<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;">
							<select id="mealType_{{id}}" name="mealType_{{id}}" mealid="{{id}}" class="meal-type">
								<option value="01" selected="selected">围餐</option>
								<option value="02">自助餐</option>
							</select>
						</div>
						<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
							<select id="mealscheduleTime_{{id}}" name="mealscheduleTime_{{id}}" mealid="{{id}}" class="meal-cgt">
									<option value="早餐" selected="selected">早餐</option>
									<option value="午餐">午餐</option>
									<option value="晚餐">晚餐</option>
							</select>
						</div>
					</div>
					<div>
						<div style="float: left;">数量：</div>
						<div class="num meal-minus" style="float: left;">-</div>
						<div class="meal-num" style="float: left;">
							<input type="number" name="meal_num_{{id}}" id="meal_num_{{id}}" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateMealSchedulePrice();">
						</div>
						<div class="num meal-plus" style="float: left;">+</div>
						<div style="clear:both;"></div>
					</div>
				</div>
				<div style="margin:0.5rem 0;">
					 <div style="float: left;width: 20%;padding:0.3rem 0;">用餐时间：</div>
					 <div style="float: left;width: 80%;">
						 <div class="display-flex" style="width: 100%;">
						 	<input type="hidden" id="mealscheduleId_{{id}}" name="mealscheduleId_{{id}}" value="">
						 	
							<input type="date" class="meal-schedule date" id="mealscheduleDate_{{id}}" name="mealscheduleDate_{{id}}" mealid="{{id}}" onchange="mealScheduleDate(this)" value="">
							 
							 <span id="mealschedulecurrency_{{id}}" style="">
							 	￥<input type="number" class="price" value="{{price}}" name="mealPrice_{{id}}" id="mealPrice{{id}}" onkeyup="calculateMealSchedulePrice();">/围
							 </span>
							  <img class="meal-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;margin:0.4rem 0;">
						 </div>
					 </div>
					  <div style="clear:both;"></div>
				</div>
			</div>
			<div style="">
							 <div style="float: left;width: 20%;">&nbsp;</div>
							 <div style="float: left;width: 80%;">
								 <div style="width: 100%;padding:0.4rem 0;">
									 <span class="add meal-add-schedule" style="" mealId="{{id}}">添加档期</span>
								 </div>
							 </div>
							  <div style="clear:both;"></div>
						</div>
		</div>
	</div>
	
</script>
<script id="meal_schedule_item" type="text/html">	
	<div>
		<input type="hidden"  name="bookingRecordId" value="" >
		<div class="display-flex" style="margin:0.5rem 0;color: #999999;line-height: 26px;">
			<div>
				<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;">
					<select id="mealType_{{id}}" name="mealType_{{id}}" mealid="{{id}}" class="meal-type">
						<option value="01" selected="selected">围餐</option>
						<option value="02">自助餐</option>
					</select>
				</div>
				<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
					<select id="mealscheduleTime_{{id}}" name="mealscheduleTime_{{id}}" mealid="{{id}}" class="meal-cgt">
							<option value="早餐" selected="selected">早餐</option>
							<option value="午餐">午餐</option>
							<option value="晚餐">晚餐</option>
					</select>
				</div>
			</div>
			<div>
				<div style="float: left;">数量：</div>
				<div class="num meal-minus" style="float: left;">-</div>
				<div class="meal-num" style="float: left;">
					<input type="number" name="meal_num_{{id}}" id="meal_num_{{id}}" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateMealSchedulePrice();">
				</div>
				<div class="num meal-plus" style="float: left;">+</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div style="margin:0.5rem 0;">
			 <div style="float: left;width: 20%;padding:0.3rem 0;">用餐时间：</div>
			 <div style="float: left;width: 80%;">
				 <div class="display-flex" style="width: 100%;">
				 	<input type="hidden" id="mealscheduleId_{{id}}" name="mealscheduleId_{{id}}" value="">
				 	
					<input type="date" class="meal-schedule date" id="mealscheduleDate_{{id}}" name="mealscheduleDate_{{id}}" mealid="{{id}}" onchange="mealScheduleDate(this)" value="">
					 
					 <span id="mealschedulecurrency_{{id}}" style="">
					 	￥<input type="number" class="price" value="{{price}}" name="mealPrice_{{id}}" id="mealPrice{{id}}" onkeyup="calculateMealSchedulePrice();">/围
					 </span>
					  <img class="meal-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="height:16px;margin:0.4rem 0;">
				 </div>
			 </div>
			  <div style="clear:both;"></div>
		</div>
	</div>
</script>
</html>
