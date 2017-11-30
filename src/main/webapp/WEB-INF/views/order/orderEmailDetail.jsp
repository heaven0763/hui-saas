<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
.pad-10{padding:10px;}
.pad-10-k{padding:10px 30px;}
.pad-5{padding:5px;}
.pad-ud-5{padding:5px 0;}
.pad-ud2-5{padding:2.5px 0;}
.pad-lr-5{padding:0 5px;}
.pad-lr-10{padding:0 10px;}
.pad-lr-20{padding:0 20px;}
.pad-lr-25{padding:0 25px;}
.pad-lr-30{padding:0 30px;}
.bottom-line{border-bottom: 1px solid #ddd;}
.vertical-timeline::before {
    content: '';
    position: absolute;
    left: 23.5px;
    height: 90%;
    width: 2px;
    background: #cccccc;
    top: 18px;
    margin-bottom: 20px;
}
.timeline-one-list{}
/* .timeline-one-list:last-child {
    height: 0;
} */
del {
    text-decoration: line-through;
    background-color:#ffffff;
}
.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:-15px;left: 0;}
.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}

.cmstatus{background-image: url('${ctx}/static/resource/css/images/cmstatus.png'); }

.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
.hide{display: none;}
.state-item {
	padding: 0.5rem 0;
	border-bottom: 1px solid #f5f5f5;
	text-align: center;
	color: #999999;
}
.state-item-check {color: #019FEA;}
.display-flex {display: flex;justify-content: space-between;}
.showRemark{background-image: url('${ctx}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
.hideRemark{background-image: url('${ctx}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
</style>
</head>
<body style="font-family: Microsoft YaHei,Helvetica,Arial,sans-serif;font-size: 14px;">
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-5" >
			<h3>订单信息</h3>
		</div>
		<div class="col-sm-7" >
		</div>
	</div>
	<hr style="padding: 5px;margin-top: 0; margin-bottom: 0; "/>
	<div id="haha">
		<div class="row">
			<div class="col-sm-12" style="">
				<div class="" style="position: relative;">
					<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
						<%-- ${order.sourceAppId eq '1'?'会':'內'} --%>
					</div>
					<h3 style="margin-left: 55px;position: relative;">
					订单号：${order.orderNo }
					<c:if test="${order.commissionStatus eq '00' and  order.sourceAppId ne '0'}">
						<div class="cmstatus" style="position: absolute;left: 34%;top: -5px;width: 80px;height: 30px;">	</div>
					</c:if>
					</h3>
				</div>
			</div>
		</div>
		<!-- 基本信息 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
			</div>
			<div class="row">
				<div class="col-sm-12 pad-10-k" >
					<div style="position: relative;">
						<span style="color: #019FEA;font-size: 20px;font-weight: bold;">预定的场地名称：${order.hotelName }</span>
						<div style="text-align: right;position:absolute;top: 10px;right:10px;"><!--  border-radius:50%; -->
							<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px;display: inline-block;text-align: center;">${dSv.trsltDict('05',order.state)}</span>
							&nbsp;&nbsp;
							<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px; display: inline-block;text-align: center;">${dSv.trsltDict('07',order.settlementStatus)}</span>
						</div>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span style="font-weight: bold;color: #019FEA;">活动名称：${order.activityTitle}</span>
						<span class="pad-lr-10">-</span>
						<span style="">地区：${order.area}</span>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span>活动时间：${order.activityDate}</span>
						<span class="pad-lr-10">-</span>
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
						<span style="">跟进销售：${order.hotelSaleName}</span>
						<span class="pad-lr-5">-</span>
						<span style="">${order.hotelSaleMobile}</span>
					</div>
				</div>
			</div>
		</div>
		<!-- 活动场地选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">活动场地选择</span></div>
			</div>
			<c:if test="${not empty sites}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="placePrice" value="0"></c:set>
							<c:set var="commissionFeeRate" value="0"></c:set>
							<c:forEach items="${sites }" varStatus="st" var="site">
								<c:set var="commissionFeeRate" value="${site.commissionFeeRate }"></c:set>
								<div class="row bottom-line">
									<div class="col-sm-6">
										<div class="row pad-5">
				                            <div class="col-xs-12 col-md-6">
				                            	<span style="color: #019FEA;font-weight: bold;">${site.ismain eq '1'?'主会场':'分会场' }：${site.placeName }</span>
				                            </div>
				                            <%-- <span style="color: #019FEA;font-weight: bold;">（${site.ismain eq '1'?'主会场':'分会场' }）</span> --%>
				                            <%-- <div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${site.ismain eq '1'?'主会场':'分会场' }</span></div> --%>
				                        </div>
				                        <div class="row pad-5">
				                            <div class="col-md-12" style="color: #cccccc;">面积${site.hallArea }m²&nbsp;&nbsp;容纳人数${site.peopleNum }人&nbsp;&nbsp;层高${site.height }m&nbsp;&nbsp;楼层${site.floor }F&nbsp;&nbsp;${site.pillar eq 0?'无柱':'立柱' }${site.pillar eq 0?'':site.pillar }</div>
				                        </div>
									</div>
									<div class="col-sm-6" style="color:#019FEA;">
										<c:forEach items="${site.bookingRecordModels }" varStatus="bst" var="br">
											<div class="row pad-5">
					                            <div class="col-md-9">预定档期：${br.placeDate }&nbsp;&nbsp;<span class="pad-lr-5" style="border-radius:20px;border: 1px solid #019FEA;">&nbsp;&nbsp;${br.placeScheduleTxt }&nbsp;&nbsp;</span></div>
					                            <div class="col-md-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${br.price }" /></div>
					                            <c:set var="placePrice" value="${placePrice+br.price}"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
						
						<div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">小计：<fmt:formatNumber type="currency" value="${placePrice}"/></div>
			                        </div>
								</div>
							</div>
							<c:if test="${commissionFeeRate > 0}">
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">场地加收服务费（<fmt:formatNumber type="number" value="${commissionFeeRate }"  maxFractionDigits="0"/>%）：<fmt:formatNumber type="currency" value="${placePrice*commissionFeeRate/100 }"/></div>
			                        </div>
								</div>
							</div>
							</c:if>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"><c:set var="placeSumPrice" value="${placePrice*(1+commissionFeeRate/100) }"></c:set></div>
			                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${placeSumPrice}" /></span></div>
			                        </div>
								</div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<!-- <div class="hideRemark" style="width: 70px;height: 32px;display: none;"></div> -->
								<div class="Remark pad-5" style="display: none;">
									${order.meetingRemark }
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty sites}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
					未选择场地
					</div>
				</div>
			</c:if>
		</div>
		<!-- 住房选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">住房选择</span></div>
			</div>
			<c:if test="${not empty rooms }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="roomPrice" value="0"></c:set>
							<c:forEach items="${rooms }" varStatus="st" var="room">
								<div class="row bottom-line">
									<div class="col-sm-2">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
												<c:if test="${rst.index eq 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;">${room.placeName }</span></div>
												</c:if>
												<c:if test="${rst.index ne 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
												</c:if>
					                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-10">
										<c:forEach items="${room.bookingRecordModels}" varStatus="rst" var="br">
											<div class="row pad-5 ${(rst.index+1)<fn:length(room.bookingRecordModels)?'bottom-line':'' }">
				                            	<div class="col-xs-12 col-md-4" style="color: #cccccc;"><span style="font-weight: bold;">${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}&nbsp;&nbsp;×${br.quantity }间</span></div>
					                            <div class="col-xs-12 col-md-3" style="text-align: right;color: #019FEA;">入住时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-2" style="text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/间</div>
					                            <div class="col-xs-12 col-md-3" style="text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
					                            <c:set var="roomPrice" value="${roomPrice+br.price*br.quantity }"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice}"/></span></div>
		                        </div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5" style="display: none;">
									${order.houseRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${empty rooms}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未选择住房
					</div>
				</div>
			</c:if>
		</div>
		<!-- 用餐选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">用餐选择</span></div>
			</div>
			<c:if test="${not empty meals }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="mealPrice" value="0"></c:set>
							<c:forEach items="${meals }" varStatus="st" var="meal">
							<div class="row bottom-line pad-5">
								<div class="col-sm-2">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5">
											<c:if test="${rst.index eq 0 }">
				                            	<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
											</c:if>
											<c:if test="${rst.index ne 0 }">
												<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
											</c:if>
				                           
				                        </div>
			                        </c:forEach>
								</div>
								<div class="col-sm-10">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5 ${(rst.index+1)<fn:length(meal.bookingRecordModels)?'bottom-line':'' }">
				                            <div class="col-xs-12 col-md-4" ><span style="color: #cccccc;">${br.mealType eq '01'?'围餐':'自助餐'}&nbsp;&nbsp;${br.placeSchedule }&nbsp;&nbsp;×${br.quantity }${br.mealType eq '01'?'围':'个'}</span></div>
				                            <div class="col-xs-12 col-md-3 " style="text-align: right;color: #019FEA;">用餐时间：${br.placeDate }</div>
				                            <div class="col-xs-12 col-md-2" style="text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/${br.mealType eq '01'?'围':'个'}</div>
				                            <div class="col-xs-12 col-md-3" style="text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
				                            <c:set var="mealPrice" value="${mealPrice+br.price*br.quantity }"></c:set>
				                        </div>
			                        </c:forEach>
								</div>
							</div>
							</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice}"/></span></div>
		                        </div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5" style="display: none;">
									${order.dinnerRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${empty meals}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未选择用餐
					</div>
				</div>
			</c:if>
		</div>
		<!-- 其他费用 -->
		
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">其他费用</span></div>
			</div>
			<c:if test="${not empty otherDetails }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
									<div class="row bottom-line">
										<div class="col-md-2 pad-ud-5">
											${odtl.placeName }
										</div>
										<div class="col-md-7 pad-ud-5">
											<span>单价：<fmt:formatNumber type="currency" value="${odtl.amount/odtl.quantity }" /></span>
											<span class="pad-lr-10">-</span>
											<span>数量：<fmt:formatNumber type="number" value="${odtl.quantity }" /></span>
										</div>
										<div class="col-md-3 pad-ud-5" style="text-align: right;padding-right: 20px;">
											费用：<fmt:formatNumber type="currency" value="${odtl.amount }" />
										</div>
									</div>
								</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}"/></span></div>
		                        </div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${empty otherDetails}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未添加其他费用
					</div>
				</div>
			</c:if>
		</div>
		<div class="row" style="border-top:1px solid #000;"></div>
		<div class="row pad-10">
			<div class="col-sm-12" >
				<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
				<div class="Remark pad-5" style="display: none;">
					${order.memo }
				</div>
			</div>
		</div>
		
		<div class="row pad-10 pad-lr-25">
			<div class="col-sm-12 " style="background: #f5f5f5;">
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">场地费用：<fmt:formatNumber type="currency" value="${placeSumPrice  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">住房费用：<fmt:formatNumber type="currency" value="${empty roomPrice?0:roomPrice }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">用餐费用：<fmt:formatNumber type="currency" value="${empty mealPrice?0:mealPrice  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">其他费用：<fmt:formatNumber type="currency" value="${order.otherAmount  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;color: red;">总计：<fmt:formatNumber type="currency" value="${mealPrice+roomPrice+placeSumPrice+order.otherAmount }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">已付定金：<fmt:formatNumber type="currency" value="${order.prepaid  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></span>
					</div>
				</div>
				<c:if test="${order.settlementStatus >='04'}">
					<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span id="finalPayment" style="font-size:16px;font-weight: bold;">
							结算金额：<fmt:formatNumber type="currency" value="${order.settlementAmount+order.prepaid}" />
						</span>
					</div>
					</div>
				</c:if>
				<%-- <c:if test="${order.state eq '09'  }">
				</c:if> --%>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="pad-10">
					<input type="hidden" id="logidx" value="0">
					<table style="width: 100%;">
						<c:forEach items="${logs }" var="log" varStatus="st">
						<tr>
							<td class="pad-10" style="width: 30%;border-top: 1px solid #f5f5f5;border-bottom:1px solid #f5f5f5;color: #0B9FE5; ">
								<span>${st.index ==0?'最新修改':''}  ${dUs.toDay(log.operateTime) }</span>
							</td>
							<td class="pad-10" style="width: 70%;border-top: 1px solid #f5f5f5;border-bottom:1px solid #f5f5f5;border-left: 1px solid #f5f5f5;position: relative;color: #A0A0A0;">
								<div style="background-color: #f1f1f1; color: #fff; position: absolute;top: 46%;left: -5px;width: 10px; height: 10px; border-radius: 50%;"></div>
								<c:if test="${st.index ==0}">
								<div class="pad-lr-10" onclick="showLog(this);" style="position:absolute;top:10px;right: 10px;border-radius: 5px;border: 1px solid #0B9FE5;width: 160px;text-align: center;color: #0B9FE5;cursor: pointer;">
								查看更多记录 <span class="fa fa-chevron-down"></span></div>
								</c:if>
								<div style="width: 100%;">
									<c:if test="${log.operateType eq 'INSERT' }">
										<div class="row pad-ud2-5">
											<div class="col-sm-12" >
												客户提交订单
											</div>
										</div>
										<div class="row pad-ud2-5">
											<div class="col-sm-12" style="color:#cccccc;">
												提交时间：${dUs.toSecond(log.operateTime) }
											</div>
										</div>
									</c:if>
									<c:if test="${log.operateType eq 'UPDATE' }">
										<c:if test="${empty log.rname }">
											<c:forEach items="${log.changeDatas }" var="data">
												<div>
													${data.title }调整为：<span style="color:#FFB42B;">${data.nvalue }</span>
												</div>
											</c:forEach>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" >
													客户提交订单
												</div>
											</div>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" style="color:#cccccc;">
													提交时间：${dUs.toSecond(log.operateTime) }
												</div>
											</div>
										</c:if>
										<c:if test="${not empty log.rname }">
											<c:forEach items="${log.changeDatas }" var="data">
												<div>
													<%-- <div class="col-sm-7">
														
														<c:if test="${empty data.type }">${data.ovalue }</c:if>
														<c:if test="${not empty data.type }"><del><fmt:formatNumber type="currency" value="${data.ovalue }" /></del></c:if>
													</div>
													<div class="col-sm-5"> --%>
														${data.title }调整为：
														<span style="color:#FFB42B;">
														<c:if test="${empty data.type }">	${data.nvalue }</c:if>
														<c:if test="${not empty data.type }"><fmt:formatNumber type="currency" value="	${data.nvalue }" /></c:if>
														</span>
													<!-- </div> -->
												</div>
											</c:forEach>
											<div class="row pad-ud2-5">
												<div class="col-sm-12">
													修改人：${log.rname } ${log.position }
												</div>
											</div>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" style="color:#cccccc;">
													修改时间：${dUs.toSecond(log.operateTime) }
												</div>
											</div>
										</c:if>
									</c:if>
								</div>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function () {
	common.pms.init();
	$(".remark-btn").click(function(){
		var crtclass = $(this).hasClass("hideRemark");
		if(crtclass){
			$(this).removeClass("hideRemark");
			$(this).addClass("showRemark");
			$(this).next().hide();
		}else{
			$(this).removeClass("showRemark");
			$(this).addClass("hideRemark");
			$(this).next().show();
		}
	});
	
	
	orderTrajectory();
	$("#btn_modify").click(function(){
		$("#modify_content").toggleClass("hide");
	});
	$(".backto").click(function(){
		loadContent(this,'${ctx}/'+$(".item-active").find('a').attr('url'),'QUICK');
	});
	if("${issend}"==1){
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
	
	showLog();
});
function showLog(self){
	var logidx = $("#logidx").val();
	if(logidx==0){
		$("table tr").hide();
		$("table tr:eq(0)").show();
		$("#logidx").val("1");
		if(self){
			$(self).find("span").toggleClass("fa-chevron-down").toggleClass("fa-chevron-up");
		}
	}else{
		$("table tr").show();
		$("#logidx").val("0");
		if(self){
			$(self).find("span").toggleClass("fa-chevron-down").toggleClass("fa-chevron-up");
		}
	}
}
function orderTrajectory(){
	var readOrder = common.getstorage("readOrder${aUs.getCurrentUserId()}",readOrder);
	var orderNo = '${order.orderNo}';
	
	if(readOrder){
		if(readOrder.indexOf(orderNo)<0){
			readOrder +=",${order.orderNo}";
		}
	}else{
		readOrder = "${order.orderNo}";
	}
	common.setstorage("readOrder${aUs.getCurrentUserId()}",readOrder);	
}

</script>
</body>
</html>
